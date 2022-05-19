Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A61A52CDFB
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 10:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235253AbiESILs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 04:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233117AbiESILp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 04:11:45 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FCBD5E167
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 01:11:44 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id y7so6881239ejr.13
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 01:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=01228AsAW87u3V4vkE8Gdp75PpcK5YiypQ0QBFNy3Fo=;
        b=fyqnVlGla7N4lQ5uwn8e1++nR5hMcVfH7kXZQI8dELebvdx5wPXYCoEaQ4C87TZKZb
         qH6CdEFNVlapKLhCj99xyjQxf1VcaZ5TtbUaMKjoLY/in6GwqZcXS+42KdFB0vUzPvQx
         lzfvA3ZG3agZdJ4K7WGDR3LIwxpLVJycMi1YA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=01228AsAW87u3V4vkE8Gdp75PpcK5YiypQ0QBFNy3Fo=;
        b=4TeC2Qugd3NPxURtvGopmkZ5ubCVNuV3EshXA5yZYE5K0iPqge1qfJZa1zeX1/w0Y3
         pIgRZTZV8DVeTkIW34pkzAWLJrKi5ts8MmmyDi5Vi3FdUtCFy+iFM1+RDx5KwBF4TUfq
         gopujKxifar2WudXa7jF4BPy1iD1i/qhzN5B6igvZ1lj96kDwOxA/AbUcALi8GveKA56
         tF2ooVGHSKgWgVG2+cgUUhsKQycqwE+LFNBTzZ0jOHUg905831A3XycJJiAQznOiVgbm
         FqeZKMqBpA5vCkocxGa5VwJGQTVXNbNRxbMGFXgsB3pMhjvnpHYubnMxMpx36kwXRNBy
         5mJQ==
X-Gm-Message-State: AOAM5327OI5I6As7w7syfZto1kxRpegaLff+dguD8wD5KeyLrdqddkO7
        snJ2QwwyLg+oviPge0UbjTi0hj95gC4MaKjyYiB12A==
X-Google-Smtp-Source: ABdhPJzdkLMSSx0pz3mvtK7JWYgQo736KqrmG37YE3VmOXM1RmsRocrZV0O4P9+IYgPClG3/SwjKr46CzO94QFvxqI0=
X-Received: by 2002:a17:907:3f8e:b0:6f4:4723:4185 with SMTP id
 hr14-20020a1709073f8e00b006f447234185mr3050546ejc.359.1652947902583; Thu, 19
 May 2022 01:11:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220518111652.223727-8-angelogioacchino.delregno@collabora.com> <20220519045340.11198-1-miles.chen@mediatek.com>
