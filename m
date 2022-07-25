Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9402457FB0F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 10:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233796AbiGYIOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 04:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233853AbiGYIOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 04:14:09 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4079013EA5;
        Mon, 25 Jul 2022 01:14:04 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6B1B066015BF;
        Mon, 25 Jul 2022 09:14:01 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658736842;
        bh=PpK61lKZbKQpFNRPAxrKTr/Fd+0s6I0u9aP/BeZ2hl4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=aa4Lg2jdBb+mlYqsi3WUQi05qZ5Cl2mEGYIREWjW1FxdXvG8viLlXax10wz8RJbBG
         +qOPiWFFYAiXS1/AAFgLjgwMqNlNnczTbRfqN8YzLBvc36mwHB4mLM8qvWYPR51GnO
         4Bvg+rR1wUyVDNC3Y4iDtv8SecdX5Y5OvRIiFiYRur/FGcoYLrm4+FUNrA59qRmXQt
         QYV16K9yheqLG39HyHdXTW9jsSriDEJkglprwQdqtp1yZi9kIBVU/ybGwT27Atz9G+
         l2iB90RbrlL1ICh6x75vtltK1hbEJvizevzOU0om5uD1xQczrKPWcXmoj8DS5n1Hbg
         bMUMI9zE8cQIQ==
Message-ID: <6d6d05cf-9c56-a29a-64cd-1de62c530167@collabora.com>
Date:   Mon, 25 Jul 2022 10:13:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v6 4/8] dt-bindings: clock: mediatek: Add clock driver
 bindings for MT6795
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        sboyd@kernel.org
Cc:     mturquette@baylibre.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        p.zabel@pengutronix.de, y.oudjana@protonmail.com,
        jason-jh.lin@mediatek.com, ck.hu@mediatek.com,
        fparent@baylibre.com, rex-bc.chen@mediatek.com,
        tinghan.shen@mediatek.com, ikjn@chromium.org,
        miles.chen@mediatek.com, sam.shih@mediatek.com, wenst@chromium.org,
        bgolaszewski@baylibre.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, paul.bouchara@somainline.org,
        kernel@collabora.com
References: <20220722090609.52364-1-angelogioacchino.delregno@collabora.com>
 <20220722090609.52364-5-angelogioacchino.delregno@collabora.com>
 <8d656940-567f-d8ea-8cb1-4ca37dde3e0c@linaro.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <8d656940-567f-d8ea-8cb1-4ca37dde3e0c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 23/07/22 22:45, Krzysztof Kozlowski ha scritto:
> On 22/07/2022 11:06, AngeloGioacchino Del Regno wrote:
>> Add the bindings for the clock drivers of the MediaTek Helio X10
>> MT6795 SoC.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   .../bindings/clock/mediatek,mt6795-clock.yaml | 66 +++++++++++++++++++
>>   .../clock/mediatek,mt6795-sys-clock.yaml      | 54 +++++++++++++++
>>   2 files changed, 120 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt6795-clock.yaml
>>   create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt6795-sys-clock.yaml
> 
> You already got a review tag, didn't you? In v5?
> 
> 

I'm sorry, yes I got Rob's review tag in v5 and I somehow forgot to add
it to v6 :-(

Should I send a v7 for adding back the tag?

Angelo
