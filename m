Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB9B35447A8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 11:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235008AbiFIJf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 05:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233025AbiFIJfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 05:35:55 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C767D654B;
        Thu,  9 Jun 2022 02:35:51 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3D1EC66016FD;
        Thu,  9 Jun 2022 10:35:49 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654767350;
        bh=BH72tA3Gv2tLURwDnY5UsSEkwsx+vUzwp5wTPxVczvk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=aFgguC5hMuyVbHwuGvCHFJ/j16RiTIEJQ4LRbUFOphEqEyKiRcnjJxU8B66h/GYQ3
         GT4U+S2FDQS4S3AGCcCaRin3wtBLGC3hxCBCSeMrx2JX+jozSujwzsrd4N3kasKMZq
         xb2PmVvm4z1F+7aYRKRxe32oRugDq2sax4108q+hp0dCiiAltoVHxLT5nLh84KlWZN
         xykOEDKdoJSUMDP3HUAW7qeyPZCEq4cGi6nCaQ2Vq8TijxtaONgDPNjXKCDNkdTaCW
         5XFKn7XzzqiLqvKcovYV+NFovRiH2SrZtWqaHEKxtODGlePSDyhrTS/200pYBUAocV
         WLARRgsksZ3cw==
Message-ID: <1974b83e-967a-41ed-e790-52ceaf349ad3@collabora.com>
Date:   Thu, 9 Jun 2022 11:35:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v3 1/2] dt-bindings: timer: mediatek: Add CPUX System
 Timer and MT6795 compatible
Content-Language: en-US
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        daniel.lezcano@linaro.org
Cc:     tglx@linutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, konrad.dybcio@somainline.org,
        marijn.suijten@somainline.org, martin.botka@somainline.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        paul.bouchara@somainline.org
References: <20220518112435.241116-1-angelogioacchino.delregno@collabora.com>
 <20220518112435.241116-2-angelogioacchino.delregno@collabora.com>
 <afd9ab8e-5bad-54ee-3f44-5e0cfdb22e75@gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <afd9ab8e-5bad-54ee-3f44-5e0cfdb22e75@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 07/06/22 18:11, Matthias Brugger ha scritto:
> 
> 
> On 18/05/2022 13:24, AngeloGioacchino Del Regno wrote:
>> Document the "CPUXGPT" CPU General Purpose Timer, used as ARM/ARM64
>> System Timer on MediaTek platforms and add the MT6795 compatible for it.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   .../devicetree/bindings/timer/mediatek,mtk-timer.txt          | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt 
>> b/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
>> index 6f1f9dba6e88..49706cbef45d 100644
>> --- a/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
>> +++ b/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
>> @@ -2,6 +2,7 @@ MediaTek Timers
>>   ---------------
>>   MediaTek SoCs have two different timers on different platforms,
> 
> Nit: There are now three different timers so maybe:
> "MediaTek SoCs have different timers on different platforms,"
> 
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> 

Hi Matthias,
can we please ignore that description nit for this patch?

I was anyway planning to do a YAML conversion after getting this merged in, perhaps
we can just fix that on the new one instead?

Cheers,
Angelo

>> +- CPUX (ARM/ARM64 System Timer)
>>   - GPT (General Purpose Timer)
>>   - SYST (System Timer)
>> @@ -29,6 +30,9 @@ Required properties:
>>       * "mediatek,mt7629-timer" for MT7629 compatible timers (SYST)
>>       * "mediatek,mt6765-timer" for MT6765 and all above compatible timers (SYST)
>> +    For those SoCs that use CPUX
>> +    * "mediatek,mt6795-systimer" for MT6795 compatible timers (CPUX)
>> +
>>   - reg: Should contain location and length for timer register.
>>   - clocks: Should contain system clock.

