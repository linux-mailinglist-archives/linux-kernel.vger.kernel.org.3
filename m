Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 380DB5826C8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 14:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233250AbiG0MhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 08:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232306AbiG0MhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 08:37:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9278D2F39D;
        Wed, 27 Jul 2022 05:37:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E256DB82110;
        Wed, 27 Jul 2022 12:37:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3693DC433C1;
        Wed, 27 Jul 2022 12:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658925435;
        bh=FcC0gC1xLPcLA9GRYOYnjIS552FK1zWq5KMKcekOllM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2MgWypE/NorWoguCTOrtK73Am2fnNirXGsNW9uJNiHSAME6ezqb3kFKjA4xHphCV9
         WuAsU8hfR7Q5g4brxAN5P3rKkDMBmxzrhIRvNzNLhxtcy7CdIAtBupWmKkAAb5Qeu9
         FEqxOmroUgcB7vACofiyu5i542r1mnslI5gcrFMc=
Date:   Wed, 27 Jul 2022 14:37:13 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Slark Xiao <slark_xiao@163.com>
Cc:     mathias.nyman@intel.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH] xhci: Fix typo 'the the' in comment
Message-ID: <YuExeRQp4aHZ4Viy@kroah.com>
References: <20220722095325.78891-1-slark_xiao@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220722095325.78891-1-slark_xiao@163.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 22, 2022 at 05:53:25PM +0800, Slark Xiao wrote:
> Replace 'the the' with 'the' in the comment.
> 
> Signed-off-by: Slark Xiao <slark_xiao@163.com>
> ---
>  drivers/usb/host/xhci-ring.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
> index 46d0b9ad6f74..ad81e9a508b1 100644
> --- a/drivers/usb/host/xhci-ring.c
> +++ b/drivers/usb/host/xhci-ring.c
> @@ -1964,7 +1964,7 @@ static void handle_port_status(struct xhci_hcd *xhci,
>  
>  	/*
>  	 * Check to see if xhci-hub.c is waiting on RExit to U0 transition (or
> -	 * RExit to a disconnect state).  If so, let the the driver know it's
> +	 * RExit to a disconnect state).  If so, let the driver know it's
>  	 * out of the RExit state.
>  	 */
>  	if (!DEV_SUPERSPEED_ANY(portsc) && hcd->speed < HCD_USB3 &&
> -- 
> 2.25.1
> 

Someone else already sent this before you did, sorry.
