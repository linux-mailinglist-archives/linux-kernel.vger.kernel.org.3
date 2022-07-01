Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7077563AC0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 22:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbiGAUC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 16:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiGAUC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 16:02:56 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3953945505
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 13:02:55 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-fb6b4da1dfso4917771fac.4
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 13:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=E+gJxnK4x+F6oWbEEmYqUpuvsfkMG3Ju/mtAYz6bWFE=;
        b=cffPQRQV8oAKlYgxAvGRsBRiC4InV9EqW+EaZ/kwBtg4l3dNJVfgzE3m/k+ug8i+fd
         g+qfqUxu0/aUaxuB1AtnrlJGhrVsoU3Wg5TJ5jyx5PnNYhxn6n3IASED6+kLPt4k8BfM
         1SSarGouM7ODb1qWmZ4EBi8XbBWGvPaeXRzpbArGGZ4E1QKwmZf6kyowoeAx6+pQ5sZn
         hembYLNGb+Dcv1EnF97/DsvJix64pdkr9RX4ost61wsjuIEUrAMzOAxdn/LJKcBIA44h
         vpHttsBSMXSmNBi1G3i2W9GhKyA1dp8TMzkrXnDLbLWokUfDfvX7gUsLOEQLfkq76IMd
         BRdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=E+gJxnK4x+F6oWbEEmYqUpuvsfkMG3Ju/mtAYz6bWFE=;
        b=3fTChZOBGtvWeJFjAusxisn3W3oxOtEZcHS2TWMRiwDbVd2IMQar0DJuL2g3M+icOp
         alQoBJemwSRGnsAd/HuXnAFLmnD+q64MJM4HEAxxBN2t3lfQrdVNO10MSA1EY5JYOErG
         vW6PWZrlr8FmVQ0BWHENaOpefMntln2NueWRe99lQEtYclh4fLBfBUv4GIBzs2F+Wy9Q
         gd3g2EiZWQfEHh3MbUhy3RMmkMMroDumMcGzaAD/BXKuVY2nAQFAvAziz7L1K3nfEWuN
         GGI6wKwlsRXTAYPiMFOSoNOd9poVF2RH7GHeHfCHzEN3w0VKKjZl9qfVb5E0S11lyFYf
         3l8A==
X-Gm-Message-State: AJIora/eTyBxrL8L2jPKjV4DPs0DyoROjrTPvJVkroHJtD4rMAajy+WT
        wxr8zy07JHjEnzRYeNYVLxsYng==
X-Google-Smtp-Source: AGRyM1uNx0tsFp5anX4LCqf0eW3NEHSf+c1TniUAWc7xtIHWYrtjxX762UE1Swc/NcKh6QwPQNPlnA==
X-Received: by 2002:a05:6870:c144:b0:eb:5ef1:7d8c with SMTP id g4-20020a056870c14400b000eb5ef17d8cmr11093878oad.232.1656705773586;
        Fri, 01 Jul 2022 13:02:53 -0700 (PDT)
Received: from [192.168.11.16] (cpe-173-173-107-246.satx.res.rr.com. [173.173.107.246])
        by smtp.gmail.com with ESMTPSA id e25-20020a056870239900b001048f70e03dsm14864738oap.15.2022.07.01.13.02.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Jul 2022 13:02:53 -0700 (PDT)
Message-ID: <1a591158-b712-b736-455c-5a4ee6c502ec@kali.org>
Date:   Fri, 1 Jul 2022 15:02:51 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH v2] arm64: dts: qcom: sdm845: Switch PSCI cpu idle states
 from PC to OSI
Content-Language: en-US
To:     Abel Vesa <abel.vesa@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220630101403.1888541-1-abel.vesa@linaro.org>
From:   Steev Klimaszewski <steev@kali.org>
In-Reply-To: <20220630101403.1888541-1-abel.vesa@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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


