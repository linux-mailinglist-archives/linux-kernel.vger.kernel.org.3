Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57D574F0141
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 13:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354700AbiDBLrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 07:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345585AbiDBLrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 07:47:42 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD32102419;
        Sat,  2 Apr 2022 04:45:50 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id o10so10904830ejd.1;
        Sat, 02 Apr 2022 04:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=mNsju5GL00z1RyQm3l0+7VPkhzm9rxPNhHy/pDN9Wuo=;
        b=F3Wq1Dg9QSg+Au6PwkGHbLQcljvRxPcQK1PVu4cDckHceuCw+38Prd39W8jTjp1G6O
         I89qcEbphxVwtRiqZr1PQOGe+TbQbbIgH+q/CEuPYgVyCkguZACeQJGbsN3bW11Q11W2
         414efPmFug+n+PW0j3hAMLQB+KUhiiT9E0M2vZAABgr1Hw46X/fCcYwHnEuPFMXAHpXv
         0y4oLwr5PDA6dD9ga4lSO/DTPbwIF8JN6qc13D+8Y79hAtsrhyoZWF/yKzCivmstLT/R
         hVGDP4J2WDaBYhFLpFPmzz/8FHnLOMXSXAVWzzgjRGkVFlEOV0sKQRB2eVhHycg2ayTe
         sK2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mNsju5GL00z1RyQm3l0+7VPkhzm9rxPNhHy/pDN9Wuo=;
        b=LEaBqP65CtFmXpsVum2L1Yap8PFY54Kb3iEYtMx6K2W2c+Asotf41f9Y/5pkOv+xlu
         j6LCvc2xyRkIL1dgulR2G2sgFygrv0u1g1/zeuW8TvUqhMd6wpLHTFfp+zimYri83z+T
         zykVDARUt2llAc1l5FcOqoDNdCvP9/Xlxbs/Ewoy6CmYSlc57CFZr3PfNlCszmo/bvCd
         +4qSxvtsHgASFJvA+dcmg9gj1gNxNSv9XbSmbMnvzd00lUF+U9Z2bRM2NYhWbEzAkYjr
         t/qR0v776ONI3tg9TbqwkQs+W6dQub50qtQscYKnWe81QJnZUgGFuqSEGhfos7mZKseM
         r9sQ==
X-Gm-Message-State: AOAM5334WOWyOrfx8n8mvHfqdCWHUwpBIcnEscDm7b/O2vor+V6ERwXf
        9dyGKxnay0DMdM7oaHK+iIs3RNgLP0g=
X-Google-Smtp-Source: ABdhPJw/2Ag/W5KshG7t4c90IlqoKELgYULFOTQbmu+MAoQqg+LUOYqOGC1BTGegKdXvs+xkILrGHQ==
X-Received: by 2002:a17:907:6284:b0:6e0:f895:15a with SMTP id nd4-20020a170907628400b006e0f895015amr3553176ejc.713.1648899949252;
        Sat, 02 Apr 2022 04:45:49 -0700 (PDT)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id y14-20020a50eb8e000000b00419bdc32466sm2316223edr.15.2022.04.02.04.45.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Apr 2022 04:45:48 -0700 (PDT)
Message-ID: <7c786619-6fcf-21dd-8e5a-0ec67da2a63d@gmail.com>
Date:   Sat, 2 Apr 2022 13:45:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v3 1/2] dt-bindings: clock: convert
 rockchip,rk3188-cru.txt to YAML
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        zhangqing@rock-chips.com, Stephen Boyd <sboyd@kernel.org>
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, mturquette@baylibre.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220329111323.3569-1-jbx6244@gmail.com>
 <20220331225134.7A0A9C340ED@smtp.kernel.org> <3107512.vfdyTQepKt@diego>
 <c212c994-fc5d-6ad0-3cd6-88dc2c719e38@linaro.org>
From:   Johan Jonker <jbx6244@gmail.com>
In-Reply-To: <c212c994-fc5d-6ad0-3cd6-88dc2c719e38@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/2/22 13:41, Krzysztof Kozlowski wrote:
> On 01/04/2022 09:55, Heiko Stübner wrote:
>> Hi Stephen,
>>
>> Am Freitag, 1. April 2022, 00:51:32 CEST schrieb Stephen Boyd:
>>> Quoting Johan Jonker (2022-03-29 04:13:22)
>>>> diff --git a/Documentation/devicetree/bindings/clock/rockchip,rk3188-cru.yaml b/Documentation/devicetree/bindings/clock/rockchip,rk3188-cru.yaml
>>>> new file mode 100644
>>>> index 000000000..ddd7e46af
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/clock/rockchip,rk3188-cru.yaml
>>>> @@ -0,0 +1,78 @@
>>>> +# SPDX-License-Identifier: GPL-2.0
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/clock/rockchip,rk3188-cru.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: Rockchip RK3188/RK3066 Clock and Reset Unit (CRU)
>>>> +
>>>> +maintainers:
>>>> +  - Elaine Zhang <zhangqing@rock-chips.com>
>>>> +  - Heiko Stuebner <heiko@sntech.de>
>>>> +
>>>> +description: |
>>>> +  The RK3188/RK3066 clock controller generates and supplies clocks to various
>>>> +  controllers within the SoC and also implements a reset controller for SoC
>>>> +  peripherals.
>>>> +  Each clock is assigned an identifier and client nodes can use this identifier
>>>> +  to specify the clock which they consume. All available clocks are defined as
>>>> +  preprocessor macros in the dt-bindings/clock/rk3188-cru.h and
>>>> +  dt-bindings/clock/rk3066-cru.h headers and can be used in device tree sources.
>>>> +  Similar macros exist for the reset sources in these files.
>>>> +  There are several clocks that are generated outside the SoC. It is expected
>>>> +  that they are defined using standard clock bindings with following
>>>> +  clock-output-names:
>>>> +    - "xin24m"    - crystal input                 - required
>>>> +    - "xin32k"    - RTC clock                     - optional
>>>> +    - "xin27m"    - 27mhz crystal input on RK3066 - optional
>>>> +    - "ext_hsadc" - external HSADC clock          - optional
>>>> +    - "ext_cif0"  - external camera clock         - optional
>>>> +    - "ext_rmii"  - external RMII clock           - optional
>>>> +    - "ext_jtag"  - external JTAG clock           - optional
>>>
>>> I'd expect all these clks here to be inputs to this node.
>>
>> The optional clocks are all part of a circular dependency.
>>
>> So for example xin32k normally is generated by the pmic and fed
>> back into the system, so to get xin32k, we need the pmic to probe,
>> which needs i2c, which in turn already needs the clock controller.
> 
> Are you sure that xin32k (RTC) clock should be input to the clock
> controller? I would expect it is the input to the SoC RTC block, so
> there is no circular dependency.

clk-rk3188.c:

PNAME(mux_pll_p)		= { "xin24m", "xin32k" };

> 
> 
> Best regards,
> Krzysztof
