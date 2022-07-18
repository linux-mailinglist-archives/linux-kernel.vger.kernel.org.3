Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A96457796B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 03:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbiGRBur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 21:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiGRBuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 21:50:44 -0400
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com [210.131.2.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B3612617;
        Sun, 17 Jul 2022 18:50:43 -0700 (PDT)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 26I1oNpJ003576;
        Mon, 18 Jul 2022 10:50:24 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 26I1oNpJ003576
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1658109024;
        bh=lhmLp+GypwgvX/iEleEwdXY5F8LazzpdirKNejyUh70=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kUejGBPiekNwkwWeDpQkzwgpJgQjokGGstOEhiTj+epUmmHWC0Eu1v7fUsbXuzQP9
         Aicu5fJXjtpJG8q0HBKsyFVLsNYApqHwggTswSdkgUl54kEfA9fOWp/1r71XVeorMq
         U2jXIOdHFJcA1wO32xGbJIp/HP2DEE/e1gOZwykaeob6Lvoo34z4BDtviLTCkb/ol8
         YgQuSgMxtLoTwNUoJgLjolePzc/DZO9NzV8Eku+pkYiQH3WH0lNCiYYsvzEeOrzhns
         ytS8vZMUtyz7bTBW5Vqqaz2Ic4E7YfWxpHRAdUgRc1Y7B6WiBCeOjkQzh/lK0bAO7s
         mTfpKk0aEx+Qw==
X-Nifty-SrcIP: [209.85.128.43]
Received: by mail-wm1-f43.google.com with SMTP id ay11-20020a05600c1e0b00b003a3013da120so6918769wmb.5;
        Sun, 17 Jul 2022 18:50:24 -0700 (PDT)
X-Gm-Message-State: AJIora8lOpHSSvhCBKP8P2sI8yRREX0tNNaXk/+877Hm/UzPsXlhCPVv
        TWXv3OQse/RhTrsDyZ8PNzZ7BGjlJ8qSJswJ3JY=
X-Google-Smtp-Source: AGRyM1uhKv6UpDeF+V4+PlWw4qGSsEoWbI4ApsTU5kcseJNaD5ObwV6+1zvCPjnBdRBA7PfVkeJBTYjUkGKaDy2GFrE=
X-Received: by 2002:a05:600c:a42:b0:39c:9086:8a34 with SMTP id
 c2-20020a05600c0a4200b0039c90868a34mr30609166wmq.169.1658109022757; Sun, 17
 Jul 2022 18:50:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220716093249.19326-1-bagasdotme@gmail.com>
In-Reply-To: <20220716093249.19326-1-bagasdotme@gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 18 Jul 2022 10:49:42 +0900
X-Gmail-Original-Message-ID: <CAK7LNASvOjn+abQ1196+tpvVYnj9zkPPnuc4on02aQG_YhU_dw@mail.gmail.com>
Message-ID: <CAK7LNASvOjn+abQ1196+tpvVYnj9zkPPnuc4on02aQG_YhU_dw@mail.gmail.com>
Subject: Re: [PATCH 0/4] kbuild: lto: documentation fixes
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Martin Liska <mliska@suse.cz>, Andi Kleen <ak@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 16, 2022 at 6:33 PM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> Here is documentation fixes for kbuild LTO feature tree [1]. Two patches
> fixes warnings reported by kernel test robot, the others are formatting
> improvements.


Please do not submit patches unrelated to the mainline.

This series applies to the individual repository of Jiri Slaby.









>
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git
>
> Bagas Sanjaya (4):
>   Documentation: lto: add blank line padding before single requirement
>     list
>   Documentation: lto: use bullet list for FAQ
>   Documentation: lto: use bullet lists for external link references list
>   Documentation: lto: add LTO documentation to toc index
>
>  Documentation/kbuild/index.rst     |  2 ++
>  Documentation/kbuild/lto-build.rst | 36 +++++++++++++++++-------------
>  2 files changed, 23 insertions(+), 15 deletions(-)
>
>
> base-commit: 79a278f10955da2801240f52efb828d158b2b36c
> --
> An old man doll... just what I always wanted! - Clara
>


-- 
Best Regards
Masahiro Yamada
