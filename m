Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 686AF4B6843
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 10:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236145AbiBOJz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 04:55:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236116AbiBOJz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 04:55:56 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D65A10CF31
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 01:55:46 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id o9so21060657ljq.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 01:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=46FfI5X1BSFeVo5mcmXLhOyINdGGM+w+Dd3G0ef81t4=;
        b=e6FZRxnD6PTlzKm6mn+luAsr6Y5MkCucNkdmiztanZom9yc2MLgh01sVaFjfNEAZE+
         vCFOZ77rna74dybPM7t6oFdNBkufZDayY2TP3eSmuf3J09xFPF2B1xsNQJ1QD/7y7LEg
         zUUDe8ZkqXBYXayxWuJpoCULHvivnk5DoLxjTPRrXUIK8hfUS8XzZRRuxUtv3ddLCIU3
         0Mh6uKDBvoj8pa93mzYBVEuMQg9SowGfNPWBV2siYnHyauS/6HKkfGy4quumjomPhsFI
         1hUibRGezXE+z+VmahEROLOUkYc2eTFR0mIFX25T3MCKILxB7vHklIkGmm3rZvfp0Ge4
         nYqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=46FfI5X1BSFeVo5mcmXLhOyINdGGM+w+Dd3G0ef81t4=;
        b=dyNSoLtZAW1fa+YRxViJPcdA0xA+ByGfFvKYyh2hj+Vs4P0VnSLGNTmbq8dNXi9hsb
         qxjm/GSJHds7HDKyGvtpoB+cwLJGpUIm4xis+Ughu9eJQsG6eMsiTg78SwOurlxNbMIX
         isRKj371QuXf2ZfHk2DyBoKkt81A+HrB5qO61ESFRA8NE4b3cg6oKtP5D4l730sB7kGU
         IA7FDZIHU8/ZGgYViUVRYqSle/o6BruiCKACyv6xwl9CJTHz/DLd4PktAlCUiy1iJO5z
         rHhTr6EKJ8gdUFvz7iIv19pgA5CkoyIN/2kOsaKmRAGytTFl3amXiYgcCAYWMrnQdivt
         wvTw==
X-Gm-Message-State: AOAM5301VLx7DKQbwgYxlhdDrn+MFz/0zQC0chLXbanMEkcDZyDXf+e1
        fjFJkHl5k80gEPBlN3+FWVcpOA==
X-Google-Smtp-Source: ABdhPJxihYcxc+bZWzxnuYG8vahFYHta1BJMmIUgjpdI8oNvOaWe6hval1HLogwrMQB4SnTv/DBs2w==
X-Received: by 2002:a05:651c:1792:: with SMTP id bn18mr1959525ljb.18.1644918944736;
        Tue, 15 Feb 2022 01:55:44 -0800 (PST)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id q30sm738704ljc.134.2022.02.15.01.55.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 01:55:44 -0800 (PST)