In-Reply-To: <20220519045340.11198-1-miles.chen@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Thu, 19 May 2022 16:11:31 +0800
Message-ID: <CAGXv+5E0k1c3f1KnhUFs-kBVYqLH726UvhAaiBk=NMkR7+8H8g@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] clk: mediatek: Add MediaTek Helio X10 MT6795 clock drivers
To:     Miles Chen <miles.chen@mediatek.com>
Cc:     angelogioacchino.delregno@collabora.com, bgolaszewski@baylibre.com,
        chun-jie.chen@mediatek.com, ck.hu@mediatek.com,
        devicetree@vger.kernel.org, fparent@baylibre.com,
        ikjn@chromium.org, jason-jh.lin@mediatek.com, kernel@collabora.com,
        konrad.dybcio@somainline.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        marijn.suijten@somainline.org, martin.botka@somainline.org,
        matthias.bgg@gmail.com, mturquette@baylibre.com,
        p.zabel@pengutronix.de, paul.bouchara@somainline.org,
        phone-devel@vger.kernel.org, rex-bc.chen@mediatek.com,
        robh+dt@kernel.org, sam.shih@mediatek.com, sboyd@kernel.org,
        tinghan.shen@mediatek.com, weiyi.lu@mediatek.com,
        y.oudjana@protonmail.com, ~postmarketos/upstreaming@lists.sr.ht
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 12:53 PM Miles Chen <miles.chen@mediatek.com> wrote:
>
>
> Hi Angelo,
>
> >Add the clock drivers for the entire clock tree of MediaTek Helio X10
> >MT6795, including system clocks (apmixedsys, infracfg, pericfg, topckgen)
> >and multimedia clocks (mmsys, mfg, vdecsys, vencsys).
> >
> >Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> >---
> > drivers/clk/mediatek/Kconfig                 |  37 ++
> > drivers/clk/mediatek/Makefile                |   6 +
> > drivers/clk/mediatek/clk-mt6795-apmixedsys.c | 157 +++++
> > drivers/clk/mediatek/clk-mt6795-infracfg.c   | 148 +++++
> > drivers/clk/mediatek/clk-mt6795-mfg.c        |  50 ++
> > drivers/clk/mediatek/clk-mt6795-mm.c         | 106 ++++
> > drivers/clk/mediatek/clk-mt6795-pericfg.c    | 160 +++++
> > drivers/clk/mediatek/clk-mt6795-topckgen.c   | 611 +++++++++++++++++++
> > drivers/clk/mediatek/clk-mt6795-vdecsys.c    |  55 ++
> > drivers/clk/mediatek/clk-mt6795-vencsys.c    |  50 ++
> > 10 files changed, 1380 insertions(+)
> > create mode 100644 drivers/clk/mediatek/clk-mt6795-apmixedsys.c
> > create mode 100644 drivers/clk/mediatek/clk-mt6795-infracfg.c
> > create mode 100644 drivers/clk/mediatek/clk-mt6795-mfg.c
> > create mode 100644 drivers/clk/mediatek/clk-mt6795-mm.c
> > create mode 100644 drivers/clk/mediatek/clk-mt6795-pericfg.c
> > create mode 100644 drivers/clk/mediatek/clk-mt6795-topckgen.c
> > create mode 100644 drivers/clk/mediatek/clk-mt6795-vdecsys.c
> > create mode 100644 drivers/clk/mediatek/clk-mt6795-vencsys.c
> >
> >diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
> >index d5936cfb3bee..da8142dff3c3 100644
> >--- a/drivers/clk/mediatek/Kconfig
> >+++ b/drivers/clk/mediatek/Kconfig
> >@@ -259,6 +259,43 @@ config COMMON_CLK_MT6779_AUDSYS
> >       help
> >         This driver supports Mediatek MT6779 audsys clocks.
> >
> >+config COMMON_CLK_MT6795
> >+      tristate "Clock driver for MediaTek MT6795"
> >+      depends on ARCH_MEDIATEK || COMPILE_TEST
> >+      select COMMON_CLK_MEDIATEK
> >+      default ARCH_MEDIATEK
> >+      help
> >+        This driver supports MediaTek MT6795 basic clocks and clocks
> >+        required for various peripherals found on MediaTek.
>
> Thanks for doing this, I was wondering if we can use only COMMON_CLK_MT6795 to build all
> clk-mt6795-*? like CONFIG_COMMON_CLK_MT8195 style:
>
> obj-$(CONFIG_COMMON_CLK_MT8195) += clk-mt8195-apmixedsys.o clk-mt8195-topckgen.o \
>                                    clk-mt8195-peri_ao.o clk-mt8195-infra_ao.o \
>                                    clk-mt8195-cam.o clk-mt8195-ccu.o clk-mt8195-img.o \
>                                    clk-mt8195-ipe.o clk-mt8195-mfg.o clk-mt8195-scp_adsp.o \
>                                    clk-mt8195-vdec.o clk-mt8195-vdo0.o clk-mt8195-vdo1.o \
>                                    clk-mt8195-venc.o clk-mt8195-vpp0.o clk-mt8195-vpp1.o \
>                                    clk-mt8195-wpe.o clk-mt8195-imp_iic_wrap.o \
>                                    clk-mt8195-apusys_pll.o
>
> So we do not have to keep other COMMON_CLK_MT6795_* configs.

+1 to that. I'm not sure if splitting the Kconfig symbols by subsystem
ever made sense. Either you want a fully functioning system, or you
don't want support for a given SoC built-in.

