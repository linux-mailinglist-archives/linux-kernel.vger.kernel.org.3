Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7F9452CE72
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 10:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235443AbiESIhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 04:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbiESIhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 04:37:46 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E909371DA0
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 01:37:43 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id y13so7762996eje.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 01:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mcaKm7hSkDe1Yx1fdIcH1uCHiW8h1SPpMhUlJx4epu0=;
        b=CU7CeC622rXFO63/zglREfjGV716nrCj4Pq1ASrVLqn5U06fDc6o0f3GPmPyx3C9ze
         s0xVyCxabU+69hwaJvtwKM3slwK4GpIeCEFBL0xX425xrnbvDIKROEH2eKG0QvQeGP/+
         XH7muyxG5Baaob651nyFjrYWwtYd+78IaTbPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mcaKm7hSkDe1Yx1fdIcH1uCHiW8h1SPpMhUlJx4epu0=;
        b=HNOshOKpb0p1Dp3ubxhKRhaY8mDtKdNmY/Xj/SepjOCFPkjbxQBK573tsphdC1zFxZ
         /kDpLPTm1s6JZ3NkyXLr8gqmet7ob0K7JvIide+zBQUjEpRCu/B0cO4x/i3l2OoAfF6w
         dAs4B3yWZMWbFZDfiEcbkHOWRU5MMwX8fMEv+KD0YhaUc2GCp/DrIPjeniSwG6xrS5gJ
         FbHByKp1KOqE1aPwe+Xyzr0mRFcfmTDNr7Br0nG38HizTyCziqeJBQSaoBF86epwcQSK
         4PbdzV3m20AaApAB5d1KlNPQEAhglmhJTHaI0g/8U2e+cEtOY1qxYSpPXIT0iK5Ib7PZ
         K9nA==
X-Gm-Message-State: AOAM532TVd3/ywUeTvO9qvk6/fCw0B4GiCxhj88MtOUMqaxmFbEksgFg
        W8GWMazV1rT37PblFJ+wm5SPGXRpMcIkYRyphSmHiQ==
X-Google-Smtp-Source: ABdhPJxiPnjQ5bGwx97AQgiyzheAJ2m1/CzUGaTdLMcg/HC1NcBZUt8qYvEdlyLjdsC6Q4YB6W1oOvw2N4Fukaps7M4=
X-Received: by 2002:a17:907:961e:b0:6f4:b201:6629 with SMTP id
 gb30-20020a170907961e00b006f4b2016629mr3259570ejc.152.1652949462440; Thu, 19
 May 2022 01:37:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220518111652.223727-8-angelogioacchino.delregno@collabora.com>
 <20220519045340.11198-1-miles.chen@mediatek.com> <11bf21cd-85c4-f64c-2af7-7695e71aee07@collabora.com>
