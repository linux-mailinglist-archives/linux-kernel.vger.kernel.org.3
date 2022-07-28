Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E497D58415E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 16:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232248AbiG1OeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 10:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232152AbiG1Odq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 10:33:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF64C70E5F
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 07:31:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 21EBA60D3F
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 14:31:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D52BC433D7;
        Thu, 28 Jul 2022 14:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659018671;
        bh=rEZ3HWyilQRmsTqLC6tsvT1vq4xR57sJHYAQ7hOZ6LY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2esncDzSSQ37LN8wjBeYZ8DiM3VNOhWHTvoWFsPcQgixbWbW9zzYd+Br47JiFlDrv
         TWKCplBLWDRQ7SDkFfYyjnKArdzyH3CQXeltfbvRgzvJEn32tKj6iZUTtzTeT+5/3k
         qCE4Su+Te60/gg7JxBS5CeoGs+dNA1FuGFVLygD0=
Date:   Thu, 28 Jul 2022 16:31:08 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jason Wang <wangborong@cdjrlc.com>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] init: Fix comment typo
Message-ID: <YuKdrLqHRsoBbiDF@kroah.com>
References: <20220715051033.27972-1-wangborong@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220715051033.27972-1-wangborong@cdjrlc.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2022 at 01:10:33PM +0800, Jason Wang wrote:
> The double `core' is duplicated in line 33, remove one.
> 
> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
> ---
>  drivers/base/init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/base/init.c b/drivers/base/init.c
> index 397eb9880cec..ae75ed7bbc41 100644
> --- a/drivers/base/init.c
> +++ b/drivers/base/init.c
> @@ -30,7 +30,7 @@ void __init driver_init(void)
>  	hypervisor_init();
>  
>  	/* These are also core pieces, but must come after the
> -	 * core core pieces.
> +	 * core pieces.

Nope, the original is correct here, please read it again.

greg k-h
