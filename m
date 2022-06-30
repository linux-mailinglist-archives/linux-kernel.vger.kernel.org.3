Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 683A4561584
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 10:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233831AbiF3I4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 04:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiF3I4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 04:56:45 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F19942A0F
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 01:56:43 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id lw20so37684891ejb.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 01:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=H3BHyIVN58h0JYNCnD+iJzSYDLLh6207clQog8XMs/E=;
        b=QXwghw3IFy+WkNkXSHBNF20Cqm3wUab5R1elqtJuqfZPdMLEi5MgvbTLAV4cJB49h5
         Qtm0U1WWgLUEFdgkNQy/c29iR3MWNL2XcaMx+C31m9m1QFnK7QUS38YOJfRtzCiD7lEf
         eM+x3WyRWCIsFra0RXdNQf+VPJqbUwVloiFNI6zScELdDddeJrYbH+p6sYvCuZrN2jv9
         bp4eyvDs94Pt2tT7bs/eJl1YNVKcXy/9wSxIFHNDxjeN2Ciwfu6SrrAwXb9olPWXhI54
         jPU9sOF8AMHk+TmqSjUPCYgpNlNH0RfgT/IpEogesjj7oTo37pyHb6hBGlV4o8I141SJ
         +bUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=H3BHyIVN58h0JYNCnD+iJzSYDLLh6207clQog8XMs/E=;
        b=CsVEqlCeIUR9/zLNxtlRZvoyJdRlDlM48XZgg7RVTkFIYM4jH2N9r7r25EzVIeW84N
         uhujO/qXURXLxP8IjwYeMszoahB4kteuKhja6VkI9NSeH3vVdvORKrSdijNY3Gk6j4DF
         JKe/iD5ZWDd5puWEHdM1eSWHYRNg4H7FdHixYW/bjKavRxUxTAbXU2fA362m7pFCC87C
         h3hRk+soAPzRq71yM2NElp6/PwIlu2qbS0Zw/kc549TofxfWXWOHJpf2PZ6YU1qgXmWm
         8B53fe0kDniiiZupzRKpnI4UqWv/wYkxHXokfuLZo8qFLhi+88mpEjaJBUGIf5m8AKRX
         C64A==
X-Gm-Message-State: AJIora86HlHwksR+O4Fjl35SeJiSEv+wykJTEHwCVAdkIOBt4HF9nK/Y
        IjeAyeXyoOuxPsuiHz3drcPYcQ==
X-Google-Smtp-Source: AGRyM1sPnEW7S7jRgRblCGVdswvKzsSRfaMIJfORer7aT0QBwDdHw/pEXEJAtQSdTlMxHgrHdNZagQ==
X-Received: by 2002:a17:907:75d3:b0:72a:42a2:9d74 with SMTP id jl19-20020a17090775d300b0072a42a29d74mr5514399ejc.567.1656579401534;
        Thu, 30 Jun 2022 01:56:41 -0700 (PDT)
Received: from [192.168.0.188] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id s1-20020aa7c541000000b004357171dcccsm12782897edr.12.2022.06.30.01.56.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 01:56:40 -0700 (PDT)
Message-ID: <ac791289-4d35-a56e-c967-7c55e8a7d934@linaro.org>
Date:   Thu, 30 Jun 2022 10:56:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] arm64: dts: qcom: sdm845: Switch PSCI cpu idle states
 from PC to OSI
Content-Language: en-US
To:     Abel Vesa <abel.vesa@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220630084250.1763869-1-abel.vesa@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220630084250.1763869-1-abel.vesa@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/06/2022 10:42, Abel Vesa wrote:
> This switches from the flat PC idle states of sdm845 to OSI hierarchical

s/This switches/Switch/

