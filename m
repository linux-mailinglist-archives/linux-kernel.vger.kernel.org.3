Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC0555FDE9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 12:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232816AbiF2KvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 06:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbiF2Ku5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 06:50:57 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08372314D;
        Wed, 29 Jun 2022 03:50:53 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D792B6601907;
        Wed, 29 Jun 2022 11:50:50 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656499852;
        bh=VB4xmm1pqPyAJPc0TeGDMO5zgTSwWc/1+kwgXsrt4qs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Hm1APcJMp3r5Z/fFRTMizpJTQ1FWIo8qar/oI5Vqac3oOc3XdRouobWFKHlU1Xtb/
         K2DkYVAqhhGrFnbIFJ9nBPOq77G/jQNnR0NcMpJni5yOtedfJvJUx639JtnEPJYfEY
         F1wmPeS6XXYQJC48PdoOAb04Z9Pdu7v/rtBzr/NxasiZ42+eu1+HSdpXLEsG5alTls
         RnmvSxeBeU6eMgXzQWqqPkPu4ABEZrEDViu3/8o/EFdTic/EOnHIblKof6W0q9yqHW
         ql/1SDvS6yQ9cp/xtFNDZYEmSNad/gM4C5gBG8m9U6ihpJKI4xhmFjQi5hdRFflyb6
         AP0vfPLUHmeHw==
Message-ID: <603cffde-f8f4-d313-c7a9-ad87b70fa61e@collabora.com>
Date:   Wed, 29 Jun 2022 12:50:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4 3/7] dt-bindings: reset: Add bindings for MT6795 Helio
 X10 reset controllers
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        robh+dt@kernel.org
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
        kernel@collabora.com, Rob Herring <robh@kernel.org>
References: <20220627085632.23797-1-angelogioacchino.delregno@collabora.com>
 <20220627085632.23797-4-angelogioacchino.delregno@collabora.com>
 <51748cbc-e895-13cc-6b8e-8c62b211aa4e@linaro.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <51748cbc-e895-13cc-6b8e-8c62b211aa4e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 29/06/22 12:49, Krzysztof Kozlowski ha scritto:
> On 27/06/2022 10:56, AngeloGioacchino Del Regno wrote:
>> Add the reset controller bindings for MT6795.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> Acked-by: Rob Herring <robh@kernel.org>
>> ---
>>   include/dt-bindings/reset/mt6795-resets.h | 50 +++++++++++++++++++++++
>>   1 file changed, 50 insertions(+)
>>   create mode 100644 include/dt-bindings/reset/mt6795-resets.h
>>
>> diff --git a/include/dt-bindings/reset/mt6795-resets.h b/include/dt-bindings/reset/mt6795-resets.h
>> new file mode 100644
>> index 000000000000..0a6514884eae
>> --- /dev/null
>> +++ b/include/dt-bindings/reset/mt6795-resets.h
> 
> You still need vendor prefix.
> 
> 

Ouch, I'm sorry, I was somehow convinced that I had added it.

v5 coming as soon as I can.

Sorry again,
Angelo
