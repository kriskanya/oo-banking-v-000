class Transfer

  attr_reader :sender, :receiver, :amount
  attr_accessor :status

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = 'pending'
  end

  def both_valid?
    sender.valid? && receiver.valid? 
  end

  def execute_transaction
    if both_valid? && sender.balance > amount && self.status == "pending"
      @sender.balance -= @amount
      @receiver.balance += @amount
      self.status = 'complete'
    else
      self.reject_transfer
    end
  end

  def reverse_transfer
    if both_valid? && receiver.balance > amount && self.status == "complete"
      @receiver.balance -= @amount
      @sender.balance += @amount
      @status = 'reversed'
    else
      self.reject_transfer
    end
  end

  def reject_transfer
    @status = 'rejected'
    "Transaction rejected. Please check your account balance."
  end

end