> idle states. The exceptions are the cheza plaftorms, which need to remain
> with PC idle states. So in order allow all the other platforms to switch,
> while cheza platforms to remain the same, replace the PC idle states with
> the OSI ones in the main SDM845 dtsi, and then override the inherited OSI
> states with PC ones, delete inherited psci cpus nodes, domain idle states
> and power domain properties.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
> 
> In order to maintain bisectability, I kept everything in one patch.
> 
>  arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi | 132 ++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/sdm845.dtsi       | 136 +++++++++++++--------
>  2 files changed, 214 insertions(+), 54 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
> index e7e4cc5936aa..8640748fc53c 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
> @@ -145,6 +145,138 @@ panel_in_edp: endpoint {
>  	};
>  };
> 
> +&psci {
> +	/delete-node/ cpu0;
> +	/delete-node/ cpu1;
> +	/delete-node/ cpu2;
> +	/delete-node/ cpu3;
> +	/delete-node/ cpu4;
> +	/delete-node/ cpu5;
> +	/delete-node/ cpu6;
> +	/delete-node/ cpu7;
> +	/delete-node/ cpu-cluster0;
> +};
> +
> +&cpus {
> +	/delete-node/ domain-idle-states;
> +};
> +
> +&cpu_idle_states {
> +		LITTLE_CPU_SLEEP_0: cpu-sleep-0-0 {

Wrong indentation.

> +			compatible = "arm,idle-state";
> +			idle-state-name = "little-power-down";
> +			arm,psci-suspend-param = <0x40000003>;
> +			entry-latency-us = <350>;
> +			exit-latency-us = <461>;
> +			min-residency-us = <1890>;
> +			local-timer-stop;
> +		};
> +
> +		LITTLE_CPU_SLEEP_1: cpu-sleep-0-1 {
> +			compatible = "arm,idle-state";
> +			idle-state-name = "little-rail-power-down";
> +			arm,psci-suspend-param = <0x40000004>;
> +			entry-latency-us = <360>;
> +			exit-latency-us = <531>;
> +			min-residency-us = <3934>;
> +			local-timer-stop;
> +		};
> +
> +		BIG_CPU_SLEEP_0: cpu-sleep-1-0 {
> +			compatible = "arm,idle-state";
> +			idle-state-name = "big-power-down";
> +			arm,psci-suspend-param = <0x40000003>;
> +			entry-latency-us = <264>;
> +			exit-latency-us = <621>;
> +			min-residency-us = <952>;
> +			local-timer-stop;
> +		};
> +
> +		BIG_CPU_SLEEP_1: cpu-sleep-1-1 {
> +			compatible = "arm,idle-state";
> +			idle-state-name = "big-rail-power-down";
> +			arm,psci-suspend-param = <0x40000004>;
> +			entry-latency-us = <702>;
> +			exit-latency-us = <1061>;
> +			min-residency-us = <4488>;
> +			local-timer-stop;
> +		};
> +
> +		CLUSTER_SLEEP_0: cluster-sleep-0 {
> +			compatible = "arm,idle-state";
> +			idle-state-name = "cluster-power-down";
> +			arm,psci-suspend-param = <0x400000F4>;
> +			entry-latency-us = <3263>;
> +			exit-latency-us = <6562>;
> +			min-residency-us = <9987>;
> +			local-timer-stop;
> +		};
> +};
> +
> +&CPU0 {
> +	/delete-property/ power-domains;
> +	/delete-property/ power-domain-names;
> +	cpu-idle-states = <&LITTLE_CPU_SLEEP_0
> +			   &LITTLE_CPU_SLEEP_1
> +			   &CLUSTER_SLEEP_0>;
> +};
> +
> +&CPU1 {
> +	/delete-property/ power-domains;
> +	/delete-property/ power-domain-names;
> +	cpu-idle-states = <&LITTLE_CPU_SLEEP_0
> +			   &LITTLE_CPU_SLEEP_1
> +			   &CLUSTER_SLEEP_0>;
> +};
> +
> +&CPU2 {
> +	/delete-property/ power-domains;
> +	/delete-property/ power-domain-names;
> +	cpu-idle-states = <&LITTLE_CPU_SLEEP_0
> +			   &LITTLE_CPU_SLEEP_1
> +			   &CLUSTER_SLEEP_0>;
> +};
> +
> +&CPU3 {
> +	/delete-property/ power-domains;
> +	/delete-property/ power-domain-names;
> +	cpu-idle-states = <&LITTLE_CPU_SLEEP_0
> +			   &LITTLE_CPU_SLEEP_1
> +			   &CLUSTER_SLEEP_0>;
> +};
> +
> +&CPU4 {
> +	/delete-property/ power-domains;
> +	/delete-property/ power-domain-names;
> +	cpu-idle-states = <&BIG_CPU_SLEEP_0
> +			   &BIG_CPU_SLEEP_1
> +			   &CLUSTER_SLEEP_0>;
> +};
> +
> +&CPU5 {
> +	/delete-property/ power-domains;
> +	/delete-property/ power-domain-names;
> +	cpu-idle-states = <&BIG_CPU_SLEEP_0
> +			   &BIG_CPU_SLEEP_1
> +			   &CLUSTER_SLEEP_0>;
> +};
> +
> +&CPU6 {
> +	/delete-property/ power-domains;
> +	/delete-property/ power-domain-names;
> +	cpu-idle-states = <&BIG_CPU_SLEEP_0
> +			   &BIG_CPU_SLEEP_1
> +			   &CLUSTER_SLEEP_0>;
> +};
> +
> +&CPU7 {
> +	/delete-property/ power-domains;
> +	/delete-property/ power-domain-names;
> +	cpu-idle-states = <&BIG_CPU_SLEEP_0
> +			   &BIG_CPU_SLEEP_1
> +			   &CLUSTER_SLEEP_0>;
> +};
> +
>  /*
>   * Reserved memory changes
>   *
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 83439739de37..6bb027d2ab58 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -188,7 +188,7 @@ spss_mem: spss@97b00000 {
>  		};
>  	};
> 
> -	cpus {
> +	cpus: cpus {
>  		#address-cells = <2>;
>  		#size-cells = <0>;
> 
> @@ -197,15 +197,14 @@ CPU0: cpu@0 {
>  			compatible = "qcom,kryo385";
>  			reg = <0x0 0x0>;
>  			enable-method = "psci";
> -			cpu-idle-states = <&LITTLE_CPU_SLEEP_0
> -					   &LITTLE_CPU_SLEEP_1
> -					   &CLUSTER_SLEEP_0>;
>  			capacity-dmips-mhz = <611>;
>  			dynamic-power-coefficient = <290>;
>  			qcom,freq-domain = <&cpufreq_hw 0>;
>  			operating-points-v2 = <&cpu0_opp_table>;
>  			interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_EBI1 3>,
>  					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
> +			power-domains = <&CPU_PD0>;
> +			power-domain-names = "psci";
>  			#cooling-cells = <2>;
>  			next-level-cache = <&L2_0>;
>  			L2_0: l2-cache {
> @@ -222,15 +221,14 @@ CPU1: cpu@100 {
>  			compatible = "qcom,kryo385";
>  			reg = <0x0 0x100>;
>  			enable-method = "psci";
> -			cpu-idle-states = <&LITTLE_CPU_SLEEP_0
> -					   &LITTLE_CPU_SLEEP_1
> -					   &CLUSTER_SLEEP_0>;
>  			capacity-dmips-mhz = <611>;
>  			dynamic-power-coefficient = <290>;
>  			qcom,freq-domain = <&cpufreq_hw 0>;
>  			operating-points-v2 = <&cpu0_opp_table>;
>  			interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_EBI1 3>,
>  					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
> +			power-domains = <&CPU_PD1>;
> +			power-domain-names = "psci";
>  			#cooling-cells = <2>;
>  			next-level-cache = <&L2_100>;
>  			L2_100: l2-cache {
> @@ -244,15 +242,14 @@ CPU2: cpu@200 {
>  			compatible = "qcom,kryo385";
>  			reg = <0x0 0x200>;
>  			enable-method = "psci";
> -			cpu-idle-states = <&LITTLE_CPU_SLEEP_0
> -					   &LITTLE_CPU_SLEEP_1
> -					   &CLUSTER_SLEEP_0>;
>  			capacity-dmips-mhz = <611>;
>  			dynamic-power-coefficient = <290>;
>  			qcom,freq-domain = <&cpufreq_hw 0>;
>  			operating-points-v2 = <&cpu0_opp_table>;
>  			interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_EBI1 3>,
>  					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
> +			power-domains = <&CPU_PD2>;
> +			power-domain-names = "psci";
>  			#cooling-cells = <2>;
>  			next-level-cache = <&L2_200>;
>  			L2_200: l2-cache {
> @@ -266,9 +263,6 @@ CPU3: cpu@300 {
>  			compatible = "qcom,kryo385";
>  			reg = <0x0 0x300>;
>  			enable-method = "psci";
> -			cpu-idle-states = <&LITTLE_CPU_SLEEP_0
> -					   &LITTLE_CPU_SLEEP_1
> -					   &CLUSTER_SLEEP_0>;
>  			capacity-dmips-mhz = <611>;
>  			dynamic-power-coefficient = <290>;
>  			qcom,freq-domain = <&cpufreq_hw 0>;
> @@ -276,6 +270,8 @@ &LITTLE_CPU_SLEEP_1
>  			interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_EBI1 3>,
>  					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
>  			#cooling-cells = <2>;
> +			power-domains = <&CPU_PD3>;
> +			power-domain-names = "psci";
>  			next-level-cache = <&L2_300>;
>  			L2_300: l2-cache {
>  				compatible = "cache";
> @@ -289,14 +285,13 @@ CPU4: cpu@400 {
>  			reg = <0x0 0x400>;
>  			enable-method = "psci";
>  			capacity-dmips-mhz = <1024>;
> -			cpu-idle-states = <&BIG_CPU_SLEEP_0
> -					   &BIG_CPU_SLEEP_1
> -					   &CLUSTER_SLEEP_0>;
>  			dynamic-power-coefficient = <442>;
>  			qcom,freq-domain = <&cpufreq_hw 1>;
>  			operating-points-v2 = <&cpu4_opp_table>;
>  			interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_EBI1 3>,
>  					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
> +			power-domains = <&CPU_PD4>;
> +			power-domain-names = "psci";
>  			#cooling-cells = <2>;
>  			next-level-cache = <&L2_400>;
>  			L2_400: l2-cache {
> @@ -311,14 +306,13 @@ CPU5: cpu@500 {
>  			reg = <0x0 0x500>;
>  			enable-method = "psci";
>  			capacity-dmips-mhz = <1024>;
> -			cpu-idle-states = <&BIG_CPU_SLEEP_0
> -					   &BIG_CPU_SLEEP_1
> -					   &CLUSTER_SLEEP_0>;
>  			dynamic-power-coefficient = <442>;
>  			qcom,freq-domain = <&cpufreq_hw 1>;
>  			operating-points-v2 = <&cpu4_opp_table>;
>  			interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_EBI1 3>,
>  					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
> +			power-domains = <&CPU_PD5>;
> +			power-domain-names = "psci";
>  			#cooling-cells = <2>;
>  			next-level-cache = <&L2_500>;
>  			L2_500: l2-cache {
> @@ -333,14 +327,13 @@ CPU6: cpu@600 {
>  			reg = <0x0 0x600>;
>  			enable-method = "psci";
>  			capacity-dmips-mhz = <1024>;
> -			cpu-idle-states = <&BIG_CPU_SLEEP_0
> -					   &BIG_CPU_SLEEP_1
> -					   &CLUSTER_SLEEP_0>;
>  			dynamic-power-coefficient = <442>;
>  			qcom,freq-domain = <&cpufreq_hw 1>;
>  			operating-points-v2 = <&cpu4_opp_table>;
>  			interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_EBI1 3>,
>  					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
> +			power-domains = <&CPU_PD6>;
> +			power-domain-names = "psci";
>  			#cooling-cells = <2>;
>  			next-level-cache = <&L2_600>;
>  			L2_600: l2-cache {
> @@ -355,14 +348,13 @@ CPU7: cpu@700 {
>  			reg = <0x0 0x700>;
>  			enable-method = "psci";
>  			capacity-dmips-mhz = <1024>;
> -			cpu-idle-states = <&BIG_CPU_SLEEP_0
> -					   &BIG_CPU_SLEEP_1
> -					   &CLUSTER_SLEEP_0>;
>  			dynamic-power-coefficient = <442>;
>  			qcom,freq-domain = <&cpufreq_hw 1>;
>  			operating-points-v2 = <&cpu4_opp_table>;
>  			interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_EBI1 3>,
>  					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
> +			power-domains = <&CPU_PD7>;
> +			power-domain-names = "psci";
>  			#cooling-cells = <2>;
>  			next-level-cache = <&L2_700>;
>  			L2_700: l2-cache {
> @@ -407,53 +399,35 @@ core7 {
>  			};
>  		};
> 
> -		idle-states {
> +		cpu_idle_states: idle-states {
>  			entry-method = "psci";
> 
>  			LITTLE_CPU_SLEEP_0: cpu-sleep-0-0 {
>  				compatible = "arm,idle-state";
> -				idle-state-name = "little-power-down";
> -				arm,psci-suspend-param = <0x40000003>;
> +				idle-state-name = "little-rail-power-collapse";
> +				arm,psci-suspend-param = <0x40000004>;
>  				entry-latency-us = <350>;
>  				exit-latency-us = <461>;
>  				min-residency-us = <1890>;
>  				local-timer-stop;
>  			};
> 
> -			LITTLE_CPU_SLEEP_1: cpu-sleep-0-1 {
> -				compatible = "arm,idle-state";
> -				idle-state-name = "little-rail-power-down";
> -				arm,psci-suspend-param = <0x40000004>;
> -				entry-latency-us = <360>;
> -				exit-latency-us = <531>;
> -				min-residency-us = <3934>;
> -				local-timer-stop;
> -			};
> -
>  			BIG_CPU_SLEEP_0: cpu-sleep-1-0 {
>  				compatible = "arm,idle-state";
> -				idle-state-name = "big-power-down";
> -				arm,psci-suspend-param = <0x40000003>;
> +				idle-state-name = "big-rail-power-collapse";
> +				arm,psci-suspend-param = <0x40000004>;
>  				entry-latency-us = <264>;
>  				exit-latency-us = <621>;
>  				min-residency-us = <952>;
>  				local-timer-stop;
>  			};
> +		};
> 
> -			BIG_CPU_SLEEP_1: cpu-sleep-1-1 {
> -				compatible = "arm,idle-state";
> -				idle-state-name = "big-rail-power-down";
> -				arm,psci-suspend-param = <0x40000004>;
> -				entry-latency-us = <702>;
> -				exit-latency-us = <1061>;
> -				min-residency-us = <4488>;
> -				local-timer-stop;
> -			};
> -
> +		domain-idle-states {
>  			CLUSTER_SLEEP_0: cluster-sleep-0 {
> -				compatible = "arm,idle-state";
> -				idle-state-name = "cluster-power-down";
> -				arm,psci-suspend-param = <0x400000F4>;
> +				compatible = "domain-idle-state";
> +				idle-state-name = "cluster-power-collapse";
> +				arm,psci-suspend-param = <0x4100c244>;
>  				entry-latency-us = <3263>;
>  				exit-latency-us = <6562>;
>  				min-residency-us = <9987>;
> @@ -1050,9 +1024,63 @@ slpi_smp2p_in: slave-kernel {
>  		};
>  	};
> 
> -	psci {
> +	psci: psci {
>  		compatible = "arm,psci-1.0";
>  		method = "smc";
> +
> +		CPU_PD0: cpu0 {

Node name: power-domain-cpu0
You can test it with dtbs_check for power-domain.yaml

> +			#power-domain-cells = <0>;
> +			power-domains = <&CLUSTER_PD>;
> +			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
> +		};
> +
> +		CPU_PD1: cpu1 {

Ditto and so on.

> +			#power-domain-cells = <0>;
> +			power-domains = <&CLUSTER_PD>;
> +			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
> +		};
> +
> +		CPU_PD2: cpu2 {
> +			#power-domain-cells = <0>;
> +			power-domains = <&CLUSTER_PD>;
> +			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
> +		};
> +
> +		CPU_PD3: cpu3 {
> +			#power-domain-cells = <0>;
> +			power-domains = <&CLUSTER_PD>;
> +			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
> +		};
> +
> +		CPU_PD4: cpu4 {
> +			#power-domain-cells = <0>;
> +			power-domains = <&CLUSTER_PD>;
> +			domain-idle-states = <&BIG_CPU_SLEEP_0>;
> +		};
> +
> +		CPU_PD5: cpu5 {
> +			#power-domain-cells = <0>;
> +			power-domains = <&CLUSTER_PD>;
> +			domain-idle-states = <&BIG_CPU_SLEEP_0>;
> +		};
> +
> +		CPU_PD6: cpu6 {
> +			#power-domain-cells = <0>;
> +			power-domains = <&CLUSTER_PD>;
> +			domain-idle-states = <&BIG_CPU_SLEEP_0>;
> +		};
> +
> +		CPU_PD7: cpu7 {
> +			#power-domain-cells = <0>;
> +			power-domains = <&CLUSTER_PD>;
> +			domain-idle-states = <&BIG_CPU_SLEEP_0>;
> +		};
> +
> +		CLUSTER_PD: cpu-cluster0 {

I guess here (you have only one cluster):
power-domain-cluster

> +			#power-domain-cells = <0>;
> +			domain-idle-states = <&CLUSTER_SLEEP_0>;
> +		};
> +

No need for blank line.

>  	};
> 
>  	soc: soc@0 {
> --
> 2.34.3
> 


Best regards,
Krzysztof
