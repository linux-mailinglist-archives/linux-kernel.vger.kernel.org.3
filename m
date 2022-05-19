Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3726752D029
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 12:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236512AbiESKIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 06:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232667AbiESKID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 06:08:03 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D36DA7740;
        Thu, 19 May 2022 03:08:02 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id f9so9039622ejc.0;
        Thu, 19 May 2022 03:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EZvPkAeujwgNKCH5EMvSfalxGi18lEkG+bj2iAM0yAs=;
        b=jLOnF0e7IvKq0dViMCad++sS/fMzl1uvK8JrCKAnJ8R/TGlg3fdAeTxdFfmrkYDg7I
         KZ/MY7YpSK86SmKcjAJ8Hepr8OoTq3DoJ1tlflZmNQ3+8mtkpTpKjvxp5H9JkadBoWTM
         F3TKYyy1q83krbp92fH28aMfL7MhgnFiQVIQgHsSPiP8J6X8kvEE+ingczbeOz7Oy+g/
         x472XDt1dNPEqSoQo5dGfGevS/JIsxg4Ac5NRg88wGRY02FmWhy5ci9mCXC1Hct5mcuX
         DivoBjJmvk4KGKIgUvevNHnWKrfdrvrl9oc8u+wev/CDk+fs1gJLS0B9yfEWYqmcD/yj
         t9dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EZvPkAeujwgNKCH5EMvSfalxGi18lEkG+bj2iAM0yAs=;
        b=h7J7bnM8u/P0hTKvf2DgsDzxGheBaaHIA9FO98YqNqKROvo9t8s/IQU1IoCMYxi6uJ
         Ybbf8B9zghzbdwLaScJQCiWA1O3Pdk+e64mU4xWVgxhuPT97sJDP5z0/0ejBNjFoVK7h
         rjIL6QiEMQ9elz+1fu4plxlZ6kwROrNp5o4o96xPrJfqFRmaRy1tj057b/PLWZ2oNHDv
         7uDnH0TWfu2riSOvJLrpxf4EhStaxs1nQ1IYSk3e38J1uqowrTPDLA07yGOCzCR3NZiA
         EGKrI+Uql2P9GVimZ4AVGRZrkL5khagKsS/YTCoEA9vOtABHNKMTJtNQ8EjcjgmpCn9V
         TrkQ==
X-Gm-Message-State: AOAM532us8p0P4bXmBN3k1/4jFAqwagttCwp4zReaeDFAIAq8dm6EdSB
        32951UPxB9p70e5Ytyoa1fD8iK5xZ06ecgrA6IM=
X-Google-Smtp-Source: ABdhPJzJayPSTOH8apl4X7mFph72vPHSGtbxYNMETu8oPZt5Ra6jCHh52C93NfRy/hJ4wplCEVFMXJnKsXs6wcDGcMw=
X-Received: by 2002:a17:907:a088:b0:6f4:f661:f77a with SMTP id
 hu8-20020a170907a08800b006f4f661f77amr3494449ejc.77.1652954880656; Thu, 19
 May 2022 03:08:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220518192924.20948-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAHp75VeyU4Ox76wz9VfT8qEKHsE1eAo2iw27Lro1tmjJB0npMg@mail.gmail.com> <CA+V-a8tp0T=ojr3hB-QacOvV5sCZ29YXspPzKSSpGHUA8_1XDA@mail.gmail.com>
In-Reply-To: <CA+V-a8tp0T=ojr3hB-QacOvV5sCZ29YXspPzKSSpGHUA8_1XDA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 19 May 2022 12:07:23 +0200
Message-ID: <CAHp75VcauAsM2dTsS2CjOTc1_fwd-oT=A+yU6LzQ+vwQRAHjBg@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] Renesas RZ/G2L IRQC support
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Marc Zyngier <maz@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
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

On Thu, May 19, 2022 at 6:07 AM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
> On Wed, May 18, 2022 at 10:10 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Wed, May 18, 2022 at 9:29 PM Lad Prabhakar
> > <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:

...

> > > GIC. Out of GPIOINT0-122 only 32 can be mapped to GIC SPI, this mapping is
> > > handled by the pinctrl and IRQC driver.
> >
> > Where is the explanation on why valid_mask can't be used instead?
> >
> The .valid_mask option is one time setting but what I need is
> something dynamic i.e. out of 392 GPIO pins any 32 can be used as an
> interrupt pin. Also with this patch we also save on memory here [0].

Which internal APIs are bound to valid_mask not to be updated?

-- 
With Best Regards,
Andy Shevchenko
