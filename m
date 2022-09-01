Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40BB85A9C86
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 18:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234826AbiIAQG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 12:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234746AbiIAQGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 12:06:24 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75ECB5926B
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 09:06:22 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id by6so18381352ljb.11
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 09:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=y/D8ZrdtNbYgp7NAJGSD17iXrnK1XO6f+XSKqvV15P0=;
        b=YEcVo+TqZLikeY2bfLfMQXYWnLT2ecpN6LfbIPNRii2qKAmq+fF2KxzHqdt28bg+oy
         4CCfYurczxtS5bQPBdw8UtNlv+74RMUrvu++B8oNBwyjopZi3BqV5PEXjM3w9XSTkEn0
         Ff8cyqoGS/6LyGVYP+2VtHRK3wiqLX+MZK4PmVxYx+HgLM+iwJ+tUhq7/yLIq5j/Ghco
         yD4BXy6JrwxBh9uuCjVst19bBqeH2r+t8S4aTQGGWTMKZ1M4bj52Mb0mZpfJNCabiW6a
         7Mul5rHJJ0iI1zWWi0SHtYFW8uhL+wpCiOkBewVwnsf9BhG4x7r0YrMOzH1lz83IKYH7
         bsnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=y/D8ZrdtNbYgp7NAJGSD17iXrnK1XO6f+XSKqvV15P0=;
        b=GeIlwsk9B9Laq1Ki3cCd80wIzVgoJZPEkbPm+ytVN+tBw0YjChNNTdag6RDXKLbXLi
         3Ga15JqZRTemSxJP7gI1prePI1Qa5hep03u5RrlHxVtPxXcmbJzN4XHA12feA09+NnQq
         dRXJkToFFuVOjLh2IeR6/anpq+D3NrgDeDoZX2H3jnsuxy3fd27rvhvtHnb7GTe47/Ed
         HiVZ4f2hTz5M61tLP9WxYi6kDcWUYU9/H7vlaxoPAtjBYBF/jY/xIx782AQWgl6ZtY31
         mYGtt5ZcdbRDU2FnWuAU+eFZlDaqo3+W/oi4u6aY2yeWcNk0CeCfZ9kn+58ms7+D7LtL
         Wv/w==
X-Gm-Message-State: ACgBeo3TcGjGsvWqfgFcQ8IiS5gnZUzNwSihJ3WSBTK28Ed+T1PbUjjX
        PJeFd877EhX0rkuMkxk/YwB9Qw==
X-Google-Smtp-Source: AA6agR77koAUoyzW9yFSqfwU4B4LHzjLtbuIU2dg4F4NcXikmz9tVrpUc5AcS7QyqPdaJcEtGp+MFw==
X-Received: by 2002:a2e:a785:0:b0:268:a64e:4b49 with SMTP id c5-20020a2ea785000000b00268a64e4b49mr1772705ljf.270.1662048380793;
        Thu, 01 Sep 2022 09:06:20 -0700 (PDT)
Received: from [192.168.28.124] (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id v20-20020a2e2f14000000b0025e60089f34sm2528657ljv.52.2022.09.01.09.06.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 09:06:20 -0700 (PDT)
Message-ID: <8b1f1576-62c1-5a17-561a-619b88587a4a@linaro.org>
Date:   Thu, 1 Sep 2022 19:06:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 06/14] arm64: dts: qcom: sm6115: Add usb and related phy
 nodes
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
 <20220901072414.1923075-7-iskren.chernev@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220901072414.1923075-7-iskren.chernev@gmail.com>
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
> Add support for the USB controller and its HS PHY to SM6115.
> 
> Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
> ---
>  arch/arm64/boot/dts/qcom/sm6115.dtsi | 62 ++++++++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> index a6be8b93a44d..00fd185c87aa 100644
> --- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> @@ -412,6 +412,21 @@ gcc: clock-controller@1400000 {
>  			#power-domain-cells = <1>;
>  		};
>  
> +		hsusb_phy: phy@1613000 {
> +			compatible = "qcom,sm6115-qusb2-phy";
> +			reg = <0x1613000 0x180>;
> +			#phy-cells = <0>;
> +
> +			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>,
> +				 <&gcc GCC_AHB2PHY_USB_CLK>;
> +			clock-names = "ref", "cfg_ahb";
> +
> +			resets = <&gcc GCC_QUSB2PHY_PRIM_BCR>;
> +			nvmem-cells = <&qusb2_hstx_trim>;
> +
> +			status = "disabled";
> +		};
> +
>  		qfprom@1b40000 {
>  			compatible = "qcom,qfprom";
>  			reg = <0x1b40000 0x7000>;
> @@ -434,6 +449,53 @@ rpm_msg_ram: memory@45f0000 {
>  			reg = <0x45f0000 0x7000>;
>  		};
>  
> +		usb3: usb@4ef8800 {
> +			compatible = "qcom,sm6115-dwc3", "qcom,dwc3";
> +			reg = <0x04ef8800 0x400>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +
> +			clocks = <&gcc GCC_CFG_NOC_USB3_PRIM_AXI_CLK>,
> +				 <&gcc GCC_USB30_PRIM_MASTER_CLK>,
> +				 <&gcc GCC_SYS_NOC_USB3_PRIM_AXI_CLK>,
> +				 <&gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>,
> +				 <&gcc GCC_USB30_PRIM_SLEEP_CLK>,
> +				 <&gcc GCC_USB3_PRIM_CLKREF_CLK>;
> +			clock-names = "cfg_noc", "core", "iface", "mock_utmi",
> +				      "sleep", "xo";
> +
> +			assigned-clocks = <&gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>,
> +					  <&gcc GCC_USB30_PRIM_MASTER_CLK>;
> +			assigned-clock-rates = <19200000>, <66666667>;
> +
> +			interrupts = <GIC_SPI 260 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "hs_phy_irq", "ss_phy_irq";
> +
> +			resets = <&gcc GCC_USB30_PRIM_BCR>;
> +			power-domains = <&gcc GCC_USB30_PRIM_GDSC>;
> +			qcom,select-utmi-as-pipe-clk;
> +			status = "disabled";
> +
> +			usb3_dwc3: dwc3@4e00000 {

Node name: usb

Does not look like you tested the DTS against bindings. Please run `make
dtbs_check` (see Documentation/devicetree/bindings/writing-schema.rst
for instructions).

Best regards,
Krzysztof
