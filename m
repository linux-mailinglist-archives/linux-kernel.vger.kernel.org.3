Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF7FB5789A3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 20:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235941AbiGRShs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 14:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbiGRShr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 14:37:47 -0400
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94B32A712;
        Mon, 18 Jul 2022 11:37:43 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id f73so22309120yba.10;
        Mon, 18 Jul 2022 11:37:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R5Gzu2vC6YOr2f4JuwNPRc950PV/uVKpReIL6pHTttU=;
        b=oHgeiWPPUd5/mwmyWrTHhxvIF1GMzmLwZGTWch216FYe46v/HhqHp5+cyrWtGV9XEo
         9KtG1zmTSmV99Y5O3bOkzhzNHnkfea0lAWvA8lJv1AdBnA+kCTMGtjU8nbOnZG0XaoVd
         0nW842aKirG4nv3dr7LDPggUvJvQpttc5pP5DQDbHXvaQnXaNpAQWYBo/5xDK2sN5oX9
         efhTCtaP5ZSC83Z7USXpPDW+PFAuf+lpZ6W6fSL/W/zoYSEkf/t3qKt4Mxaw3yxiThW5
         BFvkrqsXtAJV7PbJ2cpVdfkITKAXuLUxiiKj84WoGxDC3aiV83gKskn3JKMnyUkE2Wf9
         FleQ==
X-Gm-Message-State: AJIora8fx05IvHZufBzZtGJ5kuxEGnGzjSzzGHSlpjyaFjwxIn8Pxh6X
        sShLaFPg27FbhqTtWHihYG0yDHNhj4kST9MEjik=
X-Google-Smtp-Source: AGRyM1u/BuO6tkSEtKjTAdGp8lJNlFRpnj2d/scZEiAkOIihRmKpiYBuDnZ+pTHJTzuP3pwjddMj+J8MeQOsfRKSkcw=
X-Received: by 2002:a25:828f:0:b0:670:22f9:f7eb with SMTP id
 r15-20020a25828f000000b0067022f9f7ebmr10809841ybk.137.1658169463155; Mon, 18
 Jul 2022 11:37:43 -0700 (PDT)
MIME-Version: 1.0
References: <06ba1e63-16a5-5659-e062-3c7e12f7e5cd@gmail.com>
In-Reply-To: <06ba1e63-16a5-5659-e062-3c7e12f7e5cd@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 18 Jul 2022 20:37:27 +0200
Message-ID: <CAJZ5v0hbwy2YA-Kpz884=Jf+v9t0yWrCBV4rV_Lz6x2wYUjn4w@mail.gmail.com>
Subject: Re: [GIT PULL] devfreq next for 5.20
To:     Chanwoo Choi <cwchoi00@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "open list:DEVICE FREQUENCY (DEVFREQ)" <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Chanwoo Choi <chanwoo@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2022 at 8:03 PM Chanwoo Choi <cwchoi00@gmail.com> wrote:
>
> Dear Rafael,
>
> This is devfreq-next pull request for v5.20-rc1. I add detailed description of
> this pull request on the following tag. Please pull devfreq with
> following updates.
>
> Best Regards,
> Chanwoo Choi
>
>
> The following changes since commit 32346491ddf24599decca06190ebca03ff9de7f8:
>
>   Linux 5.19-rc6 (2022-07-10 14:40:51 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git tags/devfreq-next-for-5.20
>
> for you to fetch changes up to 53f853d55e312a639eaa910154248ce06eb754ac:
>
>   PM / devfreq: tegra30: Add error message for devm_devfreq_add_device() (2022-07-15 11:40:08 +0900)
> ----------------------------------------------------------------
>
> Update devfreq next for v5.20
>
> Detailed description for this pull request:
> 1. Add new Mediatek CCI (Cache Coherent Interconnect) devfreq driver
> - Add new MediaTek Cache Coherent Interconnect (CCI) devfreq drviver
>   which supports the dynamic voltage and clock scaling.
>   This driver uses the passive devfreq governor to get target frequencies
>   and adjust voltages because it depends on MediaTek cpu frequency
>   driver. In MT8183 and MT8186, the MediaTek CCI is supplied
>   by the same regulators with the little core CPUs.
>
> 2. Update the devfreq drivers
> - Convert the Samsung Exynos SoC Bus bindings to DT schema of exynos-bus.c
>
> - Remove kernel-doc warnings by adding the description for unused
>   fucntio parameters on devfreq core.
>
> - Use NULL to pass a null pointer rather than zero according to function
>   propotype on imx-bus.c
>
> - Print error message instead of error interger value on tegra30-devfreq.c
>
> ----------------------------------------------------------------
> Colin Ian King (1):
>       PM / devfreq: imx-bus: use NULL to pass a null pointer rather than zero
>
> Dmitry Osipenko (1):
>       PM / devfreq: tegra30: Add error message for devm_devfreq_add_device()
>
> Johnson Wang (2):
>       dt-bindings: interconnect: Add MediaTek CCI dt-bindings
>       PM / devfreq: mediatek: Introduce MediaTek CCI devfreq driver
>
> Krzysztof Kozlowski (1):
>       dt-bindings: interconnect: samsung,exynos-bus: convert to dtschema
>
> Mauro Carvalho Chehab (1):
>       PM / devfreq: shut up kernel-doc warnings
>
>  .../devicetree/bindings/devfreq/exynos-bus.txt     | 488 ---------------------
>  .../bindings/interconnect/mediatek,cci.yaml        | 141 ++++++
>  .../bindings/interconnect/samsung,exynos-bus.yaml  | 290 ++++++++++++
>  MAINTAINERS                                        |   3 +-
>  drivers/devfreq/Kconfig                            |  10 +
>  drivers/devfreq/Makefile                           |   1 +
>  drivers/devfreq/devfreq.c                          |   4 +
>  drivers/devfreq/imx-bus.c                          |   2 +-
>  drivers/devfreq/mtk-cci-devfreq.c                  | 440 +++++++++++++++++++
>  drivers/devfreq/tegra30-devfreq.c                  |   4 +-
>  10 files changed, 892 insertions(+), 491 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/devfreq/exynos-bus.txt
>  create mode 100644 Documentation/devicetree/bindings/interconnect/mediatek,cci.yaml
>  create mode 100644 Documentation/devicetree/bindings/interconnect/samsung,exynos-bus.yaml
>  create mode 100644 drivers/devfreq/mtk-cci-devfreq.c

Pulled, thanks!
