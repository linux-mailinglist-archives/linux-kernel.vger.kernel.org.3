Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1DE5A5EA1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 10:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbiH3Iv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 04:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231787AbiH3IvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 04:51:19 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A867197B1D;
        Tue, 30 Aug 2022 01:50:45 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id m16so13202165wru.9;
        Tue, 30 Aug 2022 01:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=y50L5GZVbvvACJzqECIw6k5gdho7yrllYoPqCWoxaDo=;
        b=f0jtaBsjiMBC3be5ItKoe1oj1Gdhn1LRjaXKzjv50t2jVwnOQdKsRvEPxxAOoQXv/s
         b6OPiQZGWzOxDzzxMxy4LkHZZ/TJSdjCD+ndZVdmAveCUIW3hO7wJn9Zui/UKkz3GX4L
         YPHvWtIWIQdPOaI9s6IMzQUL2mHoQaQWHtwrFrX5D8r9Ywb73r0ENDcR/uaxk0GqO1HN
         jjwcwM+GxemCvjuYfrT8ptsn0UV8Bz3QtHcrauQlLbq3a6uYWrKyn+P8IhwKyH/9CMMx
         cxHD08S6H9fv2a1OhlU66XEtsZgwe+SSl0dRQuUiAH5hPPq9/d2Dp9URU8rDmuhERegK
         rdqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=y50L5GZVbvvACJzqECIw6k5gdho7yrllYoPqCWoxaDo=;
        b=bK4XXS459ax+uZIsNaS+AqRpEx72uZ3XgJA7LwoccsXT8nRWh+pu+N2dCwcP5ygCCB
         pt/5isUsaMvTP311jcHoaGay7GjEFqpjuhLMxq1J9wKpjDBS1XdEHnH059DT6UfjCspz
         R8uFGoMlr2/V6911ae4goUteeMCn7H2h+wi0+TSM6vnIvFM2TC2aurTRUdKN3+okXmEh
         8uo8EpuPPH8iGk37AKlDnkTiuZv6G46tZMI1MscIQDz6KGzR55yxTGnxF1MWdWeeEYNQ
         V0ZksqBLbKM9X6NMAXjhwRXYNANOujXQAgJmSINHMuuK2SzgT8uDR1TrH3G8bf2SOvGs
         Ss0w==
X-Gm-Message-State: ACgBeo24mteEPV4WvyS1u95B4PPji++afrYTQDSA44iI4OYIwGOcETGs
        W/5vq3+Qs1a//qKYvi+DtegUZ04+AQk=
X-Google-Smtp-Source: AA6agR4JM5gMgpsO9Zqy3pj9N336WW9LiFLW8FuJvAQhVnkzNddi+ZGLzibe3hEckMcQF6t9Xugq7g==
X-Received: by 2002:adf:a490:0:b0:225:2da4:10ff with SMTP id g16-20020adfa490000000b002252da410ffmr8390266wrb.1.1661849443627;
        Tue, 30 Aug 2022 01:50:43 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id n25-20020a05600c3b9900b003a50924f1c0sm14464215wms.18.2022.08.30.01.50.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 01:50:42 -0700 (PDT)
Message-ID: <88030f8d-45e3-e880-48cc-d119858e8139@gmail.com>
Date:   Tue, 30 Aug 2022 10:50:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH] arm64: dts: mediatek: Add missing xHCI clocks for mt8192
 and mt8195
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Cc:     kernel@collabora.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20220708194314.56922-1-nfraprado@collabora.com>
 <5a4e0bfe-e332-42af-5888-b59b3afff24d@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <5a4e0bfe-e332-42af-5888-b59b3afff24d@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/07/2022 11:34, AngeloGioacchino Del Regno wrote:
> Il 08/07/22 21:43, Nícolas F. R. A. Prado ha scritto:
>> The MediaTek xHCI dt-binding expects a specific order for the clocks,
>> but the mt8192 and mt8195 devicetrees were skipping some of the middle
>> clocks. These clocks are wired to the controller hardware but aren't
>> controllable.
>>
>> Add the missing clocks as handles to fixed clocks, so that the clock
>> order is respected and the dtbs_check warnings are gone.
>>
>> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 

applied, thanks!

>> ---
>> A previous attempt to solve this also made all clocks required and
>> updated all MediaTek DTs using the xhci binding [1].
>>
>> To avoid the DT change noise, the binding change is now being reverted
>> [2] and only mt8192 and mt8195 DTs are updated in this commit to get rid
>> of the warnings.
>>
>> [1] https://lore.kernel.org/all/20220623193702.817996-4-nfraprado@collabora.com/
>> [2] https://lore.kernel.org/all/20220708192605.43351-1-nfraprado@collabora.com
>>
>>   arch/arm64/boot/dts/mediatek/mt8192.dtsi |  9 ++++++---
>>   arch/arm64/boot/dts/mediatek/mt8195.dtsi | 18 ++++++++++++++----
>>   2 files changed, 20 insertions(+), 7 deletions(-)
