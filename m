Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A24E54F0AAB
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 17:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355481AbiDCPiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 11:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232259AbiDCPiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 11:38:04 -0400
Received: from gateway22.websitewelcome.com (gateway22.websitewelcome.com [192.185.46.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51AB927163
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 08:36:09 -0700 (PDT)
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway22.websitewelcome.com (Postfix) with ESMTP id C94DFCF73
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 10:36:08 -0500 (CDT)
Received: from 162-215-252-75.unifiedlayer.com ([208.91.199.152])
        by cmsmtp with SMTP
        id b2Gunbu3j22u3b2GunkLeS; Sun, 03 Apr 2022 10:36:08 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=S9kyq3prUNE5HlsvNUnZDxnM3YNPjxnZKzbpLeHWtg4=; b=c4M3VL07wbRVvrKjSmkp3QOqSm
        adMlo6Kg9Lb2yNZPZmvLcKrDA80lw6W8IB3lcd3ZKvvVsDULx/j5jplAbY1fGHzIx1mdUt9gDNv/l
        DkfYW97FxsYWpgOi3BvWbWznBqOd8sZYr92Cnk3E31b7R4mXu9C+P5Ry32/pPRgjndrGoqiVcwNci
        FWCIlY0obiz+wrK9jriGBEv8KCeeLK1hC5g7RveJhCuwee7vpws0ZbSsepsVBgQEa11dhLKQVOsFa
        5b6sqe/WGpbfGac+nFqETCb8y5TPdwIcXM7V6Y1DzbCt0gmprSJ9dkb9H5HwDNmdSJWo/8Una13nj
        1L9MH6kQ==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:57822 helo=localhost)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@roeck-us.net>)
        id 1nb2Gu-0041Pb-Cx; Sun, 03 Apr 2022 15:36:08 +0000
Date:   Sun, 3 Apr 2022 08:36:07 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] tty: serial: mpc52xx_uart: make rx/tx hooks return
 unsigned
Message-ID: <20220403153607.GA3644508@roeck-us.net>
References: <20220224111028.20917-1-jslaby@suse.cz>
 <20220224111028.20917-2-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224111028.20917-2-jslaby@suse.cz>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1nb2Gu-0041Pb-Cx
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (localhost) [108.223.40.66]:57822
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 1
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 12:10:24PM +0100, Jiri Slaby wrote:
> All these return bitmasks, so it makes more sense to return unsigned --
> this is what a reader and also all the callers expect.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>

With this patch in place:

drivers/tty/serial/mpc52xx_uart.c:static unsigned int mpc52xx_psc_raw_tx_rdy(struct uart_port *port)
drivers/tty/serial/mpc52xx_uart.c:static int mpc512x_psc_raw_tx_rdy(struct uart_port *port)
                                         ^^^
drivers/tty/serial/mpc52xx_uart.c:static int mpc5125_psc_raw_tx_rdy(struct uart_port *port)
                                         ^^^

Same for other functions. This results in lots of compile errors.

Guenter

> ---
>  drivers/tty/serial/mpc52xx_uart.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/tty/serial/mpc52xx_uart.c b/drivers/tty/serial/mpc52xx_uart.c
> index 2704dc988e4a..8a6958377764 100644
> --- a/drivers/tty/serial/mpc52xx_uart.c
> +++ b/drivers/tty/serial/mpc52xx_uart.c
> @@ -83,11 +83,11 @@ static irqreturn_t mpc5xxx_uart_process_int(struct uart_port *port);
>  
>  struct psc_ops {
>  	void		(*fifo_init)(struct uart_port *port);
> -	int		(*raw_rx_rdy)(struct uart_port *port);
> -	int		(*raw_tx_rdy)(struct uart_port *port);
> -	int		(*rx_rdy)(struct uart_port *port);
> -	int		(*tx_rdy)(struct uart_port *port);
> -	int		(*tx_empty)(struct uart_port *port);
> +	unsigned int	(*raw_rx_rdy)(struct uart_port *port);
> +	unsigned int	(*raw_tx_rdy)(struct uart_port *port);
> +	unsigned int	(*rx_rdy)(struct uart_port *port);
> +	unsigned int	(*tx_rdy)(struct uart_port *port);
> +	unsigned int	(*tx_empty)(struct uart_port *port);
>  	void		(*stop_rx)(struct uart_port *port);
>  	void		(*start_tx)(struct uart_port *port);
>  	void		(*stop_tx)(struct uart_port *port);
> @@ -203,34 +203,34 @@ static void mpc52xx_psc_fifo_init(struct uart_port *port)
>  	out_be16(&psc->mpc52xx_psc_imr, port->read_status_mask);
>  }
>  
> -static int mpc52xx_psc_raw_rx_rdy(struct uart_port *port)
> +static unsigned int mpc52xx_psc_raw_rx_rdy(struct uart_port *port)
>  {
>  	return in_be16(&PSC(port)->mpc52xx_psc_status)
>  	    & MPC52xx_PSC_SR_RXRDY;
>  }
>  
> -static int mpc52xx_psc_raw_tx_rdy(struct uart_port *port)
> +static unsigned int mpc52xx_psc_raw_tx_rdy(struct uart_port *port)
>  {
>  	return in_be16(&PSC(port)->mpc52xx_psc_status)
>  	    & MPC52xx_PSC_SR_TXRDY;
>  }
>  
>  
> -static int mpc52xx_psc_rx_rdy(struct uart_port *port)
> +static unsigned int mpc52xx_psc_rx_rdy(struct uart_port *port)
>  {
>  	return in_be16(&PSC(port)->mpc52xx_psc_isr)
>  	    & port->read_status_mask
>  	    & MPC52xx_PSC_IMR_RXRDY;
>  }
>  
> -static int mpc52xx_psc_tx_rdy(struct uart_port *port)
> +static unsigned int mpc52xx_psc_tx_rdy(struct uart_port *port)
>  {
>  	return in_be16(&PSC(port)->mpc52xx_psc_isr)
>  	    & port->read_status_mask
>  	    & MPC52xx_PSC_IMR_TXRDY;
>  }
>  
> -static int mpc52xx_psc_tx_empty(struct uart_port *port)
> +static unsigned int mpc52xx_psc_tx_empty(struct uart_port *port)
>  {
>  	u16 sts = in_be16(&PSC(port)->mpc52xx_psc_status);
>  
> @@ -1365,7 +1365,7 @@ static const struct uart_ops mpc52xx_uart_ops = {
>  /* Interrupt handling                                                       */
>  /* ======================================================================== */
>  
> -static inline int
> +static inline unsigned int
>  mpc52xx_uart_int_rx_chars(struct uart_port *port)
>  {
>  	struct tty_port *tport = &port->state->port;
> -- 
> 2.35.1
> 
