Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 376455A9C73
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 18:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234757AbiIAQDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 12:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234742AbiIAQDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 12:03:45 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5703C90195
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 09:03:43 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id z20so18402153ljq.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 09:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=6Ie3NhdzsnzkHobegq8CeuHpaJaVXRWlLeKNtTsv8O0=;
        b=z4FtSVp2RHNxkbSZcAk8wUVKJFa6CO3ms2ApM3jOiaOWYwgOdi/+YooyMaC6LwueLG
         fJ4AEW/PXNW3LxUrKi39aO1q+52mdsIxgriNAPT60FxmAyfPI75JrVbRXGft+kUY81jC
         pWEGy5SQl+9lUn0n+4lCWkUMf1wvk7+drPqB+nJuLockJ/iHNSDfiV6lhgL/LV5uotpn
         N119J43Cr2eN5juxkfICF1PuZz/S5jCq/sjGHgwimxszkJl1Snc22nSBSveQV795YokU
         d859bI/wSimQ1XX2xyJLHptDVc54hyigmDgPtobzidIMSyohqKQxEzmdPTLuHIaWKJyl
         jkEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=6Ie3NhdzsnzkHobegq8CeuHpaJaVXRWlLeKNtTsv8O0=;
        b=39GO+FFzwsPicgES8+O/uojEXoGBWq6SU5IBEAaUvALc7xp3VKccNP9D2+vpVosCvX
         u3/iicHRAGChnPCpjoRUXbLylMkKqWkgJ7hEJUT0V7FQ62Ie/vfRYM46vf2YFJmJFiHt
         HQ92sCxcC4AvuOF1uD6SPHQB1EnA05LLu7mWQIlnQ3L4n21U5jSUoYgzjO+8zjstufAm
         COlnoa6ZiG5c8dC2l8/2bmnx649sPAPQm3Wuav+J06xpH+AsJU27eg8f2wnIVIcM1od5
         VPEq48zSgee1lz//D0fmo12khSKKIH6t/0PxeCOMUd8YXgzRIt7KmVrqdsv/X0qFJDnI
         JTFA==
X-Gm-Message-State: ACgBeo1USmk8w8ZIdgQLW2WN9t6tgjdr8NBe9Js0+gdCsXHNb2P7MnhL
        GjROnRKHIn8QaeVg5Lc6SOrRTg==
X-Google-Smtp-Source: AA6agR7t4fuNzNHKo8c7mOSlUC6TCJARyrf/+ArSuud6w7jHV6UEkfv9fGz+W6HJh/yLfKlF0Z/ihw==
X-Received: by 2002:a2e:9555:0:b0:260:3dc:12fb with SMTP id t21-20020a2e9555000000b0026003dc12fbmr10284096ljh.125.1662048221600;
        Thu, 01 Sep 2022 09:03:41 -0700 (PDT)
Received: from [192.168.28.124] (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id bi37-20020a05651c232500b00261e7e7b698sm179427ljb.123.2022.09.01.09.03.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 09:03:41 -0700 (PDT)
Message-ID: <6be03c44-ec58-c041-5882-57bd2491e4b9@linaro.org>
Date:   Thu, 1 Sep 2022 19:03:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 01/14] arm64: dts: qcom: sm6115: Add basic soc dtsi
Content-Language: en-US
To:     Iskren Chernev <iskren.chernev@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org
References: <20220901072414.1923075-1-iskren.chernev@gmail.com>
 <20220901072414.1923075-2-iskren.chernev@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220901072414.1923075-2-iskren.chernev@gmail.com>
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

