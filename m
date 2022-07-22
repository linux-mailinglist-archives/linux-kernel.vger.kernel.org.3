Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62A3757E1CD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 15:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbiGVNAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 09:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiGVNAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 09:00:00 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3400589E9E;
        Fri, 22 Jul 2022 05:59:59 -0700 (PDT)
Received: from mail-oa1-f46.google.com ([209.85.160.46]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MPp0l-1nseHW1fVr-00MuPL; Fri, 22 Jul 2022 14:59:57 +0200
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-10d6e8990b9so6196136fac.7;
        Fri, 22 Jul 2022 05:59:56 -0700 (PDT)
X-Gm-Message-State: AJIora+6WOhSd7cvJnowuvD68w5wG0UkUeJKAcxr5+48QdNgaFm1Xdms
        4H2MhASEBaydmp9zy90gNQSjmUXlfB0lkLP6KOI=
X-Google-Smtp-Source: AGRyM1vMjRHI1IDUKbv+qzBIY07jN7IIb+WM6l11w0OpthFdMwRbJ5FA5xnOLQhwQ+CrcLNxnU4NQipl0zyL1l9OZjU=
X-Received: by 2002:a05:6870:6114:b0:10c:6bf:542f with SMTP id
 s20-20020a056870611400b0010c06bf542fmr7505287oae.188.1658494795774; Fri, 22
 Jul 2022 05:59:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220722103129.22998-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20220722103129.22998-1-lukas.bulwahn@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 22 Jul 2022 14:59:39 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2gLvpLMEyejJtg8J5TLPjuPRUc-aJwTK2Og9pLeQT2Ww@mail.gmail.com>
Message-ID: <CAK8P3a2gLvpLMEyejJtg8J5TLPjuPRUc-aJwTK2Og9pLeQT2Ww@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: rectify entry for ARM/NUVOTON NPCM ARCHITECTURE
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Tomer Maimon <tmaimon77@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Avi Fishman <avifishman70@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:vxJmmzc8DRXX+kvwjV07yQQad7WNG7IWbOgiOTVmaIhV5jFvaD9
 e3JKdxxLKmfJlR5QNgN0enXdF3WCt3KF0vWAhgFoAbm+2oNdBjqF0Z4PfbXxY+5j4L/mlXc
 kvPoz5xEjy+xfjQDf3WgszkaiwAdGNVuzKgGvrBrL+zfQWpPVJtyzHkw5xSP96njb9rpugm
 7tSurz0LB9pUNvXcWzkKA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OIISGVn7qQ8=:DR3DLaJnztGYHVl2p5yxPH
 yprnhtwmF5GNvg7JIaNWCNTqjLYNV5bXvt75ngyWoIW9TOZY8SNfSrW2Ek0YbI/NLkBH6xj5T
 thiRh8tAZPEiuxPJ6dqmMIqPzx81qsulQ3ZdKyTnmf/xIX4QePre0PFFmhPNTWvGNTqb0j9hQ
 pJni2ARqGjIza/ZjILRFaCyL7PSE9DP0qKCtd5esYjtBLxnLkDyLJHLg0OAPGZIUd7y/B3NVj
 aYUgvS16tLRAh2+qCeoUq9Xy9hZq+0ZRKzgYKSqBEsE/+uwVv3+IOYlE+XyN1wkUoBHiTWgvp
 HmYFkso+CFCEUI3kUopO7R0LGdo+Kj2QKAsXscoJt9AW4rTpvd+gOc1+YGQv3oeiKgSGJyy/d
 waae2Evb4INvvBn2wMlNj7JjY9oloJrcC2xGhfd48aHAIwoo3dBz+K4O2FPMSPBRtMF+ubMyL
 9AzJZ5TgCG2UT3FmAGKah3N50vdSF3S7dRXZD9VJzzU+7aVYvfOiD2Qh4zarA0MjCApE/mEzX
 NUCG9HNgGPJl0eR2z4ZryGxjPw/pvllR32i5EYB0lkGgjmgpHCXZTCbGiiq1eio5WdlAkjH8q
 2GslEU8NnUjfWH6yBv9vs4Bn3OjrSPMdaQKoV3bF8SNg1swoYtI5cyo708s/iyHT6jlwvd0ht
 VypV6zuUGzZmMzWx9slFDoMhEw0s9QXUxmoaj4CiEwnSOgsHW37i1PeU/p8IyRBAaJ7S0v368
 BeC9YDK2jFSX1us5jPeick/NzziB6cayxQ9dT11F9vBLsPFJwg8BxWWvCJci7V/6KP1DCa+Ei
 clw3yPZk9ebnfJqAcuq8K5DQPbWNCPG6dojIC/MExeIZn2Al2ubt+MfqFGUkk6T3bKzH1WW3p
 3gpxaPJzFtmAnQY2mfQQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 22, 2022 at 12:31 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> Commit 08e950449c62 ("dt-binding: clk: npcm845: Add binding for Nuvoton
> NPCM8XX Clock") obviously adds nuvoton,npcm845-clk.h, but the file entry in
> MAINTAINERS, added with commit 3670d2ec13ee ("arm64: npcm: Add support for
> Nuvoton NPCM8XX BMC SoC") then refers to nuvoton,npcm8xx-clock.h.
>
> Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
> broken reference.
>
> Repair this file reference in ARM/NUVOTON NPCM ARCHITECTURE.
>
> Fixes: 3670d2ec13ee ("arm64: npcm: Add support for Nuvoton NPCM8XX BMC SoC")
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> Arnd, please pick this patch on top of the commits above.

Done, thanks!

      Arnd
