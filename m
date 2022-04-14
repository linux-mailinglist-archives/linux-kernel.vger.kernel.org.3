Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFBA15009FD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 11:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241863AbiDNJiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 05:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241920AbiDNJho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 05:37:44 -0400
Received: from conssluserg-05.nifty.com (conssluserg-05.nifty.com [210.131.2.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD17A1EC4F;
        Thu, 14 Apr 2022 02:35:19 -0700 (PDT)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 23E9Yl5q019234;
        Thu, 14 Apr 2022 18:34:47 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 23E9Yl5q019234
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1649928887;
        bh=2Oz4V0KhZBjjnBw8krFxJrCuaxXB2BLQ2IuqfHamrvc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Z2ZPR7ereAhdrEPdDmjJWsxulZdliXZOL0GbvJoxW9FCdUOJHbxFZNA2P8gSBA6MV
         ZYpZKFAZHbDmp+KTXGfx4hDLxxljRuqC+EhOUWdEtVadONVNtId1doQuhWlLRid8FL
         HntVMWaQeF8ryUmoYulcPIPWXxc2eU3CO59YEikKEyc1aRWEaTCAdTKGlD47zzzbZ/
         4GWFlqHxg6Y3BVLiynYgu14LESuaOi/MjOlyUDdXUBAYftUHOnGvrD7np32LWqldIs
         +mqfjvJYD1SfLUQBq3YGvOX9pqnlVIFOWVA5T1IGIOj7UleTMtyPFmfyW2H7Ff3PYB
         4mIdviwUdKn3Q==
X-Nifty-SrcIP: [209.85.216.51]
Received: by mail-pj1-f51.google.com with SMTP id s14-20020a17090a880e00b001caaf6d3dd1so8772747pjn.3;
        Thu, 14 Apr 2022 02:34:47 -0700 (PDT)
X-Gm-Message-State: AOAM530CRAoIKoAnaP1YOv+dff2HmfoBgtNx7s/BtN/W+INDYvqcYLJK
        dg3uVpdrIR4/f5X8v3GF+TjgFJSVCk4C0P1uMC4=
X-Google-Smtp-Source: ABdhPJwbcwKFZNW4CGJliLoszefWwzsg/jyS9vJty0M2bVCXUSdrah3phP3M+IHGQ8RuSfU5uVX5sxcW0wn9YE6aHE4=
X-Received: by 2002:a17:902:b183:b0:14f:c266:20d5 with SMTP id
 s3-20020a170902b18300b0014fc26620d5mr46827728plr.136.1649928886714; Thu, 14
 Apr 2022 02:34:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220414091419.7654-1-jslaby@suse.cz>
In-Reply-To: <20220414091419.7654-1-jslaby@suse.cz>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 14 Apr 2022 18:33:51 +0900
X-Gmail-Original-Message-ID: <CAK7LNATn2QrFn0fTixnbtZ-VOtWid2PvFKPmjfX+z_UtZgTMgA@mail.gmail.com>
Message-ID: <CAK7LNATn2QrFn0fTixnbtZ-VOtWid2PvFKPmjfX+z_UtZgTMgA@mail.gmail.com>
Subject: Re: [PATCH] scripts: dummy-tools, add pahole
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 6:14 PM Jiri Slaby <jslaby@suse.cz> wrote:
>
> CONFIG_PAHOLE_VERSION is a part of a config since the commit below. And
> when multiple people update the config, this value constantly changes.
> Even if they use dummy scripts.
>
> To fix this:
> * add a pahole dummy script returning v99.99 -> 9999
> * call it in Makefile taking CROSS_COMPILE into account.
>
> The latter happens only if $(CROSS_COMPILE)pahole really exists. This is
> because a cross pahole likely exists only in dummy tools now, not in
> real cross tools.


I do not think this is the right thing to do.

(As I said somewhere, I am opposed to checking pahole version in Kconfig).


Also, $(CROSS_COMPILE)pahole looks insane.

You can create a dummy pahole in your local system.

$ echo 'echo v99.99' > $HOME/bin/dummy-pahole
$ chmod +x  $HOME/bin/dummy-pahole
$ make CROSS_COMPILE=scripts/dummy-tools  PAHOLE=dummy-pahole  menuconfig









> Fixes: 613fe1692377 (kbuild: Add CONFIG_PAHOLE_VERSION)
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: Michal Marek <michal.lkml@markovi.net>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: linux-kbuild@vger.kernel.org
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> ---
>  Makefile                   | 2 +-
>  scripts/dummy-tools/pahole | 4 ++++
>  2 files changed, 5 insertions(+), 1 deletion(-)
>  create mode 100755 scripts/dummy-tools/pahole
>
> diff --git a/Makefile b/Makefile
> index ecbd42f3451a..2ef722ba0a41 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -502,7 +502,7 @@ RUSTFMT             = rustfmt
>  CLIPPY_DRIVER  = clippy-driver
>  BINDGEN                = bindgen
>  CARGO          = cargo
> -PAHOLE         = pahole
> +PAHOLE         = $(if $(wildcard $(CROSS_COMPILE)pahole),$(CROSS_COMPILE)pahole,pahole)
>  RESOLVE_BTFIDS = $(objtree)/tools/bpf/resolve_btfids/resolve_btfids
>  LEX            = flex
>  YACC           = bison
> diff --git a/scripts/dummy-tools/pahole b/scripts/dummy-tools/pahole
> new file mode 100755
> index 000000000000..53501a36fa71
> --- /dev/null
> +++ b/scripts/dummy-tools/pahole
> @@ -0,0 +1,4 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +echo v99.99
> --
> 2.35.2
>


-- 
Best Regards
Masahiro Yamada
