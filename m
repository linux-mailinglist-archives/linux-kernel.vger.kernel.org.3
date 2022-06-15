Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6303754CF15
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 18:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346347AbiFOQy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 12:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbiFOQy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 12:54:56 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B24A549F92;
        Wed, 15 Jun 2022 09:54:55 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id m24so16151286wrb.10;
        Wed, 15 Jun 2022 09:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=O0ZNCzaGbIN6vYx92G4OUm186Sl4b3mFGrPcQiPkGOk=;
        b=FWFfE/TrOsOqhKNBqDjPUw1E7PsUxALBEn9s+nTsX2df5Hx2wbVhzfUT/DUXRnQpnS
         y1WJqF+s3WJHsn1DPXWQOQtlbNRQuDyptNEM4nr6MeSafsU1dPtHIULXL+MQ3fGzaqYM
         NgASYW/jRkv6l0ZagU9DLznhoJ+G23wWKjS9X/eSpnNdUWMKuepQg/hFM8aVnvJVD1i7
         58rvgMp5z0X4w/AZZn031OrSvk9Vo3t4oNimvCl2flH1cQxaoO9l5kVRc6IYg6tRnlDV
         x3SSlYjYWZyFy79oPP8KftfTu34PQzBwjm1YJ8iuURHu1VsErk2pjiDI/K1c6Sr4M1Ce
         n+JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=O0ZNCzaGbIN6vYx92G4OUm186Sl4b3mFGrPcQiPkGOk=;
        b=bOLt1jHa9uV/hYBJmdxIIRIXU5qXO0verrYv98jIxBMkT655GTQRBSbhxiF/Fr+Hgz
         XmzKw10umJv/ZqMACSegUizRWfuWP2GAYBLZzroQClSn0+Z841WUBSaieRCfg+EwHnq2
         41en80xQFk0Q/bAZ6MRFwQDVGm1wcvbgFJP3+hD+RKQ7aPMlMwdR7jr4V0jEsxJiKUNB
         we9uEdfgCDKQhaSuRurfOuh/9OMjJcONtsI9syBkc7azmzW3TZjiwWUl9TJOlHFq5dAQ
         nSj2oeTqqXcc8FCjEd9TMvCn2SVYQNGpCYPdK7bTn6fsE+yVUA7D/OPWt1y3jGJUjlBq
         uGzw==
X-Gm-Message-State: AJIora/U9SH/j3BwctqCmaiNJ7zzVQkPbOKF7Y6qTHUiIKlYNuqlJ4Fe
        lB1wPbsxj9IjLCAOSMzdKvY=
X-Google-Smtp-Source: AGRyM1upL28UfLmiDNOCmxFWdPZt1LH1eRzJbtxF7HVF5ZDTc2UCPQgDR6kt2epkDohPh0R41Pw3Xg==
X-Received: by 2002:adf:e2cb:0:b0:20c:c1bb:9fcb with SMTP id d11-20020adfe2cb000000b0020cc1bb9fcbmr704620wrj.35.1655312094114;
        Wed, 15 Jun 2022 09:54:54 -0700 (PDT)
Received: from [192.168.0.36] ([37.223.143.134])
        by smtp.gmail.com with ESMTPSA id p22-20020a1c7416000000b0039c5a765388sm2890998wmc.28.2022.06.15.09.54.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 09:54:52 -0700 (PDT)
Message-ID: <bd788f00-0328-e57d-d56f-7e975996a9d0@gmail.com>
Date:   Wed, 15 Jun 2022 18:54:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH RESEND v10 3/3] ARM: dts: Add PCIe support for Airoha
 EN7523
Content-Language: en-US
To:     Felix Fietkau <nbd@nbd.name>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20220615125335.96089-1-nbd@nbd.name>
 <20220615125335.96089-3-nbd@nbd.name>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220615125335.96089-3-nbd@nbd.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/06/2022 14:53, Felix Fietkau wrote:
