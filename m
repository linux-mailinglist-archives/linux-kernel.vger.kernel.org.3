Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E689529B63
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 09:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241718AbiEQHsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 03:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241486AbiEQHsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 03:48:36 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D6A47393;
        Tue, 17 May 2022 00:48:30 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 8ADA31F441AA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652773709;
        bh=ExwtYhF6lW41/VV+VosOgNIh/aIBIehqgDlrAU2wlqI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=llZKudObnwhLoG7831KnTVNHUlFkO6VQxYU9MnYi/2Tjfen3kZxHbcg1jUNBXi4pj
         ZvSVeei11j1tJRXPCE+7+OiaXsX6oJltMp9hOe7+IdhXSq5wEMNyqXZ9n27mUGVdt/
         bc9qtEwgeUDzl25M0osEVwNOPGNMWKqCHgLq8bWLrXHAArODExKHdDGEfqSrj2ww49
         8+6KF54m8/pVVdmMj6qrGSQ4vr9r3bMqUYe9AKeM+knvnoVz2hKlmDY4/Fd3TRIZR4
         t3wfLguv3KsdglOl37QL0PxAZLh5OTajsNe9q61Zr4mxkF4SceWzvo6ZZNjt6bywSm
         c2GwOyoe+yIWg==
Message-ID: <b3e34db8-4e79-f6e3-35b8-e32891f2c85b@collabora.com>
Date:   Tue, 17 May 2022 09:48:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 4/5] dt-bindings: arm: mediatek: Add clock driver bindings
 for MT6795
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
        y.oudjana@protonmail.com, jason-jh.lin@mediatek.com,
        ck.hu@mediatek.com, fparent@baylibre.com, rex-bc.chen@mediatek.com,
        tinghan.shen@mediatek.com, chun-jie.chen@mediatek.com,
        weiyi.lu@mediatek.com, ikjn@chromium.org, miles.chen@mediatek.com,
        sam.shih@mediatek.com, wenst@chromium.org,
        bgolaszewski@baylibre.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, paul.bouchara@somainline.org,
        kernel@collabora.com
References: <20220513165050.500831-1-angelogioacchino.delregno@collabora.com>
 <20220513165050.500831-5-angelogioacchino.delregno@collabora.com>
 <20220516172819.GA2938099-robh@kernel.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220516172819.GA2938099-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 16/05/22 19:28, Rob Herring ha scritto:
> On Fri, May 13, 2022 at 06:50:49PM +0200, AngeloGioacchino Del Regno wrote:
>> Add the bindings for the clock drivers of the MediaTek Helio X10
>> MT6795 SoC.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   .../arm/mediatek/mediatek,mt6795-clock.yaml   | 67 +++++++++++++++++
>>   .../mediatek/mediatek,mt6795-sys-clock.yaml   | 73 +++++++++++++++++++
>>   2 files changed, 140 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mt6795-clock.yaml
>>   create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mt6795-sys-clock.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt6795-clock.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt6795-clock.yaml
>> new file mode 100644
>> index 000000000000..b7d96d0ed867
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt6795-clock.yaml
>> @@ -0,0 +1,67 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: "http://devicetree.org/schemas/arm/mediatek/mediatek,mt6795-clock.yaml#"
>> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
>> +
>> +title: MediaTek Functional Clock Controller for MT6795
>> +
>> +maintainers:
>> +  - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> +  - Chun-Jie Chen <chun-jie.chen@mediatek.com>
>> +
>> +description: |
>> +  The clock architecture in MediaTek like below
>> +  PLLs -->
>> +          dividers -->
>> +                      muxes
>> +                           -->
>> +                              clock gate
>> +
>> +  The devices provide clock gate control in different IP blocks.
>> +
>> +properties:
>> +  compatible:
>> +    items:
> 
> Don't need 'items' if only 1 item.
> 
>> +      - enum:
>> +          - mediatek,mt6795-mfgcfg
>> +          - mediatek,mt6795-vdecsys
>> +          - mediatek,mt6795-vencsys
> 
> blank line.
> 
>> +  reg:
>> +    maxItems: 1
>> +
>> +  '#clock-cells':
>> +    const: 1
>> +
>> +required:
>> +  - compatible
>> +  - reg
> 
> Why is #clock-cells optional?
> 

I've used one of the other mediatek,mt(something)-(sys-)clock.yaml as a base
for these ones, giving for granted that they were correct, but now that you're
pointing that out... effectively, I should've checked if the ones that are
already merged in were correct *before* using these as a base for mine.

Thanks for your review: I'll send a v2 soon... and I will also separately
send some fixes for the existing ones, as your review comments also apply
to these ones.

Regards,
Angelo

