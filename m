Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5B9856A02A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 12:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233808AbiGGKl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 06:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235363AbiGGKlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 06:41:50 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4C557215;
        Thu,  7 Jul 2022 03:41:48 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id q9so25698025wrd.8;
        Thu, 07 Jul 2022 03:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=AWk1Z5M5SWdApDSOa1sdcUjH/ZrS41Uj70CxP1iIBEY=;
        b=Q9i8+V9mX7CMwLFG1MVGGhx8nrZVt5/zzB9FFoo4v8WHX89lbh1JhLeXgY5L9pKoco
         iRbJ7H2bZDSvjTe6f/HnJob3uyUBaV55v2LPxGsdH94HrSQ4kvebHFCeCGv7LlB9AKu7
         RrDEddLM6hngxF1yJMMC5JraOJsa1DnjE6RzRYjDsl4jBAqBV3rqxPXREKp8TwzsOkdt
         Eg5XbdWvU5CFUhtBHkzXrvapyIWK1NQh9z3wjMr66enK0/aW/HMuDsJXPkttKS0NPW92
         w+rYrB9voK80ctcuQI7pAdE/tLsBOd9B3EfrrL1e3CGs20Giw5HDR3jgeO8aneXyBXtk
         bXfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=AWk1Z5M5SWdApDSOa1sdcUjH/ZrS41Uj70CxP1iIBEY=;
        b=BAtvHPMkmlqKaJ1udOYhPsKsFNt0joo6q7O5mtQ/Xut0/Xef+J7ucddUe7HeeTMeG1
         OlpI1ag9bzWTOJIHlprWorrzquq++7OTB2e2F7sG84hvIkEBrvUa/HwwhCy5yjwaMcDC
         Ve2ovd9HCPP2HxMxbEIiKR0QvexV4UNM341pMg7Jj2PuZsS6osBiUUebiTYL/DUZgKVB
         jgLiSc5lAKUcfDljByXp4Mezv8rR3PG82rSpFx+aVXwBglSPP52IYvCcHT45AoXGO0wl
         GLNS7oDIdZ/UMneVgQtGwib1fvVxQeij4zWTt8EVJkvFEilceZBzBxuvAzY+Mfqlltqq
         Fbjg==
X-Gm-Message-State: AJIora/TCNwx/xZchj4WdIv+iM3E+Wznam1yZC0F7kcumlHZ3ojPCGTe
        gVlMd9SEnA2u4s5/6HQ2d6g=
X-Google-Smtp-Source: AGRyM1t2zasbMiF3MWY2dw1TcEEKZ25K4+xE5Ii9yxj9FzxvwTPc8TRwQ7+xwCe9gkFE7vgFIV8tuw==
X-Received: by 2002:a5d:6da2:0:b0:21b:c9cb:f96c with SMTP id u2-20020a5d6da2000000b0021bc9cbf96cmr42764518wrs.670.1657190506913;
        Thu, 07 Jul 2022 03:41:46 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id d7-20020a5d5387000000b0021d5c52f4b4sm14133497wrv.34.2022.07.07.03.41.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jul 2022 03:41:45 -0700 (PDT)
Message-ID: <640c1a9b-f8b5-aa89-19af-7d6f5c55eb12@gmail.com>
Date:   Thu, 7 Jul 2022 12:41:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Xiandong Wang <xiandong.wang@mediatek.com>
References: <20220705122627.2273-1-allen-kh.cheng@mediatek.com>
 <20220705122627.2273-2-allen-kh.cheng@mediatek.com>
 <5916c91b-41a1-c97a-84b4-7d48739a0639@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: soc: mediatek: add mdp3 mutex support
 for mt8186
In-Reply-To: <5916c91b-41a1-c97a-84b4-7d48739a0639@collabora.com>
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



On 07/07/2022 10:52, AngeloGioacchino Del Regno wrote:
> Il 05/07/22 14:26, Allen-KH Cheng ha scritto:
>> Add mdp3 mutex compatible for mt8186 SoC.
>>
>> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
>> Signed-off-by: Xiandong Wang <xiandong.wang@mediatek.com>
> 
> 
> Please drop this commit. Adding a mdp3-mutex compatible is not needed here.
> 

Thanks for checking. We probably would need a fallback compatible. We can only 
know from the HW engineers that can confirm if the IP block is the same as the 
disp mutex or a different one.

I'll drop both patches for now until things got clear.

Regards,
Matthias

>> ---
>>   .../devicetree/bindings/soc/mediatek/mediatek,mutex.yaml         | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git 
>> a/Documentation/devicetree/bindings/soc/mediatek/mediatek,mutex.yaml 
>> b/Documentation/devicetree/bindings/soc/mediatek/mediatek,mutex.yaml
>> index 627dcc3e8b32..234fa5dc07c2 100644
>> --- a/Documentation/devicetree/bindings/soc/mediatek/mediatek,mutex.yaml
>> +++ b/Documentation/devicetree/bindings/soc/mediatek/mediatek,mutex.yaml
>> @@ -30,6 +30,7 @@ properties:
>>         - mediatek,mt8173-disp-mutex
>>         - mediatek,mt8183-disp-mutex
>>         - mediatek,mt8186-disp-mutex
>> +      - mediatek,mt8186-mdp3-mutex
>>         - mediatek,mt8192-disp-mutex
>>         - mediatek,mt8195-disp-mutex
> 
> 
> 
