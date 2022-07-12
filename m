Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFBF55711DA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 07:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbiGLFbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 01:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiGLFbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 01:31:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F598C74B
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 22:31:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4850FB8165A
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 05:31:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75E35C3411E;
        Tue, 12 Jul 2022 05:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657603893;
        bh=ewsn8XSKrUU4a3V3NcShJTyHCP3TmCqI2YkJla5ug4I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aoXlZAJuk9Tx6iElIqjg0dwjF++TADKAOlLmyeaevoxhuaS5YRKLpWVvNs6APCxf2
         OLRJu33k1yCZ6HbuwPa5K8DpCUMVVc2ajeGAvW80dyrxuwZ2sCM3+tpRQAAEPdmh7z
         X/vJgZIGz7KLVdXeVnf52s73kSuIO0cLYikdGEC0=
Date:   Tue, 12 Jul 2022 07:31:29 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Shinyzenith <aakashsensharma@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: android: bind_alloc: asm/cacheflush to
 linux/cacheflush
Message-ID: <Ys0HMXzpjZX+kVsD@kroah.com>
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

Including the issues found by my patch bot, please consider working in
drivers/staging/ first and not in other portions of the kernel, so that
you can learn the proper processes and development model and not bother
maintainers of other subsystems.

Note, you also forgot to send your change to the correct people for
review.

thanks,

greg k-h