On 6/30/22 5:14 AM, Abel Vesa wrote:
> Switch from the flat PC idle states of sdm845 to OSI hierarchical idle
> states. The exceptions are the cheza plaftorms, which need to remain with
> PC idle states. So in order allow all the other platforms to switch,
> while cheza platforms to remain the same, replace the PC idle states with
> the OSI ones in the main SDM845 dtsi, and then override the inherited OSI
> states with PC ones, delete inherited psci cpus nodes, domain idle states
> and power domain properties.
>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>
> Changes since v1:
>   * fixed the commit message as suggested by Krzysztof
>   * dropped blank line sdm845 dtsi
>   * renamed sdm845 dtsi psci subnodes to power domain cpus and cluster
>   * fixed indentation for idle states in cheza dtsi
>
>   arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi | 132 ++++++++++++++++++++
>   arch/arm64/boot/dts/qcom/sdm845.dtsi       | 135 ++++++++++++---------
>   2 files changed, 213 insertions(+), 54 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
> index e7e4cc5936aa..13d3d7328210 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
> @@ -145,6 +145,138 @@ panel_in_edp: endpoint {
>   	};
>   };
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
> +	LITTLE_CPU_SLEEP_0: cpu-sleep-0-0 {
> +		compatible = "arm,idle-state";
> +		idle-state-name = "little-power-down";
> +		arm,psci-suspend-param = <0x40000003>;
> +		entry-latency-us = <350>;
> +		exit-latency-us = <461>;
> +		min-residency-us = <1890>;
> +		local-timer-stop;
> +	};
> +
> +	LITTLE_CPU_SLEEP_1: cpu-sleep-0-1 {
> +		compatible = "arm,idle-state";
> +		idle-state-name = "little-rail-power-down";
> +		arm,psci-suspend-param = <0x40000004>;
> +		entry-latency-us = <360>;
> +		exit-latency-us = <531>;
> +		min-residency-us = <3934>;
> +		local-timer-stop;
> +	};
> +
> +	BIG_CPU_SLEEP_0: cpu-sleep-1-0 {
> +		compatible = "arm,idle-state";
> +		idle-state-name = "big-power-down";
> +		arm,psci-suspend-param = <0x40000003>;
> +		entry-latency-us = <264>;
> +		exit-latency-us = <621>;
> +		min-residency-us = <952>;
> +		local-timer-stop;
> +	};
> +
> +	BIG_CPU_SLEEP_1: cpu-sleep-1-1 {
> +		compatible = "arm,idle-state";
> +		idle-state-name = "big-rail-power-down";
> +		arm,psci-suspend-param = <0x40000004>;
> +		entry-latency-us = <702>;
> +		exit-latency-us = <1061>;
> +		min-residency-us = <4488>;
> +		local-timer-stop;
> +	};
> +
> +	CLUSTER_SLEEP_0: cluster-sleep-0 {
> +		compatible = "arm,idle-state";
> +		idle-state-name = "cluster-power-down";
> +		arm,psci-suspend-param = <0x400000F4>;
> +		entry-latency-us = <3263>;
> +		exit-latency-us = <6562>;
> +		min-residency-us = <9987>;
> +		local-timer-stop;
> +	};
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
>   /*
>    * Reserved memory changes
>    *
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 83439739de37..491b3d66ffc0 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -188,7 +188,7 @@ spss_mem: spss@97b00000 {
>   		};
>   	};
>
> -	cpus {
> +	cpus: cpus {
>   		#address-cells = <2>;
>   		#size-cells = <0>;
>
> @@ -197,15 +197,14 @@ CPU0: cpu@0 {
>   			compatible = "qcom,kryo385";
>   			reg = <0x0 0x0>;
>   			enable-method = "psci";
> -			cpu-idle-states = <&LITTLE_CPU_SLEEP_0
> -					   &LITTLE_CPU_SLEEP_1
> -					   &CLUSTER_SLEEP_0>;
>   			capacity-dmips-mhz = <611>;
>   			dynamic-power-coefficient = <290>;
>   			qcom,freq-domain = <&cpufreq_hw 0>;
>   			operating-points-v2 = <&cpu0_opp_table>;
>   			interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_EBI1 3>,
>   					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
> +			power-domains = <&CPU_PD0>;
> +			power-domain-names = "psci";
>   			#cooling-cells = <2>;
>   			next-level-cache = <&L2_0>;
>   			L2_0: l2-cache {
> @@ -222,15 +221,14 @@ CPU1: cpu@100 {
>   			compatible = "qcom,kryo385";
>   			reg = <0x0 0x100>;
>   			enable-method = "psci";
> -			cpu-idle-states = <&LITTLE_CPU_SLEEP_0
> -					   &LITTLE_CPU_SLEEP_1
> -					   &CLUSTER_SLEEP_0>;
>   			capacity-dmips-mhz = <611>;
>   			dynamic-power-coefficient = <290>;
>   			qcom,freq-domain = <&cpufreq_hw 0>;
>   			operating-points-v2 = <&cpu0_opp_table>;
>   			interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_EBI1 3>,
>   					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
> +			power-domains = <&CPU_PD1>;
> +			power-domain-names = "psci";
>   			#cooling-cells = <2>;
>   			next-level-cache = <&L2_100>;
>   			L2_100: l2-cache {
> @@ -244,15 +242,14 @@ CPU2: cpu@200 {
>   			compatible = "qcom,kryo385";
>   			reg = <0x0 0x200>;
>   			enable-method = "psci";
> -			cpu-idle-states = <&LITTLE_CPU_SLEEP_0
> -					   &LITTLE_CPU_SLEEP_1
> -					   &CLUSTER_SLEEP_0>;
>   			capacity-dmips-mhz = <611>;
>   			dynamic-power-coefficient = <290>;
>   			qcom,freq-domain = <&cpufreq_hw 0>;
>   			operating-points-v2 = <&cpu0_opp_table>;
>   			interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_EBI1 3>,
>   					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
> +			power-domains = <&CPU_PD2>;
> +			power-domain-names = "psci";
>   			#cooling-cells = <2>;
>   			next-level-cache = <&L2_200>;
>   			L2_200: l2-cache {
> @@ -266,9 +263,6 @@ CPU3: cpu@300 {
>   			compatible = "qcom,kryo385";
>   			reg = <0x0 0x300>;
>   			enable-method = "psci";
> -			cpu-idle-states = <&LITTLE_CPU_SLEEP_0
> -					   &LITTLE_CPU_SLEEP_1
> -					   &CLUSTER_SLEEP_0>;
>   			capacity-dmips-mhz = <611>;
>   			dynamic-power-coefficient = <290>;
>   			qcom,freq-domain = <&cpufreq_hw 0>;
> @@ -276,6 +270,8 @@ &LITTLE_CPU_SLEEP_1
>   			interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_EBI1 3>,
>   					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
>   			#cooling-cells = <2>;
> +			power-domains = <&CPU_PD3>;
> +			power-domain-names = "psci";
>   			next-level-cache = <&L2_300>;
>   			L2_300: l2-cache {
>   				compatible = "cache";
> @@ -289,14 +285,13 @@ CPU4: cpu@400 {
>   			reg = <0x0 0x400>;
>   			enable-method = "psci";
>   			capacity-dmips-mhz = <1024>;
> -			cpu-idle-states = <&BIG_CPU_SLEEP_0
> -					   &BIG_CPU_SLEEP_1
> -					   &CLUSTER_SLEEP_0>;
>   			dynamic-power-coefficient = <442>;
>   			qcom,freq-domain = <&cpufreq_hw 1>;
>   			operating-points-v2 = <&cpu4_opp_table>;
>   			interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_EBI1 3>,
>   					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
> +			power-domains = <&CPU_PD4>;
> +			power-domain-names = "psci";
>   			#cooling-cells = <2>;
>   			next-level-cache = <&L2_400>;
>   			L2_400: l2-cache {
> @@ -311,14 +306,13 @@ CPU5: cpu@500 {
>   			reg = <0x0 0x500>;
>   			enable-method = "psci";
>   			capacity-dmips-mhz = <1024>;
> -			cpu-idle-states = <&BIG_CPU_SLEEP_0
> -					   &BIG_CPU_SLEEP_1
> -					   &CLUSTER_SLEEP_0>;
>   			dynamic-power-coefficient = <442>;
>   			qcom,freq-domain = <&cpufreq_hw 1>;
>   			operating-points-v2 = <&cpu4_opp_table>;
>   			interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_EBI1 3>,
>   					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
> +			power-domains = <&CPU_PD5>;
> +			power-domain-names = "psci";
>   			#cooling-cells = <2>;
>   			next-level-cache = <&L2_500>;
>   			L2_500: l2-cache {
> @@ -333,14 +327,13 @@ CPU6: cpu@600 {
>   			reg = <0x0 0x600>;
>   			enable-method = "psci";
>   			capacity-dmips-mhz = <1024>;
> -			cpu-idle-states = <&BIG_CPU_SLEEP_0
> -					   &BIG_CPU_SLEEP_1
> -					   &CLUSTER_SLEEP_0>;
>   			dynamic-power-coefficient = <442>;
>   			qcom,freq-domain = <&cpufreq_hw 1>;
>   			operating-points-v2 = <&cpu4_opp_table>;
>   			interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_EBI1 3>,
>   					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
> +			power-domains = <&CPU_PD6>;
> +			power-domain-names = "psci";
>   			#cooling-cells = <2>;
>   			next-level-cache = <&L2_600>;
>   			L2_600: l2-cache {
> @@ -355,14 +348,13 @@ CPU7: cpu@700 {
>   			reg = <0x0 0x700>;
>   			enable-method = "psci";
>   			capacity-dmips-mhz = <1024>;
> -			cpu-idle-states = <&BIG_CPU_SLEEP_0
> -					   &BIG_CPU_SLEEP_1
> -					   &CLUSTER_SLEEP_0>;
>   			dynamic-power-coefficient = <442>;
>   			qcom,freq-domain = <&cpufreq_hw 1>;
>   			operating-points-v2 = <&cpu4_opp_table>;
>   			interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_EBI1 3>,
>   					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
> +			power-domains = <&CPU_PD7>;
> +			power-domain-names = "psci";
>   			#cooling-cells = <2>;
>   			next-level-cache = <&L2_700>;
>   			L2_700: l2-cache {
> @@ -407,53 +399,35 @@ core7 {
>   			};
>   		};
>
> -		idle-states {
> +		cpu_idle_states: idle-states {
>   			entry-method = "psci";
>
>   			LITTLE_CPU_SLEEP_0: cpu-sleep-0-0 {
>   				compatible = "arm,idle-state";
> -				idle-state-name = "little-power-down";
> -				arm,psci-suspend-param = <0x40000003>;
> +				idle-state-name = "little-rail-power-collapse";
> +				arm,psci-suspend-param = <0x40000004>;
>   				entry-latency-us = <350>;
>   				exit-latency-us = <461>;
>   				min-residency-us = <1890>;
>   				local-timer-stop;
>   			};
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
>   			BIG_CPU_SLEEP_0: cpu-sleep-1-0 {
>   				compatible = "arm,idle-state";
> -				idle-state-name = "big-power-down";
> -				arm,psci-suspend-param = <0x40000003>;
> +				idle-state-name = "big-rail-power-collapse";
> +				arm,psci-suspend-param = <0x40000004>;
>   				entry-latency-us = <264>;
>   				exit-latency-us = <621>;
>   				min-residency-us = <952>;
>   				local-timer-stop;
>   			};
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
>   			CLUSTER_SLEEP_0: cluster-sleep-0 {
> -				compatible = "arm,idle-state";
> -				idle-state-name = "cluster-power-down";
> -				arm,psci-suspend-param = <0x400000F4>;
> +				compatible = "domain-idle-state";
> +				idle-state-name = "cluster-power-collapse";
> +				arm,psci-suspend-param = <0x4100c244>;
>   				entry-latency-us = <3263>;
>   				exit-latency-us = <6562>;
>   				min-residency-us = <9987>;
> @@ -1050,9 +1024,62 @@ slpi_smp2p_in: slave-kernel {
>   		};
>   	};
>
> -	psci {
> +	psci: psci {
>   		compatible = "arm,psci-1.0";
>   		method = "smc";
> +
> +		CPU_PD0: power-domain-cpu0 {
> +			#power-domain-cells = <0>;
> +			power-domains = <&CLUSTER_PD>;
> +			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
> +		};
> +
> +		CPU_PD1: power-domain-cpu1 {
> +			#power-domain-cells = <0>;
> +			power-domains = <&CLUSTER_PD>;
> +			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
> +		};
> +
> +		CPU_PD2: power-domain-cpu2 {
> +			#power-domain-cells = <0>;
> +			power-domains = <&CLUSTER_PD>;
> +			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
> +		};
> +
> +		CPU_PD3: power-domain-cpu3 {
> +			#power-domain-cells = <0>;
> +			power-domains = <&CLUSTER_PD>;
> +			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
> +		};
> +
> +		CPU_PD4: power-domain-cpu4 {
> +			#power-domain-cells = <0>;
> +			power-domains = <&CLUSTER_PD>;
> +			domain-idle-states = <&BIG_CPU_SLEEP_0>;
> +		};
> +
> +		CPU_PD5: power-domain-cpu5 {
> +			#power-domain-cells = <0>;
> +			power-domains = <&CLUSTER_PD>;
> +			domain-idle-states = <&BIG_CPU_SLEEP_0>;
> +		};
> +
> +		CPU_PD6: power-domain-cpu6 {
> +			#power-domain-cells = <0>;
> +			power-domains = <&CLUSTER_PD>;
> +			domain-idle-states = <&BIG_CPU_SLEEP_0>;
> +		};
> +
> +		CPU_PD7: power-domain-cpu7 {
> +			#power-domain-cells = <0>;
> +			power-domains = <&CLUSTER_PD>;
> +			domain-idle-states = <&BIG_CPU_SLEEP_0>;
> +		};
> +
> +		CLUSTER_PD: power-domain-cluster {
> +			#power-domain-cells = <0>;
> +			domain-idle-states = <&CLUSTER_SLEEP_0>;
> +		};
>   	};
>
>   	soc: soc@0 {
> --
> 2.34.3
>
Tested on the Lenovo Yoga C630

Tested-by: Steev Klimaszewski <steev@kali.org>

