Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00B8A52CE9B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 10:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235578AbiESIqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 04:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235627AbiESIqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 04:46:07 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39B726ADB
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 01:46:05 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id tk15so8537319ejc.6
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 01:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R1UJqj/pkW+UdftCSNcz+tgzAZ+j9Z8JSlJihPFE/pE=;
        b=Kz0T+20kWI33J+8FREY+GO/jU52aA83gMmXXey3+lFJzzs4O6V55QaiqvIstUHyQp1
         LFOpLQVAvfwww80/2wWjU8Nyrn998ft8ttoPN5yHiU1mLAAlea+LeHO6AH/hpitrWFdo
         M7LdSSJ+y6US+7h0GY5q/D+fqR/XPO74W2AaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R1UJqj/pkW+UdftCSNcz+tgzAZ+j9Z8JSlJihPFE/pE=;
        b=hFAXQGe0XdznvdxZ6u3I0msnYiLmntxdu22LXt0RIlAUA0NImsmV0KJRxK4LeOrWBU
         EdVrF2LrXA3JkO0auLUSEn1o0vZ0FFcA5Gk3emmXK+RX06U59LtKlRiknO7kDjk1M5aW
         SDZdbSR/QAcM9Mtw/DX7WBgY369dnBGcZtveG4SE8jjqVQNtiBeWlvIhjk5igzjvoh2f
         idN+ldCWs+Bq6XlmlKh+b3IsLZiJcqF0wJ+kH/uf6Om5e65APTFjjRBsmwJrJ5rVsa5D
         uBxZhxJl7Y3DI6zWubkrtqFHWP+et2y5qV3zCmOYhcohxPooUj4IoFYyipP3JyIZRkMa
         AFMA==
X-Gm-Message-State: AOAM533/t+HTCkM9FRnqeUSFUI9A6h4paneuoI9nZbsJMYACSIuvzLUt
        9UwJZWoxLmrHif1E5vsnTYZVHTkWAWmn9DzFnLyecA==
X-Google-Smtp-Source: ABdhPJzhCok9mwoNFwX8hp+iq4r0zfazXJkBtazp/ZX0YjRO6MxlH2JwTaSCzcg8S2ZUKdpfU7r0yMDH869rIqV1Gh8=
X-Received: by 2002:a17:906:a10e:b0:6f3:e70b:b572 with SMTP id
 t14-20020a170906a10e00b006f3e70bb572mr3104969ejy.546.1652949963623; Thu, 19
 May 2022 01:46:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220518111652.223727-7-angelogioacchino.delregno@collabora.com>
 <20220519044153.11078-1-miles.chen@mediatek.com> <7e60b63c-2bf7-a77e-fe0f-a891efa77a47@collabora.com>
 <CAGXv+5FiteAu7in-CnmVUkDKy=ub1X6etyK1--PHPYKO3FPa=w@mail.gmail.com> <3981552b-2153-1b87-f345-2b1f9be6c56f@collabora.com>
In-Reply-To: <3981552b-2153-1b87-f345-2b1f9be6c56f@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Thu, 19 May 2022 16:45:52 +0800
Message-ID: <CAGXv+5GwqLKvM3yReZMW92ZC3nDwdbD+_x8ROBOjppgnsgGkyw@mail.gmail.com>
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

