Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 115BD54CAC1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 16:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355892AbiFOOCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 10:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355813AbiFOOCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 10:02:03 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7C34839C;
        Wed, 15 Jun 2022 07:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655301699; x=1686837699;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=qgHM8XmLxIPsBfIw5yleLnkXDEbC8DohJ794buDpozg=;
  b=ZqWFS4P2r1VHIlexrh7WQZ6f18JhglbGCuUNibVkW/x3VdgyyYg+mVgj
   AgD65vYZL4rb83IhlWQbao8/6wpiKMJv8RlYYx3ol8ih6bIlyzWY2SGQk
   MmAN2CUDtub99CXIil7wMwMBr33YWue+18My6QtOolkz27+JeidR5w/Fm
   JbsIJ0z2xgjpyn2LFfI7ZW2E0NFBOfl+AAVMMVpufCyAiOJAydSfAqN1m
   cB1bZ7R2DSMzrO8kEy3XhQym5NkURf/OKfrdBbSemQb8zABCihoZx5IBk
   ffKTgXihVBcJTGVrs7CAmP3wbCG6YBbI1h0q2HfDPtabaXaYdfzwf3UNy
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="261991712"
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="261991712"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 07:01:38 -0700
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="536048530"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 07:01:36 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1o1TaO-000dU9-Rm;
        Wed, 15 Jun 2022 17:01:32 +0300
Date:   Wed, 15 Jun 2022 17:01:32 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>
Subject: Re: [PATCH v7 2/6] serial: 8250: create lsr_save_mask
Message-ID: <YqnmPHB8qBXIBou+@smile.fi.intel.com>
References: <20220615124829.34516-1-ilpo.jarvinen@linux.intel.com>
 <20220615124829.34516-3-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220615124829.34516-3-ilpo.jarvinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 03:48:25PM +0300, Ilpo Järvinen wrote:
> Allow drivers to alter LSR save mask.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/tty/serial/8250/8250.h      | 2 +-
>  drivers/tty/serial/8250/8250_core.c | 4 ++++
>  drivers/tty/serial/8250/8250_dw.c   | 2 +-
>  include/linux/serial_8250.h         | 1 +
>  4 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
> index 0ff5688ba90c..5cc967fe3b59 100644
> --- a/drivers/tty/serial/8250/8250.h
> +++ b/drivers/tty/serial/8250/8250.h
> @@ -138,7 +138,7 @@ static inline u16 serial_lsr_in(struct uart_8250_port *up)
>  	u16 lsr = up->lsr_saved_flags;
>  
>  	lsr |= serial_in(up, UART_LSR);
> -	up->lsr_saved_flags = lsr & LSR_SAVE_FLAGS;
> +	up->lsr_saved_flags = lsr & up->lsr_save_mask;
>  
>  	return lsr;
>  }
> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
> index 90ddc8924811..57e86133af4f 100644
> --- a/drivers/tty/serial/8250/8250_core.c
> +++ b/drivers/tty/serial/8250/8250_core.c
> @@ -1007,6 +1007,7 @@ int serial8250_register_8250_port(const struct uart_8250_port *up)
>  		uart->port.rs485	= up->port.rs485;
>  		uart->rs485_start_tx	= up->rs485_start_tx;
>  		uart->rs485_stop_tx	= up->rs485_stop_tx;
> +		uart->lsr_save_mask	= up->lsr_save_mask;
>  		uart->dma		= up->dma;
>  
>  		/* Take tx_loadsz from fifosize if it wasn't set separately */
> @@ -1094,6 +1095,9 @@ int serial8250_register_8250_port(const struct uart_8250_port *up)
>  			ret = 0;
>  		}
>  
> +		if (!uart->lsr_save_mask)
> +			uart->lsr_save_mask = LSR_SAVE_FLAGS;	/* Use default LSR mask */
> +
>  		/* Initialise interrupt backoff work if required */
>  		if (up->overrun_backoff_time_ms > 0) {
>  			uart->overrun_backoff_time_ms =
> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
> index 4cc69bb612ab..167a691c7b19 100644
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c
> @@ -129,7 +129,7 @@ static void dw8250_tx_wait_empty(struct uart_port *p)
>  
>  	while (tries--) {
>  		lsr = readb (p->membase + (UART_LSR << p->regshift));
> -		up->lsr_saved_flags |= lsr & LSR_SAVE_FLAGS;
> +		up->lsr_saved_flags |= lsr & up->lsr_save_mask;
>  
>  		if (lsr & UART_LSR_TEMT)
>  			break;
> diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
> index 4565f25ba9a2..8c7b793aa4d7 100644
> --- a/include/linux/serial_8250.h
> +++ b/include/linux/serial_8250.h
> @@ -120,6 +120,7 @@ struct uart_8250_port {
>  	 */
>  #define LSR_SAVE_FLAGS UART_LSR_BRK_ERROR_BITS
>  	u16			lsr_saved_flags;
> +	u16			lsr_save_mask;
>  #define MSR_SAVE_FLAGS UART_MSR_ANY_DELTA
>  	unsigned char		msr_saved_flags;
>  
> -- 
> 2.30.2
> 

-- 
With Best Regards,
Andy Shevchenko


