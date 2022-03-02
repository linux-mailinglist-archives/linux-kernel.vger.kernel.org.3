Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3741B4CB217
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 23:14:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242213AbiCBWPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 17:15:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbiCBWPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 17:15:30 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E09C9BE1CD;
        Wed,  2 Mar 2022 14:14:46 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id q4so2608098ilt.0;
        Wed, 02 Mar 2022 14:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=9ub8TndGmTDnXv5II0vAs1rwRRkggXTkQUEfUiR0zUM=;
        b=O+XP97fQEzccgNOmdZKRo9ExVQ6aP9qNniiLwYD8WAvJPbeMRPKx6qhcYfeOpm0jG7
         2kfV6H5Avz5r9Z+Iou+NSRVgPwPyPX0cX1Yh74n49X9gYvVvK66tIN+4U3E4EnQJ7Ix5
         jWPLTXBBZ1pMEyhmLG+OdDJy0s4gHZNgvKCPey2ibIH/50zY0fZTcgWDcXiT/E4pH84j
         iknTD0iNaiGnirSwb0OoN8BZ8zcRCWoy9dxo2ZqVN6lTbZAPMXrIjBLpM0CvkhUeOKTI
         eTrWkYr2nJjuReRc1dWQ2pdcjso9mx/Gr3a8IU2YoBpTYfhgTJJT9fYYzl2YzeKBpMzH
         llaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=9ub8TndGmTDnXv5II0vAs1rwRRkggXTkQUEfUiR0zUM=;
        b=E4bxqwnPhJQJJsOi5SViVkP/WHeWFGDbuXmu9IEJMt/xeqk4qcGY+aNxtS4m6g6t3H
         CQ/POq2mLDYe4E9RUt/RrURPLAiuftnfpjPLZPfz1Re5x+Gqu+TOLYdUEyKe+KQdqu58
         GItVc3Cfv+Inj2nWhwjQIQ+fnNLvRb8eMF1GD7uKjb4yfR6UcIZdZKS/pJm/wAopzGBq
         PyZ4QYaCvSzVCEr5FGMurhdK2UJsLekE+8iDZ6dObWQPFugfbJfRAbcPe2ywEc9xBkLO
         bRO9U6k1xoCTVOH3Sc/VB9p3AVCwb7cxtsYJ7gVy3AvANuiUzjHXi9kuxNFE4uRkIm3r
         JPyg==
X-Gm-Message-State: AOAM530Kum6m+mX5LlBrNIBOJOsQRHc62TRS3REK/vya95saNLhW3mhJ
        suMToQVB2gebWSCUIym1pci1MNNs1eWsUtLqAMk=
X-Google-Smtp-Source: ABdhPJzli2sDxakapKJWnAyE4Ias/tvbMiWhQHQ+dnKForLGnwLdQ++qGFoPyE7z1ZhQJ/yaEqdh8N2Jt0Lib+cjkjw=
X-Received: by 2002:a05:6e02:1c04:b0:2be:4c61:20f4 with SMTP id
 l4-20020a056e021c0400b002be4c6120f4mr29224878ilh.245.1646259286229; Wed, 02
 Mar 2022 14:14:46 -0800 (PST)
MIME-Version: 1.0
References: <20220301145233.3689119-1-arnd@kernel.org> <20220301145233.3689119-3-arnd@kernel.org>
In-Reply-To: <20220301145233.3689119-3-arnd@kernel.org>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Wed, 2 Mar 2022 23:14:10 +0100
Message-ID: <CA+icZUWCTuVeohWvePhxYY3WC9xAYSy9nP1xQQf=tFH_mWDCNQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] Kbuild: use -std=gnu11 for KBUILD_USERCFLAGS
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Marco Elver <elver@google.com>,
        Jani Nikula <jani.nikula@intel.com>,
        David Sterba <dsterba@suse.com>, Alex Shi <alexs@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kbuild@vger.kernel.org, llvm@lists.linux.dev,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 2, 2022 at 10:47 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> As we change the C language standard for the kernel from gnu89 to
> gnu11, it makes sense to also update the version for user space
> compilation.
>

Overdue.

Can you point me to a lore link where I can easily fetch the full 3/3
v3 patchset?

I would like to give this a try on x86-64 with my latest kernel-config
(based on the latest kernel-config v5.17-rc5 from Debian/unstable).

What Linux source base do I need?
Is Linux v5.17-rc6 good enough (patchset applicable) for testing?

Thanks, Arnd.

Regards,
- Sedat -

> Some users have older native compilers than what they use for
> kernel builds, so I considered using gnu99 as the default version
> for wider compatibility with gcc-4.6 and earlier.
>
> However, testing with older compilers showed that we already require
> HOSTCC version 5.1 as well because a lot of host tools include
> linux/compiler.h that uses __has_attribute():
>
>   CC      tools/objtool/exec-cmd.o
> In file included from tools/include/linux/compiler_types.h:36:0,
>                  from tools/include/linux/compiler.h:5,
>                  from exec-cmd.c:2:
> tools/include/linux/compiler-gcc.h:19:5: error: "__has_attribute" is not defined [-Werror=undef]
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index 37ef6a555dcd..7c9be7f1ccd4 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -432,7 +432,7 @@ HOSTCXX     = g++
>  endif
>
>  export KBUILD_USERCFLAGS := -Wall -Wmissing-prototypes -Wstrict-prototypes \
> -                           -O2 -fomit-frame-pointer -std=gnu89 \
> +                           -O2 -fomit-frame-pointer -std=gnu11 \
>                             -Wdeclaration-after-statement
>  export KBUILD_USERLDFLAGS :=
>
> --
> 2.29.2
>
