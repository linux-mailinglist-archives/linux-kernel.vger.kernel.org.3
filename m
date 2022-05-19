Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C45B52CE4A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 10:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235512AbiESI01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 04:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235491AbiESI0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 04:26:17 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F71E5B3D7;
        Thu, 19 May 2022 01:26:16 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 118141F45711
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652948774;
        bh=1d39A1iXkDbd4B353PPJSJmVjYf8hp8qBHyfRLORy2I=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=UrKD/jKIExX547tw0Gf3zIVW2SdYvaxfw5VmAYdSim6ZBMF/m1BGKDcx2XnOg/+Bz
         braLzbE3u1DzezIFbx+nh/6nW4OXb1BnkRLwb5JN31tthvc6z/w98/1HOufE1/lCF3
         75GN9ybBHK66/wl1TClW5T0YK3zcuQZ+1x+6pbn7u6QR3/pWkcsVyL5LKP6grepM6l
         K3yw5yvbtIHN1tuqQdgzCGAMNzkqrC0La0DtSVPN68FMc1+vUmlUDGjdllJI6zxoIc
         yGapvRxQ248LtI6FlES+kQ3oe+lBVrVEpHEkxlYZVP0qal2M1U0tqmWrUvxWhaH4l9
         GquIqBTcxl9SQ==
Message-ID: <3981552b-2153-1b87-f345-2b1f9be6c56f@collabora.com>
Date:   Thu, 19 May 2022 10:26:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2 6/7] clk: mediatek: Export required symbols to compile
 clk drivers as module
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>
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
References: <20220518111652.223727-7-angelogioacchino.delregno@collabora.com>
 <20220519044153.11078-1-miles.chen@mediatek.com>
 <7e60b63c-2bf7-a77e-fe0f-a891efa77a47@collabora.com>
 <CAGXv+5FiteAu7in-CnmVUkDKy=ub1X6etyK1--PHPYKO3FPa=w@mail.gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAGXv+5FiteAu7in-CnmVUkDKy=ub1X6etyK1--PHPYKO3FPa=w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 19/05/22 10:15, Chen-Yu Tsai ha scritto:
