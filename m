Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81666587B54
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 13:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236766AbiHBLFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 07:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236701AbiHBLE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 07:04:59 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382A6DD;
        Tue,  2 Aug 2022 04:04:58 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id bv3so3531254wrb.5;
        Tue, 02 Aug 2022 04:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc;
        bh=nHi8fLHEx0FAPEMq1lv35iSGwVjA+eu1JTfdJG/1JwA=;
        b=Lal3Ie/ci8JOgPvGGtAlBm+U3/MyomhyVeQYF8BxD+cyn/mzYMbb0osW/bFrWGKyoS
         IPD1iNwxtnxdZ4xzKaV94j4XsnpgI3VK7s+oYr/3frgnNe1u1OplTeJkDHD/gajbkPV6
         kAA7OjLG0cB2hH6Y7Hy3mUCGwsaURof5IrhcyVDeGMq62nrRl/70ELU0iIr3UnhYd0hs
         +IfVPDh0HzVUGYx9SVzeeImsTuz8L91WWWPr6QLIBCQd6L84fzWRQk0rfdiBzGdTF6qf
         NBGPGvIPjrS0exxyTrJ4YdSwOW8IhWrgYE6LBAh+U/ROTt6CuuIeKKOFt91TOUzmKn2h
         qI1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=nHi8fLHEx0FAPEMq1lv35iSGwVjA+eu1JTfdJG/1JwA=;
        b=RZU52G6NqHEzDYVWATHme2cQSWa8lJBN498s1rk05csHmdJ3V8ckRbIvdzF8GFPMeG
         hTW7hzZcB25aWakCE+b9Pt70FV5cr9fJ6nAGN8Z8jLNtCKiKGG4HaOU2k1eVL5YwxbWX
         FUMVaA1YJwMwsUasEa3wMO3HC2PR4rg0Jir+HNIsg6PrhAQGISfMwkV3a+xxuBZdegeN
         JxnTBldSRY+dVky2goB40Eu8qER0wu2NPgqDeIXteo/+GrE0mHvFt5If3uT1yOWIzEMK
         bLkZKrSc5Ehcy4WPmEIkVRarZo6MF61UmI2RDW0fJVSp2QtDecXgRaTaINYe0iTRiGxB
         BUXQ==
X-Gm-Message-State: ACgBeo3TK0ex8oyPy46HbzBgk44rXSBGUClwFuB9zkodsedtL8TtV2YE
        521LJD0YYi9LjrSc3l7S3LtDqfVnsaf6qA==
X-Google-Smtp-Source: AA6agR7DlMgWDRSL/ir77djsoo6TQQwGJanGObcqxajeOs3Ab9UqoY9gLUS27WVcA6hneLY29OqAVA==
X-Received: by 2002:a5d:47a8:0:b0:21d:b690:9273 with SMTP id 8-20020a5d47a8000000b0021db6909273mr11991374wrb.242.1659438296497;
        Tue, 02 Aug 2022 04:04:56 -0700 (PDT)
Received: from [192.168.1.145] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id o5-20020a05600c510500b003a2d6c623f3sm24236447wms.19.2022.08.02.04.04.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 04:04:55 -0700 (PDT)
Message-ID: <5dac39d1-3b42-40e9-5693-0c127e8c689a@gmail.com>
Date:   Tue, 2 Aug 2022 13:04:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Krzysztof Kozlowski <krzk+dt@kernel.org>, nfraprado@collabora.com,
        angelogioacchino.delregno@collabora.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20220721014845.19044-1-allen-kh.cheng@mediatek.com>
 <20220721014845.19044-2-allen-kh.cheng@mediatek.com>
 <CAGXv+5HXwVpaJPV-4Z6qw14xZzEkx_E7dVks6-GBa7bQyN8hCg@mail.gmail.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v4 1/4] dt-bindings: mediatek: watchdog: Fix compatible
 fallbacks and example
