Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7B957D96C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 06:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbiGVEVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 00:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiGVEVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 00:21:25 -0400
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com [210.131.2.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605CC97498;
        Thu, 21 Jul 2022 21:21:24 -0700 (PDT)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 26M4L7ML021313;
        Fri, 22 Jul 2022 13:21:08 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 26M4L7ML021313
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1658463668;
        bh=OEip7BONkb2erWAIqYnB3BgqhTayepaKvTIy6aAPLK4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vRNMEmwRXdykKsKDONRyITF3SjwpIBUPDDaNvVbKabic7RgAEgsCPxtD+w1FFj9KI
         8LXat4NqAUwFS/J2WVNIEYskrk1BgSlWQxaGXvjslXOd1Zis9L1CX+o66n67lmlzNs
         C+WzazpEm15wUQYpZlAn73c8Fa3zdc/0bSh184yaUQYwzhrcLGTEJeW4+zRcY8kH2y
         Mk4vH6W76vI/IvMpGvIhsf4VCuIuroHUgn/EsKBLwvjAhBxOf4a3sc9vNf7W+mBkJx
         hDOwBQYdAYokFtwL46wMQVY5zjo08kNp9A7U01jnjgPqhUSuxoGC7eF6cRabqsiaJv
         vf84Loc1gKl1A==
X-Nifty-SrcIP: [209.85.128.43]
Received: by mail-wm1-f43.google.com with SMTP id x23-20020a05600c179700b003a30e3e7989so1822064wmo.0;
        Thu, 21 Jul 2022 21:21:08 -0700 (PDT)
X-Gm-Message-State: AJIora/lVMz07bnTtravYmEGB3B722P5uN/ESaBJG7k4iSwe9+P7Ylea
        G8z6DkBt0Cq4ufP0eBs//ZUW45fPFTugfSim3bI=
X-Google-Smtp-Source: AGRyM1slKDNAES6s8DwAXFmZqCz0NU9JeRmpExdPGRV1IIItxxTteO7GbspvNtzdeSMHsI/VDdE211QpWd7KePOFFbg=
X-Received: by 2002:a05:600c:a42:b0:39c:9086:8a34 with SMTP id
 c2-20020a05600c0a4200b0039c90868a34mr10786453wmq.169.1658463667129; Thu, 21
 Jul 2022 21:21:07 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20220716081736epcas2p346100e67cf44b1dbb79f6e2a4ab07dbf@epcas2p3.samsung.com>
 <20220716084532.2324050-1-youngmin.nam@samsung.com>
In-Reply-To: <20220716084532.2324050-1-youngmin.nam@samsung.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 22 Jul 2022 13:20:30 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR3YGoQU6ZTZmC84C1OoH0rPinjoyPDXCD0BDPoRS4NDA@mail.gmail.com>
Message-ID: <CAK7LNAR3YGoQU6ZTZmC84C1OoH0rPinjoyPDXCD0BDPoRS4NDA@mail.gmail.com>
Subject: Re: [PATCH] Makefile.extrawarn: add -Wformat-insufficient-args for
 clang build
To:     Youngmin Nam <youngmin.nam@samsung.com>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        hosung0.kim@samsung.com, d7271.choe@samsung.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 16, 2022 at 5:17 PM Youngmin Nam <youngmin.nam@samsung.com> wrote:
>
> The -Wformat-insufficient-args for clang is useful to detect the situation
> when the total number is unmatched between format specifiers and arguments.
>
> Originally, this option is enabled by default(Link[1]), but it is disabled by
> -Wno-format explicitly so that we can't detect this unmatched situation.
>
> We can enable it by adding this option after -Wno-format.
>
> Link[1]: https://releases.llvm.org/13.0.0/tools/clang/docs/DiagnosticsReference.html#wformat-insufficient-args
> Signed-off-by: Youngmin Nam <youngmin.nam@samsung.com>
> ---


Please let me hold on this patch because
I'd rather go straight to the removal of  -Wno-format.

https://lore.kernel.org/linux-kbuild/CAFhGd8pk+0XEz0tMiJcwMM7B3NYF=yF4cHW8A-6-81SgpKFPNw@mail.gmail.com/T/#m4becf6ed91f25217b59a840ed1829f36e49fe347



>  scripts/Makefile.extrawarn | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
> index f5f0d6f09053..c23d7c286bad 100644
> --- a/scripts/Makefile.extrawarn
> +++ b/scripts/Makefile.extrawarn
> @@ -48,6 +48,7 @@ else
>  ifdef CONFIG_CC_IS_CLANG
>  KBUILD_CFLAGS += -Wno-initializer-overrides
>  KBUILD_CFLAGS += -Wno-format
> +KBUILD_CFLAGS += -Wformat-insufficient-args
>  KBUILD_CFLAGS += -Wno-sign-compare
>  KBUILD_CFLAGS += -Wno-format-zero-length
>  KBUILD_CFLAGS += $(call cc-disable-warning, pointer-to-enum-cast)
> --
> 2.34.0
>


-- 
Best Regards
Masahiro Yamada
