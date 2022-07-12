Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9290A5711D9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 07:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbiGLFaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 01:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbiGLFaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 01:30:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E88683F15
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 22:30:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B8ADCB8112C
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 05:30:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCD9BC3411E;
        Tue, 12 Jul 2022 05:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657603815;
        bh=Ygh8SW4GAmx2XClGCVdfSmQtTLNfRKvXfnXGOUWFjs0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l8C56UUplHDjG3l8iSNpb6WVZgK8Huw3rjOC9UZfSUzynQ9jLT4PXx5ixkXcEokYI
         hSjQuthiqNf8giIivoGRBRsyem21B2Y1nqoHh0qfPtmcPZErVN/LcllXneFtdyG8uD
         YkwYci8o/se6fnY0+A8IlKGqg06VqWEsMJDslFvE=
Date:   Tue, 12 Jul 2022 07:30:11 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Shinyzenith <aakashsensharma@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: android: bind_alloc: asm/cacheflush to
 linux/cacheflush
Message-ID: <Ys0G4/HybcaS4GA0@kroah.com>
References: <20220711213059.7197-1-aakashsensharma@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220711213059.7197-1-aakashsensharma@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 03:00:59AM +0530, Shinyzenith wrote:
> * Removing checkpatch warnings.
> * No functional changes.
> 
> Signed-off-by: Shinyzenith <aakashsensharma@gmail.com>
> ---
>  drivers/android/binder_alloc.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
> index 5649a0371a1f..795132af0c15 100644
> --- a/drivers/android/binder_alloc.c
> +++ b/drivers/android/binder_alloc.c
> @@ -1,6 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> -/* binder_alloc.c
> - *
> +/*
>   * Android IPC Subsystem
>   *
>   * Copyright (C) 2007-2017 Google, Inc.
> @@ -19,7 +18,7 @@
>  #include <linux/sched.h>
>  #include <linux/list_lru.h>
>  #include <linux/ratelimit.h>
> -#include <asm/cacheflush.h>
> +#include <linux/cacheflush.h>
>  #include <linux/uaccess.h>
>  #include <linux/highmem.h>
>  #include <linux/sizes.h>
> -- 
> 2.37.0
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

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
