Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24B3B4BDD41
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:45:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353351AbiBUKU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 05:20:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353310AbiBUKUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 05:20:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C467C3BA64;
        Mon, 21 Feb 2022 01:39:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 60271B80EBB;
        Mon, 21 Feb 2022 09:39:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25F56C340E9;
        Mon, 21 Feb 2022 09:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645436396;
        bh=rhiY1Uq54BfvApTWrJAP4qVMye7jLI87y2X4/jm+Vn0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rV8/iIeI2gv4XgE5LeP87TlJApRVoyK2FYzsywB4zrAAHp2p+pRLdRJ0mdMZXkmac
         h4eTgming5tDRtu68iz8N0wmblJSWVtAvxpP4lPZ5pdlVmwvYCi+7RKc8Ra7tPbi78
         f/pOnxe09KtJv33UWdOIy69fBbpuP9N3il9OXLvKKQWeEDTqgu0IgSLqC3GXtvL2Ar
         ipuXH2YL2A+mvDOsjAiceQSKdahuOmYvyUmr5xaHFUIajkLV05zedkm6TiTW1wyexG
         bdEIc5e/CH2js960foduTAXQ1e04HV5aM8d5MwJt38fXuA2otJ/AAEyHol7z5Y6kgA
         XPlqa4+xhSQAg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nM5Af-0007A3-8o; Mon, 21 Feb 2022 10:39:53 +0100
Date:   Mon, 21 Feb 2022 10:39:53 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Husni Faiz <ahamedhusni73@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] usb: serial: Fix Coding Style Error Around
 Ternary Operator
Message-ID: <YhNd6R3WtSIfjnY8@hovoldconsulting.com>
References: <20220212175510.521072-1-ahamedhusni73@gmail.com>
 <20220220131405.179732-1-ahamedhusni73@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220220131405.179732-1-ahamedhusni73@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 20, 2022 at 06:44:05PM +0530, Husni Faiz wrote:
> This patch fixes "spaces required around that '?'"  checkpatch error
> Added a space before the "?" ternary operator.
> 
> Signed-off-by: Husni Faiz <ahamedhusni73@gmail.com>
> ---
> V1->V2 : Separated the style changes into multiple patches.
> 
>  drivers/usb/serial/cp210x.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
> index 8a60c0d56863..1fcdfb7d118c 100644
> --- a/drivers/usb/serial/cp210x.c
> +++ b/drivers/usb/serial/cp210x.c
> @@ -1403,7 +1403,7 @@ static int cp210x_tiocmget(struct tty_struct *tty)
>  		|((control & CONTROL_RTS) ? TIOCM_RTS : 0)
>  		|((control & CONTROL_CTS) ? TIOCM_CTS : 0)
>  		|((control & CONTROL_DSR) ? TIOCM_DSR : 0)
> -		|((control & CONTROL_RING)? TIOCM_RI  : 0)
> +		|((control & CONTROL_RING) ? TIOCM_RI  : 0)
>  		|((control & CONTROL_DCD) ? TIOCM_CD  : 0);

I'm pretty sure the author intended the TIOCM arguments to be aligned
here.

But in any case, I'm not taking checkpatch.pl clean ups unless you're
also doing real changes to the code in question.

>  	dev_dbg(&port->dev, "%s - control = 0x%02x\n", __func__, control);

Johan
