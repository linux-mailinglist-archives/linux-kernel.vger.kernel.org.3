Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF5E5A9CF8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 18:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233260AbiIAQUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 12:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232902AbiIAQUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 12:20:25 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85AE92F3B0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 09:20:23 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id m7so16267650lfq.8
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 09:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=m+FhuVC9zsmBuPqczl82iep7EQ0hRYQKXXieJt5VGZg=;
        b=dcWnJRXDU4JrUZbK/QiyBi/v6boEp5WzmqeDKimaZ8Dm4sQC/tY9/GHF6Dawf1FLuw
         LvJO3UXXbRBGsdxkWdMUmFtTdLKgALBmHeF7uYdTPmrSj9dBdMo84GWuW/wC2MRdmBKH
         Iq+9zKsJht1IK15bGi7xc0px+D+WIDXOT+O5F8NgUIFSKarDyfKGRyyf7JH2jrxMYXtT
         qj5WzBq8f7Z2mFVIHSQM4ILDmKDKbhCTfG5MpCza5Em5vbQ0bBS4xYQ6jDR2Gfvw6TzA
         Y/a7EElMMLP14jP9wVCn1tW8OkTJr+8leMQkyVwcPlGAjoiqqDKN+XocCw8asbT8CJMb
         YDBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=m+FhuVC9zsmBuPqczl82iep7EQ0hRYQKXXieJt5VGZg=;
        b=Jxtq9RlvpCWJCaZfi1EA+UsInNmqAiIZBdAqzUJvD6mcIu6QQMBVFY6jBiIdg27+fW
         KV2iuls7ijyQYh1tuZ9+whTE+iSWPvqOsbuLLPB1VWwbWCDmjNaI62j973HFFGx9lKV6
         lYfrhcMjjI351qgSJrxZYRIobBYBmwVFcn+HUtsG04RvXPR3EyDftjtXqk6QKU62yEWd
         mN+690HPdCYVKfUVIYBqEbN2eIl1pPZL8CHed1HDNw/GIZHjhuelkmwZrNnyD3P6jI8/
         vKb1rHTy2st2MR47KLgK0bMYEt9JPvz9F8dAl0+GxGe/WeiIZ3eWsdebAMrncMNsanz+
         wAjA==
X-Gm-Message-State: ACgBeo0enjC7/iLsfPqhDMzgTPkkIY2MB5jjfgKH3MgOlHtKBC3Qt8+H
        cgJ+dzpTb9H2IetzvW62sMy2gQ==
X-Google-Smtp-Source: AA6agR7qj8UkAxIk7Zimk3Lo5Lwb7oBdWKWEyGYjaKKWTeBaWKdcQuL65WY5fr/iOVNtxuivNVxKow==
X-Received: by 2002:a05:6512:3b87:b0:494:9a8d:f74f with SMTP id g7-20020a0565123b8700b004949a8df74fmr1292105lfv.8.1662049221843;
        Thu, 01 Sep 2022 09:20:21 -0700 (PDT)
Received: from [192.168.28.124] (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id y20-20020a05651c107400b00261cd70e41asm1850937ljm.32.2022.09.01.09.20.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 09:20:20 -0700 (PDT)
Message-ID: <ccd72f2b-911e-c4fd-7bbc-ce21e5a34c68@linaro.org>
Date:   Thu, 1 Sep 2022 19:20:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 14/14] arm64: dts: qcom: sm4250: Add support for
 oneplus-billie2
Content-Language: en-US
To:     Iskren Chernev <iskren.chernev@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org
References: <20220901072414.1923075-1-iskren.chernev@gmail.com>
 <20220901072414.1923075-15-iskren.chernev@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220901072414.1923075-15-iskren.chernev@gmail.com>
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

