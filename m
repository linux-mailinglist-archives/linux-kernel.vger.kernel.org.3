Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8DB352CE0A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 10:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235190AbiESIPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 04:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbiESIPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 04:15:17 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4095F27A
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 01:15:15 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id i19so8342054eja.11
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 01:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X/HlVYPwgofRxaTk6imTwB8PcUSbOstLV3YcDOYZEJw=;
        b=C3vj2wbP2x4bbj09+r76aN1AxNcBgryPCLNUzVfK9ssr5gwZFqmrgH6+KqAd2w4HyN
         lA2wyg3zoygVXPCj8pR3usPUaatLUlbBniZSF8pjBnJdH98Lwewl3yWT71aSs1Jw/Hz+
         PHPhyVleyj1rCb20psivjpiqMuwfK+FD1pBQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X/HlVYPwgofRxaTk6imTwB8PcUSbOstLV3YcDOYZEJw=;
        b=eaK71FZf1JXh1/q2+uwqssNvVEUIoI+whJ66AzzM/M2tBWSCv/M7UqFjw6OyLs9z1i
         TBuiiV6ToRl+rTwRoNL97p/Rp0gd4M5lxD8Wm8DNJlINB7hsIjHkPV+BOKFGaY7ns0fK
         ASpOl9+YPqSMLHGTcyerpq7HeKnBh4/VeFUkROEIgqkpjlff6uVNX0SYR07Wvze76Wdi
         GJhFsfeehQp5AwvdEg+hbSWwypFmDdM4IEVAguwuOLvkeTzwZQBDsXEOdPGRdG85JmIN
         i3E8qOqX3Yb0mIOYJvMpZ6m1S1nJ8v1JN3QaGCGScxcLzGaOG7XdIUimak6ZuS8vOlyk
         Ou+A==
X-Gm-Message-State: AOAM530bT0OUmOsWRssi29Rn1ypi6NI34kSfszYZ5gxQmF8xhZA0MWxq
        zS6oOh5s1vW9Ym28SH+FfDBpG9tc491nD3jkSNpM7w==
X-Google-Smtp-Source: ABdhPJyq1UEZvSBP5DeREc22IsYZ7V5DeEyqmra4f8ewtbbNU+RcW98uM0dpOvj+yTS2WcylmOX0KhE9hY8on/dkFNk=
X-Received: by 2002:a17:907:1b14:b0:6ef:a5c8:afbd with SMTP id
 mp20-20020a1709071b1400b006efa5c8afbdmr3221451ejc.151.1652948114080; Thu, 19
 May 2022 01:15:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220518111652.223727-7-angelogioacchino.delregno@collabora.com>
 <20220519044153.11078-1-miles.chen@mediatek.com> <7e60b63c-2bf7-a77e-fe0f-a891efa77a47@collabora.com>
In-Reply-To: <7e60b63c-2bf7-a77e-fe0f-a891efa77a47@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Thu, 19 May 2022 16:15:03 +0800
Message-ID: <CAGXv+5FiteAu7in-CnmVUkDKy=ub1X6etyK1--PHPYKO3FPa=w@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] clk: mediatek: Export required symbols to compile
 clk drivers as module
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

