Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3B052E2E3
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 05:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345042AbiETDKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 23:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234406AbiETDKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 23:10:51 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A67EFE55
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 20:10:47 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id n10so13236701ejk.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 20:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VzSjf+UlkdmPK52vS7yOaoMagJCGv/wcSOSyKIbiwH8=;
        b=Lywk4LXhXPJIPKesDr6LiwUJDzAgYYKOyYyRTyyNrlwAJLGu+VAlmZPBTcbryvDetE
         LLET3VW3TbL0MlXH7V5vhi3X3qGdEoEpa3qumIWFp5M5f8566Dj/OTxkToFsyAl5TqhH
         Xaa8QmHWA8hVYy8ndnue6sC88sMUgFvMQ4PZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VzSjf+UlkdmPK52vS7yOaoMagJCGv/wcSOSyKIbiwH8=;
        b=UKdq0s9XTDZ8vKq+AJdjBTFtfXFB99u5dF2lstlHrtmc1jVbu83hHmX2NQDMH0Go47
         Jq7bQJPw7+QMdo2uiHdUN1YuNJ9dSCX40f6gpyqPDGe5X6xSIwXvaw0t1icvIvTyaHz1
         ZLiIQzsehcAzYwJaFpkYPmJQt1hYoBxp5wkM/WVnmn8Tp+sPlWyFmllpXUMzMO/oOg9c
         +Y8fAZsPZKhcRFzWGhML4h0mfXPRVrX4VSBTkE61Ivv/7GgjU2KuWoyurjXg7HE9kzvq
         83CQtrHaxd9t7yRuS+/OELDp1RRui/pdhAb5npqfrobXJVH0uEmezOvl5Zkp1IICXjp+
         zoQg==
X-Gm-Message-State: AOAM532gnNkAc6OxxHZoEjIzt4Fu2rwWelemAtWr6TAwo6Aln89GI3Cc
        TgR1OFgnWH9qlbjzeXaKktQQ79HrqvKV8PU/pocQ1w==
X-Google-Smtp-Source: ABdhPJxkwfvvFqGzx0Rjd3TwAAV9uPperVy6YXPVSMZ2LDoibXy6/wsJm53sl4Y7MYj/0N6I4f1/tS3Mih7BMNTIsic=
X-Received: by 2002:a17:907:3f8e:b0:6f4:4723:4185 with SMTP id
 hr14-20020a1709073f8e00b006f447234185mr6913293ejc.359.1653016246258; Thu, 19
 May 2022 20:10:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220519125527.18544-1-rex-bc.chen@mediatek.com>
 <20220519125527.18544-14-rex-bc.chen@mediatek.com> <3f39777a225fac66f01858262defcc11c6135bb2.camel@mediatek.com>
In-Reply-To: <3f39777a225fac66f01858262defcc11c6135bb2.camel@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 20 May 2022 11:10:35 +0800
Message-ID: <CAGXv+5Ee3QvpHqWeSOFJYmq+P3POFSTB45JM42UNF8pn4b4T9A@mail.gmail.com>
Subject: Re: [PATCH v7 13/19] dt-bindings: reset: mediatek: Add infra_ao reset
 index for MT8192/MT8195
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>
Cc:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?B?Q2h1bi1KaWUgQ2hlbiAo6Zmz5rWa5qGAKQ==?= 
        <Chun-Jie.Chen@mediatek.com>,
        =?UTF-8?B?UnVueWFuZyBDaGVuICjpmYjmtqbmtIsp?= 
        <Runyang.Chen@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
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

