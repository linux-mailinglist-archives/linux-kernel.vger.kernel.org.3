Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49FB85A9A59
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 16:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234764AbiIAObP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 10:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234779AbiIAObK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 10:31:10 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A476C11E;
        Thu,  1 Sep 2022 07:31:08 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id b5so22608592wrr.5;
        Thu, 01 Sep 2022 07:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=T/lFULYC7Ke1BXi647CM88bU431QP21ewJEyzWrvSnM=;
        b=pA6sBzZZzHEeFvlcNG2Ev480dc0grCRm4fpEKUDjzJBJR3yioXatFWOp0k2t+hsrOj
         XSLbaevCk5Txr3pfKnlAUMTgqqizV3+IrA6jNLKyB6uOhJZGdBKkORmJlLQPvq65rBBa
         hvNkcCTyu/7sVmNGh9lkgTn1i1p4uJMsZ2KN4T9cf9NYj12veqSJCkLesgYkBg8mASes
         m/Dc/Qk0/KdXA+VK60qDwSdpOYRkEamqJh+ffOtRBG+d0HNl6dfhqgSL/lOco32OaeuY
         xsIBYjVPut6HLP0TUnSY34RJbnCOul2LORID2WdjkuPcZ2iYTqM8ESw2BfFR8ubyGkNL
         zCdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=T/lFULYC7Ke1BXi647CM88bU431QP21ewJEyzWrvSnM=;
        b=KsIOJnbNPBicp2VT1RgOX4pAEM/DdjaeQ1EaUs/jVNB7KEwMGeL3MbX2ADb3YadqV8
         3E8diZk3aLdOmjKNNi1cNCxr95gmsnwpQ4RqivTKMjCkRbta5ImcMKQynaqdRyItyNTi
         tj5Jtaqo1LDeeGEPs2tL+FC7bxGbAD4dkk68kpDAspt1JORsiLQfuXPS5TnNGt51bJy9
         8XGCepy217tbp5FgIjsq41jiwvonN2uSLNNnzxWyBR/ymJGV3ZUqK0C2VaOU/H274ra9
         zToqqZSU0DAQs8Jg6QxFpO/SoCcwdkadtEQ9cQvC80qnHwmKMW7xlO8heUX4JdZBPr6+
         Rm1Q==
X-Gm-Message-State: ACgBeo18VqHkQFIIsKiiXG6J8i2KaaFb5MZlHdJnJfRjN38TCI+qDvLe
        w4N/fsP+Ba05hHHeve5NZ2I=
X-Google-Smtp-Source: AA6agR7f+KK2jItph90PXKwihYdt6FOBY3qQdM3Me1JOJcTgSGVJ1rQ0W2v00+QaPvjHdXZWIpFxoA==
X-Received: by 2002:a5d:5274:0:b0:226:d134:80aa with SMTP id l20-20020a5d5274000000b00226d13480aamr14529277wrc.59.1662042666771;
        Thu, 01 Sep 2022 07:31:06 -0700 (PDT)
Received: from [192.168.0.30] ([47.62.125.55])
        by smtp.gmail.com with ESMTPSA id b8-20020a5d4d88000000b002253d865715sm11813494wru.87.2022.09.01.07.31.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 07:31:05 -0700 (PDT)
Message-ID: <aac98d72-863d-eb7b-caab-73bb0fddeb83@gmail.com>
Date:   Thu, 1 Sep 2022 16:31:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v5] arm64: dts: mt7986: add built-in Wi-Fi device nodes
Content-Language: en-US
To:     Peter Chiu <chui-hao.chiu@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     devicetree@vger.kernel.org, Ryder Lee <ryder.Lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Sam Shih <sam.shih@mediatek.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220901130552.26234-1-chui-hao.chiu@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220901130552.26234-1-chui-hao.chiu@mediatek.com>
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



On 01/09/2022 15:05, Peter Chiu wrote:
> This enables built-in 802.11ax Wi-Fi support.
> 
> Reviewed-by: Sam Shih <sam.shih@mediatek.com>
> Reviewed-by: Ryder Lee <ryder.lee@mediatek.com>
> Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
> 

That won't work without the pinctrl yaml file updated. Please send both together 
so that we can review them.

Regards,
Matthias