On Thu, May 19, 2022 at 4:05 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 19/05/22 06:41, Miles Chen ha scritto:
> >
> > Hi Angelo,
> >
> >> In order to compile the clock drivers for various MediaTek SoCs as
> >> modules, it is necessary to export a few functions from the MediaTek
> >> specific clocks (and reset) libraries.
> >>
> >> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> >> ---
> >> drivers/clk/mediatek/clk-apmixed.c | 1 +
> >> drivers/clk/mediatek/clk-cpumux.c  | 2 ++
> >> drivers/clk/mediatek/clk-mtk.c     | 2 ++
> >> drivers/clk/mediatek/reset.c       | 1 +
> >> 4 files changed, 6 insertions(+)
> >>
> >> diff --git a/drivers/clk/mediatek/clk-apmixed.c b/drivers/clk/mediatek/clk-apmixed.c
> >> index 6b0ab0a346e8..f126da693a7f 100644
> >> --- a/drivers/clk/mediatek/clk-apmixed.c
> >> +++ b/drivers/clk/mediatek/clk-apmixed.c
> >> @@ -98,5 +98,6 @@ struct clk_hw *mtk_clk_register_ref2usb_tx(const char *name,
> >>
> >>      return &tx->hw;
> >> }
> >> +EXPORT_SYMBOL_GPL(mtk_clk_register_ref2usb_tx);
> >>
> >> MODULE_LICENSE("GPL");
> >> diff --git a/drivers/clk/mediatek/clk-cpumux.c b/drivers/clk/mediatek/clk-cpumux.c
> >> index 2b5d48591738..25618eff6f2a 100644
> >> --- a/drivers/clk/mediatek/clk-cpumux.c
> >> +++ b/drivers/clk/mediatek/clk-cpumux.c
> >> @@ -150,6 +150,7 @@ int mtk_clk_register_cpumuxes(struct device_node *node,
> >>
> >>      return PTR_ERR(hw);
> >> }
> >> +EXPORT_SYMBOL_GPL(mtk_clk_register_cpumuxes);
> >>
> >> void mtk_clk_unregister_cpumuxes(const struct mtk_composite *clks, int num,
> >>                               struct clk_hw_onecell_data *clk_data)
> >> @@ -166,5 +167,6 @@ void mtk_clk_unregister_cpumuxes(const struct mtk_composite *clks, int num,
> >>              clk_data->hws[mux->id] = ERR_PTR(-ENOENT);
> >>      }
> >> }
> >> +EXPORT_SYMBOL_GPL(mtk_clk_unregister_cpumuxes);
> >>
> >> MODULE_LICENSE("GPL");
> >> diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
> >> index 05a188c62119..41e60a7e8ff9 100644
> >> --- a/drivers/clk/mediatek/clk-mtk.c
> >> +++ b/drivers/clk/mediatek/clk-mtk.c
> >> @@ -459,6 +459,7 @@ int mtk_clk_simple_probe(struct platform_device *pdev)
> >>      mtk_free_clk_data(clk_data);
> >>      return r;
> >> }
> >> +EXPORT_SYMBOL_GPL(mtk_clk_simple_probe);
> >>
> >> int mtk_clk_simple_remove(struct platform_device *pdev)
> >> {
> >> @@ -472,5 +473,6 @@ int mtk_clk_simple_remove(struct platform_device *pdev)
> >>
> >>      return 0;
> >> }
> >> +EXPORT_SYMBOL_GPL(mtk_clk_simple_remove);
> >
> > Thanks, I need this too. I am preparing a patch to use mtk_clk_simple_remove/mtk_clk_simple_probe
> > for MT6779 clks first and maybe I can apply this to all MediaTek clk drivers.
> >
> > Reviewed-by: Miles Chen <miles.chen@mediatek.com>
>
> Hello Miles,
>
> thanks for telling me, because my next step would have been exactly what
> you're doing, for all MediaTek clk drivers... otherwise we'd be doing
> redundant work going afterwards.

Should we consider using symbol namespaces (EXPORT_SYMBOL_NS)?

ChenYu

> Regards,
> Angelo
>
> >
> > thanks,
> > Miles
> >>
> >> MODULE_LICENSE("GPL");
> >> diff --git a/drivers/clk/mediatek/reset.c b/drivers/clk/mediatek/reset.c
> >> index 179505549a7c..290ceda84ce4 100644
> >> --- a/drivers/clk/mediatek/reset.c
> >> +++ b/drivers/clk/mediatek/reset.c
> >> @@ -228,5 +228,6 @@ int mtk_register_reset_controller_with_dev(struct device *dev,
> >>
> >>      return 0;
> >> }
> >> +EXPORT_SYMBOL_GPL(mtk_register_reset_controller_with_dev);
> >>
> >> MODULE_LICENSE("GPL");
> >> --
> >> 2.35.1
> >>
> >>
>
