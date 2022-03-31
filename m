Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DBFD4ED159
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 03:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352325AbiCaBhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 21:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbiCaBhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 21:37:36 -0400
Received: from conssluserg-05.nifty.com (conssluserg-05.nifty.com [210.131.2.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F002342A37;
        Wed, 30 Mar 2022 18:35:49 -0700 (PDT)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 22V1ZSmM018184;
        Thu, 31 Mar 2022 10:35:29 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 22V1ZSmM018184
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1648690529;
        bh=BhtUEXw72ErbRqB+ITo7H4qPfJkEmZoUPwgbzXJtchg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Dvq8CVo67lAp/7wZp/j1BbGwpKic3zdUm5FtBMaP0DYY8TVsFAW3a2ggiTZypX0oj
         GSO6kL5X24rpmf42IDytQlxvuIEzPwo+YWJ1uK9tG/Ogh7/02V3/zVI0s6kSL9ISLB
         AcVxUa8D50xgLHRhtAjaaAemYU/+rL+Gpgs8OIpZTvaeRkfAQf/eXdmt5J1nroX8rt
         2i5lZs/l+aqp34btP9sj2U3Dmu99zwYQosWcxakESuR7/gYZWwkTqM9F6Y2sYWyfH8
         4vqZ1AioNYs15NXHSY8acUucA178yj9FiIC8FY2JBx+f+bGpCrPa5DyoVw/yk0cGnF
         xn3LcazcQTFMA==
X-Nifty-SrcIP: [209.85.216.41]
Received: by mail-pj1-f41.google.com with SMTP id g9-20020a17090ace8900b001c7cce3c0aeso1302577pju.2;
        Wed, 30 Mar 2022 18:35:29 -0700 (PDT)
X-Gm-Message-State: AOAM532rQCDQI5U3MxIFdIx36gOS8GYVEvlRC7xeRqIEeB8tNr3eQcwc
        sbyo5bx1ufhYgqT8i1jciReruL4UxJCljiSctqE=
X-Google-Smtp-Source: ABdhPJy/rTr8PLYt7T5HvYzYI5JrEy23u7/kM6xdvtM7ukgecW0gPQ3QlmQatZ89IYAPfnWZDH1cjc0895hiPJ5yUMI=
X-Received: by 2002:a17:90b:4d01:b0:1c9:ec79:1b35 with SMTP id
 mw1-20020a17090b4d0100b001c9ec791b35mr3002696pjb.77.1648690528528; Wed, 30
 Mar 2022 18:35:28 -0700 (PDT)
MIME-Version: 1.0
References: <479c5c98-0e0d-072d-dae1-f91629989e46@gmail.com>
 <CAK7LNASxaJMUAS6vgcDX3jwM9LQj7Lz8RX941FQhrDrtJSt6GA@mail.gmail.com> <e55edf6f-2aac-87a5-c0f8-363a536b9f92@gmail.com>
In-Reply-To: <e55edf6f-2aac-87a5-c0f8-363a536b9f92@gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 31 Mar 2022 10:34:42 +0900
X-Gmail-Original-Message-ID: <CAK7LNARmYdz5zgnoa_J4kgBP5qB4QViapp_UMXu4Now1jknMNQ@mail.gmail.com>
Message-ID: <CAK7LNARmYdz5zgnoa_J4kgBP5qB4QViapp_UMXu4Now1jknMNQ@mail.gmail.com>
Subject: Re: [PATCH] riscv: Set SRCARCH to riscv if ARCH is riscv64 or riscv32
To:     Ben Westover <kwestover.kw@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 3:40 AM Ben Westover <kwestover.kw@gmail.com> wrote:
>
> Hello Masahiro,
>
> On 3/30/22 11:31 AM, Masahiro Yamada wrote:
> > On Wed, Mar 30, 2022 at 11:34 PM Ben Westover <kwestover.kw@gmail.com> wrote:
> >>
> >> When riscv64 or riscv32 are used as the value for ARCH during compilation, like
> >> in tools that get the ARCH value from uname, set SRCARCH to riscv instead of
> >> failing because the riscv64 and riscv32 targets don't exist.
> >
> > Can you refer to the code that really needs this?
> Some software like DKMS compiles out-of-tree modules by running `uname -m`and
> using that for the ARCH value. Without this patch, that compilation fails because
> uname shows either riscv64 or riscv32 while riscv should be used.

It is a bug in DKMS.

The ARCH=* in linux kernel does not necessarily match to 'uname -m'.

For example, we use ARCH=arm64 for arm 64-bit (so called aarch64),
but it does not match "aarch64".

The kernel has freedom to determine the supported string for ARCH=.

DKMS must adjust to the kernel code.




> This code already exists for sparc and parisc, as well as x86 of course.

This is because there is a historical reason.

If you look at the old code  (e.g. 2.6.x,)
arch/i386/ and arch/x86_64 were separate directories.

They were unified into arch/x86/ now, but we still support
ARCH=i386/x86_64.  It helps to choose a different defconfig.
See arch/x86/Makefile.


I do not see such code for riscv, where 32/64-bit is selected
only by Kconfig.




>
> Thanks,
> --
> Ben Westover



-- 
Best Regards
Masahiro Yamada
