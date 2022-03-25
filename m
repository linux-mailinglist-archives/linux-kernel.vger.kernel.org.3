Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F45D4E71B9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 11:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352985AbiCYLAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 07:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243420AbiCYLAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 07:00:36 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B673454FAB;
        Fri, 25 Mar 2022 03:59:01 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id h4so10317018wrc.13;
        Fri, 25 Mar 2022 03:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Sbm++pREB8Tn7aftqpmOypQULO34T527DsluYOX/zIk=;
        b=LzGpqax5QidHzHeYIQEWQbQyUn9d07FrbjwozhZFzWpfFwce15G9/6iMT2WrcNXJ9N
         80p5EhTnbO/RC0GA7F3urnpHXTre+gJwcj7flcqBubmz1+XYRa1VpBDhsTe0gnW3h1hy
         xbvYgfTq7rq0BtOfP7wDJcxenKW8oEb9KcZYL4X1KVX/Vyto48qTAdNfXvLBFQIsIxLE
         i2UFsf4Lt58lJPgY/U3zy/5fJXoz68mzc7G/bbWQ4UlkmujfrXdZKzkusNuIMvfMz/eN
         9NZkNkqaJVBVa7J8HjzTnLGk0UX5PqFWa6Zd/dUGTpU0j4Wq5yu/Hpc5tEM2iQB/7ifM
         TLfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Sbm++pREB8Tn7aftqpmOypQULO34T527DsluYOX/zIk=;
        b=VLF9vsLZLSh33fl1LqudzWI12i61fAgFKCc+tBPNKdhy2C2di0SIjJZCI1pOYmLZVk
         0br4hD+x/2Rf27BQrLhGXMC6FCmvKtPSgYiEKzHzjSFiY+hvW3EOLQl0BE1asuYEMRpc
         nXWc1KCqnHkerNzWRAZZVNCukr++H7N4Q3HAdIUO6RbGihv/ebK42qahbZW017/wHgcu
         YhiZS03R/mR/s1GQ61c0LY/PP/qYCrBeFxl7VTc9iS0lUJ/osuQbHSuOETphdBqlgl6c
         vF54TKLY4JlqMrXrJv1khcnZECkTY7tcFQvIV6HafGo8idly7oG0gtBBnfU4cs5r9Gi5
         NALg==
X-Gm-Message-State: AOAM530FSfluKQjhI0v63B5bqCLxOuDJmR8lBfBZMLcZ5KW0UL0/l/Kr
        l/0zyLjwNNs5Lb4ADtk2p7EY6qBACGra8g==
X-Google-Smtp-Source: ABdhPJy7/c1QRMbbo2B936mq1qYK5pOMrX601vD69gDJnL6GFoLc7CE48qzhP96WX0Cq0Wvi4+zb2A==
X-Received: by 2002:adf:e6ce:0:b0:203:d9cb:a1b4 with SMTP id y14-20020adfe6ce000000b00203d9cba1b4mr8831281wrm.140.1648205940078;
        Fri, 25 Mar 2022 03:59:00 -0700 (PDT)
Received: from [192.168.1.145] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id l20-20020a05600c1d1400b0038cba2f88c0sm9548069wms.26.2022.03.25.03.58.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 03:58:59 -0700 (PDT)
Message-ID: <2ef7d715-8b1f-8264-819d-6eb55beb773c@gmail.com>
Date:   Fri, 25 Mar 2022 11:58:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 14/22] arm64: dts: mt8192: Add m4u and smi nodes
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
 <20220318144534.17996-15-allen-kh.cheng@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220318144534.17996-15-allen-kh.cheng@mediatek.com>
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



On 18/03/2022 15:45, Allen-KH Cheng wrote:
> Add m4u and smi nodes for mt8192 SoC
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Applied thanks

