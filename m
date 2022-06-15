Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 725EB54C675
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 12:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347571AbiFOKr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 06:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347173AbiFOKr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 06:47:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7186B11C1B
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 03:47:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9AD82B81CFB
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 10:47:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6CB0C3411C;
        Wed, 15 Jun 2022 10:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655290070;
        bh=7yKIsz2DOQ6ZDm3v1kgaIoyLB3quEDaqeNVdRLaqmW4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EQolA9BlWos+aVVYCyuZL9AGim9qQN28aFbdoRqBOU2iByz0MLDFZYMRwonl4KjIr
         g9/m6YSKz4QtWxsBJZov+9TBOMKXQln7CWD0RL5/UG37xyqL6aBmNfSpHlWPh43Lez
         bhE5XV/oklWiSmJPWpvBzjJeEpcXMEA8HoqsHaio=
Date:   Wed, 15 Jun 2022 12:47:45 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ojas Sinha <sinhaojas67@gmail.com>
Cc:     jirislaby@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/tty: Fix code style errors in amiserial.c
Message-ID: <Yqm40b3BibeVU8IA@kroah.com>
References: <20220615103601.131489-1-sinhaojas67@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615103601.131489-1-sinhaojas67@gmail.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 04:06:01PM +0530, Ojas Sinha wrote:
> Signed-off-by: Ojas Sinha <sinhaojas67@gmail.com>
> ---
>  drivers/tty/amiserial.c | 154 ++++++++++++++++++++--------------------
>  1 file changed, 77 insertions(+), 77 deletions(-)
> 
> diff --git a/drivers/tty/amiserial.c b/drivers/tty/amiserial.c
> index afb2d373dd47..6eb57677cbba 100644
> --- a/drivers/tty/amiserial.c
> +++ b/drivers/tty/amiserial.c
> @@ -17,7 +17,7 @@
>   * Richard Lucock 28/12/99
>   *
>   *  Copyright (C) 1991, 1992  Linus Torvalds
> - *  Copyright (C) 1992, 1993, 1994, 1995, 1996, 1997, 
> + *  Copyright (C) 1992, 1993, 1994, 1995, 1996, 1997,
>   * 		1998, 1999  Theodore Ts'o
>   *
>   */
> @@ -175,7 +175,7 @@ static void rs_start(struct tty_struct *tty)
>  
>  static void receive_chars(struct serial_state *info)
>  {
> -        int status;
> +	int status;
>  	int serdatr;
>  	unsigned char ch, flag;
>  	struct	async_icount *icount;
> @@ -189,9 +189,9 @@ static void receive_chars(struct serial_state *info)
>  	amiga_custom.intreq = IF_RBF;
>  	mb();
>  
> -	if((serdatr & 0x1ff) == 0)
> +	if ((serdatr & 0x1ff) == 0)
>  	    status |= UART_LSR_BI;
> -	if(serdatr & SDR_OVRUN)
> +	if (serdatr & SDR_OVRUN)
>  	    status |= UART_LSR_OE;
>  
>  	ch = serdatr & 0xff;
> @@ -266,7 +266,7 @@ static void transmit_chars(struct serial_state *info)
>  	amiga_custom.intreq = IF_TBE;
>  	mb();
>  	if (info->x_char) {
> -	        amiga_custom.serdat = info->x_char | 0x100;
> +		amiga_custom.serdat = info->x_char | 0x100;
>  		mb();
>  		info->icount.tx++;
>  		info->x_char = 0;
> @@ -276,7 +276,7 @@ static void transmit_chars(struct serial_state *info)
>  	    || info->tport.tty->flow.stopped
>  	    || info->tport.tty->hw_stopped) {
>  		info->IER &= ~UART_IER_THRI;
> -	        amiga_custom.intena = IF_TBE;
> +		amiga_custom.intena = IF_TBE;
>  		mb();
>  		return;
>  	}
> @@ -295,7 +295,7 @@ static void transmit_chars(struct serial_state *info)
>  	printk("THRE...");
>  #endif
>  	if (info->xmit.head == info->xmit.tail) {
> -	        amiga_custom.intena = IF_TBE;
> +		amiga_custom.intena = IF_TBE;
>  		mb();
>  		info->IER &= ~UART_IER_THRI;
>  	}
> @@ -373,15 +373,15 @@ static void check_modem_status(struct serial_state *info)
>  	}
>  }
>  
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
> +	if (info->IER & UART_IER_MSI)
>  	  check_modem_status(info);
>  	return IRQ_HANDLED;
>  }
> @@ -443,7 +443,7 @@ static int startup(struct tty_struct *tty, struct serial_state *info)
>  {
>  	struct tty_port *port = &info->tport;
>  	unsigned long flags;
> -	int	retval=0;
> +	int	retval = 0;
>  	unsigned long page;
>  
>  	page = get_zeroed_page(GFP_KERNEL);
> @@ -664,7 +664,7 @@ static void change_speed(struct tty_struct *tty, struct serial_state *info,
>  	if (I_IGNBRK(tty)) {
>  		info->ignore_status_mask |= UART_LSR_BI;
>  		/*
> -		 * If we're ignore parity and break indicators, ignore 
> +		 * If we're ignore parity and break indicators, ignore
>  		 * overruns too.  (For real raw support).
>  		 */
>  		if (I_IGNPAR(tty))
> @@ -685,7 +685,7 @@ static void change_speed(struct tty_struct *tty, struct serial_state *info,
>  
>  	/* Enable or disable parity bit */
>  
> -	if(cval & UART_LCR_PARITY)
> +	if (cval & UART_LCR_PARITY)
>  	  serper |= (SERPER_PARENB);
>  
>  	amiga_custom.serper = serper;
> @@ -740,7 +740,7 @@ static void rs_flush_chars(struct tty_struct *tty)
>  	local_irq_restore(flags);
>  }
>  
> -static int rs_write(struct tty_struct * tty, const unsigned char *buf, int count)
> +static int rs_write(struct tty_struct *tty, const unsigned char *buf, int count)
>  {
>  	int	c, ret = 0;
>  	struct serial_state *info = tty->driver_data;
> @@ -816,15 +816,15 @@ static void rs_flush_buffer(struct tty_struct *tty)
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
> +		/* Check this ! */
> +		local_irq_save(flags);
> +		if (!(amiga_custom.intenar & IF_TBE)) {
>  		    amiga_custom.intena = IF_SETCLR | IF_TBE;
>  		    mb();
>  		    /* set a pending Tx Interrupt, transmitter should restart now */
> @@ -840,12 +840,12 @@ static void rs_send_xchar(struct tty_struct *tty, char ch)
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
> @@ -864,7 +864,7 @@ static void rs_throttle(struct tty_struct * tty)
>  	local_irq_restore(flags);
>  }
>  
> -static void rs_unthrottle(struct tty_struct * tty)
> +static void rs_unthrottle(struct tty_struct *tty)
>  {
>  	struct serial_state *info = tty->driver_data;
>  	unsigned long flags;
> @@ -990,7 +990,7 @@ static int set_serial_info(struct tty_struct *tty, struct serial_struct *ss)
>   * 	    release the bus after transmitting. This must be done when
>   * 	    the transmit shift register is empty, not be done when the
>   * 	    transmit holding register is empty.  This functionality
> - * 	    allows an RS485 driver to be written in user space. 
> + * 	    allows an RS485 driver to be written in user space.
>   */
>  static int get_lsr_info(struct serial_state *info, unsigned int __user *value)
>  {
> @@ -1117,54 +1117,54 @@ static int rs_ioctl(struct tty_struct *tty,
>  	}
>  
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
> -		/*
> -		 * Wait for any of the 4 modem inputs (DCD,RI,DSR,CTS) to change
> -		 * - mask passed in arg for lines of interest
> - 		 *   (use |'ed TIOCM_RNG/DSR/CD/CTS for masking)
> -		 * Caller should use TIOCGICOUNT to see which one it was
> -		 */
> -		case TIOCMIWAIT:
> +	/*
> +	 * Wait for any of the 4 modem inputs (DCD,RI,DSR,CTS) to change
> +	 * - mask passed in arg for lines of interest
> + 	 *   (use |'ed TIOCM_RNG/DSR/CD/CTS for masking)
> +	 * Caller should use TIOCGICOUNT to see which one it was
> +	 */
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
> +			    cnow.dcd == cprev.dcd && cnow.cts == cprev.cts) {
> +				ret = -EIO; /* no change => error */
> +				break;
> +			}
> +			if (((arg & TIOCM_RNG) && (cnow.rng != cprev.rng)) ||
> +			     ((arg & TIOCM_DSR) && (cnow.dsr != cprev.dsr)) ||
> +			     ((arg & TIOCM_CD)  && (cnow.dcd != cprev.dcd)) ||
> +			     ((arg & TIOCM_CTS) && (cnow.cts != cprev.cts))) {
> +				ret = 0;
> +				break;
>  			}
> -			finish_wait(&info->tport.delta_msr_wait, &wait);
> -			return ret;
> +			schedule();
> +			/* see if a signal did it */
> +			if (signal_pending(current)) {
> +				ret = -ERESTARTSYS;
> +				break;
> +			}
> +			cprev = cnow;
> +		}
> +		finish_wait(&info->tport.delta_msr_wait, &wait);
> +		return ret;
>  
> -		default:
> -			return -ENOIOCTLCMD;
> +	default:
> +		return -ENOIOCTLCMD;
>  		}
>  	return 0;
>  }
> @@ -1216,14 +1216,14 @@ static void rs_set_termios(struct tty_struct *tty, struct ktermios *old_termios)
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
> @@ -1239,8 +1239,8 @@ static void rs_close(struct tty_struct *tty, struct file * filp)
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
> @@ -1255,7 +1255,7 @@ static void rs_close(struct tty_struct *tty, struct file * filp)
>  	}
>  	shutdown(tty, state);
>  	rs_flush_buffer(tty);
> -		
> +
>  	tty_ldisc_flush(tty);
>  	port->tty = NULL;
>  
> @@ -1277,7 +1277,7 @@ static void rs_wait_until_sent(struct tty_struct *tty, int timeout)
>  	 * Set the check interval to be 1/5 of the estimated time to
>  	 * send a single character, and make it at least 1.  The check
>  	 * interval should also be less than the timeout.
> -	 * 
> +	 *
>  	 * Note: we have to use pretty tight timings here to satisfy
>  	 * the NIST-PCTS.
>  	 */
> @@ -1302,7 +1302,7 @@ static void rs_wait_until_sent(struct tty_struct *tty, int timeout)
>  	printk("In rs_wait_until_sent(%d) check=%lu...", timeout, char_time);
>  	printk("jiff=%lu...", jiffies);
>  #endif
> -	while(!((lsr = amiga_custom.serdatr) & SDR_TSRE)) {
> +	while (!((lsr = amiga_custom.serdatr) & SDR_TSRE)) {
>  #ifdef SERIAL_DEBUG_RS_WAIT_UNTIL_SENT
>  		printk("serdatr = %d (jiff=%lu)...", lsr, jiffies);
>  #endif
> @@ -1340,7 +1340,7 @@ static void rs_hangup(struct tty_struct *tty)
>   * the IRQ chain.   It also performs the serial-specific
>   * initialization for the tty structure.
>   */
> -static int rs_open(struct tty_struct *tty, struct file * filp)
> +static int rs_open(struct tty_struct *tty, struct file *filp)
>  {
>  	struct tty_port *port = tty->port;
>  	struct serial_state *info = container_of(port, struct serial_state,
> @@ -1378,15 +1378,15 @@ static inline void line_info(struct seq_file *m, int line,
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
> -- 
> 2.36.1
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

- Your patch did many different things all at once, making it difficult
  to review.  All Linux kernel patches need to only do one thing at a
  time.  If you need to do multiple things (such as clean up all coding
  style issues in a file/driver), do it in a sequence of patches, each
  one doing only one thing.  This will make it easier to review the
  patches to ensure that they are correct, and to help alleviate any
  merge issues that larger patches can cause.

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
