Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 423DD574BA7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 13:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238028AbiGNLQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 07:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234714AbiGNLQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 07:16:21 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33F7501A8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 04:16:19 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id bf9so2199691lfb.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 04:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=kmBnD1ihRB06Ia8Vq2SlP4UAQsZhPpINxuW42/4ow7U=;
        b=x0nLCtfPaPvFHum5VzmZahCa5w0Qi+SNJerCTn/aea5hWIP1YY37aqDvEMWIzWKi1z
         phsapgVLFcXj6DCtlp81ZAyvI05yfu8gfxgkbnOxTlMBLNPNI11m17T9pMu2FRArpLK0
         7xAf/Ho6q2/xsRPDrV5wEn483ZbCCcJTKk5hjB9kOGCEPTVyYSDI5WeCIWNMrZRKgcIS
         p+Db8Srz5jgadkaG8iAXD8Lwag6SZwQNRoiEN623mFi7eB+CrNvhqU8+AJxj4mNyNlfA
         xR4hXqrKzKRjoN2QFT1zWGTNhgYuTfHPW4zb8hNr3ZEcu0m52nL4drf1/0vtKpj/HWgO
         m+XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kmBnD1ihRB06Ia8Vq2SlP4UAQsZhPpINxuW42/4ow7U=;
        b=qasMsAllG+w6PaCXizoQ70RSNrbEZhGMDmVBGhWRbbXnLxAtQLZ3j1F2a1SkfJ3XnG
         hc5f1iQG9h0PEm+iRr8EWCihGsNY0MdwPgVGL0iyDs23Y7YFq8pPtv3W+b+XwYPvZOmc
         l5fTm96Vhj2a7DDOlDfIB0eGqyK94FIMSFUTmckSkN3j9/WRgxTJ9x3LkZWeKGfN9+hg
         /m+TaFiBMakFA39VPuH+HeZE+AHa3x/apDPMTKVuzdKSe1ZcZKXOZuU4OIoP+n5YoZ6e
         AVt6NNh/un8leZBoD8eDVdT/lG8mboH2VhIGIAVh8PmgddSLZwZT4J13qN+SsiOjIUNF
         UdQw==
X-Gm-Message-State: AJIora9YUpSsBUtZqbV7m4K47w2sDxH9VeTU4HvuttXxb38SWTw2bVJj
        UizcLeUv94HSYGxkZC6Vc87muA==
X-Google-Smtp-Source: AGRyM1sXzPam7UwLq82AtZ2FuDJphQUoMDogkXhS/oGoOELmQuPjVLsSHCcY2nGxjfLOiwOQAFQVJg==
X-Received: by 2002:a19:915c:0:b0:486:93d4:9fee with SMTP id y28-20020a19915c000000b0048693d49feemr4753256lfj.301.1657797377973;
        Thu, 14 Jul 2022 04:16:17 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id c3-20020a056512238300b004833caeb8bdsm305313lfv.101.2022.07.14.04.16.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 04:16:17 -0700 (PDT)
Message-ID: <763aaaab-ce5e-5fad-51ed-95147c46afd8@linaro.org>
Date:   Thu, 14 Jul 2022 13:16:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 4/4] arm64: dts: qcom: Add device tree for Sony Xperia 1
 IV
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220713201047.1449786-1-konrad.dybcio@somainline.org>
 <20220713201047.1449786-4-konrad.dybcio@somainline.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220713201047.1449786-4-konrad.dybcio@somainline.org>
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

On 13/07/2022 22:10, Konrad Dybcio wrote:
> Add support for Sony Xperia 1 IV, a.k.a PDX223. This device is a part
> of the SoMC SM8450 Nagara platform and currently it is the only
> device based on that board, so no -common DTSI is created until (if?)
> other Nagara devices appear.
> 
> This commit brings support for:

Thank you for your patch. There is something to discuss/improve.