On 01/09/2022 10:24, Iskren Chernev wrote:
> Add initial support for OnePlus Nord N100, based on SM4250. Currently
> working:
> - boots
> - usb
> - buildin flash storage (UFS)
> - SD card reader
> 
> Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
> ---
>  .../boot/dts/qcom/sm4250-oneplus-billie2.dts  | 240 ++++++++++++++++++
>  1 file changed, 240 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts b/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
> new file mode 100644
> index 000000000000..c1cf0288aa5f
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
> @@ -0,0 +1,240 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2021, Iskren Chernev <iskren.chernev@gmail.com>
> + */
> +
> +/dts-v1/;
> +
> +#include "sm4250.dtsi"
> +
> +/ {
> +	model = "OnePlus Nord N100";
> +	compatible = "oneplus,billie2", "qcom,sm4250";
> +
> +	/* required for bootloader to select correct board */
> +	qcom,msm-id = <0x1a1 0x10000 0x1bc 0x10000>;
> +	qcom,board-id = <0x1000b 0x00>;
> +
> +	aliases {
> +	};
> +
> +	chosen {
> +		bootargs = "earlycon=tty0 console=tty0 clk_ignore_unused pd_ignore_unused";

No bootargs. They are not suitable for wide-use.

> +
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		stdout-path = "framebuffer0";
> +
> +		framebuffer0: framebuffer@9d400000 {
> +			compatible = "simple-framebuffer";
> +			reg = <0 0x5c000000 0 (1600 * 720 * 4)>;
> +			width = <720>;
> +			height = <1600>;
> +			stride = <(720 * 4)>;
> +			format = "a8r8g8b8";
> +			status= "okay";

No need for status in new nodes.

> +		};
> +	};
> +
> +	reserved-memory {
> +		mtp_mem: memory@cc300000 {
> +			reg = <0x00 0xcc300000 0x00 0xb00000>;
> +			no-map;
> +		};
> +
> +		param_mem: memory@cc200000 {
> +			reg = <0x00 0xcc200000 0x00 0x100000>;
> +			no-map;
> +		};
> +
> +		bootloader_log_mem: memory@5fff7000 {
> +			reg = <0x00 0x5fff7000 0x00 0x8000>;
> +			no-map;
> +		};
> +
> +		ramoops@cbe00000 {
> +			compatible = "ramoops";
> +			reg = <0x0 0xcbe00000 0x0 0x400000>;
> +			record-size = <0x40000>;
> +			pmsg-size = <0x200000>;
> +			console-size = <0x40000>;
> +			ftrace-size = <0x40000>;
> +		};
> +	};
> +};
> +
> +&usb3 {
> +	status = "okay";
> +};
> +
> +&hsusb_phy {
> +	status = "okay";

Status is the last property. Also in other places.

> +	vdd-supply = <&vreg_l4a>;
> +	vdda-pll-supply = <&vreg_l12a>;
> +	vdda-phy-dpdm-supply = <&vreg_l15a>;
> +
> +};
> +
> +&tlmm {
> +	gpio-reserved-ranges = <14 4>;
> +};
> +
> +&sdhc_2 {
> +	status = "okay";
> +	vmmc-supply = <&vreg_l22a>;
> +	vqmmc-supply = <&vreg_l5a>;
> +
> +	cd-gpios = <&tlmm 88 GPIO_ACTIVE_HIGH>;
> +
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&sdc2_state_on>;
> +	pinctrl-1 = <&sdc2_state_off>;
> +};
> +
> +&ufs_mem_hc {
> +	status = "okay";
> +	vcc-supply = <&vreg_l24a>;
> +	vcc-max-microamp = <600000>;
> +	vccq2-supply = <&vreg_l11a>;
> +	vccq2-max-microamp = <600000>;
> +};
> +
> +&ufs_mem_phy {
> +	status = "okay";
> +	vdda-phy-supply = <&vreg_l4a>;
> +	vdda-pll-supply = <&vreg_l12a>;
> +	vddp-ref-clk-supply = <&vreg_l18a>;
> +};
> +
> +&rpm_requests {
> +	pm6125-regulators {

regulators

> +		compatible = "qcom,rpm-pm6125-regulators";
> +


Best regards,
Krzysztof
