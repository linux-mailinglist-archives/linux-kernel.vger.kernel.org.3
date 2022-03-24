Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E81C4E681E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 18:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347419AbiCXRzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 13:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234287AbiCXRz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 13:55:27 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4416D849;
        Thu, 24 Mar 2022 10:53:54 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id p189so3198600wmp.3;
        Thu, 24 Mar 2022 10:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=TfVnUyN/hXuaNJUfYCszqrcV/Y41SovVpMRK9OnsasU=;
        b=IfV7WXPL3p6XHd58K5LzFWiySP6JIds58NsWE+OjifmBanhApG5VNoHIjRg3EiZ6oE
         q55n0/UVLf6fVQSeRo+NALJSfJCMDDf2fJKooTmVEYiOwQZNVxNl7WiQhH2ehRTmniD2
         KDb1fot0vbkdM/AH8tLvzyGI5hoGS2fOg9evQ3RbcQXRUdYog3vC88TdYOKRw1719H0A
         qWBde+evig3AheBAc7oNnF833Cx6d98Zp+j73DzmdXgGooo2GMf9RUUDKznvIpB4uz+O
         BsjLnIfjxhY71YXJYFtdGKhpXQu8k1oY7pIrHvs5zTPMrInUhcEveJLVOwSKQqm8qqO+
         eVEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TfVnUyN/hXuaNJUfYCszqrcV/Y41SovVpMRK9OnsasU=;
        b=fnAkc+zXKaCy1vZ6WUDf5ImGDuZoznMrqAbdcyQeo/caNCe+nekJaCYUC5fLgqsDNg
         a5fwEB57Yt07U1kGsnkPvw2PENMpM5ccLkB4+dQM5Ygyt5TImtWgGRM0k8sR16nzD/yl
         7bCHMKZO5jyYDjKTlisU43zuS1c3FW5JRCT1kybFy/+GDD9Vsp9wxky2fEJs9ndguOVi
         R/V1xtEMHDkpbIOL+tDwUAkFa8XvINTzGo1BgJE6czNfBnxy+v7KsdrxUsdv9lTv3wGF
         i2wuulc9ZBf5zFU4Sj54Y1yrqjM8mcA2Ec2EGOzh2xFPPCT875Js8RRCANojOALRGmAy
         bknA==
X-Gm-Message-State: AOAM53324AThyK28QSAzn+NcInvPoId4a2P3bXDrKx4zBaFk3N4iMYHO
        mvaimNltwu2x4EM4j8ttnNk=
X-Google-Smtp-Source: ABdhPJzFPTRXE56MSVLFfNGawg1yKq8+gZO3tliSVtZMhxzNCWb901NYb1XcroBFlWZ8yFguR6GipQ==
X-Received: by 2002:a05:600c:3b02:b0:38c:9148:70dc with SMTP id m2-20020a05600c3b0200b0038c914870dcmr5811612wms.104.1648144433529;
        Thu, 24 Mar 2022 10:53:53 -0700 (PDT)
Received: from [192.168.0.32] ([137.101.87.65])
        by smtp.gmail.com with ESMTPSA id v20-20020a7bcb54000000b0037fa63db8aasm6803998wmj.5.2022.03.24.10.53.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Mar 2022 10:53:53 -0700 (PDT)
Message-ID: <90324c6f-e3ef-5b18-8779-8a11ca67039b@gmail.com>
Date:   Thu, 24 Mar 2022 18:53:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 12/22] arm64: dts: mt8192: Add mmc device nodes
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
 <20220318144534.17996-13-allen-kh.cheng@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220318144534.17996-13-allen-kh.cheng@mediatek.com>
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
> Add mmc nodes for mt8192 SoC.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>   arch/arm64/boot/dts/mediatek/mt8192.dtsi | 34 +++++++++++++++++++++---
>   1 file changed, 30 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> index 6220d6962f58..2648f2847993 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> @@ -1150,10 +1150,36 @@
>   			#clock-cells = <1>;
>   		};
>   
> -		msdc: clock-controller@11f60000 {
> -			compatible = "mediatek,mt8192-msdc";
> -			reg = <0 0x11f60000 0 0x1000>;
> -			#clock-cells = <1>;

We don't need the msdc_axi_wrap clock and that's why we delete the node, 
correct? In that case we could only disable the node, as DTS should describe the 
HW as it is. Please also add a line in the commit message explaining that.

Regards,
Matthias

> +		mmc0: mmc@11f60000 {
> +			compatible = "mediatek,mt8192-mmc", "mediatek,mt8183-mmc";
> +			reg = <0 0x11f60000 0 0x1000>, <0 0x11f50000 0 0x1000>;
> +			interrupts = <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clocks = <&topckgen CLK_TOP_MSDC50_0_SEL>,
> +				 <&msdc_top CLK_MSDC_TOP_H_MST_0P>,
> +				 <&msdc_top CLK_MSDC_TOP_SRC_0P>,
> +				 <&msdc_top CLK_MSDC_TOP_P_CFG>,
> +				 <&msdc_top CLK_MSDC_TOP_P_MSDC0>,
> +				 <&msdc_top CLK_MSDC_TOP_AXI>,
> +				 <&msdc_top CLK_MSDC_TOP_AHB2AXI_BRG_AXI>;
> +			clock-names = "source", "hclk", "source_cg", "sys_cg",
> +				      "pclk_cg", "axi_cg", "ahb_cg";
> +			status = "disabled";
> +		};
> +
> +		mmc1: mmc@11f70000 {
> +			compatible = "mediatek,mt8192-mmc", "mediatek,mt8183-mmc";
> +			reg = <0 0x11f70000 0 0x1000>, <0 0x11c70000 0 0x1000>;
> +			interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clocks = <&topckgen CLK_TOP_MSDC30_1_SEL>,
> +				 <&msdc_top CLK_MSDC_TOP_H_MST_1P>,
> +				 <&msdc_top CLK_MSDC_TOP_SRC_1P>,
> +				 <&msdc_top CLK_MSDC_TOP_P_CFG>,
> +				 <&msdc_top CLK_MSDC_TOP_P_MSDC1>,
> +				 <&msdc_top CLK_MSDC_TOP_AXI>,
> +				 <&msdc_top CLK_MSDC_TOP_AHB2AXI_BRG_AXI>;
> +			clock-names = "source", "hclk", "source_cg", "sys_cg",
> +				      "pclk_cg", "axi_cg", "ahb_cg";
> +			status = "disabled";
>   		};
>   
>   		mfgcfg: clock-controller@13fbf000 {
