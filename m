Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E607597746
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 22:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241659AbiHQUBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 16:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbiHQUBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 16:01:37 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E09A599D
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 13:01:36 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-10e615a36b0so16372958fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 13:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=6eODbFYSNHzTuwWiVkGa7QI/g8whElY3HQhU5xyyJDA=;
        b=qBrlMrWhOyQQz/D+59/12MDC6dZAIb0gON7CtF6SLWaq7F4zU+4tS0olQW+SGbSlno
         klAf6dyr3CGXkeM578EJB3bE20Bi5RngNjXIwiwEKUOEbMquC2cBgRrHLlwrS+68K39e
         MmpBCtyV0GMM2x2L1teBOI/VpdeIpY4p+sZZUyCE+UfGauMcYRd6ZlvMTiuE/KMW3vDz
         Su5TmRASdAednAbpZyzqLeDBQYHnx/U0oELBhLtN5DzqkAWMYqAwtUcw/JHbbsXVYPBR
         Tjd7kOusj39+0fM6TUFCo3/WYnF1JugEN2WjngwDoGthNbU8+V+3l9zlXYAMzlbYgdQ8
         91Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=6eODbFYSNHzTuwWiVkGa7QI/g8whElY3HQhU5xyyJDA=;
        b=EshqPaxWnmQixxhsZjazSL6vYTTRyaWHCV40/VpyJ/37UDaa4tz/2iPNuw2DPCm2Du
         /G/wKI7PJPkEedfATiqsN0zzrbI0UQ1+nhqGAKWquRIVnAp5mPROT0GwPH6Slg38gymF
         XeC79VhhtEBZfre0rE8RQgtbDdQlcKqs9lxq/Ql/07Ni+EMYI5zIYPZCfBSwYdnlUwcT
         fyEtJb/iPJA35f8/QJUSZqoYIXQCnG9ryRMat37GCbr2gmDqlrt31Pcd0lmGlJhnHSum
         UEXrVZownJW5HUf0o/AFzYpBe67T7sHbjAOSv4UyKRbg9N38j8giESTme92/d3muDanZ
         uF3w==
X-Gm-Message-State: ACgBeo04GbrCjldEMIpndzvHAKQUs+/8aK5reBHfIjBjRfKwECxMpWE0
        /gcBZIS6SQFhaJ0G+TQu8K4JAgrKQEo=
X-Google-Smtp-Source: AA6agR6RJuC5Xm1znTFKNuqH8lMO0ei7i8lAdw6tVu8DL6IGAuGr5xYUioJSxzbyZIulOWyQ0slmiA==
X-Received: by 2002:a05:6870:5b85:b0:11c:1d6f:2c82 with SMTP id em5-20020a0568705b8500b0011c1d6f2c82mr2419548oab.14.1660766495386;
        Wed, 17 Aug 2022 13:01:35 -0700 (PDT)
Received: from localhost ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id cv3-20020a056870c68300b0010d7242b623sm3109486oab.21.2022.08.17.13.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 13:01:34 -0700 (PDT)
Date:   Wed, 17 Aug 2022 12:59:22 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Sander Vanheule <sander@svanheule.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Yury Norov <yury.norov@gmail.com>
Subject: Re: [GIT PULL] Bitmap patches for v6.0-rc2
Message-ID: <Yv1ImkLgHZglhIyp@yury-laptop>
References: <Yv0RKXkSYMLjCezv@yury-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yv0RKXkSYMLjCezv@yury-laptop>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ LKML

On Wed, Aug 17, 2022 at 09:05:03AM -0700, Yury Norov wrote:
> The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:
> 
>   Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)
> 
> are available in the Git repository at:
> 
>   https://github.com/norov/linux.git tags/bitmap-6.0-rc2
> 
> for you to fetch changes up to 61b123ffcedac72a1ac6a96d1da87d25efddcbda:
> 
>   lib/cpumask: drop always-true preprocessor guard (2022-08-15 11:00:44 -0700)
> 
> ----------------------------------------------------------------
> 
> Hi Linus,
> 
> Please pull this updates for UP rework series. The one that we have
> in -rc1 came from mm tree, and doesn't include latest changes.
> 
> One important advantage is that the new one based on cpumask headers
> rework, and it allows to keep cpumask.c a purely SMP thing.
> 
> From Sander Vanheule's email:
> 
> cpumask: UP optimisation fixes follow-up
> 
> As an older version of the UP optimisation fixes was merged, not all
> review feedback has been implemented.  These patches implement the
> feedback received on the merged version [1], and the respin [2], for
> changes related to include/linux/cpumask.h and lib/cpumask.c.
> 
> [1] https://lore.kernel.org/lkml/cover.1656777646.git.sander@svanheule.net/
> [2] https://lore.kernel.org/lkml/cover.1659077534.git.sander@svanheule.net/
> 
> Thanks,
> Yury
> 
> ----------------------------------------------------------------
> Sander Vanheule (3):
>       cpumask: align signatures of UP implementations
>       lib/cpumask: add inline cpumask_next_wrap() for UP
>       lib/cpumask: drop always-true preprocessor guard
> 
>  include/linux/cpumask.h | 26 +++++++++++++++++++++++---
>  lib/Makefile            |  3 ++-
>  lib/cpumask.c           |  2 --
>  3 files changed, 25 insertions(+), 6 deletions(-)