Reducing the number of Kconfig symbols also helps people running randconfig
tests.


ChenYu

>
> thanks,
> Miles
>
> >+
> >+config COMMON_CLK_MT6795_MFGCFG
> >+      tristate "Clock driver for MediaTek MT6795 mfgcfg"
> >+      depends on COMMON_CLK_MT6795
> >+      default COMMON_CLK_MT6795
> >+      help
> >+        This driver supports MediaTek MT6795 mfgcfg clocks.
> >+
> >+config COMMON_CLK_MT6795_MMSYS
> >+       tristate "Clock driver for MediaTek MT6795 mmsys"
> >+       depends on COMMON_CLK_MT6795
> >+      default COMMON_CLK_MT6795
> >+       help
> >+         This driver supports MediaTek MT6795 mmsys clocks.
> >+
> >+config COMMON_CLK_MT6795_VDECSYS
> >+      tristate "Clock driver for MediaTek MT6795 VDECSYS"
> >+      depends on COMMON_CLK_MT6795
> >+      default COMMON_CLK_MT6795
> >+      help
> >+        This driver supports MediaTek MT6795 vdecsys clocks.
> >+
> >+config COMMON_CLK_MT6795_VENCSYS
> >+      tristate "Clock driver for MediaTek MT6795 VENCSYS"
> >+      depends on COMMON_CLK_MT6795
> >+      default COMMON_CLK_MT6795
> >+      help
> >+        This driver supports MediaTek MT6795 vencsys clocks.
> >+
> > config COMMON_CLK_MT6797
> >       bool "Clock driver for MediaTek MT6797"
> >       depends on (ARCH_MEDIATEK && ARM64) || COMPILE_TEST
> >diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
> >index caf2ce93d666..57f0bf90e934 100644
> >--- a/drivers/clk/mediatek/Makefile
> >+++ b/drivers/clk/mediatek/Makefile
> >@@ -17,6 +17,12 @@ obj-$(CONFIG_COMMON_CLK_MT6779_VDECSYS) += clk-mt6779-vdec.o
> > obj-$(CONFIG_COMMON_CLK_MT6779_VENCSYS) += clk-mt6779-venc.o
> > obj-$(CONFIG_COMMON_CLK_MT6779_MFGCFG) += clk-mt6779-mfg.o
> > obj-$(CONFIG_COMMON_CLK_MT6779_AUDSYS) += clk-mt6779-aud.o
> >+obj-$(CONFIG_COMMON_CLK_MT6795) += clk-mt6795-apmixedsys.o clk-mt6795-infracfg.o \
> >+                                 clk-mt6795-pericfg.o clk-mt6795-topckgen.o
> >+obj-$(CONFIG_COMMON_CLK_MT6795_MFGCFG) += clk-mt6795-mfg.o
> >+obj-$(CONFIG_COMMON_CLK_MT6795_MMSYS) += clk-mt6795-mm.o
> >+obj-$(CONFIG_COMMON_CLK_MT6795_VDECSYS) += clk-mt6795-vdecsys.o
> >+obj-$(CONFIG_COMMON_CLK_MT6795_VENCSYS) += clk-mt6795-vencsys.o
>
>
>
> > obj-$(CONFIG_COMMON_CLK_MT6797) += clk-mt6797.o
> > obj-$(CONFIG_COMMON_CLK_MT6797_IMGSYS) += clk-mt6797-img.o
> > obj-$(CONFIG_COMMON_CLK_MT6797_MMSYS) += clk-mt6797-mm.o
> >diff --git a/drivers/clk/mediatek/clk-mt6795-apmixedsys.c b/drivers/clk/mediatek/clk-mt6795-apmixedsys.c
> >new file mode 100644
> >index 000000000000..766e83765cbb
> >--- /dev/null
> >+++ b/drivers/clk/mediatek/clk-mt6795-apmixedsys.c
> >@@ -0,0 +1,157 @@
> >+// SPDX-License-Identifier: GPL-2.0-only
> >+/*