> +		pm8450_s3: smps3 {
> +			regulator-name = "pm8450_s3";
> +			regulator-min-microvolt = <500000>;
> +			regulator-max-microvolt = <600000>;
> +		};
> +
> +		pm8450_l2: ldo2 {
> +			regulator-name = "pm8450_l2";
> +			regulator-min-microvolt = <880000>;
> +			regulator-max-microvolt = <912000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		pm8450_l3: ldo3 {
> +			regulator-name = "pm8450_l3";
> +			regulator-min-microvolt = <912000>;
> +			regulator-max-microvolt = <912000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +

Remove blank line.

> +	};
> +
> +	pmr735a-rpmh-regulators {
> +		compatible = "qcom,pmr735a-rpmh-regulators";
> +		qcom,pmic-id = "e";
> +
> +		vdd-s1-supply = <&vph_pwr>;
> +		vdd-s2-supply = <&vph_pwr>;
> +		vdd-s3-supply = <&vph_pwr>;
> +
> +		vdd-l1-l2-supply = <&pmr735a_s2>;
> +		vdd-l3-supply = <&pmr735a_s1>;
> +		vdd-l4-supply = <&pm8350c_s1>;
> +		vdd-l5-l6-supply = <&pm8350c_s1>;
> +		vdd-l7-bob-supply = <&vreg_bob>;
> +
> +		pmr735a_s1: smps1 {
> +			regulator-name = "pmr735a_s1";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1296000>;
> +		};
> +
> +		pmr735a_s2: smps2 {
> +			regulator-name = "pmr735a_s2";
> +			regulator-min-microvolt = <500000>;
> +			regulator-max-microvolt = <1040000>;
> +		};
> +
> +		pmr735a_s3: smps3 {
> +			regulator-name = "pmr735a_s3";
> +			regulator-min-microvolt = <435000>;
> +			regulator-max-microvolt = <2352000>;
> +		};
> +
> +		pmr735a_l1: ldo1 {
> +			regulator-name = "pmr735a_l1";
> +			regulator-min-microvolt = <800000>;
> +			regulator-max-microvolt = <800000>;
> +		};
> +
> +		pmr735a_l2: ldo2 {
> +			regulator-name = "pmr735a_l2";
> +			regulator-min-microvolt = <480000>;
> +			regulator-max-microvolt = <912000>;
> +		};
> +
> +		pmr735a_l3: ldo3 {
> +			regulator-name = "pmr735a_l3";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +		};
> +
> +		pmr735a_l4: ldo4 {
> +			regulator-name = "pmr735a_l4";
> +			regulator-min-microvolt = <1776000>;
> +			regulator-max-microvolt = <1776000>;
> +		};
> +
> +		pmr735a_l5: ldo5 {
> +			regulator-name = "pmr735a_l5";
> +			regulator-min-microvolt = <880000>;
> +			regulator-max-microvolt = <880000>;
> +		};
> +
> +		pmr735a_l6: ldo6 {
> +			regulator-name = "pmr735a_l6";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +		};
> +
> +		pmr735a_l7: ldo7 {
> +			regulator-name = "pmr735a_l7";
> +			regulator-min-microvolt = <2800000>;
> +			regulator-max-microvolt = <2800000>;
> +		};
> +	};
> +};
> +
> +&gpi_dma0 {
> +	status = "okay";
> +};
> +
> +&gpi_dma1 {
> +	status = "okay";
> +};
> +
> +&gpi_dma2 {
> +	status = "okay";
> +};
> +
> +/* I2C4 is used, it hosts a Samsung touchscreen, but GPI DMA is broken.. */
> +
> +&i2c5 {
> +	clock-frequency = <400000>;
> +	status = "okay";
> +
> +	/* Dialog SLG51000 CMIC @ 75 */
> +};
> +
> +&i2c9 {
> +	clock-frequency = <400000>;
> +	status = "okay";
> +
> +	/* NXP SN1X0 NFC @ 28 */
> +};
> +
> +&i2c13 {
> +	clock-frequency = <400000>;
> +	status = "okay";
> +
> +	/* Richwave RTC6226 FM Radio Receiver @ 64 */
> +};
> +
> +&i2c14 {
> +	clock-frequency = <1000000>;
> +	status = "okay";
> +
> +	cs35l41_l: cs35l41@40 {


Generic node name is needed.

> +		compatible = "cirrus,cs35l41";
> +		reg = <0x40>;
> +		interrupt-parent = <&tlmm>;
> +		interrupts = <182 IRQ_TYPE_LEVEL_LOW>;
> +		reset-gpios = <&tlmm 183 GPIO_ACTIVE_HIGH>;
> +		cirrus,boost-peak-milliamp = <4000>;
> +		cirrus,boost-ind-nanohenry = <1000>;
> +		cirrus,boost-cap-microfarad = <15>;
> +		cirrus,gpio2-src-select = <2>;
> +		cirrus,gpio2-output-enable;
> +		cirrus,asp-sdout-hiz = <3>;
> +		#sound-dai-cells = <1>;
> +	};
> +
> +	cs35l41_r: cs35l41@41 {

Ditto.

> +		compatible = "cirrus,cs35l41";
> +		reg = <0x41>;
> +		interrupt-parent = <&tlmm>;
> +		interrupts = <182 IRQ_TYPE_LEVEL_LOW>;
> +		reset-gpios = <&tlmm 183 GPIO_ACTIVE_HIGH>;
> +		cirrus,boost-peak-milliamp = <4000>;
> +		cirrus,boost-ind-nanohenry = <1000>;
> +		cirrus,boost-cap-microfarad = <15>;
> +		cirrus,gpio2-src-select = <2>;
> +		cirrus,gpio2-output-enable;
> +		cirrus,asp-sdout-hiz = <3>;
> +		#sound-dai-cells = <1>;
> +	};
> +};
> +
> +&i2c15 {
> +	clock-frequency = <400000>;
> +	status = "okay";
> +
> +	/* AMS TCS3490 RGB+IR color sensor @ 72 */
> +};
> +
> +&i2c19 {
> +	clock-frequency = <1000000>;
> +	status = "okay";
> +
> +	/* Cirrus Logic CS40L25A boosted haptics driver @ 40 */
> +};
> +
> +&pcie0 {
> +	max-link-speed = <2>;
> +	status = "okay";
> +};
> +
> +&pcie0_phy {
> +	vdda-phy-supply = <&pm8350_l5>;
> +	vdda-pll-supply = <&pm8350_l6>;
> +	status = "okay";
> +};
> +
> +&remoteproc_adsp {
> +	firmware-name = "qcom/adsp.mbn";
> +	status = "okay";
> +};
> +
> +&remoteproc_cdsp {
> +	firmware-name = "qcom/cdsp.mbn";
> +	status = "okay";
> +};
> +
> +&remoteproc_slpi {
> +	firmware-name = "qcom/slpi.mbn";
> +	status = "okay";
> +};
> +
> +&qupv3_id_0 {
> +	status = "okay";
> +};
> +
> +&qupv3_id_1 {
> +	status = "okay";
> +};
> +
> +&qupv3_id_2 {
> +	status = "okay";
> +};
> +
> +&sdhc_2 {
> +	cd-gpios = <&tlmm 92 GPIO_ACTIVE_HIGH>;
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&sdc2_default_state &sdc2_card_det_n>;
> +	pinctrl-1 = <&sdc2_sleep_state &sdc2_card_det_n>;
> +	vmmc-supply = <&pm8350c_l9>;
> +	vqmmc-supply = <&pm8350c_l6>;
> +	/* Forbid SDR104/SDR50 - broken hw! */
> +        sdhci-caps-mask = <0x3 0x0>;

Wrong indentation.

> +	no-sdio;
> +	no-mmc;
> +	status = "okay";
> +};



Best regards,
Krzysztof