In-Reply-To: <11bf21cd-85c4-f64c-2af7-7695e71aee07@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Thu, 19 May 2022 16:37:31 +0800
Message-ID: <CAGXv+5H4gF5GXzfk8mjkG4Kry8uCs1CQbKoViBuc9LC+XdHH=A@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] clk: mediatek: Add MediaTek Helio X10 MT6795 clock drivers
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Miles Chen <miles.chen@mediatek.com>, bgolaszewski@baylibre.com,
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 4:17 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 19/05/22 06:53, Miles Chen ha scritto:
> >
> > Hi Angelo,
> >
> >> Add the clock drivers for the entire clock tree of MediaTek Helio X10
> >> MT6795, including system clocks (apmixedsys, infracfg, pericfg, topckgen)
> >> and multimedia clocks (mmsys, mfg, vdecsys, vencsys).
> >>
> >> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> >> ---
> >> drivers/clk/mediatek/Kconfig                 |  37 ++
> >> drivers/clk/mediatek/Makefile                |   6 +
> >> drivers/clk/mediatek/clk-mt6795-apmixedsys.c | 157 +++++
> >> drivers/clk/mediatek/clk-mt6795-infracfg.c   | 148 +++++
> >> drivers/clk/mediatek/clk-mt6795-mfg.c        |  50 ++
> >> drivers/clk/mediatek/clk-mt6795-mm.c         | 106 ++++
> >> drivers/clk/mediatek/clk-mt6795-pericfg.c    | 160 +++++
> >> drivers/clk/mediatek/clk-mt6795-topckgen.c   | 611 +++++++++++++++++++
> >> drivers/clk/mediatek/clk-mt6795-vdecsys.c    |  55 ++
> >> drivers/clk/mediatek/clk-mt6795-vencsys.c    |  50 ++
> >> 10 files changed, 1380 insertions(+)
> >> create mode 100644 drivers/clk/mediatek/clk-mt6795-apmixedsys.c
> >> create mode 100644 drivers/clk/mediatek/clk-mt6795-infracfg.c
> >> create mode 100644 drivers/clk/mediatek/clk-mt6795-mfg.c
> >> create mode 100644 drivers/clk/mediatek/clk-mt6795-mm.c
> >> create mode 100644 drivers/clk/mediatek/clk-mt6795-pericfg.c
> >> create mode 100644 drivers/clk/mediatek/clk-mt6795-topckgen.c
> >> create mode 100644 drivers/clk/mediatek/clk-mt6795-vdecsys.c
> >> create mode 100644 drivers/clk/mediatek/clk-mt6795-vencsys.c
> >>
> >> diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
> >> index d5936cfb3bee..da8142dff3c3 100644
> >> --- a/drivers/clk/mediatek/Kconfig
> >> +++ b/drivers/clk/mediatek/Kconfig
> >> @@ -259,6 +259,43 @@ config COMMON_CLK_MT6779_AUDSYS
> >>      help
> >>        This driver supports Mediatek MT6779 audsys clocks.
> >>
> >> +config COMMON_CLK_MT6795
> >> +    tristate "Clock driver for MediaTek MT6795"
> >> +    depends on ARCH_MEDIATEK || COMPILE_TEST
> >> +    select COMMON_CLK_MEDIATEK
> >> +    default ARCH_MEDIATEK
> >> +    help
> >> +      This driver supports MediaTek MT6795 basic clocks and clocks
> >> +      required for various peripherals found on MediaTek.
> >
> > Thanks for doing this, I was wondering if we can use only COMMON_CLK_MT6795 to build all
> > clk-mt6795-*? like CONFIG_COMMON_CLK_MT8195 style:
> >
> > obj-$(CONFIG_COMMON_CLK_MT8195) += clk-mt8195-apmixedsys.o clk-mt8195-topckgen.o \
> >                                  clk-mt8195-peri_ao.o clk-mt8195-infra_ao.o \
> >                                  clk-mt8195-cam.o clk-mt8195-ccu.o clk-mt8195-img.o \
> >                                  clk-mt8195-ipe.o clk-mt8195-mfg.o clk-mt8195-scp_adsp.o \
> >                                  clk-mt8195-vdec.o clk-mt8195-vdo0.o clk-mt8195-vdo1.o \
> >                                  clk-mt8195-venc.o clk-mt8195-vpp0.o clk-mt8195-vpp1.o \
> >                                  clk-mt8195-wpe.o clk-mt8195-imp_iic_wrap.o \
> >                                  clk-mt8195-apusys_pll.o
> >
> > So we do not have to keep other COMMON_CLK_MT6795_* configs.
> >
>
> I don't think that this would bring any benefit - it's the opposite, if anything!
>
> Think about platforms that don't need any ISP functionality, or are headless (hence
> not requiring anything for dsi/hdmi/dp and display and/or media generally): what
> I've done is splitting the clock drivers that are critical for any functionality
> of the SoC to the ones that are enabling "facultative" functionality.
>
> Hence, the usecases for this kind of splitting are:
> 1. Somewhat rare (corner) cases: someone may not want to compile in any of the
>     mm/venc/vdec/mfg clock drivers because they don't need the functionality at
>     all (probably, including the other related drivers), or;
> 2. It would be possible to compile as built-in only the "main" drivers (apmixed,
>     infra, peri, topck) to achieve a boot (ex.: you need eMMC to boot, at least)
>     and then compile the mm/venc/vdec/mfg as modules to be loaded after mounting
>     a rootfs (where you probably also have mediatek-drm, vcodec, etc as modules).

I assume you mean split them into two groups:

  - essential for booting to a state capable of loading modules from storage
    So apmixedsys + topckgen + infra_ao + peri_ao + imp_iic_wrap (maybe?)
  - everything else

The whole MT8195 clock driver suite is roughly 70KB, with half of that for
the four essential clock drivers.

If the system is really that limited in storage, you probably are already
running a highly customized config and build system. And kind of doesn't
make sense that that is a real limitation for the larger chips like the
MT8195.

IMO having two Kconfig symbols for one chip is still much better than
having ten though.

> For this reason, I would propose to actually split the MT8195 clocks as well
> and the ones for other models to achieve what I explained so that, in the future,
> when this entire framework will fully support (read: fully tested) modularity,
> we will be able to set these to compile as module by default, which would greatly
> reduce the kernel size.
> That's important, not only for MediaTek SoCs, but also for others (nxp, qcom, etc)
> that don't need MediaTek clock drivers at all, since upstream we build one kernel
> image for all, and not specialized images.

AFAIK the upstream defconfig was never intended for end users to directly
consume. It is only there for all the automated testing. End users should
either generate their own config, or have their distros come up with
something sane, like building everything as modules. The soc maintainers
(if not Linus) were quite clear about this.


Regards
ChenYu