Message-ID: <9b0fbece-8618-6b48-0240-3bab45e54a77@linaro.org>
Date:   Tue, 15 Feb 2022 12:55:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v2] arm64: dts: qcom: sm8450: add interconnect nodes
Content-Language: en-GB
To:     Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Georgi Djakov <djakov@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220203002936.3009402-1-vkoul@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220203002936.3009402-1-vkoul@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 03/02/2022 03:29, Vinod Koul wrote:
> And the various interconnect nodes found in SM8450 SoC and use it for
> UFS controller.
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
> 
> Changes in v2:
> 	- Fix the mc_virt node
> 	- Add clk_virt node
> 	- Rebase to rc1
> 
>   arch/arm64/boot/dts/qcom/sm8450.dtsi | 85 ++++++++++++++++++++++++++++
>   1 file changed, 85 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> index 10c25ad2d0c7..ccc67918c46a 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> @@ -8,6 +8,7 @@
>   #include <dt-bindings/clock/qcom,rpmh.h>
>   #include <dt-bindings/gpio/gpio.h>
>   #include <dt-bindings/power/qcom-rpmpd.h>
> +#include <dt-bindings/interconnect/qcom,sm8450.h>
>   #include <dt-bindings/soc/qcom,rpmh-rsc.h>
>   
>   / {
> @@ -250,6 +251,18 @@ scm: scm {
>   		};
>   	};
>   
> +	clk_virt: interconnect@0 {
> +		compatible = "qcom,sm8450-clk-virt";
> +		#interconnect-cells = <2>;
> +		qcom,bcm-voters = <&apps_bcm_voter>;
> +	};
> +
> +	mc_virt: interconnect@1 {
> +		compatible = "qcom,sm8450-mc-virt";
> +		#interconnect-cells = <2>;
> +		qcom,bcm-voters = <&apps_bcm_voter>;
> +	};
> +
>   	memory@a0000000 {
>   		device_type = "memory";
>   		/* We expect the bootloader to fill in the size */
> @@ -620,6 +633,54 @@ i2c14: i2c@a98000 {
>   			};
>   		};
>   
> +		config_noc: interconnect@1500000 {
> +			compatible = "qcom,sm8450-config-noc";
> +			reg = <0 0x01500000 0 0x1c000>;
> +			#interconnect-cells = <2>;
> +			qcom,bcm-voters = <&apps_bcm_voter>;
> +		};
> +
> +		system_noc: interconnect@1680000 {
> +			compatible = "qcom,sm8450-system-noc";
> +			reg = <0 0x01680000 0 0x1e200>;
> +			#interconnect-cells = <2>;
> +			qcom,bcm-voters = <&apps_bcm_voter>;
> +		};
> +
> +		pcie_noc: interconnect@16c0000 {
> +			compatible = "qcom,sm8450-pcie-anoc";
> +			reg = <0 0x016c0000 0 0xe280>;
> +			#interconnect-cells = <2>;
> +			qcom,bcm-voters = <&apps_bcm_voter>;
> +		};
> +
> +		aggre1_noc: interconnect@16e0000 {
> +			compatible = "qcom,sm8450-aggre1-noc";
> +			reg = <0 0x016e0000 0 0x1c080>;
> +			#interconnect-cells = <2>;
> +			clocks = <&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>,
> +				 <&gcc GCC_AGGRE_USB3_PRIM_AXI_CLK>;
> +			qcom,bcm-voters = <&apps_bcm_voter>;
> +		};
> +
> +		aggre2_noc: interconnect@1700000 {
> +			compatible = "qcom,sm8450-aggre2-noc";
> +			reg = <0 0x01700000 0 0x31080>;
> +			#interconnect-cells = <2>;
> +			qcom,bcm-voters = <&apps_bcm_voter>;
> +			clocks = <&gcc GCC_AGGRE_NOC_PCIE_0_AXI_CLK>,
> +				 <&gcc GCC_AGGRE_NOC_PCIE_1_AXI_CLK>,
> +				 <&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>,
> +				 <&rpmhcc RPMH_IPA_CLK>;
> +		};
> +
> +		mmss_noc: interconnect@1740000 {
> +			compatible = "qcom,sm8450-mmss-noc";
> +			reg = <0 0x01740000 0 0x1f080>;
> +			#interconnect-cells = <2>;
> +			qcom,bcm-voters = <&apps_bcm_voter>;
> +		};
> +
>   		tcsr_mutex: hwlock@1f40000 {
>   			compatible = "qcom,tcsr-mutex";
>   			reg = <0x0 0x01f40000 0x0 0x40000>;
> @@ -988,6 +1049,13 @@ cpufreq_hw: cpufreq@17d91000 {
>   			#freq-domain-cells = <1>;
>   		};
>   
> +		gem_noc: interconnect@19100000 {
> +			compatible = "qcom,sm8450-gem-noc";
> +			reg = <0 0x19100000 0 0xbb800>;
> +			#interconnect-cells = <2>;
> +			qcom,bcm-voters = <&apps_bcm_voter>;
> +		};
> +
>   		ufs_mem_hc: ufshc@1d84000 {
>   			compatible = "qcom,sm8450-ufshc", "qcom,ufshc",
>   				     "jedec,ufs-2.0";
> @@ -1004,6 +1072,9 @@ ufs_mem_hc: ufshc@1d84000 {
>   
>   			iommus = <&apps_smmu 0xe0 0x0>;
>   
> +			interconnects = <&aggre1_noc MASTER_UFS_MEM &mc_virt SLAVE_EBI1>,

As you have #interconnect-cells = <2> for all the NoCs, this should be:

		interconnects = <&aggre1_noc MASTER_UFS_MEM 0 &mc_virt SLAVE_EBI1 0>,

> +					<&gem_noc MASTER_APPSS_PROC &config_noc SLAVE_UFS_MEM_CFG>;
> +			interconnect-names = "ufs-ddr", "cpu-ufs";
>   			clock-names =
>   				"core_clk",
>   				"bus_aggr_clk",
> @@ -1102,6 +1173,20 @@ usb_1_dwc3: usb@a600000 {
>   				phy-names = "usb2-phy", "usb3-phy";
>   			};
>   		};
> +
> +		nsp_noc: interconnect@320c0000 {
> +			compatible = "qcom,sm8450-nsp-noc";
> +			reg = <0 0x320c0000 0 0x10000>;
> +			#interconnect-cells = <2>;
> +			qcom,bcm-voters = <&apps_bcm_voter>;
> +		};
> +
> +		lpass_ag_noc: interconnect@3c40000 {
> +			compatible = "qcom,sm8450-lpass-ag-noc";
> +			reg = <0 0x3c40000 0 0x17200>;
> +			#interconnect-cells = <2>;
> +			qcom,bcm-voters = <&apps_bcm_voter>;
> +		};
>   	};
>   
>   	timer {


-- 
With best wishes
Dmitry
