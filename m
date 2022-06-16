Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69E5554DD01
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 10:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359609AbiFPIgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 04:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbiFPIg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 04:36:29 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929405DA77;
        Thu, 16 Jun 2022 01:36:28 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 892186601742;
        Thu, 16 Jun 2022 09:36:26 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655368587;
        bh=sZsgXd3fsTLEaC/Xa6ctCUmW5czgXrHSQtatfJPolH8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=oh5qpCD3V6oh6r/2TKz+Q+MKTyKQMmqKGCm2+QOTXj5M81oeyTNgA0Q1B/KKFLGPK
         dQpX2zFOgEvgdWqHug3QdgxOX5ap4oD3scMMuqy9oweuaAzyfrEekgowFefU4mAwev
         cTrnfntaRAxUQ/vnhYAzVxnT1qbxNlUnmz066On3+ld+sUHbgvJAzJcFvleKDS1yMb
         FCe08b/71GIYKrpYSgM46vowqUISG8Vr3KWISTMzo+qWMZgPAG5SDVAi4hAdIjYEHN
         At0MtK8VkEACsAnFQD90Lfw4h4HqE+k9p+Tdm0Zmj0Wi714a0mb96vNMRSn4IlE8IC
         D64EfVolwbN0w==
Message-ID: <2859add6-74c3-5a4e-d3fa-68b311418459@collabora.com>
Date:   Thu, 16 Jun 2022 10:36:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/2] dt-bindings: mfd: mt6397: Add compatibles for MT6331
 RTC and keys
Content-Language: en-US
To:     Lee Jones <lee.jones@linaro.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, johnson.wang@mediatek.com,
        hsin-hsiung.wang@mediatek.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220520124617.228808-1-angelogioacchino.delregno@collabora.com>
 <20220520124617.228808-2-angelogioacchino.delregno@collabora.com>
 <YqpTrwlXmXMYuDd0@google.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <YqpTrwlXmXMYuDd0@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 15/06/22 23:48, Lee Jones ha scritto:
> On Fri, 20 May 2022, AngeloGioacchino Del Regno wrote:
> 
>> MT6331 is a multifunction device, providing RTC, keys and more: add
> 
> No such thing as an MFD.  What does the data-sheet call it?

Datasheets for this chip, or the other (6332) are not public ... and I have no
access to any: whatever you see here is done with an accurate reading of downstream
drivers and a lot of debugging and research.

Anyway, MT6331 is a PMIC, MT6332 is also a PMIC (in this case, a companion pmic).

> 
> What "more"?
> 

More is voltage regulators, display backlight PWM, LED PWM, some GPIOs, battery
charging, fuel gauge... and I think nothing else.

Anyway, okay I will list things out in the commit description.

>> the necessary compatibles to start implementing the basics.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   Documentation/devicetree/bindings/mfd/mt6397.txt | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/mt6397.txt b/Documentation/devicetree/bindings/mfd/mt6397.txt
>> index d59063503b0d..2a9533c47365 100644
>> --- a/Documentation/devicetree/bindings/mfd/mt6397.txt
>> +++ b/Documentation/devicetree/bindings/mfd/mt6397.txt
>> @@ -30,6 +30,7 @@ Optional subnodes:
>>   - rtc
>>   	Required properties: Should be one of follows
>>   		- compatible: "mediatek,mt6323-rtc"
>> +		- compatible: "mediatek,mt6331-rtc"
>>   		- compatible: "mediatek,mt6358-rtc"
>>   		- compatible: "mediatek,mt6397-rtc"
>>   	For details, see ../rtc/rtc-mt6397.txt
>> @@ -55,6 +56,7 @@ Optional subnodes:
>>   - keys
>>   	Required properties:
>>   		- compatible: "mediatek,mt6397-keys" or "mediatek,mt6323-keys"
>> +			      or "mediatek,mt6331-keys"
> 
> Please place these in a vertical list.

Will do!

Regards,
Angelo
