Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 627534F016A
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 14:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343716AbiDBMWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 08:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240203AbiDBMV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 08:21:58 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5FCF40;
        Sat,  2 Apr 2022 05:20:05 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id qh7so973013ejb.11;
        Sat, 02 Apr 2022 05:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=COt2euqRR3p6qNdVYbNstxwNnTYl7gJdBogMLtEgqTA=;
        b=Mg6rc54xEGKqf6Sr62HIXx7/S6VwcgCxSYr4+lVSZnE1JT+1Miaoyi8dFVRIHtZSdu
         5SULIpO3nKYYjA631kbta3mcFuJe2Y7ob2/PBHjSznzQfBpLvbBBYSR/YMxvMHELN1W6
         kgqKhmdovoiMgzEGZ2a5glCn4FFJmRb/FWQ4H94SPDOuQR7HRSX8NINW82ibyoBbpl/a
         8jAKy9r+WNjdm5Y33ocCMfZmZdTapku1kbkM4N08jm1YfqxE/zrNTZLVv2725+FIw50K
         fZoW+UJYI4Q+Uvy84+Tl1UynjcRquxnS3g2vifcDgU8hPca4LAIMSSStxzazcNwCxyVY
         K0nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=COt2euqRR3p6qNdVYbNstxwNnTYl7gJdBogMLtEgqTA=;
        b=zGUMP1yfxAzmD9ipwq5r3pi+0DJZTEAZWpXzYt0Ttyc4I7areR62H9fYCQrY77FvBp
         2CL/C1pbuP6t7Z53bZ+AWnLYUBKJ46e9yRYhzcflePhQkLmxwYjltbb1V/ioJ8L7m1RL
         5Dti/dIOWD75lNB9EVzJCUkxjzcHySJPnkz2nav2dCXKOh6fGx3+vEzUkmdm5hd2F5QE
         4XUanV9HhL6whmHVCJgr60lnw88vrqa3/teTr84Cx7U6LxfFJ4Yc184tzd/s8hZQoaGW
         szDYsQm96Nu5rjRRVSkk+AD7qmVdxyWbS3jPMus+DpvMAEMLKLEmEeTzY2XnQ3D/xeHP
         cstg==
X-Gm-Message-State: AOAM531lzoeIQ+uzeg4tEjfo242N9cfPvbzyFDmQB9zJGfVl+7CoN5Nz
        gQ8yxygRnoZusqKLx/X85rw=
X-Google-Smtp-Source: ABdhPJyCmCQjhb3s6usKGbvexqkR+YJgkUTkRVz71aLf6bCa6lioWwmFQnVrVCOqCIttMycVJO4N6A==
X-Received: by 2002:a17:907:9626:b0:6da:6c6f:9825 with SMTP id gb38-20020a170907962600b006da6c6f9825mr3541752ejc.600.1648902003785;
        Sat, 02 Apr 2022 05:20:03 -0700 (PDT)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id dk21-20020a0564021d9500b0041b501eab8csm2414432edb.57.2022.04.02.05.20.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Apr 2022 05:20:03 -0700 (PDT)
Message-ID: <0eed395b-ca02-2308-a5c6-7c4a72720175@gmail.com>
Date:   Sat, 2 Apr 2022 14:20:02 +0200
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
 <7c786619-6fcf-21dd-8e5a-0ec67da2a63d@gmail.com>
 <5e1b6c09-0a8f-f1d9-728b-90ffbaedae83@linaro.org>
From:   Johan Jonker <jbx6244@gmail.com>
In-Reply-To: <5e1b6c09-0a8f-f1d9-728b-90ffbaedae83@linaro.org>
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



On 4/2/22 14:16, Krzysztof Kozlowski wrote:
> On 02/04/2022 13:45, Johan Jonker wrote:
>>
>>
>> On 4/2/22 13:41, Krzysztof Kozlowski wrote:
>>> On 01/04/2022 09:55, Heiko Stübner wrote:
>>>> Hi Stephen,
>>>>
>>>> Am Freitag, 1. April 2022, 00:51:32 CEST schrieb Stephen Boyd:
>>>>> Quoting Johan Jonker (2022-03-29 04:13:22)
>>>>>> diff --git a/Documentation/devicetree/bindings/clock/rockchip,rk3188-cru.yaml b/Documentation/devicetree/bindings/clock/rockchip,rk3188-cru.yaml
>>>>>> new file mode 100644
>>>>>> index 000000000..ddd7e46af
>>>>>> --- /dev/null
>>>>>> +++ b/Documentation/devicetree/bindings/clock/rockchip,rk3188-cru.yaml
>>>>>> @@ -0,0 +1,78 @@
>>>>>> +# SPDX-License-Identifier: GPL-2.0
>>>>>> +%YAML 1.2
>>>>>> +---
>>>>>> +$id: http://devicetree.org/schemas/clock/rockchip,rk3188-cru.yaml#
>>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>>> +
>>>>>> +title: Rockchip RK3188/RK3066 Clock and Reset Unit (CRU)
>>>>>> +
>>>>>> +maintainers:
>>>>>> +  - Elaine Zhang <zhangqing@rock-chips.com>
>>>>>> +  - Heiko Stuebner <heiko@sntech.de>
>>>>>> +
>>>>>> +description: |
>>>>>> +  The RK3188/RK3066 clock controller generates and supplies clocks to various
>>>>>> +  controllers within the SoC and also implements a reset controller for SoC
>>>>>> +  peripherals.
>>>>>> +  Each clock is assigned an identifier and client nodes can use this identifier
>>>>>> +  to specify the clock which they consume. All available clocks are defined as
>>>>>> +  preprocessor macros in the dt-bindings/clock/rk3188-cru.h and
>>>>>> +  dt-bindings/clock/rk3066-cru.h headers and can be used in device tree sources.
>>>>>> +  Similar macros exist for the reset sources in these files.
>>>>>> +  There are several clocks that are generated outside the SoC. It is expected
>>>>>> +  that they are defined using standard clock bindings with following
>>>>>> +  clock-output-names:
>>>>>> +    - "xin24m"    - crystal input                 - required
>>>>>> +    - "xin32k"    - RTC clock                     - optional
>>>>>> +    - "xin27m"    - 27mhz crystal input on RK3066 - optional
>>>>>> +    - "ext_hsadc" - external HSADC clock          - optional
>>>>>> +    - "ext_cif0"  - external camera clock         - optional
>>>>>> +    - "ext_rmii"  - external RMII clock           - optional
>>>>>> +    - "ext_jtag"  - external JTAG clock           - optional
>>>>>
>>>>> I'd expect all these clks here to be inputs to this node.
>>>>
>>>> The optional clocks are all part of a circular dependency.
>>>>
>>>> So for example xin32k normally is generated by the pmic and fed
>>>> back into the system, so to get xin32k, we need the pmic to probe,
>>>> which needs i2c, which in turn already needs the clock controller.
>>>
>>> Are you sure that xin32k (RTC) clock should be input to the clock
>>> controller? I would expect it is the input to the SoC RTC block, so
>>> there is no circular dependency.
>>
>> clk-rk3188.c:
>>
>> PNAME(mux_pll_p)		= { "xin24m", "xin32k" };
> 
> Thanks, but that's not the answer whether it is an input to the clock
> controller. It's the answer how the driver implements this. :)

PX2 == rk3066

Rockchip PX2 TRM V1.0.pdf

page 30

Chip Clock Architecture Diagram 1

> 
> Best regards,
> Krzysztof
