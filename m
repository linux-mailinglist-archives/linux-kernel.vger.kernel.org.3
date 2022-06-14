Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 035FA54BBF5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 22:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353004AbiFNUlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 16:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235677AbiFNUll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 16:41:41 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7788C4ECEC
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 13:41:39 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 20so15751510lfz.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 13:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=aEy25dfcno5OHkNyMXDj3NHT7dE90MQx1wXlFfUsowc=;
        b=AgcnDEud9wRhzk3IHXnP9mDzwOXzYI8NxI8HNw/deRChpeEo4ZUkobrA183P1fiAoV
         352K5y15P4vgNsXrA9N4sE9mQUIfT+Oxl6FJnDh89W2N3bXlBVxvDTYto7eVcJQuo1hu
         zA2eZxzATLuyKKzfm9CQlI4nLT1h4yrkHcAUa+KKFXbGjGTorock9fIDYl5m41jMZ4Zc
         0TVkPnGC+r2W6BzzxXS3+SQuBi3K9TnT6LYJgLCR9JZ2EO9hSxWgKg0DyCrqR1P99Iqi
         GbzTkmZXMJvbqupAIR4CACGGTOTk3wvrOhrcntTQ32GT89DPBVSPO+Y/77/9OaGBHFOB
         0Wbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=aEy25dfcno5OHkNyMXDj3NHT7dE90MQx1wXlFfUsowc=;
        b=z9RMIg98AwIh99FP2B9bCTcjRD7eyINYmsBb8Y+S4fLZXOuFnN90R5DacmV+T76X6P
         5G++f9nmuoaSCAcsmThYat5of+Hj6RopviSqzUbz6uWYwm9uDSYfFFTnJ2qtRpdyr8c0
         6kYcl9WNBtpgP7a0vqF9aYxP8XRwodb2bsed1d6wLqSEC9FJ8oJUUMvJAPaIgvoq/Cu4
         JlsPPf+dFAW2EDG9UUt1b9GCJ0gNWimjK7nwrq13U/1dn6Z6/BK4PM6MUJ5RkciDDZwo
         fuPS4b1oVFIDVorQjvPHA2od3dj+lBf8l0lbjDSiQPffj+3dwQfvPYz6JQhtk66mbNKR
         9sKQ==
X-Gm-Message-State: AJIora/kXCjd4O3SzGqwJba49Xhs321o1YsHsVzWIUDaaQKODwuSWBKz
        fuMmvFBEOEb4r38/rCOkCVByyw==
X-Google-Smtp-Source: AGRyM1tv+yzNKffTqx7uAUQF7RYyhzqXKvjCumdHONCgKEXTUnZs7ZI9wK3keSDeEbmqy7VT1NUHsQ==
X-Received: by 2002:a19:7503:0:b0:479:50c:93d6 with SMTP id y3-20020a197503000000b00479050c93d6mr4078321lfe.356.1655239297787;
        Tue, 14 Jun 2022 13:41:37 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id a25-20020a056512201900b0047d479884b8sm1522266lfb.27.2022.06.14.13.41.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 13:41:37 -0700 (PDT)
Message-ID: <09123dd1-3cb2-d33c-f89e-d43a3d361af2@linaro.org>
Date:   Tue, 14 Jun 2022 23:41:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 2/2] arm64: dts: qcom: msm8953: add MDSS
Content-Language: en-GB
To:     Luca Weiss <luca@z3ntu.xyz>, linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220610225304.267508-1-luca@z3ntu.xyz>
 <20220610225304.267508-2-luca@z3ntu.xyz>
 <c7ac47e0-20a2-3972-e760-61276964445c@linaro.org> <4716730.GXAFRqVoOG@g550jk>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <4716730.GXAFRqVoOG@g550jk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/06/2022 12:36, Luca Weiss wrote:
