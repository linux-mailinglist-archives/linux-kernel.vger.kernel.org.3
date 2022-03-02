Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5D24C9E8E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 08:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239910AbiCBHqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 02:46:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234393AbiCBHqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 02:46:48 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA446AD135;
        Tue,  1 Mar 2022 23:46:01 -0800 (PST)
Received: from mail-wr1-f51.google.com ([209.85.221.51]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N94FT-1oImfn11vj-0164aE; Wed, 02 Mar 2022 08:46:00 +0100
Received: by mail-wr1-f51.google.com with SMTP id t11so1301829wrm.5;
        Tue, 01 Mar 2022 23:46:00 -0800 (PST)
X-Gm-Message-State: AOAM5304jN8qOfqoq5j0og2DZFTXpl274KvKpSQG3SfZvZgP0hqb3qfA
        tXq1+Pm4LlA/8mEX9jfucl7HqbeHhOAg7+wC6UQ=
X-Google-Smtp-Source: ABdhPJybMCpDhJ+avRiNAbCh29mtDBhmslr8rmSojY+YWnXGrOU1j3Ds5dfV+KlsD75CKqxDSQB3Q+Oo96ISZoS4UMs=
X-Received: by 2002:a5d:63c2:0:b0:1ef:840e:e139 with SMTP id
 c2-20020a5d63c2000000b001ef840ee139mr14713156wrw.192.1646207159864; Tue, 01
 Mar 2022 23:45:59 -0800 (PST)
MIME-Version: 1.0
References: <20220302095008.27b6c6a9@canb.auug.org.au>
In-Reply-To: <20220302095008.27b6c6a9@canb.auug.org.au>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 2 Mar 2022 08:45:43 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0Quh+PqfBWe-LqzoSgs=ROzu6-8Nq=qceeHRwj8k7uYQ@mail.gmail.com>
Message-ID: <CAK8P3a0Quh+PqfBWe-LqzoSgs=ROzu6-8Nq=qceeHRwj8k7uYQ@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the arm-soc tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:3Cr2PuXLC9siqzXDcJxqZ4TEVBDmtyV/el+EjybgZ8uEfmu+khK
 mLd21uJRZKq8SwmHlnB54cpWK1kZADXGeOgWFxRjaGnEBgtE4nu4LrJNUvkhkkJjyBHGKl7
 k1SSh6QkzIgFgA1mqvBs88Ge9GL2sgX0vFoR0QW7RKhXWv06lKZBt/Xu5cRVQK1p1MMfihF
 OlLuynTN86jLhkKBRbxHA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Mh4zv9/yuZQ=:TngWQWr18gIhmKLMQH2Eob
 UABlGxHbj5/2ZNsItGWtp8RqWWRnD12H9AjNEH91c6xS322Chw4r50iXQPqbZXUduXLb9sQ+1
 miOSLcbJ7EfSOqSh8p+Y5xetFwUFjKY5mg34ID9uAhXCXnqbDXKjqDuCSiWgWI+iYKHMQw13+
 3X1mtSqkBhWjHOwK8jXEGyfI0ZSPo/UCRVdLTE0W70Qz6eafcUzqXDv19dy2K00Zrs4B0Pn+B
 OBexUgCIAY5K1LEvp3NRKzx5dzDdHl4kpwuuRgtdnz6Q9Z6m5ZLt6O9vAfZ3HFfwql+ksbgYG
 bf0moKD/bpgOQuw++Ns5oJkaNNHVWb2ArFpT0q92BjGksXtGdBdbiWD3NioIEUQViOEYe/qiI
 SOxBcMFU0O/8vG/Zd7aWd8slEcRf5HY5M1VGcLoa0bF0QwiXVLJBTVZ0uxNpjTYpI28IZSW6k
 f1nRUu9g6VF1eSmaUGAXdt8kJAJeg7MJ+yx6mL3EyN2dfN9Y/dESPmUuPVQ1BSBSTef7XoHDh
 4sX0qj7fkAs/kR1IQGcMZPGZwjfmHTr27GhwMPymmW/Z1CX8eGFA4l0Y0vO49uC/0YHc1a9n+
 MsiNgX0NmywXsoo2FmvGwTwEaR/exJg0OwBlzYnVfjq3FLH/S0whm1p8bEv78VRafFbNdPLDx
 67b2TZR1gHVPkj+1W8/6d6N2WiMDfuA0sW8/1IsNSpRQy2CyZpgvwP1UbBWMGQJgxGbBUQxpJ
 siOWagSh0KxuktguTbLesA2E9lX6AGPtY8cqkssgisbJzMXX8uDtDwLiJDh8VJ9oAy88hpUJj
 mUV+J59Y2DB7E+gqDnBYnOQQQJIDYP1CnPG3SlKqmHxYb3FMTo=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 1, 2022 at 11:50 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> After merging the arm-soc tree, today's linux-next build (arm
> multi_v7_defconfig) failed like this:
>
> drivers/soc/mediatek/mtk-mmsys.c:64:10: error: 'const struct mtk_mmsys_driver_data' has no member named 'sw0_rst_offset'
>    64 |         .sw0_rst_offset = MT8186_MMSYS_SW0_RST_B,
>       |          ^~~~~~~~~~~~~~
> In file included from drivers/soc/mediatek/mtk-mmsys.c:18:
> drivers/soc/mediatek/mt8186-mmsys.h:55:57: warning: excess elements in struct initializer
>    55 | #define MT8186_MMSYS_SW0_RST_B                          0x160
>       |                                                         ^~~~~
> drivers/soc/mediatek/mtk-mmsys.c:64:27: note: in expansion of macro 'MT8186_MMSYS_SW0_RST_B'
>    64 |         .sw0_rst_offset = MT8186_MMSYS_SW0_RST_B,
>       |                           ^~~~~~~~~~~~~~~~~~~~~~
> drivers/soc/mediatek/mt8186-mmsys.h:55:57: note: (near initialization for 'mt8186_mmsys_driver_data')
>    55 | #define MT8186_MMSYS_SW0_RST_B                          0x160
>       |                                                         ^~~~~
> drivers/soc/mediatek/mtk-mmsys.c:64:27: note: in expansion of macro 'MT8186_MMSYS_SW0_RST_B'
>    64 |         .sw0_rst_offset = MT8186_MMSYS_SW0_RST_B,
>       |                           ^~~~~~~~~~~~~~~~~~~~~~
>
> Caused by commit
>
>   831785f0e5b9 ("soc: mediatek: mmsys: add mmsys reset control for MT8186")
>
> I have used the arm-soc tree from next-20220301 for today.

I'm going on vacation right now, did a quick revert of that commit to fix the
build. Rex-BC Chen, Matthias: please send a proper fix that I can apply next
week when I get back, to replace my revert.

         Arnd
