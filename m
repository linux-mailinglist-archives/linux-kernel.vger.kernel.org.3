Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60CE24E5510
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 16:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242408AbiCWPW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 11:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbiCWPWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 11:22:53 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B2D6D195
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 08:21:23 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id k21so3285307lfe.4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 08:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cuoO5w9isRuc8co4BURPBqQkfg+YDtR9LSrQRl6GWaI=;
        b=alLBUYdXNDt3lKU3CYCrhGVAGU7VdUyeSbdMIH5y+ez8isP34s23CwusjZ3T66lLNK
         rXLwg1SufLhLNk8h2p1xvfp12mhB1xk30IifpvcEOQpUWvIMZBl6izzfi60IYAuxxgXB
         RN7uKXqXaW354mXaEMZ/pYz+ZCzrIm2rTxzdFD61Vu+Io0YPY7usJXFpTWwqj2vk3a83
         8QPir/Owc4ZBG+YX7B3PsZtNuRwy5hkMhYyI/rg642IaXQy9Z1pIhSCxf+F4QPiHXiqC
         cs8TWvK+awlfQuwbEQvBEGHeu3hKB5fbfKpm1v4lFKAhNbLLkPRgNgD0L48TSxOfGKMc
         Lh6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cuoO5w9isRuc8co4BURPBqQkfg+YDtR9LSrQRl6GWaI=;
        b=lMbu0Cl7HfDRqlP711t6Rhv4+mFSShrCqqK9q7OPV/lyCGr5hKeACaoOnK7DfBw1+w
         jjPhAeF6JXsXqVRdlP0ikZhZy90boYEbNsukiIUNC7q8A1v4VKwWZDl5iOuk/AJx+yr+
         Mkd2DwTcTns0p/QZKGWYkPzFTuGSveSZdXQzvZ7+FRRLlF1gzWAy5pl1Xj2hg6btARMb
         U+hfoEKX7x+83VZVM0UUjShx2TRsvMkuZaRF597t28+L9sVkV+++9wP9MddSOX4GppQB
         BqnL++uDLndjdze2FYZQdNSrHL8s579MyxkLv4nple9eAiXGj+2Z+MnMTVZV9BVTGkOd
         4B4A==
X-Gm-Message-State: AOAM532+FlrE/P+CTb4gr1Q+AwOq6ib6quwiSou2d6CEHRWjlG82U1hz
        ufubviAttWt5y6WkQUK1Z1IlROuwqH7WmeLbTE2P0g==
X-Google-Smtp-Source: ABdhPJxjKmZtyLN5zP1aejCbE1Iko4CLyL0QODgQxkPseuYvPz44WiNYcpnvGDmqlMWNN8DyS7ecCFRnWVzBaVS81v8=
X-Received: by 2002:a05:6512:3fa9:b0:44a:313e:eb63 with SMTP id
 x41-20020a0565123fa900b0044a313eeb63mr270393lfa.19.1648048881309; Wed, 23 Mar
 2022 08:21:21 -0700 (PDT)
MIME-Version: 1.0
References: <1648005138-28311-1-git-send-email-baihaowen@meizu.com>
In-Reply-To: <1648005138-28311-1-git-send-email-baihaowen@meizu.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Wed, 23 Mar 2022 08:21:09 -0700
Message-ID: <CAHRSSEw2+-GpQe5Ufea1U-fQ4YkL1UR_T4Pt5UjWsgRiF+esDA@mail.gmail.com>
Subject: Re: [PATCH V2] android: binder: Fix duplicate included binder_trace.h
To:     Haowen Bai <baihaowen@meizu.com>
Cc:     gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
        maco@android.com, joel@joelfernandes.org, brauner@kernel.org,
        hridya@google.com, surenb@google.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 8:12 PM Haowen Bai <baihaowen@meizu.com> wrote:
>
> Clean up the following includecheck warning:
>
> drivers/android/binder.c: binder_trace.h is included more than once.
>
> No functional change.
>
> Signed-off-by: Haowen Bai <baihaowen@meizu.com>
> ---
> V1 -> V2: modify title asm/pgtable.h -> binder_trace.h
>
>  drivers/android/binder.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index 8351c56..a12aa3c 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -72,7 +72,6 @@
>  #include <linux/cacheflush.h>
>
>  #include "binder_internal.h"
> -#include "binder_trace.h"

This breaks the build. Please test your changes before submitting.

>
>  static HLIST_HEAD(binder_deferred_list);
>  static DEFINE_MUTEX(binder_deferred_lock);
> --
> 2.7.4
>
