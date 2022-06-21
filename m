Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 848FF552B51
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 08:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346157AbiFUGxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 02:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231830AbiFUGxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 02:53:45 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C08E1CB13
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 23:53:42 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id ej4so14061985edb.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 23:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=3PW0776m2+iZN8elL/9qGaxipccLpylA480ITxwG/L4=;
        b=ULzdkGrh0MIfOoiA9d6jLM68gGKdKBNp79NFMWc4gMgN/F/29A68q2RPpwLElqqbe/
         8ee2UcrQ4QWaBklVPLz+MHVH7uPu96nUcMUwhR6AzYdfJ9czauZjfn4xxoJDhh9LYpEL
         C3wMGfR/R9CW1J7SEE+olZyr1gKUGX6YfXrTigL/evOU7N7e9vpgS6IqZV/JDKa9SXGz
         ShZQaXYjK9Mss5xZng98UE8ydTu29fAixEL1OiC74QPNI3qDHxVN6QyHgdyxI9NK1XTr
         fqbc0RfHEhu6YHKKicVX6AbmhwCa4eFucRhLeQNzQ+v+q8eg+BOrLLI7hK8g1/Kpj9KY
         Z9/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3PW0776m2+iZN8elL/9qGaxipccLpylA480ITxwG/L4=;
        b=vZh6aLxTWm+OXVAdlANrV3YL8QELuHMcT5ESgSoBClEJ4w2MT20AzvqKRoFpl4pYpV
         3bc9ssMcV+u2pQ+uwo43P1nZjDab3WZH87e3PXuNJxJTxhfT2+/A7UvHsp03RsGm9lVM
         qodC9ngkqdS3VTJIPYr8qBu/G5Y9e8m5S1nUuqLRRwMCEBW4KT+tEXKzGBPVH6vClx1x
         2fTn+rGbnsbfv+ee2UyD/6cK6poW9raBKcmnvvm1EWs1WLkW1SAVSRm4Z7yvndmuOol1
         7a464MC+Lmtut+xpAuulvg0T2MpK/vD+LqYmKz9MteTeTXHe4afTgqv7AbvH7GVrpWsm
         AQcQ==
X-Gm-Message-State: AJIora87byyHsONHdahEwCtTr8Odm+NvuftwifToMIOweSFcXlOyB6o+
        sD6Aa8TFxuAI/kYBEq3Wm4geQw==
X-Google-Smtp-Source: AGRyM1sZXaE9AFnOkjz/4sLa7klJNhnwtB96WgbJ/hJxMW9oDlqACa5YwA4TfyDeKXRcdwn0wFbEjQ==
X-Received: by 2002:a05:6402:4248:b0:435:9150:ccfb with SMTP id g8-20020a056402424800b004359150ccfbmr4217901edb.374.1655794420829;
        Mon, 20 Jun 2022 23:53:40 -0700 (PDT)
Received: from [192.168.0.215] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id 18-20020a170906311200b00704fa2748ffsm4356927ejx.99.2022.06.20.23.53.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jun 2022 23:53:40 -0700 (PDT)
Message-ID: <9a31a488-f4fe-33f5-84e7-fe4509769d7c@linaro.org>
Date:   Tue, 21 Jun 2022 08:53:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 2/4] arm64: dts: qcom: add SC8280XP platform
Content-Language: en-US
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220607214113.4057684-1-bjorn.andersson@linaro.org>
 <20220607214113.4057684-3-bjorn.andersson@linaro.org>
 <79443fb4-5c09-a33f-594d-71ac93cc0317@linaro.org>
 <YrE84tLOpJtzrNW4@builder.lan>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <YrE84tLOpJtzrNW4@builder.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/06/2022 05:37, Bjorn Andersson wrote:
> On Wed 08 Jun 03:18 CDT 2022, Krzysztof Kozlowski wrote:
> 
>> On 07/06/2022 23:41, Bjorn Andersson wrote:
>>> Introduce initial support for the Qualcomm SC8280XP platform, aka 8cx
>>> Gen 3. This initial contribution supports SMP, CPUfreq, CPU cluster
>>> idling, GCC, TLMM, SMMU, RPMh regulators, power-domains and clocks,
>>> interconnects, some QUPs, UFS, remoteprocs, USB, watchdog, LLCC and
>>> tsens.
>>>
>>> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>>> ---
>>>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 2195 ++++++++++++++++++++++++
>>>  1 file changed, 2195 insertions(+)
>>>  create mode 100644 arch/arm64/boot/dts/qcom/sc8280xp.dtsi
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
>>> new file mode 100644
>>> index 000000000000..4143813643ad
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
>>> @@ -0,0 +1,2195 @@
>>> +// SPDX-License-Identifier: BSD-3-Clause
>>> +/*
>>> + * Copyright (c) 2021, The Linux Foundation. All rights reserved.
>>> + * Copyright (c) 2022, Linaro Limited
>>> + */
>>> +
>>> +#include <dt-bindings/clock/qcom,gcc-sc8280xp.h>
>>> +#include <dt-bindings/clock/qcom,rpmh.h>
>>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>>> +#include <dt-bindings/interconnect/qcom,sc8280xp.h>
>>> +#include <dt-bindings/mailbox/qcom-ipcc.h>
>>> +#include <dt-bindings/power/qcom-rpmpd.h>
>>> +#include <dt-bindings/soc/qcom,rpmh-rsc.h>
>>> +#include <dt-bindings/thermal/thermal.h>
>>> +
>>> +/ {
>>> +	interrupt-parent = <&intc>;
>>> +
>>> +	#address-cells = <2>;
>>> +	#size-cells = <2>;
>>> +
>>> +	clocks {
>>> +		xo_board: xo-board {
>>
>> xo-board-clk
>>
>>> +			compatible = "fixed-clock";
>>> +			#clock-cells = <0>;
>>> +			clock-frequency = <38400000>;
>>
>> The clock is probably on the board, so the frequency should be rather
>> defined in DTS.
>>
> 
> It's an interesting question, but I don't think it's possible to change
> the rate of this clock from one board to another.
> 
> So I think it's best to keep this in the .dtsi, to avoid unnecessary
> duplication.

It does not matter whether the frequency can be changed or not. This is
the same on almost every SoC and the same comments appear every time -
the clock is a property of the board, not of the SoC, so it should be in
the board DTSI. To avoid the duplication you can indeed keep here most
of the clock properties, but the frequency must be in board DTS.

Best regards,
Krzysztof
