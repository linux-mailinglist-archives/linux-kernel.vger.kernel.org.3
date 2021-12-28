Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4636F480B04
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 16:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235469AbhL1P4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 10:56:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235287AbhL1P4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 10:56:15 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86D5C061574;
        Tue, 28 Dec 2021 07:56:14 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id g7-20020a7bc4c7000000b00345c4bb365aso10258888wmk.4;
        Tue, 28 Dec 2021 07:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=t1MDQ1CuJ+CtxV/k/TCo6Po1qrBja12Cye53X+2hxAw=;
        b=o00dZLBKTdEgFVqOhz+3M4aTH+3GOsY6yRQov1N60Io3DQ0tYv672K+Ia/kb0s2Uma
         FG5vmY1zQ0BgRwgTdNKyniFugn2+4+UFg4IPcRT/XBqTgWyRME2SkYuaXbpCRn8S8Ytp
         SyREk40Ngrepjvm9sywWazRQcUAUc/FzIQB1SkSrJtHjBo0L/aX9UKBqB4Zvyp92HIJt
         itgYdg4PZW6Z+7mihWiszGF809uT++Jmw0qi+4f/22DxTIvNevnRK9qUstmAB1sADf/9
         BkceYfdugySDWoWxBVo5fSg0s8bdkd7VcXr6lOvdgDQKB2WvLAOiZFtzeF7JH88Uf5q2
         QEEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=t1MDQ1CuJ+CtxV/k/TCo6Po1qrBja12Cye53X+2hxAw=;
        b=lxoVx/nvPTfODgNkrfuAcnaV2Bt52NoIjoGKQcCVg7iOpXi4T1KLM+HOlEs8WIgeHE
         dvVsv5/ffBu/pUoDUuzy9lmI41SkAWTKuuGuTwajmFKYj3ShVobgd8ElabPjZYiitrBr
         5MjiUmjKGLO31keUym128FJJJLZFoRufeFA6Qe9YUSHNWyOe27oRArQSnmAGY/N1ba1Q
         NkZ7HnOvlUp7Duw91Ck+UERYrDFQeQhA1JG/scXqIOzrNC9eu0HUTFdh/7idAaw/pgsF
         pmQtnj+wSxYE3Yw+GFY5wlG4uzxNFDERcu4zxxPAWPhiITTUwk0sjBK9SDaTMJcwuGRB
         MtlQ==
X-Gm-Message-State: AOAM532UtCfJfjqwqztfc2XyMHjgfgriC9foqlkQCJIlKx0j6IctkfNh
        6RIcfnYjmVMLFcFcTooMW8U=
X-Google-Smtp-Source: ABdhPJwTVaMHMH2jZEptpNnvfazLDgeUnQ/pvqXSObPuy3N5yE62W28JeUWULMTu8bgsKg/0uhBGbQ==
X-Received: by 2002:a1c:23d2:: with SMTP id j201mr18135068wmj.76.1640706973311;
        Tue, 28 Dec 2021 07:56:13 -0800 (PST)
Received: from [192.168.2.177] ([207.188.161.251])
        by smtp.gmail.com with ESMTPSA id a204sm21834509wmd.39.2021.12.28.07.56.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Dec 2021 07:56:12 -0800 (PST)
Message-ID: <331e5b78-2ac7-bca6-061d-85cf25a6bd95@gmail.com>
Date:   Tue, 28 Dec 2021 16:56:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>, Maxim Kutnij <gtk3@inbox.ru>
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211219183134.3849-1-gtk3@inbox.ru>
 <20211219183134.3849-3-gtk3@inbox.ru> <YcNhMdN6rzh9yRG1@robh.at.kernel.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH 3/3] This adds a DT binding documentation for the MT6582
 SoC
In-Reply-To: <YcNhMdN6rzh9yRG1@robh.at.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/12/2021 18:32, Rob Herring wrote:
> On Sun, Dec 19, 2021 at 11:31:34PM +0500, Maxim Kutnij wrote:
>> This adds a DT binding documentation for the MT6582 SoC.
> 
> Please follow the convention used for other commits of these files in
> the subject:
> 
> dt-bindings: mediatek: ...
> 
> (That's true for all commits in the kernel)
> 

I fixed that for you. I also fixed the order of the timer and SoC compatible.

All three patches are now pushed to v5.17-tmp/dts32 [1]
This branch will be renamed to v5.17-next/dts32 after v5.17-rc1 is released.

Hope to see more patches from you to enable other drivers of the SoC.

Thanks!

[1] https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git/

>>
>> Signed-off-by: Maxim Kutnij <gtk3@inbox.ru>
>> ---
>>   Documentation/devicetree/bindings/arm/mediatek.yaml           | 4 ++++
>>   .../devicetree/bindings/timer/mediatek,mtk-timer.txt          | 1 +
>>   Documentation/devicetree/bindings/watchdog/mtk-wdt.txt        | 1 +
>>   3 files changed, 6 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
>> index 0fa55497b96..fedce0d0f3f 100644
>> --- a/Documentation/devicetree/bindings/arm/mediatek.yaml
>> +++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
>> @@ -26,6 +26,10 @@ properties:
>>             - enum:
>>                 - mediatek,mt2712-evb
>>             - const: mediatek,mt2712
>> +      - items:
>> +          - enum:
>> +              - prestigio,pmt5008-3g
>> +          - const: mediatek,mt6582
>>         - items:
>>             - enum:
>>                 - mediatek,mt6580-evbp1
>> diff --git a/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt b/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
>> index e5c57d6e018..62acdb11aff 100644
>> --- a/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
>> +++ b/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
>> @@ -11,6 +11,7 @@ Required properties:
>>   - compatible should contain:
>>   	For those SoCs that use GPT
>>   	* "mediatek,mt2701-timer" for MT2701 compatible timers (GPT)
>> +	* "mediatek,mt6582-timer" for MT6582 compatible timers (GPT)
>>   	* "mediatek,mt6580-timer" for MT6580 compatible timers (GPT)
>>   	* "mediatek,mt6589-timer" for MT6589 compatible timers (GPT)
>>   	* "mediatek,mt7623-timer" for MT7623 compatible timers (GPT)
>> diff --git a/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt b/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
>> index 0114871f887..a97418c74f6 100644
>> --- a/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
>> +++ b/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
>> @@ -8,6 +8,7 @@ Required properties:
>>   - compatible should contain:
>>   	"mediatek,mt2701-wdt", "mediatek,mt6589-wdt": for MT2701
>>   	"mediatek,mt2712-wdt": for MT2712
>> +	"mediatek,mt6582-wdt", "mediatek,mt6589-wdt": for MT6582
>>   	"mediatek,mt6589-wdt": for MT6589
>>   	"mediatek,mt6797-wdt", "mediatek,mt6589-wdt": for MT6797
>>   	"mediatek,mt7622-wdt", "mediatek,mt6589-wdt": for MT7622
>> -- 
>> 2.34.1
>>
>>
