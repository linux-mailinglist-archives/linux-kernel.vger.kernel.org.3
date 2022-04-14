Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E724C50182E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 18:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242663AbiDNQCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 12:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359712AbiDNPrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 11:47:12 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A379EF47FF;
        Thu, 14 Apr 2022 08:32:26 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id r13so10780075ejd.5;
        Thu, 14 Apr 2022 08:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zNo0g28tlK9vSNHNGKqqjmBjPaYSOEtIiawAODAYH3c=;
        b=cW++jIHdTWB0e/u7vyX0744QVnVIpLHeGh5WEu4BOxVM9uRZh7gq6XNbmyhxdiX0XR
         DnNObAKYV/atK29rtd9VDxytlGyydSI3GK7gv8UXn2s61BkOk7SirtAUukWezAkshDlq
         S/vxhU3aqvdD4Zqx1321bK8UkTZ5MlXIcTcawWigG3NoYBFnJf5STvdVx3TUpJBfsLar
         EQAclsSro41RYhUaHhwMeeWqdSJWbXVcjR24H6KwhSZsIWtZvTUOcbxQYsJQYQDPhirF
         VFdLgQ3N+EYyMsyuH2QM2c0kXC8IiDC08CHcYMnXhx4rxUrl3t3+RKGADf5TY3AHrxf3
         qKKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zNo0g28tlK9vSNHNGKqqjmBjPaYSOEtIiawAODAYH3c=;
        b=x3K3tLr7937Mz1u38hefxbTOFldKb5QKIaBNWKWBEnIfHqisPljWqb/sEsmO6numWJ
         10T7FNHVAYjremfYQy4BvvegUJ9BOhWb/ncyy1YVx+q4dDwUL1HgGLLwBE/Sj6SCFXaM
         +bAQfxD/2jTWgyoi1tql/mRZWr5e1TB/Zu7y3kXrKHGEBMO1xWbgMw7ORiOnfQqyBlc2
         eh/ZMGo7k8yUIcmR+y0Rn6QuPmtPi4udDJ3ZFlQL1JEoqDkIK03oPbB+xUFUSLyipkEw
         EPqukydwfQMFoiPS5asCJEzeiVBJHj8bYRMMcW/NNp5Ans9Sy5j44JdLvZtjo91I1/HM
         mxdw==
X-Gm-Message-State: AOAM532RGhJwSbEiUlg97cvkMK7KQitETUNg3c+UCRA63WzGDCNL/Ghg
        +pNSEKMtYaPO4XunducDbc3JbhBbdSMtvaVcic0VecYsbm8=
X-Google-Smtp-Source: ABdhPJzbycImSsBidIp4JSSW5b5SF1qL/I1dfcfErig8MjQOErRGdzGC2WsE7sy1HibLlRHnfGkpr6ZwwcMbQbIMAXs=
X-Received: by 2002:a17:907:3f03:b0:6df:b04b:8712 with SMTP id
 hq3-20020a1709073f0300b006dfb04b8712mr2856347ejc.290.1649950345064; Thu, 14
 Apr 2022 08:32:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220401103604.8705-1-andriy.shevchenko@linux.intel.com>
 <CGME20220414063849eucas1p126e41b53ff0d342f5c48408994b704e9@eucas1p1.samsung.com>
 <20220401103604.8705-12-andriy.shevchenko@linux.intel.com>
 <3a24ef01-3231-1bee-7429-dce5680c5682@samsung.com> <CAHp75VfMPpfeMpawRyLo_GtLR8+gVGgm8zW-fatp6=9a9wK18A@mail.gmail.com>
In-Reply-To: <CAHp75VfMPpfeMpawRyLo_GtLR8+gVGgm8zW-fatp6=9a9wK18A@mail.gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 14 Apr 2022 17:32:14 +0200
Message-ID: <CAFBinCCCtZvdp+01DdEE=-f7rZ8V46O125wKDqE1muA645sdUg@mail.gmail.com>
Subject: Re: [PATCH v4 11/13] pinctrl: meson: Replace custom code by
 gpiochip_node_count() call
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Qianggui Song <qianggui.song@amlogic.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Fabien Dessenne <fabien.dessenne@foss.st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic <linux-amlogic@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Philipp Zabel <p.zabel@pengutronix.de>
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

Hi Andy,

On Thu, Apr 14, 2022 at 3:51 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
[...]
> > This patch landed in linux next-20220413 as commit 88834c75cae5
> > ("pinctrl: meson: Replace custom code by gpiochip_node_count() call").
> > Unfortunately it breaks booting of all my Amlogic-based test boards
> > (Odroid C4, N2, Khadas VIM3, VIM3l). MMC driver is no longer probed and
> > boards are unable to mount rootfs. Reverting this patch on top of
> > linux-next fixes the issue.
>
> Thank you for letting me know, I'll withdraw it and investigate.
If needed I can investigate further later today/tomorrow. I think the
problem is that our node name doesn't follow the .dts recommendation.

For GXL (arch/arm64/boot/dts/amlogic/meson-gxl.dtsi) the GPIO
controller nodes are for example:
  gpio: bank@4b0 {
      ...
  }
and
  gpio_ao: bank@14 {
      ...
  }

See also:
$ git grep -C6 gpio-controller arch/arm64/boot/dts/amlogic/*.dtsi

Marek did not state which error he's getting but I suspect it fails
with "no gpio node found".


Best regards,
Martin
