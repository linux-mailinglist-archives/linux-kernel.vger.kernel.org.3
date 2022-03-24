Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 379B04E6800
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 18:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352390AbiCXRp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 13:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242158AbiCXRpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 13:45:53 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9808D63C1;
        Thu, 24 Mar 2022 10:44:21 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id a1so7675453wrh.10;
        Thu, 24 Mar 2022 10:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=hv1mGUW4D/y2FwqNconOhnQri8Bx6adahhUWQd8+hzc=;
        b=g0D7WtFBMHL6Dgb1tSv/VZG7vDbSYCH8VhlF61I3FtDCtbqaMZAwlSacniH/Mpsk52
         uIUpBFATXF2xGPfI6g45x2TXY2nUTX73JXMf6TKcu8anfdtz+QPOdouAV+EUZeJorlsl
         tkDnAMjjF+OKETkwbNnRdhhU7K1GqeLGUplG+ea6FYBDneE4iTCOxfEIkLcnF1sujiTm
         iseW8zF4PCzs/A1Yd00ACIQapXRBY/tTVKBSTzXCRKuntqX+NqFqSWLvi4ExuqfDoeSE
         NADzgEPbWLdzGR+KKt3MBR+c8Ytp7Cdp8UhpvKCUdrwk6MqEDV3hltIXtcfytjhk5HIF
         cUqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hv1mGUW4D/y2FwqNconOhnQri8Bx6adahhUWQd8+hzc=;
        b=AkQoutZYqAAAQgKnY6gdKEN8u9/qOX4iPegtWIbauNeU8FicmC1gzN9RxaCykHYU8p
         2omh/MMXnKNKFBPKHqVjc6I9Pw6lHySt5iIYn8AndKIvwGgWoOGOM1FEn5H6JUbqQqcK
         wykPZDZlLgGbtVmFlzHadGTzzcOGwwVd8qsyds5wuykoOulUnBjHnEMH0zITjnrr5uwN
         hYau+qmUlCaSnyjKPyf8NxSq1CxM+ILUeaTAiLtCytqatYF/EIiB3gKmZKm4xdklz/ds
         dj8i/T9OeAUXGcAKqiMg3iZaAS0LJtAxgjKIZ5nLt+2mhcC4T/Jmc9z1Xl7SvHECdGGp
         7DjA==
X-Gm-Message-State: AOAM533IusrgZWWe86q3XcDWQ2ACou5rNIHTAX4pB49CMcSbUWm7kP5m
        3KFarGrJ11L9q8kvKNrt2kQ=
X-Google-Smtp-Source: ABdhPJwU7em0ST1ATwrLOA2idhEsIR537fGjzUF+q2BRyr9q+TpcaOGB+9l683JQlU3r3PLtcjfvkg==
X-Received: by 2002:a5d:5846:0:b0:204:1a79:f1ab with SMTP id i6-20020a5d5846000000b002041a79f1abmr5416544wrf.520.1648143860073;
        Thu, 24 Mar 2022 10:44:20 -0700 (PDT)
Received: from [192.168.0.32] ([137.101.87.65])
        by smtp.gmail.com with ESMTPSA id p8-20020a5d4e08000000b002054b5437f2sm3002788wrt.115.2022.03.24.10.44.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Mar 2022 10:44:19 -0700 (PDT)
Message-ID: <6d7c622a-8685-c020-399e-3559a34b9ad8@gmail.com>
Date:   Thu, 24 Mar 2022 18:44:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 09/22] arm64: dts: mt8192: Add PCIe node
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
References: <20220318144534.17996-1-allen-kh.cheng@mediatek.com>
 <20220318144534.17996-10-allen-kh.cheng@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220318144534.17996-10-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/03/2022 15:45, Allen-KH Cheng wrote:
> Add PCIe node for mt8192 SoC.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> ---
>   arch/arm64/boot/dts/mediatek/mt8192.dtsi | 38 ++++++++++++++++++++++++
>   1 file changed, 38 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> index 82de1af3f6aa..3a7f93d8eeaa 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> @@ -884,6 +884,44 @@
>   			};
>   		};
>   
> +		pcie: pcie@11230000 {
> +			compatible = "mediatek,mt8192-pcie";
> +			device_type = "pci";
> +			reg = <0 0x11230000 0 0x2000>;
> +			reg-names = "pcie-mac";
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +			clocks = <&infracfg CLK_INFRA_PCIE_TL_26M>,
> +				 <&infracfg CLK_INFRA_PCIE_TL_96M>,
> +				 <&infracfg CLK_INFRA_PCIE_TL_32K>,
> +				 <&infracfg CLK_INFRA_PCIE_PERI_26M>,
> +				 <&infracfg CLK_INFRA_PCIE_TOP_H_133M>,
> +				 <&infracfg CLK_INFRA_PCIE_PL_P_250M>;
> +			clock-names = "sys_ck0", "ahb_ck0", "aux_ck0",
> +				      "obff_ck0", "axi_ck0", "pipe_ck0";

Also not mandated by the bindings nor the driver clock-names don't match the 
binding. How comes? Shall we update the bindings to have more sound names?

Regards,
Matthias

> +			assigned-clocks = <&topckgen CLK_TOP_TL_SEL>;
> +			assigned-clock-parents = <&topckgen CLK_TOP_MAINPLL_D6_D4>;
> +			resets = <&infracfg_rst 2>,
> +				 <&infracfg_rst 3>;
> +			reset-names = "phy", "mac";
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
