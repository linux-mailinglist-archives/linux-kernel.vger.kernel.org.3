Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 471174E92F7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 13:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240475AbiC1LDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 07:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240471AbiC1LDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 07:03:22 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3851E5522D;
        Mon, 28 Mar 2022 04:01:42 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id p189so8145588wmp.3;
        Mon, 28 Mar 2022 04:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ykS4CFll+H8Op4I03/7dYBqilBTYX83XNgnoe/3NCaQ=;
        b=Tga44SEmd85Vio2pvHqbRpA9ki7G9bZleXwfWn8CAc7+fIoER46ZP5xU23nXz53Muw
         dWkEuYJbyTSGubrEopIW+asPWzQaClUbHjuygPfqyhtTIuAl0Kw5p4NGl2HJU0r49ilp
         1+iLpL66KNyapj5/oAV9kW9zx3NaXNS0AaBpORa2YaaNG02WGcuiGNUEIg8lhOfXFgQR
         QmUpXdbmdTQPbV+HtaU1c1BV9ohGsrS6l1lJoMcsocKDsXbjPn3dSJBJpjYzEztsAigv
         hcZ2H7F90xgtvGiT98lZx+yrtcNpy3pxq5U9E800+jpo4dI6+uRBX7o7ycyBHncpOPD/
         OA3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ykS4CFll+H8Op4I03/7dYBqilBTYX83XNgnoe/3NCaQ=;
        b=axFXBacc6jlqOSIoEZoppx3NZBUNAJpHu308ucG0x3AuF7p1ZDYYpfrlDduMn1lirN
         SfJsZ2nGy+w+fGnrhfZKQtFaQ+kytaRZ1ECllTDJr/QYSjspqA0Ss1BAsnTK2ZR7bK0N
         hcJAV0KOvCHwUh1XG3KP95RZpj5YQ0CdS844QPlthj2rKUy4rmwHpYjQJ+Bu/t2UAfIK
         9HqeujfRPkvhz875BxcEDkCfCUCUDSQIlaYZXUiMgnEJlueHaLKUJDplFR6DgxqBh6IC
         E9hZvO8BEfuZs4sIBdk+VnW53v/lNPMurYAgVNyGyrnLVN4+PIRnhN4wSFGz/26OXh2f
         L7rw==
X-Gm-Message-State: AOAM530LcyRli2/9s/be9ALRhLprruLLUudxj9Mn/HBPS5n/iAV+kdZI
        1JEZMhGK5IjJwtUhUefNh/Y=
X-Google-Smtp-Source: ABdhPJz+3FYb0vlsoBwsGqN15gEbC63jvqxk7dxSUOipeu2cUeO5/VB4TypAZM8vKCUZng5dwSUO5w==
X-Received: by 2002:a05:600c:4ec8:b0:38c:90fb:d3bf with SMTP id g8-20020a05600c4ec800b0038c90fbd3bfmr25380404wmq.0.1648465300738;
        Mon, 28 Mar 2022 04:01:40 -0700 (PDT)
Received: from [192.168.0.32] ([137.101.87.65])
        by smtp.gmail.com with ESMTPSA id b3-20020adfd1c3000000b00205820686dasm13960361wrd.5.2022.03.28.04.01.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Mar 2022 04:01:40 -0700 (PDT)
Message-ID: <3f786a4d-146f-f378-df19-6903727d27b7@gmail.com>
Date:   Mon, 28 Mar 2022 13:01:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 20/22] arm64: dts: mt8192: Add dsi node
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
 <20220318144534.17996-21-allen-kh.cheng@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220318144534.17996-21-allen-kh.cheng@mediatek.com>
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
> Add dsi ndoe for mt8192 SoC.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> ---
>   arch/arm64/boot/dts/mediatek/mt8192.dtsi | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> index 59183fb6c80b..08e0dd2483d1 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> @@ -13,6 +13,7 @@
>   #include <dt-bindings/pinctrl/mt8192-pinfunc.h>
>   #include <dt-bindings/phy/phy.h>
>   #include <dt-bindings/power/mt8192-power.h>
> +#include <dt-bindings/reset/mt8192-resets.h>
>   #include <dt-bindings/reset/ti-syscon.h>
>   
>   / {
> @@ -1203,6 +1204,7 @@
>   			compatible = "mediatek,mt8192-mmsys", "syscon";
>   			reg = <0 0x14000000 0 0x1000>;
>   			#clock-cells = <1>;
> +			#reset-cells = <1>;
>   		};
>   
>   		mutex: mutex@14001000 {
> @@ -1327,6 +1329,20 @@
>   			clocks = <&mmsys CLK_MM_DISP_DITHER0>;
>   		};
>   
> +		dsi0: dsi@14010000 {
> +			compatible = "mediatek,mt8183-dsi";
> +			reg = <0 0x14010000 0 0x1000>;
> +			interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clocks = <&mmsys CLK_MM_DSI0>,
> +				 <&mmsys CLK_MM_DSI_DSI0>,
> +				 <&mipi_tx0>;
> +			clock-names = "engine", "digital", "hs";
> +			resets = <&mmsys MT8192_MMSYS_SW0_RST_B_DISP_DSI0>;
> +			phys = <&mipi_tx0>;
> +			phy-names = "dphy";
> +			status = "disabled";

We are missing the output port node.

Regards,
Matthias

> +		};
> +
>   		ovl_2l2: ovl@14014000 {
>   			compatible = "mediatek,mt8192-disp-ovl-2l";
>   			reg = <0 0x14014000 0 0x1000>;