> ---
>   arch/arm64/boot/dts/mediatek/mt8192.dtsi | 190 +++++++++++++++++++++++
>   1 file changed, 190 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> index 6b769fa5b427..4addf6ddd86d 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> @@ -9,6 +9,7 @@
>   #include <dt-bindings/gce/mt8192-gce.h>
>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>   #include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/memory/mt8192-larb-port.h>
>   #include <dt-bindings/pinctrl/mt8192-pinfunc.h>
>   #include <dt-bindings/phy/phy.h>
>   #include <dt-bindings/power/mt8192-power.h>
> @@ -1204,24 +1205,114 @@
>   			#clock-cells = <1>;
>   		};
>   
> +		smi_common: smi@14002000 {
> +			compatible = "mediatek,mt8192-smi-common";
> +			reg = <0 0x14002000 0 0x1000>;
> +			clocks = <&mmsys CLK_MM_SMI_COMMON>,
> +				 <&mmsys CLK_MM_SMI_INFRA>,
> +				 <&mmsys CLK_MM_SMI_GALS>,
> +				 <&mmsys CLK_MM_SMI_GALS>;
> +			clock-names = "apb", "smi", "gals0", "gals1";
> +			power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
> +		};
> +
> +		larb0: larb@14003000 {
> +			compatible = "mediatek,mt8192-smi-larb";
> +			reg = <0 0x14003000 0 0x1000>;
> +			mediatek,larb-id = <0>;
> +			mediatek,smi = <&smi_common>;
> +			clocks = <&clk26m>, <&clk26m>;
> +			clock-names = "apb", "smi";
> +			power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
> +		};
> +
> +		larb1: larb@14004000 {
> +			compatible = "mediatek,mt8192-smi-larb";
> +			reg = <0 0x14004000 0 0x1000>;
> +			mediatek,larb-id = <1>;
> +			mediatek,smi = <&smi_common>;
> +			clocks = <&clk26m>, <&clk26m>;
> +			clock-names = "apb", "smi";
> +			power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
> +		};
> +
> +		iommu0: m4u@1401d000 {
> +			compatible = "mediatek,mt8192-m4u";
> +			reg = <0 0x1401d000 0 0x1000>;
> +			mediatek,larbs = <&larb0>, <&larb1>, <&larb2>,
> +					 <&larb4>, <&larb5>, <&larb7>,
> +					 <&larb9>, <&larb11>, <&larb13>,
> +					 <&larb14>, <&larb16>, <&larb17>,
> +					 <&larb18>, <&larb19>, <&larb20>;
> +			interrupts = <GIC_SPI 277 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clocks = <&mmsys CLK_MM_SMI_IOMMU>;
> +			clock-names = "bclk";
> +			power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
> +			#iommu-cells = <1>;
> +		};
> +
>   		imgsys: clock-controller@15020000 {
>   			compatible = "mediatek,mt8192-imgsys";
>   			reg = <0 0x15020000 0 0x1000>;
>   			#clock-cells = <1>;
>   		};
>   
> +		larb9: larb@1502e000 {
> +			compatible = "mediatek,mt8192-smi-larb";
> +			reg = <0 0x1502e000 0 0x1000>;
> +			mediatek,larb-id = <9>;
> +			mediatek,smi = <&smi_common>;
> +			clocks = <&imgsys CLK_IMG_LARB9>,
> +				 <&imgsys CLK_IMG_LARB9>;
> +			clock-names = "apb", "smi";
> +			power-domains = <&spm MT8192_POWER_DOMAIN_ISP>;
> +		};
> +
>   		imgsys2: clock-controller@15820000 {
>   			compatible = "mediatek,mt8192-imgsys2";
>   			reg = <0 0x15820000 0 0x1000>;
>   			#clock-cells = <1>;
>   		};
>   
> +		larb11: larb@1582e000 {
> +			compatible = "mediatek,mt8192-smi-larb";
> +			reg = <0 0x1582e000 0 0x1000>;
> +			mediatek,larb-id = <11>;
> +			mediatek,smi = <&smi_common>;
> +			clocks = <&imgsys2 CLK_IMG2_LARB11>,
> +				 <&imgsys2 CLK_IMG2_LARB11>;
> +			clock-names = "apb", "smi";
> +			power-domains = <&spm MT8192_POWER_DOMAIN_ISP2>;
> +		};
> +
> +		larb5: larb@1600d000 {
> +			compatible = "mediatek,mt8192-smi-larb";
> +			reg = <0 0x1600d000 0 0x1000>;
> +			mediatek,larb-id = <5>;
> +			mediatek,smi = <&smi_common>;
> +			clocks = <&vdecsys_soc CLK_VDEC_SOC_LARB1>,
> +				 <&vdecsys_soc CLK_VDEC_SOC_LARB1>;
> +			clock-names = "apb", "smi";
> +			power-domains = <&spm MT8192_POWER_DOMAIN_VDEC>;
> +		};
> +
>   		vdecsys_soc: clock-controller@1600f000 {
>   			compatible = "mediatek,mt8192-vdecsys_soc";
>   			reg = <0 0x1600f000 0 0x1000>;
>   			#clock-cells = <1>;
>   		};
>   
> +		larb4: larb@1602e000 {
> +			compatible = "mediatek,mt8192-smi-larb";
> +			reg = <0 0x1602e000 0 0x1000>;
> +			mediatek,larb-id = <4>;
> +			mediatek,smi = <&smi_common>;
> +			clocks = <&vdecsys CLK_VDEC_SOC_LARB1>,
> +				 <&vdecsys CLK_VDEC_SOC_LARB1>;
> +			clock-names = "apb", "smi";
> +			power-domains = <&spm MT8192_POWER_DOMAIN_VDEC2>;
> +		};
> +
>   		vdecsys: clock-controller@1602f000 {
>   			compatible = "mediatek,mt8192-vdecsys";
>   			reg = <0 0x1602f000 0 0x1000>;
> @@ -1234,12 +1325,78 @@
>   			#clock-cells = <1>;
>   		};
>   
> +		larb7: larb@17010000 {
> +			compatible = "mediatek,mt8192-smi-larb";
> +			reg = <0 0x17010000 0 0x1000>;
> +			mediatek,larb-id = <7>;
> +			mediatek,smi = <&smi_common>;
> +			clocks = <&vencsys CLK_VENC_SET0_LARB>,
> +				 <&vencsys CLK_VENC_SET1_VENC>;
> +			clock-names = "apb", "smi";
> +			power-domains = <&spm MT8192_POWER_DOMAIN_VENC>;
> +		};
> +
>   		camsys: clock-controller@1a000000 {
>   			compatible = "mediatek,mt8192-camsys";
>   			reg = <0 0x1a000000 0 0x1000>;
>   			#clock-cells = <1>;
>   		};
>   
> +		larb13: larb@1a001000 {
> +			compatible = "mediatek,mt8192-smi-larb";
> +			reg = <0 0x1a001000 0 0x1000>;
> +			mediatek,larb-id = <13>;
> +			mediatek,smi = <&smi_common>;
> +			clocks = <&camsys CLK_CAM_CAM>,
> +				 <&camsys CLK_CAM_LARB13>;
> +			clock-names = "apb", "smi";
> +			power-domains = <&spm MT8192_POWER_DOMAIN_CAM>;
> +		};
> +
> +		larb14: larb@1a002000 {
> +			compatible = "mediatek,mt8192-smi-larb";
> +			reg = <0 0x1a002000 0 0x1000>;
> +			mediatek,larb-id = <14>;
> +			mediatek,smi = <&smi_common>;
> +			clocks = <&camsys CLK_CAM_CAM>,
> +				 <&camsys CLK_CAM_LARB14>;
> +			clock-names = "apb", "smi";
> +			power-domains = <&spm MT8192_POWER_DOMAIN_CAM>;
> +		};
> +
> +		larb16: larb@1a00f000 {
> +			compatible = "mediatek,mt8192-smi-larb";
> +			reg = <0 0x1a00f000 0 0x1000>;
> +			mediatek,larb-id = <16>;
> +			mediatek,smi = <&smi_common>;
> +			clocks = <&camsys_rawa CLK_CAM_RAWA_CAM>,
> +				 <&camsys_rawa CLK_CAM_RAWA_LARBX>;
> +			clock-names = "apb", "smi";
> +			power-domains = <&spm MT8192_POWER_DOMAIN_CAM_RAWA>;
> +		};
> +
> +		larb17: larb@1a010000 {
> +			compatible = "mediatek,mt8192-smi-larb";
> +			reg = <0 0x1a010000 0 0x1000>;
> +			mediatek,larb-id = <17>;
> +			mediatek,smi = <&smi_common>;
> +			clocks = <&camsys_rawb CLK_CAM_RAWB_CAM>,
> +				 <&camsys_rawb CLK_CAM_RAWB_LARBX>;
> +			clock-names = "apb", "smi";
> +			power-domains = <&spm MT8192_POWER_DOMAIN_CAM_RAWB>;
> +		};
> +
> +		larb18: larb@1a011000 {
> +			compatible = "mediatek,mt8192-smi-larb";
> +			reg = <0 0x1a011000 0 0x1000>;
> +			mediatek,larb-id = <18>;
> +			mediatek,smi = <&smi_common>;
> +			clocks = <&camsys_rawc CLK_CAM_RAWC_LARBX>,
> +				 <&camsys_rawc CLK_CAM_RAWC_CAM>;
> +			clock-names = "apb", "smi";
> +			power-domains = <&spm MT8192_POWER_DOMAIN_CAM_RAWC>;
> +		};
> +
>   		camsys_rawa: clock-controller@1a04f000 {
>   			compatible = "mediatek,mt8192-camsys_rawa";
>   			reg = <0 0x1a04f000 0 0x1000>;
> @@ -1264,10 +1421,43 @@
>   			#clock-cells = <1>;
>   		};
>   
> +		larb20: larb@1b00f000 {
> +			compatible = "mediatek,mt8192-smi-larb";
> +			reg = <0 0x1b00f000 0 0x1000>;
> +			mediatek,larb-id = <20>;
> +			mediatek,smi = <&smi_common>;
> +			clocks = <&ipesys CLK_IPE_SMI_SUBCOM>,
> +				 <&ipesys CLK_IPE_LARB20>;
> +			clock-names = "apb", "smi";
> +			power-domains = <&spm MT8192_POWER_DOMAIN_IPE>;
> +		};
> +
> +		larb19: larb@1b10f000 {
> +			compatible = "mediatek,mt8192-smi-larb";
> +			reg = <0 0x1b10f000 0 0x1000>;
> +			mediatek,larb-id = <19>;
> +			mediatek,smi = <&smi_common>;
> +			clocks = <&ipesys CLK_IPE_SMI_SUBCOM>,
> +				 <&ipesys CLK_IPE_LARB19>;
> +			clock-names = "apb", "smi";
> +			power-domains = <&spm MT8192_POWER_DOMAIN_IPE>;
> +		};
> +
>   		mdpsys: clock-controller@1f000000 {
>   			compatible = "mediatek,mt8192-mdpsys";
>   			reg = <0 0x1f000000 0 0x1000>;
>   			#clock-cells = <1>;
>   		};
> +
> +		larb2: larb@1f002000 {
> +			compatible = "mediatek,mt8192-smi-larb";
> +			reg = <0 0x1f002000 0 0x1000>;
> +			mediatek,larb-id = <2>;
> +			mediatek,smi = <&smi_common>;
> +			clocks = <&mdpsys CLK_MDP_SMI0>,
> +				 <&mdpsys CLK_MDP_SMI0>;
> +			clock-names = "apb", "smi";
> +			power-domains = <&spm MT8192_POWER_DOMAIN_MDP>;
> +		};
>   	};
>   };
