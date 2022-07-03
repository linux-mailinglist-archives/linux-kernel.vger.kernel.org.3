Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC4E75649DA
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 23:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbiGCVFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 17:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiGCVFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 17:05:54 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A592DF8
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 14:05:52 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id z12so1165294wrq.7
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jul 2022 14:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1M2WNab/3Dmg4ZgDzZWodPWwNs9gK2nW7vivk0r35wg=;
        b=qkSJKlPM/Y+LP4AwHgAjRaQiCcGYdC5drro3uQPRSPtk2lJGe0mWE3TYmYgDXofy6O
         RNnl1A+8+J77swOghtW+B3e9CUyvJgPwLpJmSwzgALWMG9T8HHSjjL71iG92T2mLIYU8
         7ChIrMCAMpMz8DhryJZz/+181IDb7DNnzBU+vBD6Jww3kENaAoLYki+F8Qbru8E5MVWd
         C0hi23ubPm95i5QR22d0F/e5BVraMdxQW5d0UisWNWWZIIIGpGJ9cZ+j4LnFi1qA74PQ
         z0IeEKAXgoXSxvKikqOfQQmpB9Xzbu2XqVU0D3n8kvsccMyucXrvMVrLjdf2DSm1OCJ3
         MmmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1M2WNab/3Dmg4ZgDzZWodPWwNs9gK2nW7vivk0r35wg=;
        b=ImfxARldjNijudUoNLDmKPzNan8EiJsEbPxrHsXXSzPbZskdswrSErNFaaz+ZfacPi
         XjpnaQX+hIKHAjN0xlx7zx4hdv+Z4YnABQW+X6vUzSP/XuUQ76mRVNastiQ7UwnH4ZP4
         wvQLh4NIjyk1JOpVvh+CU0EffrVpXqLPdeV30RaryquHQsmuZcdx2eHMUZ39pBkwhbrZ
         RYMIyEJb1acyjM+4/6IOCM/+6zQ0qSgrkGrfdkgpPPUJgBqKg3+h3PbKABxbj8AGDu1u
         z3phUsV5dzQ/LN9dwT95zFjougFyfMhy/O7MVQGDcIeozYJuz5UGK7D3QAhk0VCwUved
         2q1Q==
X-Gm-Message-State: AJIora8fWJBnabtyql7d5VJHB7XUiRZMmMyuF4iun7yORJ5oCHckJS6K
        ySLFPA0quM7XZbRP14Me+xv1Ksvsld3bnDb08WDIRA==
X-Google-Smtp-Source: AGRyM1sqRXh7+fnSdDsSPaBVeh45gia04bWxnifN90eaCRsZKfzusUMTYq9RvqMbWslUsPnHiRwkLPmZ93VF6ubeX9Y=
X-Received: by 2002:a05:6000:2a2:b0:21d:1e00:c198 with SMTP id
 l2-20020a05600002a200b0021d1e00c198mr23164612wry.520.1656882351066; Sun, 03
 Jul 2022 14:05:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220613195658.5607-1-brad@pensando.io> <20220613195658.5607-12-brad@pensando.io>
 <20220614084849.oodxh6cthysga5iq@ti.com>
In-Reply-To: <20220614084849.oodxh6cthysga5iq@ti.com>
From:   Brad Larson <brad@pensando.io>
Date:   Sun, 3 Jul 2022 14:05:40 -0700
Message-ID: <CAK9rFnzUGrdahqKM8DDx9Xo-v4Tqs086XSUoHf6wS2fbqK2OHQ@mail.gmail.com>
Subject: Re: [PATCH v5 11/15] spi: cadence-quadspi: Add compatible for AMD
 Pensando Elba SoC
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>, alcooperx@gmail.com,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, blarson@amd.com,
        brijeshkumar.singh@amd.com, catalin.marinas@arm.com,
        gsomlo@gmail.com, gerg@linux-m68k.org, krzk@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee.jones@linaro.org,
        Mark Brown <broonie@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        p.zabel@pengutronix.de, piotrs@cadence.com, rdunlap@infradead.org,
        robh+dt@kernel.org, samuel@sholland.org,
        Serge Semin <fancer.lancer@gmail.com>,
        suravee.suthikulpanit@amd.com, thomas.lendacky@amd.com,
        Ulf Hansson <ulf.hansson@linaro.org>, will@kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pratyush,

On Tue, Jun 14, 2022 at 1:49 AM Pratyush Yadav <p.yadav@ti.com> wrote:

> This is needed for TI's SoCs as well. APB and AHB accesses are
> independent of each other on the interconnect and can be racy. I wrote a
> couple patches [0][1] to fix this on TI's fork. I never got around to
> sending them upstream. It would be great if you can pick those up. They
> fix the race in all paths, not just indirect write.
>
> I would also prefer if we do this unconditionally. I don't think it has
> much downside even on platforms that do not strictly need this.
>
> [0] https://git.ti.com/cgit/ti-linux-kernel/ti-linux-kernel/commit/drivers/spi/spi-cadence-quadspi.c?h=ti-linux-5.10.y&id=027f03a8512086e5ef05dc4e4ff53b2628848f95
> [1] https://git.ti.com/cgit/ti-linux-kernel/ti-linux-kernel/commit/drivers/spi/spi-cadence-quadspi.c?h=ti-linux-5.10.y&id=4c367e58bab7d3f9c470c3778441f73546f20398

Let's get Elba specific support in first and then in a separate patch
go for the unconditional.  An extra op for devices for which its not
currently done will result in questions I can't answer.

Regards,
Brad
