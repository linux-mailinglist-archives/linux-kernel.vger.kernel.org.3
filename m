Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 012684F0138
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 13:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241770AbiDBLn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 07:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236262AbiDBLn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 07:43:27 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E06864BD6
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 04:41:35 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id w4so7584719wrg.12
        for <linux-kernel@vger.kernel.org>; Sat, 02 Apr 2022 04:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=AvR1umnn7W1R+x4WzthY5v4HXESOD96tHh9j731yuyI=;
        b=Gb6gnH4BnPj01KZH7A4kXWQ8hmeq0ZH581OTlA9kouF5HlC/q7ghy/f13YADvbS+Jo
         hYeV0Lhen1057rY1ps9eXglxGWRJ+9oRLY9DfDek3HIVk4IYUe2lnyyslvpf2g1JYS7t
         I4dI75ExLKdFIlfv/0VN0wWhqI5a6PD4KNZzo2syvpF2dSYiOlo/0DCazPjtPcQdhRpT
         efWFjuBh+6qwnv9V7aXGZTJ+KvtHs3Oh6OMeLBrDsxPMfrOHqeuZr1GZda1mEBn8rk1D
         v97fMdC6ZSOKulNYUi/cNy4CqgI9CqL6iEE+owkBtFoodtinaSJk5F/iI8hsr4SePWhE
         jLHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AvR1umnn7W1R+x4WzthY5v4HXESOD96tHh9j731yuyI=;
        b=bNuw5g6IWgRA0uWg3HxnnJV2FZwA2zuwpAOClY7OFpaDhkVQd4lA9mXIR9tVn/YKAy
         RVGlAWKopF5nsmT6QD/La9D67kX1cqHyRSrhtEx8BqRs+iyfibGLGC7TYOW6TSFFqJXy
         va0fqyopC9CpC7Ez2T1fqUaf6+ERYm4GZnxmQTMLjOk1XAbk7tujK5YbTo5u4b3k2bsY
         MjrbbioSar+UxyXV7cxTfEmFdo9w7nzJ3lhPgs64uPOpLxmsOH02LtODJg9Ggh76Qihp
         B7IZqX9imBRj5bvnz1US0EEE2OAJwL1AM/5oFidMMiIUmItKmtZ6Jqx/dabsndoBHmfX
         WSnA==
X-Gm-Message-State: AOAM533o18aP/Fzb16OK1Es1CPQrEIn4/99ItdP9olXAX9h1mWRhxvta
        +ji5mp+SRJs4A4gdWc9olyBVhA==
X-Google-Smtp-Source: ABdhPJyW+SkwDs4JCR2UYWWgiflNxMZWrZjRmhyqzN/fVy0Es0dbeHwx6imdXZmBlennZaTR9okHog==
X-Received: by 2002:adf:f881:0:b0:203:f9b1:a6ab with SMTP id u1-20020adff881000000b00203f9b1a6abmr10755817wrp.410.1648899693983;
        Sat, 02 Apr 2022 04:41:33 -0700 (PDT)
Received: from [192.168.0.171] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id m63-20020a1c2642000000b0038e5fa06b50sm1932105wmm.31.2022.04.02.04.41.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Apr 2022 04:41:32 -0700 (PDT)
Message-ID: <c212c994-fc5d-6ad0-3cd6-88dc2c719e38@linaro.org>
Date:   Sat, 2 Apr 2022 13:41:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 1/2] dt-bindings: clock: convert
 rockchip,rk3188-cru.txt to YAML
Content-Language: en-US
To:     =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        Johan Jonker <jbx6244@gmail.com>, zhangqing@rock-chips.com,
        Stephen Boyd <sboyd@kernel.org>
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, mturquette@baylibre.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220329111323.3569-1-jbx6244@gmail.com>
 <20220331225134.7A0A9C340ED@smtp.kernel.org> <3107512.vfdyTQepKt@diego>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <3107512.vfdyTQepKt@diego>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/04/2022 09:55, Heiko Stübner wrote:
> Hi Stephen,
> 
> Am Freitag, 1. April 2022, 00:51:32 CEST schrieb Stephen Boyd:
>> Quoting Johan Jonker (2022-03-29 04:13:22)
>>> diff --git a/Documentation/devicetree/bindings/clock/rockchip,rk3188-cru.yaml b/Documentation/devicetree/bindings/clock/rockchip,rk3188-cru.yaml
>>> new file mode 100644
>>> index 000000000..ddd7e46af
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/clock/rockchip,rk3188-cru.yaml
>>> @@ -0,0 +1,78 @@
>>> +# SPDX-License-Identifier: GPL-2.0
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/clock/rockchip,rk3188-cru.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Rockchip RK3188/RK3066 Clock and Reset Unit (CRU)
>>> +
>>> +maintainers:
>>> +  - Elaine Zhang <zhangqing@rock-chips.com>
>>> +  - Heiko Stuebner <heiko@sntech.de>
>>> +
>>> +description: |
>>> +  The RK3188/RK3066 clock controller generates and supplies clocks to various
>>> +  controllers within the SoC and also implements a reset controller for SoC
>>> +  peripherals.
>>> +  Each clock is assigned an identifier and client nodes can use this identifier
>>> +  to specify the clock which they consume. All available clocks are defined as
>>> +  preprocessor macros in the dt-bindings/clock/rk3188-cru.h and
>>> +  dt-bindings/clock/rk3066-cru.h headers and can be used in device tree sources.
>>> +  Similar macros exist for the reset sources in these files.
>>> +  There are several clocks that are generated outside the SoC. It is expected
>>> +  that they are defined using standard clock bindings with following
>>> +  clock-output-names:
>>> +    - "xin24m"    - crystal input                 - required
>>> +    - "xin32k"    - RTC clock                     - optional
>>> +    - "xin27m"    - 27mhz crystal input on RK3066 - optional
>>> +    - "ext_hsadc" - external HSADC clock          - optional
>>> +    - "ext_cif0"  - external camera clock         - optional
>>> +    - "ext_rmii"  - external RMII clock           - optional
>>> +    - "ext_jtag"  - external JTAG clock           - optional
>>
>> I'd expect all these clks here to be inputs to this node.
> 
> The optional clocks are all part of a circular dependency.
> 
> So for example xin32k normally is generated by the pmic and fed
> back into the system, so to get xin32k, we need the pmic to probe,
> which needs i2c, which in turn already needs the clock controller.

Are you sure that xin32k (RTC) clock should be input to the clock
controller? I would expect it is the input to the SoC RTC block, so
there is no circular dependency.


Best regards,
Krzysztof