> This uses the MediaTek MT7622 PCIe driver, since the PCIe IP block is nearly
> identical to the one in MT7622
> 
> Signed-off-by: Felix Fietkau <nbd@nbd.name>

applied to v5.19-next/dts32

Thanks!

> ---
>   arch/arm/boot/dts/en7523-evb.dts |  8 +++++
>   arch/arm/boot/dts/en7523.dtsi    | 58 ++++++++++++++++++++++++++++++++
>   2 files changed, 66 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/en7523-evb.dts b/arch/arm/boot/dts/en7523-evb.dts
> index a8d8bb0419a0..f23a25cce119 100644
> --- a/arch/arm/boot/dts/en7523-evb.dts
> +++ b/arch/arm/boot/dts/en7523-evb.dts
> @@ -33,3 +33,11 @@ &gpio0 {
>   &gpio1 {
>   	status = "okay";
>   };
> +
> +&pcie0 {
> +	status = "okay";
> +};
> +
> +&pcie1 {
> +	status = "okay";
> +};
> diff --git a/arch/arm/boot/dts/en7523.dtsi b/arch/arm/boot/dts/en7523.dtsi
> index 2e705b87b6c1..7f839331a777 100644
> --- a/arch/arm/boot/dts/en7523.dtsi
> +++ b/arch/arm/boot/dts/en7523.dtsi
> @@ -143,4 +143,62 @@ gpio1: gpio@1fbf0270 {
>   		gpio-controller;
>   		#gpio-cells = <2>;
>   	};
> +
> +	pcie0: pcie@1fa91000 {
> +		compatible = "airoha,en7523-pcie", "mediatek,mt7622-pcie";
> +		device_type = "pci";
> +		reg = <0x1fa91000 0x1000>;
> +		reg-names = "port0";
> +		linux,pci-domain = <0>;
> +		#address-cells = <3>;
> +		#size-cells = <2>;
> +		interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-names = "pcie_irq";
> +		clocks = <&scu EN7523_CLK_PCIE>;
> +		clock-names = "sys_ck0";
> +		bus-range = <0x00 0xff>;
> +		ranges = <0x82000000 0 0x20000000  0x20000000  0 0x8000000>;
> +		status = "disabled";
> +
> +		#interrupt-cells = <1>;
> +		interrupt-map-mask = <0 0 0 7>;
> +		interrupt-map = <0 0 0 1 &pcie_intc0 0>,
> +				<0 0 0 2 &pcie_intc0 1>,
> +				<0 0 0 3 &pcie_intc0 2>,
> +				<0 0 0 4 &pcie_intc0 3>;
> +		pcie_intc0: interrupt-controller {
> +			interrupt-controller;
> +			#address-cells = <0>;
> +			#interrupt-cells = <1>;
> +		};
> +	};
> +
> +	pcie1: pcie@1fa92000 {
> +		compatible = "airoha,en7523-pcie", "mediatek,mt7622-pcie";
> +		device_type = "pci";
> +		reg = <0x1fa92000 0x1000>;
> +		reg-names = "port1";
> +		linux,pci-domain = <1>;
> +		#address-cells = <3>;
> +		#size-cells = <2>;
> +		interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-names = "pcie_irq";
> +		clocks = <&scu EN7523_CLK_PCIE>;
> +		clock-names = "sys_ck1";
> +		bus-range = <0x00 0xff>;
> +		ranges = <0x82000000 0 0x28000000  0x28000000  0 0x8000000>;
> +		status = "disabled";
> +
> +		#interrupt-cells = <1>;
> +		interrupt-map-mask = <0 0 0 7>;
> +		interrupt-map = <0 0 0 1 &pcie_intc1 0>,
> +				<0 0 0 2 &pcie_intc1 1>,
> +				<0 0 0 3 &pcie_intc1 2>,
> +				<0 0 0 4 &pcie_intc1 3>;
> +		pcie_intc1: interrupt-controller {
> +			interrupt-controller;
> +			#address-cells = <0>;
> +			#interrupt-cells = <1>;
> +		};
> +	};
>   };
