Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8594F0166
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 14:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242730AbiDBMSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 08:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242281AbiDBMSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 08:18:34 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5B119141E
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 05:16:42 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id y10so5833305edv.7
        for <linux-kernel@vger.kernel.org>; Sat, 02 Apr 2022 05:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=tMn5SFNOvtFJo+djtkMlHoY3ZjZs+JPd7szVA4qbR0Y=;
        b=Pbq/ZW7pvqgrAMKrviMVZe4Bu5I043VMiSjnc93BbRDEuBloRuz2YHKay8cyFWYQtj
         b9M8VQVyDNln+LyPr94C2m3TQUmwDCqQuXlpq5NtK3jdS1c3gyNaBSa1tm7bxNZPSz/5
         jfNmGubEgRGt9TMc4/G29QDOcrViPofTHKy4md8UAjiK5iKPZT2PVJvbDi/zmLD7xlb6
         /5wWpfTb9HXEuWLTBuo+eFkOnTLyNOBRTvZ4TgSyEIWx5y6Px41ypotky6iNGQ07/OA2
         mfOKXHEiNnqyjmZPkhAJkQqqyOR6nRfMmlxeR9PqGw1Ch+nKr/5YIbXQ6kryFPQnTdOv
         yNgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tMn5SFNOvtFJo+djtkMlHoY3ZjZs+JPd7szVA4qbR0Y=;
        b=ByoX8zXcHVeq5S10oMP5OttZZ+8AvXvGVfz1s/m9kw/CN3fawGQHnu8aDRK3CSAShO
         u38sfEas3Xh+RF4ettikZPihirv3Su41DoctOy4t7hCAVo7RbST5D+oFozLfg+qs2D8E
         RgJzG69EuMrlGe6P7eKFw6mLCS5ZOvkPH8XG8Sq5Mdfjs7KY2TJTHPWfGoU9S7VX7qnU
         sFeoFAAEqhY56hS4RzFZnZwKPPzcRJ7Gb/qMLxZRuuRZ8u+nPyy9gvqXd/VKipRVaHYM
         p0UtPjm8rccAk9UVNNlHYnFAyt56ZMJHt0GFAKqKR20DY1ifklTwu2KgihdyUmGeXVxz
         WuQw==
X-Gm-Message-State: AOAM532XGns4BEyYDn4dI4irFcoxuSRIN8JG2HNKOuX4wx6Hk+2LmY3X
        2Rvdmfp8Ex7LbX7XmMOJyNfVuzjiSJZhKySx
X-Google-Smtp-Source: ABdhPJwvD68kVUcX+t7XPlpFYBOHkSMjj+wzKh++wVN9zNZNdR9qKez+wcEnMzzi99GmzWo/oy8K2A==
X-Received: by 2002:a50:ee05:0:b0:419:39d9:ccd8 with SMTP id g5-20020a50ee05000000b0041939d9ccd8mr25171430eds.369.1648901800793;
        Sat, 02 Apr 2022 05:16:40 -0700 (PDT)
Received: from [192.168.0.171] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id by4-20020a0564021b0400b00418fc410299sm2335191edb.62.2022.04.02.05.16.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Apr 2022 05:16:40 -0700 (PDT)
Message-ID: <5e1b6c09-0a8f-f1d9-728b-90ffbaedae83@linaro.org>
Date:   Sat, 2 Apr 2022 14:16:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 1/2] dt-bindings: clock: convert
 rockchip,rk3188-cru.txt to YAML
Content-Language: en-US
To:     Johan Jonker <jbx6244@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <7c786619-6fcf-21dd-8e5a-0ec67da2a63d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/04/2022 13:45, Johan Jonker wrote:
> 
> 
> On 4/2/22 13:41, Krzysztof Kozlowski wrote:
>> On 01/04/2022 09:55, Heiko Stübner wrote:
>>> Hi Stephen,
>>>
>>> Am Freitag, 1. April 2022, 00:51:32 CEST schrieb Stephen Boyd:
>>>> Quoting Johan Jonker (2022-03-29 04:13:22)
>>>>> diff --git a/Documentation/devicetree/bindings/clock/rockchip,rk3188-cru.yaml b/Documentation/devicetree/bindings/clock/rockchip,rk3188-cru.yaml
>>>>> new file mode 100644
>>>>> index 000000000..ddd7e46af
>>>>> --- /dev/null
>>>>> +++ b/Documentation/devicetree/bindings/clock/rockchip,rk3188-cru.yaml
>>>>> @@ -0,0 +1,78 @@
>>>>> +# SPDX-License-Identifier: GPL-2.0
>>>>> +%YAML 1.2
>>>>> +---
>>>>> +$id: http://devicetree.org/schemas/clock/rockchip,rk3188-cru.yaml#
>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>> +
>>>>> +title: Rockchip RK3188/RK3066 Clock and Reset Unit (CRU)
>>>>> +
>>>>> +maintainers:
>>>>> +  - Elaine Zhang <zhangqing@rock-chips.com>
>>>>> +  - Heiko Stuebner <heiko@sntech.de>
>>>>> +
>>>>> +description: |
>>>>> +  The RK3188/RK3066 clock controller generates and supplies clocks to various
>>>>> +  controllers within the SoC and also implements a reset controller for SoC
>>>>> +  peripherals.
>>>>> +  Each clock is assigned an identifier and client nodes can use this identifier
>>>>> +  to specify the clock which they consume. All available clocks are defined as
>>>>> +  preprocessor macros in the dt-bindings/clock/rk3188-cru.h and
>>>>> +  dt-bindings/clock/rk3066-cru.h headers and can be used in device tree sources.
>>>>> +  Similar macros exist for the reset sources in these files.
>>>>> +  There are several clocks that are generated outside the SoC. It is expected
>>>>> +  that they are defined using standard clock bindings with following
>>>>> +  clock-output-names:
>>>>> +    - "xin24m"    - crystal input                 - required
>>>>> +    - "xin32k"    - RTC clock                     - optional
>>>>> +    - "xin27m"    - 27mhz crystal input on RK3066 - optional
>>>>> +    - "ext_hsadc" - external HSADC clock          - optional
>>>>> +    - "ext_cif0"  - external camera clock         - optional
>>>>> +    - "ext_rmii"  - external RMII clock           - optional
>>>>> +    - "ext_jtag"  - external JTAG clock           - optional
>>>>
>>>> I'd expect all these clks here to be inputs to this node.
>>>
>>> The optional clocks are all part of a circular dependency.
>>>
>>> So for example xin32k normally is generated by the pmic and fed
>>> back into the system, so to get xin32k, we need the pmic to probe,
>>> which needs i2c, which in turn already needs the clock controller.
>>
>> Are you sure that xin32k (RTC) clock should be input to the clock
>> controller? I would expect it is the input to the SoC RTC block, so
>> there is no circular dependency.
> 
> clk-rk3188.c:
> 
> PNAME(mux_pll_p)		= { "xin24m", "xin32k" };

Thanks, but that's not the answer whether it is an input to the clock
controller. It's the answer how the driver implements this. :)

Best regards,
Krzysztof
