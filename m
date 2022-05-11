Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03906523C06
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 19:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345917AbiEKRzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 13:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233896AbiEKRzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 13:55:05 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D9121A952
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 10:55:02 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id be20so3407910edb.12
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 10:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=vRxXDx59BwVAdE/yeHzMrpA2E8oV/k7BSRSKcJYdNfA=;
        b=j0bCP9Ac9nsbSjZPAcD6tdqqrZV4sDP3RbsQMgYi2x5TCCiRzj83bEfxfyxjpposIi
         fXlRRRYWSmtJrhuCCbQTE8MTt2iT63WqGTsfMYSiRzrOcvRnRstfaMJuyuI7qhwZFzCQ
         IQSgpSI6eD/1J1MZTTlrLce8q7RLHtNE0FaYZ5n7rAF6EmLhc53FInghMRjL5oujH9Tk
         y9a67Ng8mpZ4/DrSbm3cdv16kis8MutYiRMCgNtajxWIGOxIzXSQWK2PqhH8IipabXgs
         k1sYGaINvDPdY68wqd79jP1OY9Tnu9eRJD/0Hv+P8Jfi32tbvvPlLXVUHavjm2Zv38f+
         5zGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vRxXDx59BwVAdE/yeHzMrpA2E8oV/k7BSRSKcJYdNfA=;
        b=24dMCGt6FTyFh/paFOttV0UnFlJXpkaDhf6YewvKQII20+y1qB3+o/zpMDWiH8MI1b
         4xcUP+VcsoA7nZKFMcEkrBpy3K3luJMI/GQLn4ranD3P2R/bhzgcIv7Dqv/KHGdIHGhk
         KGd+p9SzF8j3tLb+BKW868NPIwJ+uFEYqOkc/M57JeNzdP6kynFVWOZHQ2d685LaJ4+K
         Jjlqj0gntGvelV13Mv9IMy7DdJd+0M3Y/87h1TDn/vriZCS2GK9XBzoYyPOxfNShFAff
         35CmEWgwiKrYSsnONJhV9XQVsC2CVMvWd46mD7haen5pv/4q3hOw7uwYs89aRsBasMw8
         Ta4w==
X-Gm-Message-State: AOAM531IaHt6W5NKgYvNFEEou1VyRqBCYHHl9u0uXTdD50P8Bk9zRe2e
        yJr6eZi1dmo0dTHGKWHHjnoflg==
X-Google-Smtp-Source: ABdhPJxhoebCeo/8aCGNu+Eiiq15xXHJ5M3E/dBl0X+mb8fVJ9xZI1u4poNv7tbPbiIiBRgXjNfWmA==
X-Received: by 2002:a05:6402:50d1:b0:42a:2e52:c286 with SMTP id h17-20020a05640250d100b0042a2e52c286mr1328969edb.390.1652291701427;
        Wed, 11 May 2022 10:55:01 -0700 (PDT)
Received: from [192.168.0.155] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id q21-20020aa7d455000000b0042617ba63d3sm1448654edr.93.2022.05.11.10.55.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 10:55:01 -0700 (PDT)
Message-ID: <2d68e610-e8ae-9e08-257a-3c94c3697334@linaro.org>
Date:   Wed, 11 May 2022 19:55:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 9/9] arm64: dts: qcom: msm8953: Add remote processor nodes
Content-Language: en-US
To:     Sireesh Kodali <sireeshkodali1@gmail.com>,
        linux-remoteproc@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, phone-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <20220511161602.117772-1-sireeshkodali1@gmail.com>
 <20220511161602.117772-10-sireeshkodali1@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220511161602.117772-10-sireeshkodali1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/05/2022 18:16, Sireesh Kodali wrote:
> This commit adds the modem (q6v5_mss), WiFi (wcnss-pil) and audio DSP
> (q6v5_pas) remote processor nodes for the MSM8953 platform. It also adds
> the coresponding SMP2P, SMSM and pinctrl nodes that are needed by these
> remote processors.
> 
> Signed-off-by: Sireesh Kodali <sireeshkodali1@gmail.com>
> +			};
> +
> +			wcnss_sleep: wcnss-sleep-pins {
> +				wcss_wlan2 {

No underscores in node names, unless something needs it?

> +					pins = "gpio76";
> +					function = "wcss_wlan2";
> +				};
> +				wcss_wlan1 {
> +					pins = "gpio77";
> +					function = "wcss_wlan1";
> +				};
> +				wcss_wlan0 {
> +					pins = "gpio78";
> +					function = "wcss_wlan0";
> +				};
> +				wcss_wlan {
> +					pins = "gpio79", "gpio80";
> +					function = "wcss_wlan";
> +				};
> +
> +				pinconf {
> +					pins = "gpio76", "gpio77",
> +					     "gpio78", "gpio79",
> +					     "gpio80";
> +					drive-strength = <2>;
> +					bias-pull-down;
> +				};
> +			};
>  		};
>  
>  		gcc: clock-controller@1800000 {
> @@ -745,6 +892,59 @@ spmi_bus: spmi@200f000 {
>  			#size-cells = <0>;
>  		};
>  
> +		modem: remoteproc@4080000 {
> +			compatible = "qcom,msm8953-mss-pil";
> +			reg = <0x4080000 0x100>,
> +			    <0x4020000 0x040>;
> +
> +			reg-names = "qdsp6", "rmb";
> +
> +			interrupts-extended = <&intc 0 24 1>,
> +					      <&modem_smp2p_in 0 0>,
> +					      <&modem_smp2p_in 1 0>,
> +					      <&modem_smp2p_in 2 0>,
> +					      <&modem_smp2p_in 3 0>;
> +			interrupt-names = "wdog", "fatal", "ready",
> +					  "handover", "stop-ack";
> +
> +			clocks = <&gcc GCC_MSS_CFG_AHB_CLK>,
> +				 <&gcc GCC_MSS_Q6_BIMC_AXI_CLK>,
> +				 <&gcc GCC_BOOT_ROM_AHB_CLK>,
> +				 <&xo_board>;
> +			clock-names = "iface", "bus", "mem", "xo";
> +
> +			power-domains = <&rpmpd MSM8953_VDDCX>, <&rpmpd MSM8953_VDDMX>;
> +			power-domain-names = "cx", "mx";
> +
> +			qcom,smem-states = <&modem_smp2p_out 0>;
> +			qcom,smem-state-names = "stop";
> +
> +			resets = <&gcc GCC_MSS_BCR>;
> +			reset-names = "mss_restart";
> +
> +			qcom,halt-regs = <&tcsr 0x18000 0x19000 0x1a000>;
> +
> +			status = "okay";

No need for okay.

> +
> +			mba {
> +				memory-region = <&mba_mem>;
> +			};
> +
> +			mpss {
> +				memory-region = <&mpss_mem>;
> +			};
> +
> +			smd-edge {
> +				interrupts = <GIC_SPI 25 IRQ_TYPE_EDGE_RISING>;
> +
> +				qcom,smd-edge = <0>;
> +				qcom,ipc = <&apcs 8 12>;
> +				qcom,remote-pid = <1>;
> +
> +				label = "modem";
> +			};
> +		};
> +
>  		usb3: usb@70f8800 {
>  			compatible = "qcom,msm8953-dwc3", "qcom,dwc3";
>  			reg = <0x70f8800 0x400>;
> @@ -1057,6 +1257,74 @@ i2c_8: i2c@7af8000 {
>  			status = "disabled";
>  		};
>  
> +		pronto: remoteproc@a21b000 {
> +			compatible = "qcom,pronto-v3-pil", "qcom,pronto";
> +			reg = <0xa204000 0x2000>,
> +			      <0xa202000 0x1000>,
> +			      <0xa21b000 0x3000>;
> +			reg-names = "ccu", "dxe", "pmu";
> +
> +			memory-region = <&wcnss_fw_mem>;
> +
> +			interrupts-extended = <&intc 0 149 IRQ_TYPE_EDGE_RISING>,
> +					      <&wcnss_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
> +					      <&wcnss_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
> +					      <&wcnss_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
> +					      <&wcnss_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
> +			interrupt-names = "wdog", "fatal", "ready", "handover", "stop-ack";
> +
> +			power-domains = <&rpmpd MSM8953_VDDCX>, <&rpmpd MSM8953_VDDMX>;
> +			power-domain-names = "cx", "mx";
> +
> +			qcom,state = <&wcnss_smp2p_out 0>;
> +			qcom,state-names = "stop";
> +
> +			pinctrl-names = "default", "sleep";
> +			pinctrl-0 = <&wcnss_default>;
> +			pinctrl-1 = <&wcnss_sleep>;
> +
> +			status = "okay";

No need for status.

> +
> +			iris: iris {
> +				compatible = "qcom,wcn3660b";
> +
> +				clocks = <&rpmcc RPM_SMD_RF_CLK2>;
> +				clock-names = "xo";
> +			};
> +
> +			smd-edge {
> +				interrupts = <GIC_SPI 142 IRQ_TYPE_EDGE_RISING>;
> +
> +				qcom,ipc = <&apcs 8 17>;
> +				qcom,smd-edge = <6>;
> +				qcom,remote-pid = <4>;
> +
> +				label = "pronto";
> +
> +				wcnss {
> +					compatible = "qcom,wcnss";
> +					qcom,smd-channels = "WCNSS_CTRL";
> +
> +					qcom,mmio = <&pronto>;
> +
> +					bt {
> +						compatible = "qcom,wcnss-bt";
> +					};
> +
> +					wifi {
> +						compatible = "qcom,wcnss-wlan";
> +
> +						interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
> +							     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
> +						interrupt-names = "tx", "rx";
> +
> +						qcom,smem-states = <&apps_smsm 10>, <&apps_smsm 9>;
> +						qcom,smem-state-names = "tx-enable", "tx-rings-empty";
> +					};
> +				};
> +			};
> +		};
> +
>  		intc: interrupt-controller@b000000 {
>  			compatible = "qcom,msm-qgic2";
>  			interrupt-controller;
> @@ -1070,6 +1338,116 @@ apcs: mailbox@b011000 {
>  			#mbox-cells = <1>;
>  		};
>  
> +		lpass: remoteproc@c200000 {
> +			compatible = "qcom,msm8953-adsp-pil";
> +			reg = <0xc200000 0x100>;
> +
> +			interrupts-extended = <&intc 0 293 IRQ_TYPE_EDGE_RISING>,
> +					      <&smp2p_adsp_in 0 IRQ_TYPE_EDGE_RISING>,
> +					      <&smp2p_adsp_in 1 IRQ_TYPE_EDGE_RISING>,
> +					      <&smp2p_adsp_in 2 IRQ_TYPE_EDGE_RISING>,
> +					      <&smp2p_adsp_in 3 IRQ_TYPE_EDGE_RISING>;
> +			interrupt-names = "wdog", "fatal", "ready",
> +					  "handover", "stop-ack";
> +			clocks = <&xo_board>;
> +			clock-names = "xo";
> +
> +			power-domains = <&rpmpd MSM8953_VDDCX>;
> +			power-domain-names = "cx";
> +
> +			memory-region = <&adsp_fw_mem>;
> +
> +			qcom,smem-states = <&smp2p_adsp_out 0>;
> +			qcom,smem-state-names = "stop";
> +
> +			smd-edge {
> +				interrupts = <GIC_SPI 289 IRQ_TYPE_EDGE_RISING>;
> +
> +				label = "lpass";
> +				mboxes = <&apcs 8>;
> +				qcom,smd-edge = <1>;
> +				qcom,remote-pid = <2>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				apr {
> +					compatible = "qcom,apr-v2";
> +					qcom,smd-channels = "apr_audio_svc";
> +					qcom,apr-domain = <APR_DOMAIN_ADSP>;
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +
> +					q6core {
> +						reg = <APR_SVC_ADSP_CORE>;
> +						compatible = "qcom,q6core";
> +					};
> +
> +					q6afe: q6afe {
> +						compatible = "qcom,q6afe";
> +						reg = <APR_SVC_AFE>;
> +						q6afedai: dais {
> +							compatible = "qcom,q6afe-dais";
> +							#address-cells = <1>;
> +							#size-cells = <0>;
> +							#sound-dai-cells = <1>;
> +
> +							dai@16 {
> +								reg = <PRIMARY_MI2S_RX>;
> +								qcom,sd-lines = <0 1>;
> +							};
> +
> +							dai@21 {
> +								reg = <TERTIARY_MI2S_TX>;
> +								qcom,sd-lines = <0 1>;
> +							};
> +						};
> +						q6afecc: clock-controller {
> +							compatible = "qcom,q6afe-clocks";
> +							#clock-cells = <2>;
> +						};
> +					};
> +
> +					q6asm: q6asm {
> +						compatible = "qcom,q6asm";
> +						reg = <APR_SVC_ASM>;
> +						q6asmdai: dais {
> +							compatible = "qcom,q6asm-dais";
> +							#address-cells = <1>;
> +							#size-cells = <0>;
> +							#sound-dai-cells = <1>;
> +
> +							dai@0 {
> +								reg = <MSM_FRONTEND_DAI_MULTIMEDIA1>;
> +							};
> +
> +							dai@1 {
> +								reg = <MSM_FRONTEND_DAI_MULTIMEDIA2>;
> +							};
> +
> +							dai@2 {
> +								reg = <MSM_FRONTEND_DAI_MULTIMEDIA3>;
> +							};
> +
> +							dai@3 {
> +								reg = <MSM_FRONTEND_DAI_MULTIMEDIA4>;
> +								is-compress-dai;
> +							};
> +						};
> +					};
> +
> +					q6adm: q6adm {
> +						compatible = "qcom,q6adm";
> +						reg = <APR_SVC_ADM>;
> +						q6routing: routing {
> +							compatible = "qcom,q6adm-routing";
> +							#sound-dai-cells = <0>;
> +						};
> +					};
> +				};
> +			};
> +

Remove unneeded blank lines.

> +		};
> +
>  		timer@b120000 {
>  			compatible = "arm,armv7-timer-mem";
>  			reg = <0xb120000 0x1000>;


Best regards,
Krzysztof