> Hi Dmitry,
> 
> thanks for the feedback!
> 
> On Samstag, 11. Juni 2022 01:20:31 CEST Dmitry Baryshkov wrote:
>> On 11/06/2022 01:53, Luca Weiss wrote:
>>> From: Vladimir Lypak <vladimir.lypak@gmail.com>
>>>
>>> Add the MDSS, MDP and DSI nodes that are found on msm8953 SoC.
>>>
>>> IOMMU is not added because support for it isn't yet upstream and MDSS
>>> works fine without IOMMU on 8953.
>>>
>>> Signed-off-by: Vladimir Lypak <vladimir.lypak@gmail.com>
>>> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
>>
>> Looks good, few minor nits below.
>>
>>> ---
>>>
>>>    arch/arm64/boot/dts/qcom/msm8953.dtsi | 202 ++++++++++++++++++++++++++
>>>    1 file changed, 202 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/msm8953.dtsi
>>> b/arch/arm64/boot/dts/qcom/msm8953.dtsi index ffc3ec2cd3bc..a2aca3d05899
>>> 100644
>>> --- a/arch/arm64/boot/dts/qcom/msm8953.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/msm8953.dtsi
>>> @@ -726,6 +726,208 @@ tcsr_phy_clk_scheme_sel: syscon@193f044 {
>>>
>>>    			reg = <0x193f044 0x4>;
>>>    		
>>>    		};
>>>
>>> +		mdss: mdss@1a00000 {
>>> +			compatible = "qcom,mdss";
>>> +
>>> +			reg = <0x1a00000 0x1000>,
>>> +			      <0x1ab0000 0x1040>;
>>> +			reg-names = "mdss_phys",
>>> +				    "vbif_phys";
>>> +
>>> +			power-domains = <&gcc MDSS_GDSC>;
>>> +			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
>>> +
>>> +			interrupt-controller;
>>> +			#interrupt-cells = <1>;
>>> +
>>> +			clocks = <&gcc GCC_MDSS_AHB_CLK>,
>>> +				 <&gcc GCC_MDSS_AXI_CLK>,
>>> +				 <&gcc GCC_MDSS_VSYNC_CLK>;
>>
>> Please also add GCC_MDSS_MDP_CLK at the end of this array. It might be
>> required to read HW_REV register.
> 
> I don't think if I add that clock with the name "core" (or similar) that it
> would be used by the driver:

It is not (now), but I have plans to use it. Please consider adding it 
now, so that we won't have to change it later.

> 
> https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/msm/msm_mdss.c#L274-L302
> 
> Regards
> Luca
> 
>>
>>> +			clock-names = "iface",
>>> +				      "bus",
>>> +				      "vsync";
>>> +
>>> +			#address-cells = <1>;
>>> +			#size-cells = <1>;
>>> +			ranges;
>>
>> status = "disabled";
>>
>>> +
>>> +			mdp: mdp@1a01000 {
>>> +				compatible = "qcom,mdp5";
>>> +				reg = <0x1a01000 0x89000>;
>>> +				reg-names = "mdp_phys";
>>> +
>>> +				interrupt-parent = <&mdss>;
>>> +				interrupts = <0>;
>>> +
>>> +				power-domains = <&gcc MDSS_GDSC>;
>>> +
>>> +				clocks = <&gcc GCC_MDSS_AHB_CLK>,
>>> +					 <&gcc GCC_MDSS_AXI_CLK>,
>>> +					 <&gcc GCC_MDSS_MDP_CLK>,
>>> +					 <&gcc GCC_MDSS_VSYNC_CLK>;
>>> +				clock-names = "iface",
>>> +					      "bus",
>>> +					      "core",
>>> +					      "vsync";
>>> +
>>> +				// iommus = <&apps_iommu 0xc00 0>;
>>> +
>>> +				ports {
>>> +					#address-cells = <1>;
>>> +					#size-cells = <0>;
>>> +
>>> +					port@0 {
>>> +						reg = <0>;
>>> +						mdp5_intf1_out: endpoint {
>>> +							remote-endpoint = <&dsi0_in>;
>>> +						};
>>> +					};
>>> +
>>> +					port@1 {
>>> +						reg = <1>;
>>> +						mdp5_intf2_out: endpoint {
>>> +							remote-endpoint = <&dsi1_in>;
>>> +						};
>>> +					};
>>> +				};
>>> +			};
>>> +
>>> +			dsi0: dsi@1a94000 {
>>> +				compatible = "qcom,mdss-dsi-ctrl";
>>> +				reg = <0x1a94000 0x400>;
>>> +				reg-names = "dsi_ctrl";
>>> +
>>> +				interrupt-parent = <&mdss>;
>>> +				interrupts = <4>;
>>> +
>>> +				assigned-clocks = <&gcc BYTE0_CLK_SRC>,
>>> +						  <&gcc PCLK0_CLK_SRC>;
>>> +				assigned-clock-parents = <&dsi0_phy 0>,
>>> +							 <&dsi0_phy 1>;
>>> +
>>> +				clocks = <&gcc GCC_MDSS_MDP_CLK>,
>>> +					 <&gcc GCC_MDSS_AHB_CLK>,
>>> +					 <&gcc GCC_MDSS_AXI_CLK>,
>>> +					 <&gcc GCC_MDSS_BYTE0_CLK>,
>>> +					 <&gcc GCC_MDSS_PCLK0_CLK>,
>>> +					 <&gcc GCC_MDSS_ESC0_CLK>;
>>> +				clock-names = "mdp_core",
>>> +					      "iface",
>>> +					      "bus",
>>> +					      "byte",
>>> +					      "pixel",
>>> +					      "core";
>>> +
>>> +				phys = <&dsi0_phy>;
>>> +				phy-names = "dsi";
>>> +
>>> +				#address-cells = <1>;
>>> +				#size-cells = <0>;
>>
>> status = "disabled";
>>
>>> +
>>> +				ports {
>>> +					#address-cells = <1>;
>>> +					#size-cells = <0>;
>>> +
>>> +					port@0 {
>>> +						reg = <0>;
>>> +						dsi0_in: endpoint {
>>> +							remote-endpoint = <&mdp5_intf1_out>;
>>> +						};
>>> +					};
>>> +
>>> +					port@1 {
>>> +						reg = <1>;
>>> +						dsi0_out: endpoint {
>>> +						};
>>> +					};
>>> +				};
>>> +			};
>>> +
>>> +			dsi0_phy: dsi-phy@1a94400 {
>>> +				compatible = "qcom,dsi-phy-14nm-8953";
>>> +				reg = <0x1a94400 0x100>,
>>> +				      <0x1a94500 0x300>,
>>> +				      <0x1a94800 0x188>;
>>> +				reg-names = "dsi_phy",
>>> +					    "dsi_phy_lane",
>>> +					    "dsi_pll";
>>> +
>>> +				#clock-cells = <1>;
>>> +				#phy-cells = <0>;
>>
>> status = "disabled";
>>
>>> +
>>> +				clocks = <&gcc GCC_MDSS_AHB_CLK>, <&xo_board>;
>>> +				clock-names = "iface", "ref";
>>> +			};
>>> +
>>> +			dsi1: dsi@1a96000 {
>>> +				compatible = "qcom,mdss-dsi-ctrl";
>>> +				reg = <0x1a96000 0x400>;
>>> +				reg-names = "dsi_ctrl";
>>> +
>>> +				interrupt-parent = <&mdss>;
>>> +				interrupts = <5>;
>>> +
>>> +				assigned-clocks = <&gcc BYTE1_CLK_SRC>,
>>> +						  <&gcc PCLK1_CLK_SRC>;
>>> +				assigned-clock-parents = <&dsi1_phy 0>,
>>> +							 <&dsi1_phy 1>;
>>> +
>>> +				clocks = <&gcc GCC_MDSS_MDP_CLK>,
>>> +					 <&gcc GCC_MDSS_AHB_CLK>,
>>> +					 <&gcc GCC_MDSS_AXI_CLK>,
>>> +					 <&gcc GCC_MDSS_BYTE1_CLK>,
>>> +					 <&gcc GCC_MDSS_PCLK1_CLK>,
>>> +					 <&gcc GCC_MDSS_ESC1_CLK>;
>>> +				clock-names = "mdp_core",
>>> +					      "iface",
>>> +					      "bus",
>>> +					      "byte",
>>> +					      "pixel",
>>> +					      "core";
>>> +
>>> +				phys = <&dsi1_phy>;
>>> +				phy-names = "dsi";
>>> +
>>> +				status = "disabled";
>>> +
>>> +				ports {
>>> +					#address-cells = <1>;
>>> +					#size-cells = <0>;
>>> +
>>> +					port@0 {
>>> +						reg = <0>;
>>> +						dsi1_in: endpoint {
>>> +							remote-endpoint = <&mdp5_intf2_out>;
>>> +						};
>>> +					};
>>> +
>>> +					port@1 {
>>> +						reg = <1>;
>>> +						dsi1_out: endpoint {
>>> +						};
>>> +					};
>>> +				};
>>> +			};
>>> +
>>> +			dsi1_phy: dsi-phy@1a96400 {
>>> +				compatible = "qcom,dsi-phy-14nm-8953";
>>> +				reg = <0x1a96400 0x100>,
>>> +				      <0x1a96500 0x300>,
>>> +				      <0x1a96800 0x188>;
>>> +				reg-names = "dsi_phy",
>>> +					    "dsi_phy_lane",
>>> +					    "dsi_pll";
>>> +
>>> +				#clock-cells = <1>;
>>> +				#phy-cells = <0>;
>>> +
>>> +				clocks = <&gcc GCC_MDSS_AHB_CLK>, <&xo_board>;
>>> +				clock-names = "iface", "ref";
>>> +
>>> +				status = "disabled";
>>> +			};
>>> +		};
>>> +
>>>
>>>    		spmi_bus: spmi@200f000 {
>>>    		
>>>    			compatible = "qcom,spmi-pmic-arb";
>>>    			reg = <0x200f000 0x1000>,
> 
> 
> 
> 


-- 
With best wishes
Dmitry
