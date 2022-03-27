Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DDD14E8674
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 09:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235583AbiC0HND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 03:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235595AbiC0HMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 03:12:51 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93CAA13F55;
        Sun, 27 Mar 2022 00:11:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 016D8CE0E58;
        Sun, 27 Mar 2022 07:11:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78EFAC340EC;
        Sun, 27 Mar 2022 07:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1648365070;
        bh=tw+Ir2j7lkjAaBlt0Rkh8PQ47RW2WFXIID2C0BI4imE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GcJcWqenkhCDPq1SRaMqvG94+0j3guAjJZq3NPJq430JTeqdoCL+BLa01BC6btXvP
         f6PS5PQ3obk5X3uT3Y4whF9Oba8k8olD+yXVcxC+GjHM+jF8xVTgnZ2Zy5AoJFWsKx
         U9mb6AEiqcrFBCZ9RtdVweYCMrd3GZ94u1SNP5vs=
Date:   Sun, 27 Mar 2022 09:11:06 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     kushagra765@outlook.com
Cc:     linux-doc@vger.kernel.org, corbet@lwn.net,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        balbi@kernel.org, dhowells@redhat.com, arnd@arndb.de,
        mcgrof@kernel.org, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-cachefs@redhat.com
Subject: Re: [ PATCH ] Documentation: fixed doc-build warnings
Message-ID: <YkAOCrbbrMaYkiSb@kroah.com>
References: <TYZPR01MB3935D1963BFD458E85412E4DF81B9@TYZPR01MB3935.apcprd01.prod.exchangelabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYZPR01MB3935D1963BFD458E85412E4DF81B9@TYZPR01MB3935.apcprd01.prod.exchangelabs.com>
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 26, 2022 at 05:22:55PM +0530, kushagra765@outlook.com wrote:
> >From 9a9918b051d5709b5e14ca8afa29f3ef644b8688 Mon Sep 17 00:00:00 2001
> From: Kushagra Verma <kushagra765@outlook.com>
> Date: Sat, 26 Mar 2022 16:43:15 +0530
> Subject: [PATCH] Documentation: fixed doc-build warnings

This should not be in the body of the email, please fix :(

> 
>    This patch fixes the following (and 2 other) doc-build warnings:
>       1. ./include/linux/dcache.h:308: warning: expecting prototype for dget, dget_dlock(). Prototype was for dget_dlock() instead
> 
>       2. ./include/linux/fscache.h:268: warning: Excess function parameter 'object' description in 'fscache_use_cookie'
> 
>       3 ./include/linux/fscache.h:285: warning: Excess function parameter 'object' description in 'fscache_unuse_cookie'
> 
>       4. ./drivers/gpu/drm/drm_format_helper.c:640: warning: Excess function parameter 'src' description in 'drm_fb_xrgb8888_to_mono_reversed'

This needs to be split up into one-patch-per-subsystem and can not be
taken as-is.

thanks,

greg k-h