On Fri, May 20, 2022 at 10:58 AM Rex-BC Chen <rex-bc.chen@mediatek.com> wrote:
>
> On Thu, 2022-05-19 at 20:55 +0800, Rex-BC Chen wrote:
> > To support reset of infra_ao, add the index of infra_ao reset of
> > thermal/svs/pcei for MT8192 and thermal/svs for MT8195.
> >
> > Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> > Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Reviewed-by: AngeloGioacchino Del Regno <
> > angelogioacchino.delregno@collabora.com>
> > ---
> >  include/dt-bindings/reset/mt8192-resets.h | 8 ++++++++
> >  include/dt-bindings/reset/mt8195-resets.h | 6 ++++++
> >  2 files changed, 14 insertions(+)
> >
> > diff --git a/include/dt-bindings/reset/mt8192-resets.h b/include/dt-
> > bindings/reset/mt8192-resets.h
> > index 764ca9910fa9..12e2087c90a3 100644
> > --- a/include/dt-bindings/reset/mt8192-resets.h
> > +++ b/include/dt-bindings/reset/mt8192-resets.h
> > @@ -7,6 +7,7 @@
> >  #ifndef _DT_BINDINGS_RESET_CONTROLLER_MT8192
> >  #define _DT_BINDINGS_RESET_CONTROLLER_MT8192
> >
> > +/* TOPRGU resets */
> >  #define MT8192_TOPRGU_MM_SW_RST
> > 1
> >  #define MT8192_TOPRGU_MFG_SW_RST                             2
> >  #define MT8192_TOPRGU_VENC_SW_RST                            3
> > @@ -30,4 +31,11 @@
> >  /* MMSYS resets */
> >  #define MT8192_MMSYS_SW0_RST_B_DISP_DSI0                     15
> >
> > +/* INFRA resets */
> > +#define MT8192_INFRA_RST0_THERM_CTRL_SWRST           0
> > +#define MT8192_INFRA_RST2_PEXTP_PHY_SWRST            1
> > +#define MT8192_INFRA_RST3_THERM_CTRL_PTP_SWRST       2
> > +#define MT8192_INFRA_RST4_PCIE_TOP_SWRST             3
> > +#define MT8192_INFRA_RST4_THERM_CTRL_MCU_SWRST       4
> > +
> >  #endif  /* _DT_BINDINGS_RESET_CONTROLLER_MT8192 */
> > diff --git a/include/dt-bindings/reset/mt8195-resets.h b/include/dt-
> > bindings/reset/mt8195-resets.h
> > index a26bccc8b957..0b1937f14b36 100644
> > --- a/include/dt-bindings/reset/mt8195-resets.h
> > +++ b/include/dt-bindings/reset/mt8195-resets.h
> > @@ -7,6 +7,7 @@
> >  #ifndef _DT_BINDINGS_RESET_CONTROLLER_MT8195
> >  #define _DT_BINDINGS_RESET_CONTROLLER_MT8195
> >
> > +/* TOPRGU resets */
> >  #define MT8195_TOPRGU_CONN_MCU_SW_RST          0
> >  #define MT8195_TOPRGU_INFRA_GRST_SW_RST        1
> >  #define MT8195_TOPRGU_APU_SW_RST               2
> > @@ -26,4 +27,9 @@
> >
> >  #define MT8195_TOPRGU_SW_RST_NUM               16
> >
> > +/* INFRA resets */
> > +#define MT8195_INFRA_RST0_THERM_CTRL_SWRST     0
> > +#define MT8195_INFRA_RST3_THERM_CTRL_PTP_SWRST 1
> > +#define MT8195_INFRA_RST4_THERM_CTRL_MCU_SWRST 2
> > +
> >  #endif  /* _DT_BINDINGS_RESET_CONTROLLER_MT8195 */
> > --
> > 2.18.0
> >
>
> Hello Stephen,
>
> this patch will have conflict with Matthias's commit branch for
> include/dt-bindings/reset/mt8192-resets.h.
>
> It's on linux-next.
>
> I have fix it in this version, but I think there will be a merge
> conflict if you pick my series in this run.
>
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/include/dt-bindings/reset/mt8192-resets.h?h=next-20220519&id=19c66219e4d5b813ebbd28621cfe9c450659ded7

The commit in question is in Matthias's v5.18-next/dts64 branch, which also
has the v5.18-next-dts64 tag. The PR for this tag was already picked up
by the soc maintainers, so I guess we could consider it stable.

Matthias, what do you think? Give an ack for the patch to go through the
clk tree with the tag merged in as dependency? There's a compile time
dependency between this and the next patch so we can't just split them
into different trees.


ChenYu
