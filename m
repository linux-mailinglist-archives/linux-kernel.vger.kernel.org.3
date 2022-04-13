Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31AD44FF2CE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 10:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234147AbiDMI6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 04:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232242AbiDMI6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 04:58:44 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0404B84F
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 01:56:23 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id b21so1354894ljf.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 01:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=pW/YXqDQlANPBYShRmBV2kdR37gC3CSOvx43OZDkAhE=;
        b=qh42nCIWLGN1ZO8hf0HKW2TozddfXNaIBL9zBdN2j8n60oMeBN/ONPfQS1qzMtVYXb
         HDixcST50N9KtLPWYqQxHI2Qyjva/qMxKOMgpJ7AAs8DMV4chKNTmaPrex/fFApFPGFY
         aUsZCgsZBjlxrs6ob5iJX5Noga9W/z2l4AJfUsiokfmWZEl0XfR8IKthQQU8afNzrJQt
         z0K6VqLO8h3TIQYl1NTbqD2J/PRdSJEoZBJqgvu0XThoT+Ptyd8NNfwfcoYPWpBbSgF2
         NzzvcGl2G3XA5zDizGPbxtHgFGc1cd7gEI5BVBRTlD2eD5MZMu7cEbc3KKAk5sDV7r7S
         qWsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pW/YXqDQlANPBYShRmBV2kdR37gC3CSOvx43OZDkAhE=;
        b=rtoso5m0gxnCxH7IU0MckfhT34mBzFU0XRlRvJfWLvLfQ75oKIp08gij8/63wvD3Fm
         EzTZbwYEn/D97xMa6ZdeIfMKiyEJ7sFvAw0krTw8nRzvZj3QRN6zqBvjrTrGLCuInfZz
         i93Sw12L3910POGM3KeFQokk/jTSWi/LVXLfDmcccweKQGiQrXrcsoybb29Sb2KZZGMe
         taGkanefpyA9hXzXgK4xoP716hHNJ3sy0u0EyFvekyIV+oiS7Z/u+MNEPrJIWr7ss0AU
         6d8s+3bsLSZQrDUpf5TkcciSjb7xgj/XYJMe0sqE40/4fAUD0k8ycH6dv57ASr55AGRX
         QYHg==
X-Gm-Message-State: AOAM533siMTS/76eJDM8uYQuOtfomjs4Sge9uhZJyRVI88u14cYtvbUf
        4IlVcwYsbvL9KiuIF1+PHPN8M+sccgX01A==
X-Google-Smtp-Source: ABdhPJwNr3fF1U5cyt61pQkVfOd9PYDX8/VX7j47apbjMQcNns5dZH+kozuz5AHC6Jhsli2ImOC+SA==
X-Received: by 2002:a05:651c:4d2:b0:24b:5de1:222 with SMTP id e18-20020a05651c04d200b0024b5de10222mr10509562lji.38.1649840182020;
        Wed, 13 Apr 2022 01:56:22 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id c3-20020a056512104300b0044a3582c9ecsm4034584lfb.219.2022.04.13.01.56.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 01:56:21 -0700 (PDT)
Message-ID: <e0ab19b3-0ae4-efd4-4035-44c8a5aec443@linaro.org>
Date:   Wed, 13 Apr 2022 11:56:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 17/18] ARM: dts: qcom: add ipq8064-v2.0 dtsi
Content-Language: en-GB
To:     Ansuel Smith <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jonathan McDowell <noodles@earth.li>
References: <20220309190152.7998-1-ansuelsmth@gmail.com>
 <20220309190152.7998-18-ansuelsmth@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220309190152.7998-18-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/2022 22:01, Ansuel Smith wrote:
> Many devices are based on the v2.0 of the ipq8064 SoC. Main difference
> is a change in the pci compatible and different way to configre the usb
> phy.
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> Tested-by: Jonathan McDowell <noodles@earth.li>
> ---
>   arch/arm/boot/dts/qcom-ipq8064-v2.0.dtsi | 70 ++++++++++++++++++++++++
>   1 file changed, 70 insertions(+)
>   create mode 100644 arch/arm/boot/dts/qcom-ipq8064-v2.0.dtsi
> 
> diff --git a/arch/arm/boot/dts/qcom-ipq8064-v2.0.dtsi b/arch/arm/boot/dts/qcom-ipq8064-v2.0.dtsi
> new file mode 100644
> index 000000000000..c082c3cd1a19
> --- /dev/null
> +++ b/arch/arm/boot/dts/qcom-ipq8064-v2.0.dtsi
> @@ -0,0 +1,70 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include "qcom-ipq8064.dtsi"
> +
> +/ {
> +	aliases {
> +		serial0 = &gsbi4_serial;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};

I'd expect that /aliases and /chosen should go to the board dts files.
I see that ipq8064-v1.0.dtsi also is a mixture of SoC-specific nodes and 
board details (gpio, leds, aliases, etc.). I think it should be split 
into ipq8064-v1.0.dtsi and ipq8064-common.dtsi (or 
ipq8064-v1.0-common.dtsi). This file also should contain just SoC 
specifics, not the enablement of individual devices.

> +
> +	reserved-memory {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		rsvd@41200000 {
> +			reg = <0x41200000 0x300000>;
> +			no-map;
> +		};
> +	};
> +};
> +
> +&gsbi4 {
> +	qcom,mode = <GSBI_PROT_I2C_UART>;
> +	status = "okay";
> +
> +	serial@16340000 {
> +		status = "okay";
> +	};
> +	/*
> +	 * The i2c device on gsbi4 should not be enabled.
> +	 * On ipq806x designs gsbi4 i2c is meant for exclusive
> +	 * RPM usage. Turning this on in kernel manifests as
> +	 * i2c failure for the RPM.
> +	 */
> +};
> +
> +&CPU_SPC {
> +	status = "okay";
> +};
> +
> +&pcie0 {
> +	compatible = "qcom,pcie-ipq8064-v2";
> +};
> +
> +&pcie1 {
> +	compatible = "qcom,pcie-ipq8064-v2";
> +};
> +
> +&pcie2 {
> +	compatible = "qcom,pcie-ipq8064-v2";
> +};
> +
> +&sata {
> +	ports-implemented = <0x1>;
> +};
> +
> +&ss_phy_0 {
> +	qcom,rx-eq = <2>;
> +	qcom,tx-deamp_3_5db = <32>;
> +	qcom,mpll = <5>;
> +};
> +
> +&ss_phy_1 {
> +	qcom,rx-eq = <2>;
> +	qcom,tx-deamp_3_5db = <32>;
> +	qcom,mpll = <5>;
> +};


-- 
With best wishes
Dmitry