> ---
> v2: add clocks and clock-names.
> v3: rename wmac to wifi and change underscores to dash in node names.
> v4: rebase to the latest codebase.
> v5: remove useless pins in wf_dbdc_pins node.
> ---
>   arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts | 38 +++++++++++++++++++
>   arch/arm64/boot/dts/mediatek/mt7986a.dtsi    | 23 +++++++++++
>   arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts | 40 ++++++++++++++++++++
>   3 files changed, 101 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts b/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
> index 882277a52b69..afe37b702eef 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
> @@ -115,6 +115,13 @@
>   	status = "okay";
>   };
>   
> +&wifi {
> +	status = "okay";
> +	pinctrl-names = "default", "dbdc";
> +	pinctrl-0 = <&wf_2g_5g_pins>;
> +	pinctrl-1 = <&wf_dbdc_pins>;
> +};
> +
>   &pio {
>   	uart1_pins: uart1-pins {
>   		mux {
> @@ -129,4 +136,35 @@
>   			groups = "uart2";
>   		};
>   	};
> +
> +	wf_2g_5g_pins: wf-2g-5g-pins {
> +		mux {
> +			function = "wifi";
> +			groups = "wf_2g", "wf_5g";
> +		};
> +		conf {
> +			pins = "WF0_HB1", "WF0_HB2", "WF0_HB3", "WF0_HB4",
> +			       "WF0_HB0", "WF0_HB0_B", "WF0_HB5", "WF0_HB6",
> +			       "WF0_HB7", "WF0_HB8", "WF0_HB9", "WF0_HB10",
> +			       "WF0_TOP_CLK", "WF0_TOP_DATA", "WF1_HB1",
> +			       "WF1_HB2", "WF1_HB3", "WF1_HB4", "WF1_HB0",
> +			       "WF1_HB5", "WF1_HB6", "WF1_HB7", "WF1_HB8",
> +			       "WF1_TOP_CLK", "WF1_TOP_DATA";
> +			drive-strength = <4>;
> +		};
> +	};
> +
> +	wf_dbdc_pins: wf-dbdc-pins {
> +		mux {
> +			function = "wifi";
> +			groups = "wf_dbdc";
> +		};
> +		conf {
> +			pins = "WF0_HB1", "WF0_HB2", "WF0_HB3", "WF0_HB4",
> +			       "WF0_HB0", "WF0_HB0_B", "WF0_HB5", "WF0_HB6",
> +			       "WF0_HB7", "WF0_HB8", "WF0_HB9", "WF0_HB10",
> +			       "WF0_TOP_CLK", "WF0_TOP_DATA";
> +			drive-strength = <4>;
> +		};
> +	};
>   };
> diff --git a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
> index e3a407d03551..890ded0efc51 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
> @@ -7,6 +7,7 @@
>   #include <dt-bindings/interrupt-controller/irq.h>
>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>   #include <dt-bindings/clock/mt7986-clk.h>
> +#include <dt-bindings/reset/mt7986-resets.h>
>   
>   / {
>   	interrupt-parent = <&gic>;
> @@ -70,6 +71,11 @@
>   			reg = <0 0x43000000 0 0x30000>;
>   			no-map;
>   		};
> +
> +		wmcpu_emi: wmcpu-reserved@4fc00000 {
> +			no-map;
> +			reg = <0 0x4fc00000 0 0x00100000>;
> +		};
>   	};
>   
>   	timer {
> @@ -261,6 +267,23 @@
>   			#size-cells = <0>;
>   			status = "disabled";
>   		};
> +
> +		wifi: wifi@18000000 {
> +			compatible = "mediatek,mt7986-wmac";
> +			resets = <&watchdog MT7986_TOPRGU_CONSYS_SW_RST>;
> +			reset-names = "consys";
> +			clocks = <&topckgen CLK_TOP_CONN_MCUSYS_SEL>,
> +				 <&topckgen CLK_TOP_AP2CNN_HOST_SEL>;
> +			clock-names = "mcu", "ap2conn";
> +			reg = <0 0x18000000 0 0x1000000>,
> +			      <0 0x10003000 0 0x1000>,
> +			      <0 0x11d10000 0 0x1000>;
> +			interrupts = <GIC_SPI 213 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 214 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 216 IRQ_TYPE_LEVEL_HIGH>;
> +			memory-region = <&wmcpu_emi>;
> +		};
>   	};
>   
>   };
> diff --git a/arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts b/arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts
> index 0f49d5764ff3..3443013b5971 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts
> @@ -98,3 +98,43 @@
>   		};
>   	};
>   };
> +
> +&wifi {
> +	status = "okay";
> +	pinctrl-names = "default", "dbdc";
> +	pinctrl-0 = <&wf_2g_5g_pins>;
> +	pinctrl-1 = <&wf_dbdc_pins>;
> +};
> +
> +&pio {
> +	wf_2g_5g_pins: wf-2g-5g-pins {
> +		mux {
> +			function = "wifi";
> +			groups = "wf_2g", "wf_5g";
> +		};
> +		conf {
> +			pins = "WF0_HB1", "WF0_HB2", "WF0_HB3", "WF0_HB4",
> +			       "WF0_HB0", "WF0_HB0_B", "WF0_HB5", "WF0_HB6",
> +			       "WF0_HB7", "WF0_HB8", "WF0_HB9", "WF0_HB10",
> +			       "WF0_TOP_CLK", "WF0_TOP_DATA", "WF1_HB1",
> +			       "WF1_HB2", "WF1_HB3", "WF1_HB4", "WF1_HB0",
> +			       "WF1_HB5", "WF1_HB6", "WF1_HB7", "WF1_HB8",
> +			       "WF1_TOP_CLK", "WF1_TOP_DATA";
> +			drive-strength = <4>;
> +		};
> +	};
> +
> +	wf_dbdc_pins: wf-dbdc-pins {
> +		mux {
> +			function = "wifi";
> +			groups = "wf_dbdc";
> +		};
> +		conf {
> +			pins = "WF0_HB1", "WF0_HB2", "WF0_HB3", "WF0_HB4",
> +			       "WF0_HB0", "WF0_HB0_B", "WF0_HB5", "WF0_HB6",
> +			       "WF0_HB7", "WF0_HB8", "WF0_HB9", "WF0_HB10",
> +			       "WF0_TOP_CLK", "WF0_TOP_DATA";
> +			drive-strength = <4>;
> +		};
> +	};
> +};