In-Reply-To: <CAGXv+5HXwVpaJPV-4Z6qw14xZzEkx_E7dVks6-GBa7bQyN8hCg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/08/2022 11:29, Chen-Yu Tsai wrote:
> On Thu, Jul 21, 2022 at 10:50 AM Allen-KH Cheng
> <allen-kh.cheng@mediatek.com> wrote:
>>
>> The watchdog timer of mt8186. mt8195 and mt7986 have their DT data.
>> We should not use 'mediatek,mt6589-wdt' as fallback.
>>
>> For mediatek,wdt example of mt8183, We remove mediatek,mt6589-wdt fallback.
> 
> I think this needs some more information.
> 
> Right now on the kernel side, mt6589-wdt provides just watchdog support.
> The SoC-specific compatibles that are touched by this patch provide reset
> controls in addition to the standard watchdog, which remains the same.
> 
> If that is the case, then the fallback compatibles are correct. A fallback
> says that the new hardware is compatible with some older hardware, and
> can be run with the driver supporting that older hardware, likely with
> reduced functionality.
> 

My understanding is, that we add a fallback because although at the time we 
entered the compatible, the functionality of the device is the same as the 
fallback. Nonetheless we add a compatible specific for the device in case in the 
future we realize that the device has some functionality that is not and can not 
be covered by the fallback.

This is the case here. Actually adding the fallback in the first place was 
wrong, because the driver since ever supports the extra function for the device, 
the reset.

So this is a mere cleanup of the binding to reflect what was always present in 
the driver.

Regards,
Matthias

> As an example, if mt8195-wdt is backward compatible with mt6589-wdt,
> then it should run as mt6589-wdt, and would just be missing new
> functionality, in this case the reset controls.
> 
> So either mt6589-wdt also contains a reset control that is not the same
> as the other newer chips, or has some other functionality that the other
> chips contain, and justifies the removal of the fallback, or this patch
> is incorrect. Note that mt2701-wdt and mt762*-wdt are still listed as
> compatible with mt6589-wdt. So I think a better explanation is required.
> 
> 
> Regards
> ChenYu
> 
> 
>> Fixes:a45b408a020b("dt-bindings: watchdog: Add compatible for MediaTek MT8186")
>> Fixes:b326f2c85f3d("dt-bindings: watchdog: Add compatible for Mediatek MT8195")
>> Fixes:41e73feb1024("dt-bindings: watchdog: Add compatible for Mediatek MT7986")
>> Fixes:f43f97a0fc0e("dt-bindings: mediatek: mt8183: Add #reset-cells")
>> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
>> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   Documentation/devicetree/bindings/watchdog/mtk-wdt.txt | 9 ++++-----
>>   1 file changed, 4 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt b/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
>> index 762c62e428ef..67ef991ec4cf 100644
>> --- a/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
>> +++ b/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
>> @@ -14,12 +14,12 @@ Required properties:
>>          "mediatek,mt7622-wdt", "mediatek,mt6589-wdt": for MT7622
>>          "mediatek,mt7623-wdt", "mediatek,mt6589-wdt": for MT7623
>>          "mediatek,mt7629-wdt", "mediatek,mt6589-wdt": for MT7629
>> -       "mediatek,mt7986-wdt", "mediatek,mt6589-wdt": for MT7986
>> +       "mediatek,mt7986-wdt": for MT7986
>>          "mediatek,mt8183-wdt": for MT8183
>> -       "mediatek,mt8186-wdt", "mediatek,mt6589-wdt": for MT8186
>> +       "mediatek,mt8186-wdt": for MT8186
>>          "mediatek,mt8516-wdt", "mediatek,mt6589-wdt": for MT8516
>>          "mediatek,mt8192-wdt": for MT8192
>> -       "mediatek,mt8195-wdt", "mediatek,mt6589-wdt": for MT8195
>> +       "mediatek,mt8195-wdt": for MT8195
>>
>>   - reg : Specifies base physical address and size of the registers.
>>
>> @@ -32,8 +32,7 @@ Optional properties:
>>   Example:
>>
>>   watchdog: watchdog@10007000 {
>> -       compatible = "mediatek,mt8183-wdt",
>> -                    "mediatek,mt6589-wdt";
>> +       compatible = "mediatek,mt8183-wdt";
>>          mediatek,disable-extrst;
>>          reg = <0 0x10007000 0 0x100>;
>>          interrupts = <GIC_SPI 139 IRQ_TYPE_NONE>;
>> --
>> 2.18.0
>>
>>
