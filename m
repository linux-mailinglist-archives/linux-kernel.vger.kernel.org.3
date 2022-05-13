Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42547525C2B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 09:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377663AbiEMHIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 03:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353010AbiEMHIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 03:08:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC6D5223871;
        Fri, 13 May 2022 00:08:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 149C661ED9;
        Fri, 13 May 2022 07:08:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B20DC34100;
        Fri, 13 May 2022 07:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652425679;
        bh=9y6I+zGmd3GgMAr3xMYF8f/9wN8gZjKyrU/pked7eeI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qtUGhM+tgX4cVprBvh+OaGIZuEEJA14BC4ou4Dvi/uCvgmJ2T36OwMc75kl0YvcQ2
         l75ILJatDJWEmy0N3dlsyJH6oaW4qRGOGSjEyATxdqGhfg6MSpYTwcAVEmm9Eri3/M
         IfGYr3Oy4s03eMDXp5ws4S5N29j/B2pAfE5ZLdTKWuwbjSd2GSkNH3dQfc8VlY6Gme
         WUctwRHZQN6FR7vVprQGsRBWa9+gGjVBH22G54xD+F4RxDjKimC/jfnWrb2oa7oG/F
         pQWvWlaus3R5HkP2dRzUZ/DT8EV2j2ECEQca1AOZ+Br0bWlN7e95wX1l/KT+34peJo
         ZPmk0PV24iAMw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1npPP1-0006dr-1W; Fri, 13 May 2022 09:07:55 +0200
Date:   Fri, 13 May 2022 09:07:55 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] tty/termbits: remove #ifdef BOTHER that is always
 defined
Message-ID: <Yn4DyxIUBsEQxj+t@hovoldconsulting.com>
References: <20220511101139.5306-1-ilpo.jarvinen@linux.intel.com>
 <20220511101139.5306-3-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220511101139.5306-3-ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 01:11:36PM +0300, Ilpo Järvinen wrote:
> BOTHER is defined by all architectures.

This changed quite recently so please mention the commit in question.

No need for the verbose Subject here either.

> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/tty/mxser.c        |  2 --
>  drivers/tty/tty_baudrate.c | 20 +++++---------------
>  drivers/tty/tty_ioctl.c    |  2 --
>  3 files changed, 5 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
> index 6ebd3e4ed859..9ea7bd059d0f 100644
> --- a/drivers/tty/mxser.c
> +++ b/drivers/tty/mxser.c
> @@ -528,7 +528,6 @@ static int mxser_set_baud(struct tty_struct *tty, speed_t newspd)
>  	outb(quot >> 8, info->ioaddr + UART_DLM);	/* MS of divisor */
>  	outb(cval, info->ioaddr + UART_LCR);	/* reset DLAB */
>  
> -#ifdef BOTHER
>  	if (C_BAUD(tty) == BOTHER) {
>  		quot = MXSER_BAUD_BASE % newspd;
>  		quot *= 8;
> @@ -540,7 +539,6 @@ static int mxser_set_baud(struct tty_struct *tty, speed_t newspd)
>  
>  		mxser_set_must_enum_value(info->ioaddr, quot);
>  	} else
> -#endif
>  		mxser_set_must_enum_value(info->ioaddr, 0);

When removing the ifdef, please add the missing bracket to the else
branch as per the coding standard.

Johan