> On Thu, May 19, 2022 at 4:05 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> Il 19/05/22 06:41, Miles Chen ha scritto:
>>>
>>> Hi Angelo,
>>>
>>>> In order to compile the clock drivers for various MediaTek SoCs as
>>>> modules, it is necessary to export a few functions from the MediaTek
>>>> specific clocks (and reset) libraries.
>>>>
>>>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>>> ---
>>>> drivers/clk/mediatek/clk-apmixed.c | 1 +
>>>> drivers/clk/mediatek/clk-cpumux.c  | 2 ++
>>>> drivers/clk/mediatek/clk-mtk.c     | 2 ++
>>>> drivers/clk/mediatek/reset.c       | 1 +
>>>> 4 files changed, 6 insertions(+)
>>>>
>>>> diff --git a/drivers/clk/mediatek/clk-apmixed.c b/drivers/clk/mediatek/clk-apmixed.c
>>>> index 6b0ab0a346e8..f126da693a7f 100644
>>>> --- a/drivers/clk/mediatek/clk-apmixed.c
>>>> +++ b/drivers/clk/mediatek/clk-apmixed.c
>>>> @@ -98,5 +98,6 @@ struct clk_hw *mtk_clk_register_ref2usb_tx(const char *name,
>>>>
>>>>       return &tx->hw;
>>>> }
>>>> +EXPORT_SYMBOL_GPL(mtk_clk_register_ref2usb_tx);
>>>>
>>>> MODULE_LICENSE("GPL");
>>>> diff --git a/drivers/clk/mediatek/clk-cpumux.c b/drivers/clk/mediatek/clk-cpumux.c
>>>> index 2b5d48591738..25618eff6f2a 100644
>>>> --- a/drivers/clk/mediatek/clk-cpumux.c
>>>> +++ b/drivers/clk/mediatek/clk-cpumux.c
>>>> @@ -150,6 +150,7 @@ int mtk_clk_register_cpumuxes(struct device_node *node,
>>>>
>>>>       return PTR_ERR(hw);
>>>> }
>>>> +EXPORT_SYMBOL_GPL(mtk_clk_register_cpumuxes);
>>>>
>>>> void mtk_clk_unregister_cpumuxes(const struct mtk_composite *clks, int num,
>>>>                                struct clk_hw_onecell_data *clk_data)
>>>> @@ -166,5 +167,6 @@ void mtk_clk_unregister_cpumuxes(const struct mtk_composite *clks, int num,
>>>>               clk_data->hws[mux->id] = ERR_PTR(-ENOENT);
>>>>       }
>>>> }
>>>> +EXPORT_SYMBOL_GPL(mtk_clk_unregister_cpumuxes);
>>>>
>>>> MODULE_LICENSE("GPL");
>>>> diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
>>>> index 05a188c62119..41e60a7e8ff9 100644
>>>> --- a/drivers/clk/mediatek/clk-mtk.c
>>>> +++ b/drivers/clk/mediatek/clk-mtk.c
>>>> @@ -459,6 +459,7 @@ int mtk_clk_simple_probe(struct platform_device *pdev)
>>>>       mtk_free_clk_data(clk_data);
>>>>       return r;
>>>> }
>>>> +EXPORT_SYMBOL_GPL(mtk_clk_simple_probe);
>>>>
>>>> int mtk_clk_simple_remove(struct platform_device *pdev)
>>>> {
>>>> @@ -472,5 +473,6 @@ int mtk_clk_simple_remove(struct platform_device *pdev)
>>>>
>>>>       return 0;
>>>> }
>>>> +EXPORT_SYMBOL_GPL(mtk_clk_simple_remove);
>>>
>>> Thanks, I need this too. I am preparing a patch to use mtk_clk_simple_remove/mtk_clk_simple_probe
>>> for MT6779 clks first and maybe I can apply this to all MediaTek clk drivers.
>>>
>>> Reviewed-by: Miles Chen <miles.chen@mediatek.com>
>>
>> Hello Miles,
>>
>> thanks for telling me, because my next step would have been exactly what
>> you're doing, for all MediaTek clk drivers... otherwise we'd be doing
>> redundant work going afterwards.
> 
> Should we consider using symbol namespaces (EXPORT_SYMBOL_NS)?
> 

I don't think we should... I don't know if any module in the common clock
framework is doing that, but if we want some symbol namespace separation,
we would want that "at least" on the entire MediaTek framework, right? :-)

In that case, we can simply keep using EXPORT_SYMBOL_GPL() and change the
Makefile in this directory to add:

	ccflags-y += -DDEFAULT_SYMBOL_NAMESPACE=COMMON_CLK_MEDIATEK

...but that's surely out of scope for this specific patch series.

What do you think?

Cheers,
Angelo

> ChenYu
> 
>> Regards,
>> Angelo
>>
>>>
>>> thanks,
>>> Miles
>>>>
>>>> MODULE_LICENSE("GPL");
>>>> diff --git a/drivers/clk/mediatek/reset.c b/drivers/clk/mediatek/reset.c
>>>> index 179505549a7c..290ceda84ce4 100644
>>>> --- a/drivers/clk/mediatek/reset.c
>>>> +++ b/drivers/clk/mediatek/reset.c
>>>> @@ -228,5 +228,6 @@ int mtk_register_reset_controller_with_dev(struct device *dev,
>>>>
>>>>       return 0;
>>>> }
>>>> +EXPORT_SYMBOL_GPL(mtk_register_reset_controller_with_dev);
>>>>
>>>> MODULE_LICENSE("GPL");
>>>> --
>>>> 2.35.1
>>>>
>>>>
>>


-- 
AngeloGioacchino Del Regno
Software Engineer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK
Registered in England & Wales, no. 5513718