On Thu, May 19, 2022 at 4:26 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
> Il 19/05/22 10:15, Chen-Yu Tsai ha scritto:
> > On Thu, May 19, 2022 at 4:05 PM AngeloGioacchino Del Regno
> > <angelogioacchino.delregno@collabora.com> wrote:
> >>
> >> Il 19/05/22 06:41, Miles Chen ha scritto:
> >>>
> >>> Hi Angelo,
> >>>
> >>>> In order to compile the clock drivers for various MediaTek SoCs as
> >>>> modules, it is necessary to export a few functions from the MediaTek
> >>>> specific clocks (and reset) libraries.
> >>>>
> >>>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> >>>> ---
> >>>> drivers/clk/mediatek/clk-apmixed.c | 1 +
> >>>> drivers/clk/mediatek/clk-cpumux.c  | 2 ++
> >>>> drivers/clk/mediatek/clk-mtk.c     | 2 ++
> >>>> drivers/clk/mediatek/reset.c       | 1 +
> >>>> 4 files changed, 6 insertions(+)
> >>>>
> >>>> diff --git a/drivers/clk/mediatek/clk-apmixed.c b/drivers/clk/mediatek/clk-apmixed.c
> >>>> index 6b0ab0a346e8..f126da693a7f 100644
> >>>> --- a/drivers/clk/mediatek/clk-apmixed.c
> >>>> +++ b/drivers/clk/mediatek/clk-apmixed.c
> >>>> @@ -98,5 +98,6 @@ struct clk_hw *mtk_clk_register_ref2usb_tx(const char *name,
> >>>>
> >>>>       return &tx->hw;
> >>>> }
> >>>> +EXPORT_SYMBOL_GPL(mtk_clk_register_ref2usb_tx);
> >>>>
> >>>> MODULE_LICENSE("GPL");
> >>>> diff --git a/drivers/clk/mediatek/clk-cpumux.c b/drivers/clk/mediatek/clk-cpumux.c
> >>>> index 2b5d48591738..25618eff6f2a 100644
> >>>> --- a/drivers/clk/mediatek/clk-cpumux.c
> >>>> +++ b/drivers/clk/mediatek/clk-cpumux.c
> >>>> @@ -150,6 +150,7 @@ int mtk_clk_register_cpumuxes(struct device_node *node,
> >>>>
> >>>>       return PTR_ERR(hw);
> >>>> }
> >>>> +EXPORT_SYMBOL_GPL(mtk_clk_register_cpumuxes);
> >>>>
> >>>> void mtk_clk_unregister_cpumuxes(const struct mtk_composite *clks, int num,
> >>>>                                struct clk_hw_onecell_data *clk_data)
> >>>> @@ -166,5 +167,6 @@ void mtk_clk_unregister_cpumuxes(const struct mtk_composite *clks, int num,
> >>>>               clk_data->hws[mux->id] = ERR_PTR(-ENOENT);
> >>>>       }
> >>>> }
> >>>> +EXPORT_SYMBOL_GPL(mtk_clk_unregister_cpumuxes);
> >>>>
> >>>> MODULE_LICENSE("GPL");
> >>>> diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
> >>>> index 05a188c62119..41e60a7e8ff9 100644
> >>>> --- a/drivers/clk/mediatek/clk-mtk.c
> >>>> +++ b/drivers/clk/mediatek/clk-mtk.c
> >>>> @@ -459,6 +459,7 @@ int mtk_clk_simple_probe(struct platform_device *pdev)
> >>>>       mtk_free_clk_data(clk_data);
> >>>>       return r;
> >>>> }
> >>>> +EXPORT_SYMBOL_GPL(mtk_clk_simple_probe);
> >>>>
> >>>> int mtk_clk_simple_remove(struct platform_device *pdev)
> >>>> {
> >>>> @@ -472,5 +473,6 @@ int mtk_clk_simple_remove(struct platform_device *pdev)
> >>>>
> >>>>       return 0;
> >>>> }
> >>>> +EXPORT_SYMBOL_GPL(mtk_clk_simple_remove);
> >>>
> >>> Thanks, I need this too. I am preparing a patch to use mtk_clk_simple_remove/mtk_clk_simple_probe
> >>> for MT6779 clks first and maybe I can apply this to all MediaTek clk drivers.
> >>>
> >>> Reviewed-by: Miles Chen <miles.chen@mediatek.com>
> >>
> >> Hello Miles,
> >>
> >> thanks for telling me, because my next step would have been exactly what
> >> you're doing, for all MediaTek clk drivers... otherwise we'd be doing
> >> redundant work going afterwards.
> >
> > Should we consider using symbol namespaces (EXPORT_SYMBOL_NS)?
> >
>
> I don't think we should... I don't know if any module in the common clock
> framework is doing that, but if we want some symbol namespace separation,
> we would want that "at least" on the entire MediaTek framework, right? :-)

The sunxi-ng clk driver recently started doing this. See:

    http://git.kernel.org/torvalds/c/551b62b1e4cb64d3b42da0fbfdcd26a5fcd684be

And it's being done for all kinds of common driver libraries.

I agree that it would be done for the entire MediaTek framework.

> In that case, we can simply keep using EXPORT_SYMBOL_GPL() and change the
> Makefile in this directory to add:
>
>         ccflags-y += -DDEFAULT_SYMBOL_NAMESPACE=COMMON_CLK_MEDIATEK

Oh, I didn't know of this trick. Nice. :D

I think we still need to add MODULE_IMPORT_NS() statements, right?

> ...but that's surely out of scope for this specific patch series.
>
> What do you think?

It's definitely out of scope, but nice to have, to reduce the size of the
default symbol table, and limit the usage of the symbols the driver exports.

Regards
ChenYu
