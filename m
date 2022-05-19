Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9786A52D149
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 13:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236442AbiESLSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 07:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbiESLSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 07:18:43 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB73AA501D;
        Thu, 19 May 2022 04:18:40 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 294EA1F45A60
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652959119;
        bh=8hHuB3iHrcQC4fZoJfLi8hVlnXkttGVOtI+EU+Ln4bY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kNIuRzKxMhgD6upJLoGW4KXkvrPyPPNaTjtKrzGhVwZ4+O5k1tWYP5R6kRZ+IYT+J
         +atXn1qrvnV2JlvB0+3tGpNwpFnt9fQSoOUVzuLRYLHZzrvmccL4/8bRhc6UCaZaah
         V+lOKHmNH0nafJ4RlygrDiu1Kt8eC1b1tmkwSreJs4sFZ4VjHkEio+SftcbeswhHF+
         akrlMLbeNQH8eC0AR1pzL4Drni98XU7Ki00K7QqDEYQLWqPpvbeflCMGwi+pRRbyiA
         UgPGV44+4ccNcANnHzuo8BHoV6evaHbLu+EQYtPewZQfaV37MZEljFs/Of5SfxIpFA
         FTa0rCBgWVigw==
Message-ID: <d8de6b98-23a3-1991-8ceb-24098c38c335@collabora.com>
Date:   Thu, 19 May 2022 13:18:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v10 1/3] dt-bindings: mmc: mtk-sd: extend interrupts and
 pinctrls properties
Content-Language: en-US
To:     Axe Yang <axe.yang@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Satya Tangirala <satyat@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Lucas Stach <dev@lynxeye.de>,
        Eric Biggers <ebiggers@google.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Stephen Boyd <swboyd@chromium.org>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        Yue Hu <huyue2@yulong.com>, Tian Tao <tiantao6@hisilicon.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220519111323.14586-1-axe.yang@mediatek.com>
 <20220519111323.14586-2-axe.yang@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220519111323.14586-2-axe.yang@mediatek.com>
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

Il 19/05/22 13:13, Axe Yang ha scritto:
> Extend interrupts and pinctrls for SDIO wakeup interrupt feature.
> This feature allow SDIO devices alarm asynchronous interrupt to host
> even when host stop providing clock to SDIO card. An extra wakeup
> interrupt and pinctrl states for SDIO DAT1 pin state switching are
> required in this scenario.
> 
> Signed-off-by: Axe Yang <axe.yang@mediatek.com>
> ---
>   .../devicetree/bindings/mmc/mtk-sd.yaml       | 53 ++++++++++++++++++-
>   1 file changed, 52 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> index 2a2e9fa8c188..b068ab67a054 100644
> --- a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> @@ -72,12 +72,26 @@ properties:
>         - const: ahb_cg
>   
>     interrupts:
> -    maxItems: 1
> +    description:
> +      Should at least contain MSDC GIC interrupt. To support SDIO in-band wakeup, an extended
> +      interrupt is required and be configured as wakeup source irq.
> +    minItems: 1
> +    maxItems: 2
> +
> +  interrupt-names:
> +    items:
> +      - const: msdc_irq
>   

That ain't right. You have two interrupts, so you describe two interrupts:

interrupt-names:
   minItems: 1
   items:
     - const: msdc
     - const: sdio-wakeup

...also, I personally don't like the "_irq" suffix: we're specifying interrupts in
interrupt-names, so it sounds a bit redundant.

You're free to keep it, if you really like it though.

Regards,
Angelo