On 01/09/2022 10:24, Iskren Chernev wrote:
> Add support for Qualcomm SM6115 SoC. This includes bare minimum:
> - CPUs
> - intc
> - timer
> - reserved memory
> 
> Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
> ---
>  arch/arm64/boot/dts/qcom/sm6115.dtsi | 433 +++++++++++++++++++++++++++
>  1 file changed, 433 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/sm6115.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> new file mode 100644
> index 000000000000..69d9de540478
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> @@ -0,0 +1,433 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2021, Iskren Chernev <iskren.chernev@gmail.com>
> + */
> +
> +#include <dt-bindings/clock/qcom,gcc-sm6115.h>
> +#include <dt-bindings/clock/qcom,rpmcc.h>
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/power/qcom-rpmpd.h>
> +
> +/ {
> +	interrupt-parent = <&intc>;
> +
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	chosen { };
> +
> +	clocks {
> +		xo_board: xo-board {
> +			compatible = "fixed-clock";
> +			clock-frequency = <19200000>;

The clocks are outside of the SoC, so usually to denote it the clock
frequencies are at least defined in the board DTS. Move it there.

> +			#clock-cells = <0>;
> +			clock-output-names = "xo_board";
> +		};
> +
> +		sleep_clk: sleep-clk {
> +			compatible = "fixed-clock";
> +			clock-frequency = <32764>;
> +			#clock-cells = <0>;
> +			clock-output-names = "sleep_clk";
> +		};
> +	};
> +
> +	cpus {
> +		#address-cells = <2>;
> +		#size-cells = <0>;
> +
> +		CPU0: cpu@0 {
> +			device_type = "cpu";
> +			compatible = "qcom,kryo260";
> +			reg = <0x0 0x0>;
> +			capacity-dmips-mhz = <1024>;
> +			dynamic-power-coefficient = <100>;
> +			enable-method = "psci";
> +			next-level-cache = <&L2_0>;
> +			L2_0: l2-cache {
> +				compatible = "cache";
> +				cache-level = <2>;
> +			};
> +		};
> +
> +		CPU1: cpu@1 {
> +			device_type = "cpu";
> +			compatible = "qcom,kryo260";
> +			reg = <0x0 0x1>;
> +			capacity-dmips-mhz = <1024>;
> +			dynamic-power-coefficient = <100>;
> +			enable-method = "psci";
> +			next-level-cache = <&L2_0>;
> +		};
> +
> +		CPU2: cpu@2 {
> +			device_type = "cpu";
> +			compatible = "qcom,kryo260";
> +			reg = <0x0 0x2>;
> +			capacity-dmips-mhz = <1024>;
> +			dynamic-power-coefficient = <100>;
> +			enable-method = "psci";
> +			next-level-cache = <&L2_0>;
> +		};
> +
> +		CPU3: cpu@3 {
> +			device_type = "cpu";
> +			compatible = "qcom,kryo260";
> +			reg = <0x0 0x3>;
> +			capacity-dmips-mhz = <1024>;
> +			dynamic-power-coefficient = <100>;
> +			enable-method = "psci";
> +			next-level-cache = <&L2_0>;
> +		};
> +
> +		CPU4: cpu@100 {
> +			device_type = "cpu";
> +			compatible = "qcom,kryo260";
> +			reg = <0x0 0x100>;
> +			enable-method = "psci";
> +			capacity-dmips-mhz = <1638>;
> +			dynamic-power-coefficient = <282>;
> +			next-level-cache = <&L2_1>;
> +			L2_1: l2-cache {
> +				compatible = "cache";
> +				cache-level = <2>;
> +			};
> +		};
> +
> +		CPU5: cpu@101 {
> +			device_type = "cpu";
> +			compatible = "qcom,kryo260";
> +			reg = <0x0 0x101>;
> +			capacity-dmips-mhz = <1638>;
> +			dynamic-power-coefficient = <282>;
> +			enable-method = "psci";
> +			next-level-cache = <&L2_1>;
> +		};
> +
> +		CPU6: cpu@102 {
> +			device_type = "cpu";
> +			compatible = "qcom,kryo260";
> +			reg = <0x0 0x102>;
> +			capacity-dmips-mhz = <1638>;
> +			dynamic-power-coefficient = <282>;
> +			enable-method = "psci";
> +			next-level-cache = <&L2_1>;
> +		};
> +
> +		CPU7: cpu@103 {
> +			device_type = "cpu";
> +			compatible = "qcom,kryo260";
> +			reg = <0x0 0x103>;
> +			capacity-dmips-mhz = <1638>;
> +			dynamic-power-coefficient = <282>;
> +			enable-method = "psci";
> +			next-level-cache = <&L2_1>;
> +		};
> +
> +		cpu-map {
> +			cluster0 {
> +				core0 {
> +					cpu = <&CPU0>;
> +				};
> +
> +				core1 {
> +					cpu = <&CPU1>;
> +				};
> +
> +				core2 {
> +					cpu = <&CPU2>;
> +				};
> +
> +				core3 {
> +					cpu = <&CPU3>;
> +				};
> +			};
> +
> +			cluster1 {
> +				core0 {
> +					cpu = <&CPU4>;
> +				};
> +
> +				core1 {
> +					cpu = <&CPU5>;
> +				};
> +
> +				core2 {
> +					cpu = <&CPU6>;
> +				};
> +
> +				core3 {
> +					cpu = <&CPU7>;
> +				};
> +			};
> +		};
> +	};
> +
> +	firmware {
> +		scm: scm {
> +			compatible = "qcom,scm-sm6115", "qcom,scm";
> +			#reset-cells = <1>;
> +		};
> +	};
> +
> +	tcsr_mutex: hwlock {
> +		compatible = "qcom,tcsr-mutex";
> +		syscon = <&tcsr_mutex_regs 0 0x1000>;
> +		#hwlock-cells = <1>;
> +	};

This should be rather MMIO based TCSR mutex.
See:
https://lore.kernel.org/all/20220819083209.50844-1-krzysztof.kozlowski@linaro.org/

> +
> +	memory {
> +		device_type = "memory";
> +		/* We expect the bootloader to fill in the reg */
> +		reg = <0 0 0 0>;
> +	};
> +
> +	pmu {
> +		compatible = "arm,armv8-pmuv3";
> +		interrupts = <GIC_PPI 6 IRQ_TYPE_LEVEL_HIGH>;
> +	};
> +
> +	psci {
> +		compatible = "arm,psci-1.0";
> +		method = "smc";
> +	};
> +
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		hyp_mem: memory@45700000 {
> +			reg = <0x0 0x45700000 0x0 0x600000>;
> +			no-map;
> +		};
> +
> +		xbl_aop_mem: memory@45e00000 {
> +			reg = <0x0 0x45e00000 0x0 0x140000>;
> +			no-map;
> +		};
> +
> +		sec_apps_mem: memory@45fff000 {
> +			reg = <0x0 0x45fff000 0x0 0x1000>;
> +			no-map;
> +		};
> +
> +		smem_mem: memory@46000000 {
> +			reg = <0x0 0x46000000 0x0 0x200000>;
> +			no-map;
> +		};
> +
> +		cdsp_sec_mem: memory@46200000 {
> +			reg = <0x0 0x46200000 0x0 0x1e00000>;
> +			no-map;
> +		};
> +
> +		pil_modem_mem: memory@4ab00000 {
> +			reg = <0x0 0x4ab00000 0x0 0x6900000>;
> +			no-map;
> +		};
> +
> +		pil_video_mem: memory@51400000 {
> +			reg = <0x0 0x51400000 0x0 0x500000>;
> +			no-map;
> +		};
> +
> +		wlan_msa_mem: memory@51900000 {
> +			reg = <0x0 0x51900000 0x0 0x100000>;
> +			no-map;
> +		};
> +
> +		pil_cdsp_mem: memory@51a00000 {
> +			reg = <0x0 0x51a00000 0x0 0x1e00000>;
> +			no-map;
> +		};
> +
> +		pil_adsp_mem: memory@53800000 {
> +			reg = <0x0 0x53800000 0x0 0x2800000>;
> +			no-map;
> +		};
> +
> +		pil_ipa_fw_mem: memory@56100000 {
> +			reg = <0x0 0x56100000 0x0 0x10000>;
> +			no-map;
> +		};
> +
> +		pil_ipa_gsi_mem: memory@56110000 {
> +			reg = <0x0 0x56110000 0x0 0x5000>;
> +			no-map;
> +		};
> +
> +		pil_gpu_mem: memory@56115000 {
> +			reg = <0x0 0x56115000 0x0 0x2000>;
> +			no-map;
> +		};
> +
> +		cont_splash_memory: memory@5c000000 {
> +			reg = <0x0 0x5c000000 0x0 0x00f00000>;
> +			no-map;
> +		};
> +
> +		dfps_data_memory: memory@5cf00000 {
> +			reg = <0x0 0x5cf00000 0x0 0x0100000>;
> +			no-map;
> +		};
> +
> +		removed_mem: memory@60000000 {
> +			reg = <0x0 0x60000000 0x0 0x3900000>;
> +			no-map;
> +		};
> +
> +		secure_display_memory: memory@f3c00000 {
> +			reg = <0x0 0xf3c00000 0x0 0x5c00000>;
> +			no-map;
> +		};
> +
> +		dump_mem: memory@f9800000 {
> +			reg = <0x0 0xf9800000 0x0 0x800000>;
> +			no-map;
> +		};
> +
> +		adsp_mem: memory@fa000000 {
> +			reg = <0x0 0xfa000000 0x0 0x800000>;
> +			no-map;
> +		};
> +
> +		qseecom_mem: memory@fa800000 {
> +			reg = <0x0 0xfa800000 0x0 0x1400000>;
> +			no-map;
> +		};
> +
> +		user_contig_mem: memory@fbc00000 {
> +			reg = <0x0 0xfbc00000 0x0 0x1000000>;
> +			no-map;
> +		};
> +
> +		qseecom_ta_mem: memory@fcc00000 {
> +			reg = <0x0 0xfcc00000 0x0 0x1000000>;
> +			no-map;
> +		};
> +
> +		linux_cma_mem: memory@fdc00000 {
> +			reg = <0x0 0xfdc00000 0x0 0x2000000>;
> +			no-map;
> +		};
> +
> +	};
> +
> +	smem {
> +		compatible = "qcom,smem";
> +		memory-region = <&smem_mem>;
> +		qcom,rpm-msg-ram = <&rpm_msg_ram>;
> +		hwlocks = <&tcsr_mutex 3>;
> +	};
> +
> +	soc: soc {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0 0 0 0xffffffff>;
> +
> +		qfprom@1b40000 {
> +			compatible = "qcom,qfprom";

Does not look like you tested the DTS against bindings. Please run `make
dtbs_check` (see Documentation/devicetree/bindings/writing-schema.rst
for instructions).

> +			reg = <0x1b40000 0x7000>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			qusb2_hstx_trim: hstx_trim@25b {

No underscores in node names.

> +				reg = <0x25b 0x1>;
> +				bits = <1 4>;
> +			};
> +		};
> +
> +		tcsr_mutex_regs: syscon@1f40000 {
> +			compatible = "syscon";

syscon is not allowed on its own. Use MMIO method (see my other patchset
I linked above)

> +			reg = <0x340000 0x20000>;
> +		};
> +
> +		rpm_msg_ram: memory@45f0000 {

Does not look like you tested the DTS against bindings. Please run `make
dtbs_check` (see Documentation/devicetree/bindings/writing-schema.rst
for instructions).

> +			compatible = "qcom,rpm-msg-ram";
> +			reg = <0x45f0000 0x7000>;
> +		};
> +


Best regards,
Krzysztof
