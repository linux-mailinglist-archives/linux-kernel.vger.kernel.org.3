Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78DF7584DD3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 11:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235516AbiG2JHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 05:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbiG2JHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 05:07:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107DA84EEA
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 02:07:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 72C5BB826F0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 09:07:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C751FC433D6;
        Fri, 29 Jul 2022 09:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659085661;
        bh=4fwOa4L80btdPUQ6tY3Y/SsKFmMhkgyP5o1hf2otJ5Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jQ5iR/3pFPrVxO7ZExQzpcBJpTE11inHfjTqO3Y8IRF1WLOU7GeXRcZh/RzVecDDX
         7sw3SwcyelgbBqvtbnoybzm0+ynwq197FCEZlQZ7+xEmuPn5VGK1MZDFnBLL9WGusJ
         2Skh+yB7IdmY67ZIG0WTKv8N7oRzzGbfxa39bmJo=
Date:   Fri, 29 Jul 2022 11:07:38 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mingyi Kang <jerrykang026@gmail.com>
Cc:     martyn@welchs.me.uk, manohar.vanga@gmail.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: vme_user: Put quoted string in a single line
Message-ID: <YuOjWlnHX6SwhNKj@kroah.com>
References: <20220729084806.22479-1-jerrykang026@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220729084806.22479-1-jerrykang026@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2022 at 04:48:06PM +0800, Mingyi Kang wrote:
> This patch resolves the follwing checkpatch warnings:
> 
> WARNING: quoted string split across lines
> +			dev_err(tsi148_bridge->parent, "VME Mailbox %d received"
> +				": 0x%x\n", i, val);
> 
> WARNING: quoted string split across lines
> +	dev_err(tsi148_bridge->parent, "PCI Exception at address: 0x%08x:%08x, "
> +		"attributes: %08x\n",
> 
> WARNING: quoted string split across lines
> +	dev_err(tsi148_bridge->parent, "PCI-X attribute reg: %08x, PCI-X split "
> +		"completion reg: %08x\n",
> 
> WARNING: quoted string split across lines
> +		dev_err(tsi148_bridge->parent, "VME Bus Exception Overflow "
> +			"Occurred\n");
> 
> WARNING: quoted string split across lines
> +		dev_err(tsi148_bridge->parent, "Can't get assigned pci irq "
> +			"vector %02X\n", pdev->irq);
> 
> WARNING: quoted string split across lines
> +		dev_err(tsi148_bridge->parent, "Failed to allocate mem "
> +			"resource for window %d size 0x%lx start 0x%lx\n",
> 
> WARNING: quoted string split across lines
> +		dev_err(tsi148_bridge->parent, "Invalid VME Window "
> +			"alignment\n");
> WARNING: quoted string split across lines
> +		dev_err(tsi148_bridge->parent, "Size must be non-zero for "
> +			"enabled windows\n");
> 
> WARNING: quoted string split across lines
> +		dev_err(tsi148_bridge->parent, "Unable to allocate memory for "
> +			"resource\n");
> 
> WARNING: quoted string split across lines
> +		dev_err(tsi148_bridge->parent, "Invalid VME Offset "
> +			"alignment\n");
> 
> WARNING: quoted string split across lines
> +		dev_warn(tsi148_bridge->parent, "Currently not setting "
> +			"Broadcast Select Registers\n");
> 
> WARNING: quoted string split across lines
> +		dev_err(dev, "Currently not setting Broadcast Select "
> +			"Registers\n");
> 
> WARNING: quoted string split across lines
> +		dev_err(dev, "Currently not setting Broadcast Select "
> +			"Registers\n");
> 
> WARNING: quoted string split across lines
> +		dev_err(tsi148_bridge->parent, "Descriptor not aligned to 8 "
> +			"byte boundary as required: %p\n",
> 
> warning: quoted string split across lines
> +			dev_err(tsi148_bridge->parent, "location monitor "
> +				"callback attached, can't reset\n");
> 
> WARNING: quoted string split across lines
> +		dev_err(tsi148_bridge->parent, "Location monitor not properly "
> +			"configured\n");
> 
> WARNING: quoted string split across lines
> +		dev_err(tsi148_bridge->parent, "Failed to allocate memory for "
> +			"CR/CSR image\n");
> 
> WARNING: quoted string split across lines
> +			dev_err(tsi148_bridge->parent, "Configuring flush image"
> +				" failed\n");
> 
> Signed-off-by: Mingyi Kang <jerrykang026@gmail.com>
> ---
>  drivers/staging/vme_user/vme_tsi148.c | 57 +++++++++------------------
>  1 file changed, 19 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/staging/vme_user/vme_tsi148.c b/drivers/staging/vme_user/vme_tsi148.c
> index 956476213241..40bb432861c8 100644
> --- a/drivers/staging/vme_user/vme_tsi148.c
> +++ b/drivers/staging/vme_user/vme_tsi148.c
> @@ -125,8 +125,7 @@ static u32 tsi148_MB_irqhandler(struct vme_bridge *tsi148_bridge, u32 stat)
>  	for (i = 0; i < 4; i++) {
>  		if (stat & TSI148_LCSR_INTS_MBS[i]) {
>  			val = ioread32be(bridge->base +	TSI148_GCSR_MBOX[i]);
> -			dev_err(tsi148_bridge->parent, "VME Mailbox %d received"
> -				": 0x%x\n", i, val);
> +			dev_err(tsi148_bridge->parent, "VME Mailbox %d received: 0x%x\n", i, val);

Unwrapping the string is fine, but not the arguments.  Did you run
checkpatch on this change?  I see some warnings on it, please don't
introduce new ones.

thanks,

greg k-h
