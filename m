Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA134AC414
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 16:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380049AbiBGPnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 10:43:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241320AbiBGPgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 10:36:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA98CC0401C1
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 07:36:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 499B6B815BA
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 15:36:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21A59C004E1;
        Mon,  7 Feb 2022 15:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644248181;
        bh=Rivh5q2HLYh9B64plcinCwvTIKzADbYGhE8tAfFghBM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s/f75o01Ycz/6u04g649T9lwuldMVj31C9QTkUDpIGm6yuogxEvX8eGdkDid86Mj/
         VY1EvLV2PR/ilwaK1M8U8Pu32WneDSGXLLFLpRF2KbbNh0XKREkWrWjbyG+VMMNlGE
         FF0/7ywrPzk+YEI0bt7Ta9QcunGlxiJ5ixsgrKH0=
Date:   Mon, 7 Feb 2022 16:36:17 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ankit Kumar Pandey <itsankitkp@gmail.com>
Cc:     jirislaby@kernel.org, linux-kernel@vger.kernel.org,
        trivial@kernel.org
Subject: Re: [PATCH] Style changes to remove style guide warning in
 drivers/tty
Message-ID: <YgE8ceX1Hn+n4JL8@kroah.com>
References: <YgEvea9bNyLzvcSw@ankit-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgEvea9bNyLzvcSw@ankit-vm>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2022 at 08:10:57PM +0530, Ankit Kumar Pandey wrote:
> ---
>  drivers/tty/amiserial.c | 285 +++++++++++++++++++---------------------
>  1 file changed, 137 insertions(+), 148 deletions(-)
> 
> diff --git a/drivers/tty/amiserial.c b/drivers/tty/amiserial.c
> index 1e60dbef6..15917254e 100644
> --- a/drivers/tty/amiserial.c
> +++ b/drivers/tty/amiserial.c
> @@ -12,13 +12,13 @@
>   * (non hardware specific) changes to serial.c.
>   *
>   * The port is registered with the tty driver as minor device 64, and
> - * therefore other ports should should only use 65 upwards.
> + * therefore other ports should only use 65 upwards.
>   *
>   * Richard Lucock 28/12/99
>   *
>   *  Copyright (C) 1991, 1992  Linus Torvalds
> - *  Copyright (C) 1992, 1993, 1994, 1995, 1996, 1997, 
> - * 		1998, 1999  Theodore Ts'o
> + *  Copyright (C) 1992, 1993, 1994, 1995, 1996, 1997,
> + *		1998, 1999  Theodore Ts'o
>   *
>   */
>  
> @@ -78,8 +78,8 @@ struct serial_state {
>  	int			ignore_status_mask;
>  	int			timeout;
>  	int			quot;
> -	int			IER; 	/* Interrupt Enable Register */
> -	int			MCR; 	/* Modem control register */
> +	int			IER;	/* Interrupt Enable Register */
> +	int			MCR;	/* Modem control register */
>  	int			x_char;	/* xon/xoff character */
>  };
>  
> @@ -116,9 +116,9 @@ static struct serial_state serial_state;
>  #define SER_CTS     (1<<4)
>  #define SER_DSR     (1<<3)
>  
> -static __inline__ void rtsdtr_ctrl(int bits)
> +static inline void rtsdtr_ctrl(int bits)
>  {
> -    ciab.pra = ((bits & (SER_RTS | SER_DTR)) ^ (SER_RTS | SER_DTR)) | (ciab.pra & ~(SER_RTS | SER_DTR));
> +	ciab.pra = ((bits & (SER_RTS | SER_DTR)) ^ (SER_RTS | SER_DTR)) | (ciab.pra & ~(SER_RTS | SER_DTR));
>  }
>  
>  /*
> @@ -175,7 +175,7 @@ static void rs_start(struct tty_struct *tty)
>  
>  static void receive_chars(struct serial_state *info)
>  {
> -        int status;
> +	int status;
>  	int serdatr;
>  	unsigned char ch, flag;
>  	struct	async_icount *icount;
> @@ -189,10 +189,10 @@ static void receive_chars(struct serial_state *info)
>  	amiga_custom.intreq = IF_RBF;
>  	mb();
>  
> -	if((serdatr & 0x1ff) == 0)
> -	    status |= UART_LSR_BI;
> -	if(serdatr & SDR_OVRUN)
> -	    status |= UART_LSR_OE;
> +	if ((serdatr & 0x1ff) == 0)
> +		status |= UART_LSR_BI;
> +	if (serdatr & SDR_OVRUN)
> +		status |= UART_LSR_OE;
>  
>  	ch = serdatr & 0xff;
>  	icount->rx++;
> @@ -213,45 +213,44 @@ static void receive_chars(struct serial_state *info)
>  	  /*
>  	   * For statistics only
>  	   */
> -	  if (status & UART_LSR_BI) {
> -	    status &= ~(UART_LSR_FE | UART_LSR_PE);
> -	    icount->brk++;
> -	  } else if (status & UART_LSR_PE)
> -	    icount->parity++;
> -	  else if (status & UART_LSR_FE)
> -	    icount->frame++;
> -	  if (status & UART_LSR_OE)
> -	    icount->overrun++;
> +		if (status & UART_LSR_BI) {
> +			status &= ~(UART_LSR_FE | UART_LSR_PE);
> +			icount->brk++;
> +		} else if (status & UART_LSR_PE)
> +			icount->parity++;
> +		else if (status & UART_LSR_FE)
> +			icount->frame++;
> +		if (status & UART_LSR_OE)
> +			icount->overrun++;
>  
>  	  /*
>  	   * Now check to see if character should be
>  	   * ignored, and mask off conditions which
>  	   * should be ignored.
>  	   */
> -	  if (status & info->ignore_status_mask)
> -	    goto out;
> +		if (status & info->ignore_status_mask)
> +			goto out;
>  
> -	  status &= info->read_status_mask;
> -
> -	  if (status & (UART_LSR_BI)) {
> +		status &= info->read_status_mask;
> +		if (status & (UART_LSR_BI)) {
>  #ifdef SERIAL_DEBUG_INTR
> -	    printk("handling break....");
> +			printk("handling break....");
>  #endif
> -	    flag = TTY_BREAK;
> -	    if (info->tport.flags & ASYNC_SAK)
> -	      do_SAK(info->tport.tty);
> -	  } else if (status & UART_LSR_PE)
> -	    flag = TTY_PARITY;
> -	  else if (status & UART_LSR_FE)
> -	    flag = TTY_FRAME;
> -	  if (status & UART_LSR_OE) {
> -	    /*
> -	     * Overrun is special, since it's
> -	     * reported immediately, and doesn't
> -	     * affect the current character
> -	     */
> -	     oe = 1;
> -	  }
> +			flag = TTY_BREAK;
> +			if (info->tport.flags & ASYNC_SAK)
> +				do_SAK(info->tport.tty);
> +		} else if (status & UART_LSR_PE)
> +			flag = TTY_PARITY;
> +		else if (status & UART_LSR_FE)
> +			flag = TTY_FRAME;
> +		if (status & UART_LSR_OE) {
> +			/*
> +			 * Overrun is special, since it's
> +			 * reported immediately, and doesn't
> +			 * affect the current character
> +			 */
> +			oe = 1;
> +		}
>  	}
>  	tty_insert_flip_char(&info->tport, ch, flag);
>  	if (oe == 1)
> @@ -266,7 +265,7 @@ static void transmit_chars(struct serial_state *info)
>  	amiga_custom.intreq = IF_TBE;
>  	mb();
>  	if (info->x_char) {
> -	        amiga_custom.serdat = info->x_char | 0x100;
> +		amiga_custom.serdat = info->x_char | 0x100;
>  		mb();
>  		info->icount.tx++;
>  		info->x_char = 0;
> @@ -276,7 +275,7 @@ static void transmit_chars(struct serial_state *info)
>  	    || info->tport.tty->flow.stopped
>  	    || info->tport.tty->hw_stopped) {
>  		info->IER &= ~UART_IER_THRI;
> -	        amiga_custom.intena = IF_TBE;
> +		amiga_custom.intena = IF_TBE;
>  		mb();
>  		return;
>  	}
> @@ -295,7 +294,7 @@ static void transmit_chars(struct serial_state *info)
>  	printk("THRE...");
>  #endif
>  	if (info->xmit.head == info->xmit.tail) {
> -	        amiga_custom.intena = IF_TBE;
> +		amiga_custom.intena = IF_TBE;
>  		mb();
>  		info->IER &= ~UART_IER_THRI;
>  	}
> @@ -317,9 +316,8 @@ static void check_modem_status(struct serial_state *info)
>  		/* update input line counters */
>  		if (dstatus & SER_DSR)
>  			icount->dsr++;
> -		if (dstatus & SER_DCD) {
> +		if (dstatus & SER_DCD)
>  			icount->dcd++;
> -		}
>  		if (dstatus & SER_CTS)
>  			icount->cts++;
>  		wake_up_interruptible(&port->delta_msr_wait);
> @@ -372,17 +370,16 @@ static void check_modem_status(struct serial_state *info)
>  		}
>  	}
>  }
> -
> -static irqreturn_t ser_vbl_int( int irq, void *data)
> +static irqreturn_t ser_vbl_int(int irq, void *data)
>  {
> -        /* vbl is just a periodic interrupt we tie into to update modem status */
> +	/* vbl is just a periodic interrupt we tie into to update modem status */
>  	struct serial_state *info = data;
>  	/*
>  	 * TBD - is it better to unregister from this interrupt or to
>  	 * ignore it if MSI is clear ?
>  	 */
> -	if(info->IER & UART_IER_MSI)
> -	  check_modem_status(info);
> +	if (info->IER & UART_IER_MSI)
> +		check_modem_status(info);
>  	return IRQ_HANDLED;
>  }
>  
> @@ -410,10 +407,9 @@ static irqreturn_t ser_tx_int(int irq, void *dev_id)
>  
>  	if (amiga_custom.serdatr & SDR_TBE) {
>  #ifdef SERIAL_DEBUG_INTR
> -	  printk("ser_tx_int...");
> +		printk("ser_tx_int...");
>  #endif
> -
> -	  if (!info->tport.tty)
> +	if (!info->tport.tty)
>  		return IRQ_NONE;
>  
>  	  transmit_chars(info);
> @@ -443,7 +439,7 @@ static int startup(struct tty_struct *tty, struct serial_state *info)
>  {
>  	struct tty_port *port = &info->tport;
>  	unsigned long flags;
> -	int	retval=0;
> +	int	retval = 0;
>  	unsigned long page;
>  
>  	page = get_zeroed_page(GFP_KERNEL);
> @@ -490,7 +486,7 @@ static int startup(struct tty_struct *tty, struct serial_state *info)
>  
>  	info->MCR = 0;
>  	if (C_BAUD(tty))
> -	  info->MCR = SER_DTR | SER_RTS;
> +		info->MCR = SER_DTR | SER_RTS;
>  	rtsdtr_ctrl(info->MCR);
>  
>  	clear_bit(TTY_IO_ERROR, &tty->flags);
> @@ -571,7 +567,7 @@ static void change_speed(struct tty_struct *tty, struct serial_state *info,
>  {
>  	struct tty_port *port = &info->tport;
>  	int	quot = 0, baud_base, baud;
> -	unsigned cflag, cval = 0;
> +	unsigned int cflag, cval = 0;
>  	int	bits;
>  	unsigned long	flags;
>  
> @@ -668,7 +664,7 @@ static void change_speed(struct tty_struct *tty, struct serial_state *info,
>  	if (I_IGNBRK(tty)) {
>  		info->ignore_status_mask |= UART_LSR_BI;
>  		/*
> -		 * If we're ignore parity and break indicators, ignore 
> +		 * If we're ignore parity and break indicators, ignore
>  		 * overruns too.  (For real raw support).
>  		 */
>  		if (I_IGNPAR(tty))
> @@ -682,16 +678,13 @@ static void change_speed(struct tty_struct *tty, struct serial_state *info,
>  	local_irq_save(flags);
>  
>  	{
> -	  short serper;
> -
> +	short serper;
>  	/* Set up the baud rate */
> -	  serper = quot - 1;
> +	serper = quot - 1;
>  
>  	/* Enable or disable parity bit */
> -
> -	if(cval & UART_LCR_PARITY)
> -	  serper |= (SERPER_PARENB);
> -
> +	if (cval & UART_LCR_PARITY)
> +		serper |= (SERPER_PARENB);
>  	amiga_custom.serper = serper;
>  	mb();
>  	}
> @@ -744,7 +737,7 @@ static void rs_flush_chars(struct tty_struct *tty)
>  	local_irq_restore(flags);
>  }
>  
> -static int rs_write(struct tty_struct * tty, const unsigned char *buf, int count)
> +static int rs_write(struct tty_struct *tty, const unsigned char *buf, int count)
>  {
>  	int	c, ret = 0;
>  	struct serial_state *info = tty->driver_data;
> @@ -760,9 +753,8 @@ static int rs_write(struct tty_struct * tty, const unsigned char *buf, int count
>  				      SERIAL_XMIT_SIZE);
>  		if (count < c)
>  			c = count;
> -		if (c <= 0) {
> +		if (c <= 0)
>  			break;
> -		}
>  		memcpy(info->xmit.buf + info->xmit.head, buf, c);
>  		info->xmit.head = ((info->xmit.head + c) &
>  				   (SERIAL_XMIT_SIZE-1));
> @@ -820,20 +812,20 @@ static void rs_flush_buffer(struct tty_struct *tty)
>  static void rs_send_xchar(struct tty_struct *tty, char ch)
>  {
>  	struct serial_state *info = tty->driver_data;
> -        unsigned long flags;
> +	unsigned long flags;
>  
>  	info->x_char = ch;
>  	if (ch) {
>  		/* Make sure transmit interrupts are on */
>  
> -	        /* Check this ! */
> -	        local_irq_save(flags);
> -		if(!(amiga_custom.intenar & IF_TBE)) {
> -		    amiga_custom.intena = IF_SETCLR | IF_TBE;
> -		    mb();
> -		    /* set a pending Tx Interrupt, transmitter should restart now */
> -		    amiga_custom.intreq = IF_SETCLR | IF_TBE;
> -		    mb();
> +		/* Check this ! */
> +		local_irq_save(flags);
> +		if (!(amiga_custom.intenar & IF_TBE)) {
> +			amiga_custom.intena = IF_SETCLR | IF_TBE;
> +			mb();
> +			/* set a pending Tx Interrupt, transmitter should restart now */
> +			amiga_custom.intreq = IF_SETCLR | IF_TBE;
> +			mb();
>  		}
>  		local_irq_restore(flags);
>  
> @@ -844,12 +836,12 @@ static void rs_send_xchar(struct tty_struct *tty, char ch)
>  /*
>   * ------------------------------------------------------------
>   * rs_throttle()
> - * 
> + *
>   * This routine is called by the upper-layer tty layer to signal that
>   * incoming characters should be throttled.
>   * ------------------------------------------------------------
>   */
> -static void rs_throttle(struct tty_struct * tty)
> +static void rs_throttle(struct tty_struct *tty)
>  {
>  	struct serial_state *info = tty->driver_data;
>  	unsigned long flags;
> @@ -868,7 +860,7 @@ static void rs_throttle(struct tty_struct * tty)
>  	local_irq_restore(flags);
>  }
>  
> -static void rs_unthrottle(struct tty_struct * tty)
> +static void rs_unthrottle(struct tty_struct *tty)
>  {
>  	struct serial_state *info = tty->driver_data;
>  	unsigned long flags;
> @@ -923,7 +915,7 @@ static int set_serial_info(struct tty_struct *tty, struct serial_struct *ss)
>  	struct serial_state *state = tty->driver_data;
>  	struct tty_port *port = &state->tport;
>  	bool change_spd;
> -	int 			retval = 0;
> +	int retval = 0;
>  	unsigned int close_delay, closing_wait;
>  
>  	tty_lock(tty);
> @@ -990,11 +982,11 @@ static int set_serial_info(struct tty_struct *tty, struct serial_struct *ss)
>   * get_lsr_info - get line status register info
>   *
>   * Purpose: Let user call ioctl() to get info when the UART physically
> - * 	    is emptied.  On bus types like RS485, the transmitter must
> - * 	    release the bus after transmitting. This must be done when
> - * 	    the transmit shift register is empty, not be done when the
> - * 	    transmit holding register is empty.  This functionality
> - * 	    allows an RS485 driver to be written in user space. 
> + *	    is emptied.  On bus types like RS485, the transmitter must
> + *	    release the bus after transmitting. This must be done when
> + *	    the transmit shift register is empty, not be done when the
> + *	    transmit holding register is empty.  This functionality
> + *	    allows an RS485 driver to be written in user space.
>   */
>  static int get_lsr_info(struct serial_state *info, unsigned int __user *value)
>  {
> @@ -1065,9 +1057,9 @@ static int rs_break(struct tty_struct *tty, int break_state)
>  
>  	local_irq_save(flags);
>  	if (break_state == -1)
> -	  amiga_custom.adkcon = AC_SETCLR | AC_UARTBRK;
> +		amiga_custom.adkcon = AC_SETCLR | AC_UARTBRK;
>  	else
> -	  amiga_custom.adkcon = AC_UARTBRK;
> +		amiga_custom.adkcon = AC_UARTBRK;
>  	mb();
>  	local_irq_restore(flags);
>  	return 0;
> @@ -1117,59 +1109,57 @@ static int rs_ioctl(struct tty_struct *tty,
>  	if ((cmd != TIOCSERCONFIG) &&
>  	    (cmd != TIOCMIWAIT) && (cmd != TIOCGICOUNT)) {
>  		if (tty_io_error(tty))
> -		    return -EIO;
> +			return -EIO;
>  	}
> -
>  	switch (cmd) {
> -		case TIOCSERCONFIG:
> -			return 0;
> +	case TIOCSERCONFIG:
> +		return 0;
>  
> -		case TIOCSERGETLSR: /* Get line status register */
> -			return get_lsr_info(info, argp);
> +	case TIOCSERGETLSR: /* Get line status register */
> +		return get_lsr_info(info, argp);
>  
>  		/*
>  		 * Wait for any of the 4 modem inputs (DCD,RI,DSR,CTS) to change
>  		 * - mask passed in arg for lines of interest
> - 		 *   (use |'ed TIOCM_RNG/DSR/CD/CTS for masking)
> -		 * Caller should use TIOCGICOUNT to see which one it was
> +		 *   (use |'ed TIOCM_RNG/DSR/CD/CTS for masking)
> +		 *   Caller should use TIOCGICOUNT to see which one it was
>  		 */
> -		case TIOCMIWAIT:
> +	case TIOCMIWAIT:
> +		local_irq_save(flags);
> +		/* note the counters on entry */
> +		cprev = info->icount;
> +		local_irq_restore(flags);
> +		while (1) {
> +			prepare_to_wait(&info->tport.delta_msr_wait,
> +					&wait, TASK_INTERRUPTIBLE);
>  			local_irq_save(flags);
> -			/* note the counters on entry */
> -			cprev = info->icount;
> +			cnow = info->icount; /* atomic copy */
>  			local_irq_restore(flags);
> -			while (1) {
> -				prepare_to_wait(&info->tport.delta_msr_wait,
> -						&wait, TASK_INTERRUPTIBLE);
> -				local_irq_save(flags);
> -				cnow = info->icount; /* atomic copy */
> -				local_irq_restore(flags);
> -				if (cnow.rng == cprev.rng && cnow.dsr == cprev.dsr && 
> -				    cnow.dcd == cprev.dcd && cnow.cts == cprev.cts) {
> -					ret = -EIO; /* no change => error */
> -					break;
> -				}
> -				if ( ((arg & TIOCM_RNG) && (cnow.rng != cprev.rng)) ||
> -				     ((arg & TIOCM_DSR) && (cnow.dsr != cprev.dsr)) ||
> -				     ((arg & TIOCM_CD)  && (cnow.dcd != cprev.dcd)) ||
> -				     ((arg & TIOCM_CTS) && (cnow.cts != cprev.cts)) ) {
> -					ret = 0;
> -					break;
> -				}
> -				schedule();
> -				/* see if a signal did it */
> -				if (signal_pending(current)) {
> -					ret = -ERESTARTSYS;
> -					break;
> -				}
> -				cprev = cnow;
> +			if (cnow.rng == cprev.rng && cnow.dsr == cprev.dsr &&
> +					cnow.dcd == cprev.dcd && cnow.cts == cprev.cts) {
> +				ret = -EIO; /* no change => error */
> +				break;
>  			}
> -			finish_wait(&info->tport.delta_msr_wait, &wait);
> -			return ret;
> -
> -		default:
> -			return -ENOIOCTLCMD;
> +			if (((arg & TIOCM_RNG) && (cnow.rng != cprev.rng)) ||
> +					((arg & TIOCM_DSR) && (cnow.dsr != cprev.dsr)) ||
> +					((arg & TIOCM_CD)  && (cnow.dcd != cprev.dcd)) ||
> +					((arg & TIOCM_CTS) && (cnow.cts != cprev.cts))) {
> +				ret = 0;
> +				break;
> +			}
> +			schedule();
> +			/* see if a signal did it */
> +			if (signal_pending(current)) {
> +				ret = -ERESTARTSYS;
> +				break;
> +			}
> +			cprev = cnow;
>  		}
> +		finish_wait(&info->tport.delta_msr_wait, &wait);
> +		return ret;
> +	default:
> +		return -ENOIOCTLCMD;
> +	}
>  	return 0;
>  }
>  
> @@ -1220,14 +1210,14 @@ static void rs_set_termios(struct tty_struct *tty, struct ktermios *old_termios)
>  /*
>   * ------------------------------------------------------------
>   * rs_close()
> - * 
> + *
>   * This routine is called when the serial port gets closed.  First, we
>   * wait for the last remaining data to be sent.  Then, we unlink its
>   * async structure from the interrupt chain if necessary, and we free
>   * that IRQ if nothing is left in the chain.
>   * ------------------------------------------------------------
>   */
> -static void rs_close(struct tty_struct *tty, struct file * filp)
> +static void rs_close(struct tty_struct *tty, struct file *filp)
>  {
>  	struct serial_state *state = tty->driver_data;
>  	struct tty_port *port = &state->tport;
> @@ -1243,8 +1233,8 @@ static void rs_close(struct tty_struct *tty, struct file * filp)
>  	 */
>  	state->read_status_mask &= ~UART_LSR_DR;
>  	if (tty_port_initialized(port)) {
> -	        /* disable receive interrupts */
> -	        amiga_custom.intena = IF_RBF;
> +		/* disable receive interrupts */
> +		amiga_custom.intena = IF_RBF;
>  		mb();
>  		/* clear any pending receive interrupt */
>  		amiga_custom.intreq = IF_RBF;
> @@ -1259,7 +1249,7 @@ static void rs_close(struct tty_struct *tty, struct file * filp)
>  	}
>  	shutdown(tty, state);
>  	rs_flush_buffer(tty);
> -		
> +
>  	tty_ldisc_flush(tty);
>  	port->tty = NULL;
>  
> @@ -1281,7 +1271,7 @@ static void rs_wait_until_sent(struct tty_struct *tty, int timeout)
>  	 * Set the check interval to be 1/5 of the estimated time to
>  	 * send a single character, and make it at least 1.  The check
>  	 * interval should also be less than the timeout.
> -	 * 
> +	 *
>  	 * Note: we have to use pretty tight timings here to satisfy
>  	 * the NIST-PCTS.
>  	 */
> @@ -1290,7 +1280,7 @@ static void rs_wait_until_sent(struct tty_struct *tty, int timeout)
>  	if (char_time == 0)
>  		char_time = 1;
>  	if (timeout)
> -	  char_time = min_t(unsigned long, char_time, timeout);
> +		char_time = min_t(unsigned long, char_time, timeout);
>  	/*
>  	 * If the transmitter hasn't cleared in twice the approximate
>  	 * amount of time to send the entire FIFO, it probably won't
> @@ -1306,7 +1296,7 @@ static void rs_wait_until_sent(struct tty_struct *tty, int timeout)
>  	printk("In rs_wait_until_sent(%d) check=%lu...", timeout, char_time);
>  	printk("jiff=%lu...", jiffies);
>  #endif
> -	while(!((lsr = amiga_custom.serdatr) & SDR_TSRE)) {
> +	while (!((lsr = amiga_custom.serdatr) & SDR_TSRE)) {
>  #ifdef SERIAL_DEBUG_RS_WAIT_UNTIL_SENT
>  		printk("serdatr = %d (jiff=%lu)...", lsr, jiffies);
>  #endif
> @@ -1344,7 +1334,7 @@ static void rs_hangup(struct tty_struct *tty)
>   * the IRQ chain.   It also performs the serial-specific
>   * initialization for the tty structure.
>   */
> -static int rs_open(struct tty_struct *tty, struct file * filp)
> +static int rs_open(struct tty_struct *tty, struct file *filp)
>  {
>  	struct tty_port *port = tty->port;
>  	struct serial_state *info = container_of(port, struct serial_state,
> @@ -1356,9 +1346,8 @@ static int rs_open(struct tty_struct *tty, struct file * filp)
>  	tty->driver_data = info;
>  
>  	retval = startup(tty, info);
> -	if (retval) {
> +	if (retval)
>  		return retval;
> -	}
>  
>  	return tty_port_block_til_ready(port, tty, filp);
>  }
> @@ -1382,15 +1371,15 @@ static inline void line_info(struct seq_file *m, int line,
>  
>  	stat_buf[0] = 0;
>  	stat_buf[1] = 0;
> -	if(!(control & SER_RTS))
> +	if (!(control & SER_RTS))
>  		strcat(stat_buf, "|RTS");
> -	if(!(status & SER_CTS))
> +	if (!(status & SER_CTS))
>  		strcat(stat_buf, "|CTS");
> -	if(!(control & SER_DTR))
> +	if (!(control & SER_DTR))
>  		strcat(stat_buf, "|DTR");
> -	if(!(status & SER_DSR))
> +	if (!(status & SER_DSR))
>  		strcat(stat_buf, "|DSR");
> -	if(!(status & SER_DCD))
> +	if (!(status & SER_DCD))
>  		strcat(stat_buf, "|CD");
>  
>  	if (state->quot)
> @@ -1418,7 +1407,7 @@ static inline void line_info(struct seq_file *m, int line,
>  
>  static int rs_proc_show(struct seq_file *m, void *v)
>  {
> -	seq_printf(m, "serinfo:1.0 driver:4.30\n");
> +	seq_puts(m, "serinfo:1.0 driver:4.30\n");
>  	line_info(m, 0, &serial_state);
>  	return 0;
>  }
> @@ -1618,7 +1607,7 @@ static void amiga_serial_putc(char c)
>   *	The console must be locked when we get here.
>   */
>  static void serial_console_write(struct console *co, const char *s,
> -				unsigned count)
> +				unsigned int count)
>  {
>  	unsigned short intena = amiga_custom.intenar;
>  
> -- 
> 2.32.0
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch does not have a Signed-off-by: line.  Please read the
  kernel file, Documentation/SubmittingPatches and resend it after
  adding that line.  Note, the line needs to be in the body of the
  email, before the patch, not at the bottom of the patch or in the
  email signature.

- Your patch did many different things all at once, making it difficult
  to review.  All Linux kernel patches need to only do one thing at a
  time.  If you need to do multiple things (such as clean up all coding
  style issues in a file/driver), do it in a sequence of patches, each
  one doing only one thing.  This will make it easier to review the
  patches to ensure that they are correct, and to help alleviate any
  merge issues that larger patches can cause.

- You sent multiple patches, yet no indication of which ones should be
  applied in which order.  Greg could just guess, but if you are
  receiving this email, he guessed wrong and the patches didn't apply.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/SubmittingPatches for a description of how
  to do this so that Greg has a chance to apply these correctly.

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what is needed in order to
  properly describe the change.

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what a proper Subject: line should
  look like.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
