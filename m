Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9E604ED8C2
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 13:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235358AbiCaL6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 07:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbiCaL63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 07:58:29 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE67208C12;
        Thu, 31 Mar 2022 04:56:42 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id n35so14106290wms.5;
        Thu, 31 Mar 2022 04:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Wxsj21Het/z6xd9Casvbkn0jKbQnilJIFWcnrumAXSU=;
        b=WSzw5urQAa6H8LwgQkKimPtvog6Ro2Kkq/TwkgFYtOd9znWt4AIRG7kWdLLmWob+jK
         K4hTMeezMcJLSRRal7F5QzVDT5IN0WVXUrx4R6qJVOG7wuJBnZsqf+2enWgwG/GcH8pW
         mRbVqnHZ2zGq9oU84xzD4JyJD/2LZDo9k+trH525wZ/lpa8oHnCYOuY30Rf/cPUn4gIX
         jigHnzOHItV+FG34ytfUoc1IAwGnasVKLZE26X2sIFYVrh2pWT75LN4p8HLVyHJ/BpAP
         1u4ygdEtIQo3jdszaGR5/OI7FrupmeTcXT05JZJt3+NNWMhhAoJizUohPqTXkVr1ldVY
         /mwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Wxsj21Het/z6xd9Casvbkn0jKbQnilJIFWcnrumAXSU=;
        b=lZnKRJw4PSuO4vxU096EfYHpbT4R1MfPfC1GooIlwoBEYBmmEDTXtndcIfQSB0Xuou
         WpIZKGb2p0f4El0fv7tIdt8rnTXxC4C4FnQyD6YaQEhBWDICwUWLhKM2FrggqKM9Dgk2
         M9W9x5HjmG7q6cM7c8faqlxa6cqCk/IplwytmbKnwV3LNsSKw4Ky5otnSO2WgqJcRokm
         Z2qNEgpauiSgXSz6xWftYGfvxZFpus/WkyUlFQsCJAgS3jAH2fn91oVXgMRkmROEwxhQ
         fkIHJ4uNJcQU0Ipl85VIwNonV/MrT8Jt2JjhMyqF7xuYWtnYa63lk8JnFcQ9dKm3I7Ao
         I19Q==
X-Gm-Message-State: AOAM5311Y+dwJvwIasi9fu9aDfq4MGrtMq1Xg71oqkYY3Qnc7oeZuTvF
        wZz/A+uSw/lM26dkM3vSSIE=
X-Google-Smtp-Source: ABdhPJwqM0tYJjbGOI3ikLFWCZA1vagqtFyfRDGpTW5JHpsB6utkyOP9RhS1rPj272VgJuGOmu7qKg==
X-Received: by 2002:a05:600c:19ce:b0:38c:dcc1:4cf3 with SMTP id u14-20020a05600c19ce00b0038cdcc14cf3mr4419238wmq.126.1648727800764;
        Thu, 31 Mar 2022 04:56:40 -0700 (PDT)
Received: from [192.168.1.145] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id y11-20020a056000168b00b002041af9a73fsm23001295wrd.84.2022.03.31.04.56.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Mar 2022 04:56:40 -0700 (PDT)
Message-ID: <06a53ed1-63a8-50c1-7eb0-58ccecce624e@gmail.com>
Date:   Thu, 31 Mar 2022 13:56:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v5 1/4] arm64: dts: mt8192: Add PCIe node
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>,
        Ryder Lee <ryder.lee@kernel.org>,
        Hui Liu <hui.liu@mediatek.com>
References: <20220330133816.30806-1-allen-kh.cheng@mediatek.com>
 <20220330133816.30806-2-allen-kh.cheng@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220330133816.30806-2-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/03/2022 15:38, Allen-KH Cheng wrote:
> Add PCIe node for mt8192 SoC.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

I wonder why you left Nicolas Reviewed-by but not the one from Angelo. Anyway 
when sending a new version, be sure to drop the reviewed-by tags if there are 
substantial changes in the patch. We can argue if changing the clock names is a 
substantial change or not. Maybe that's why you left just one reviewed-by tag ;)
I'm just joking, I'll add the other tag myself.

Applied thanks.

> ---
>   arch/arm64/boot/dts/mediatek/mt8192.dtsi | 35 ++++++++++++++++++++++++
>   1 file changed, 35 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> index 579abbf4488e..69e8d1934d53 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> @@ -716,6 +716,41 @@
>   			status = "disabled";
>   		};
>   
> +		pcie: pcie@11230000 {
> +			compatible = "mediatek,mt8192-pcie";
> +			device_type = "pci";
> +			reg = <0 0x11230000 0 0x2000>;
> +			reg-names = "pcie-mac";
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +			clocks = <&infracfg CLK_INFRA_PCIE_PL_P_250M>,
> +				 <&infracfg CLK_INFRA_PCIE_TL_26M>,
> +				 <&infracfg CLK_INFRA_PCIE_TL_96M>,
> +				 <&infracfg CLK_INFRA_PCIE_TL_32K>,
> +				 <&infracfg CLK_INFRA_PCIE_PERI_26M>,
> +				 <&infracfg CLK_INFRA_PCIE_TOP_H_133M>;
> +			clock-names = "pl_250m", "tl_26m", "tl_96m",
> +				      "tl_32k", "peri_26m", "top_133m";
> +			assigned-clocks = <&topckgen CLK_TOP_TL_SEL>;
> +			assigned-clock-parents = <&topckgen CLK_TOP_MAINPLL_D6_D4>;
> +			interrupts = <GIC_SPI 251 IRQ_TYPE_LEVEL_HIGH 0>;
> +			bus-range = <0x00 0xff>;
> +			ranges = <0x82000000 0 0x12000000 0x0 0x12000000 0 0x0800000>,
> +				 <0x81000000 0 0x12800000 0x0 0x12800000 0 0x0800000>;
> +			#interrupt-cells = <1>;
> +			interrupt-map-mask = <0 0 0 7>;
> +			interrupt-map = <0 0 0 1 &pcie_intc0 0>,
> +					<0 0 0 2 &pcie_intc0 1>,
> +					<0 0 0 3 &pcie_intc0 2>,
> +					<0 0 0 4 &pcie_intc0 3>;
> +
> +			pcie_intc0: interrupt-controller {
> +				interrupt-controller;
> +				#address-cells = <0>;
> +				#interrupt-cells = <1>;
> +			};
> +		};
> +
>   		nor_flash: spi@11234000 {
>   			compatible = "mediatek,mt8192-nor";
>   			reg = <0 0x11234000 0 0xe0>;
