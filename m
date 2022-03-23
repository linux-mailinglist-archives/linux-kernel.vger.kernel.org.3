Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78B534E573E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 18:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241132AbiCWRSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 13:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233723AbiCWRSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 13:18:08 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8EDA7A99E;
        Wed, 23 Mar 2022 10:16:38 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id r190-20020a1c2bc7000000b0038a1013241dso1303407wmr.1;
        Wed, 23 Mar 2022 10:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=hkH0tUK7Ab/Z/SHkXKztrJgwmG4XsuWqH85qdLpELtM=;
        b=ct1V0Qqkvy2GvMt2u3pbPt44uLlr+I0rPDIPx0znmRRnHXn0+brP+ZiDXqkKiHZHC5
         taihcJNjpeyfyaKImanxNodfcVtuKnxE0hOol4jRG8SvEWanwNCNl4YWeDe7ppHT3/MF
         f9gnUXYOpn2GDZX9lQ8tuRH+dE+8PvgtH3XUvoc1zpqbVj17lMDIrDYOdU1L3qeeOfA3
         4OpxMGHQK0mG9sBU7Tx2UQVsLvYqNJkEQHpPlOVMMO6fvOTtr6XfsL57PRFsXGp1SmbA
         hRcIeiOpq33nR03iIwhMyv3O9y6rc71NK6CHhwZMqs6QoJQ3alHktNanm/0zcl50llu9
         BT4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hkH0tUK7Ab/Z/SHkXKztrJgwmG4XsuWqH85qdLpELtM=;
        b=Pnq7nDCKFgS/y/upsKJ+YXqpkSLSgDuydk+3ooeIVua6g4WEZoEquWxjqqzFVt9BhO
         zrM3uvTXouVgQwkzJvbDh+68/zlsVKkgKC8gR5REUtf8LEwaHifJdSYUf/jH8nHTNA/n
         FJLiLhhK7uv5MgfzgSvIQw8s5BYA0C0/XT0mZcujBZXiAGpCpaVs4rh6j0TsiW46pfTr
         ggUHZqiwaXaTby7QeccHSH32Y5yjCB5dXK0fdhAIkTV5Gfxdnjwghx8zHfd1JnrmteGu
         Cde2omq9LQ4Pjj2kSrzF6UbRkTbRf9azgcCEl2poEnWdr3bqAeYzMVAnm8AaIz3cPckf
         F4qQ==
X-Gm-Message-State: AOAM532XDf8bq1yjDcyqD/861fA003LHJROLG5T7jE56aDC2fHXeG2Pr
        6sSRl2YNiGW8oY91QJwaXe8=
X-Google-Smtp-Source: ABdhPJzMjlLcvGg/anxatVCB8sDCZ0HTUpMJqgQHEpIoSduFVctpxRURpT1yhVlix6oTzQh9Xw0fCA==
X-Received: by 2002:a7b:ce02:0:b0:381:2007:f75c with SMTP id m2-20020a7bce02000000b003812007f75cmr10735674wmc.6.1648055797230;
        Wed, 23 Mar 2022 10:16:37 -0700 (PDT)
Received: from [192.168.0.32] ([137.101.87.65])
        by smtp.gmail.com with ESMTPSA id l15-20020a05600c4f0f00b0038cbdf5221dsm3336331wmq.41.2022.03.23.10.16.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Mar 2022 10:16:36 -0700 (PDT)
Message-ID: <8e482005-8f44-3502-3bca-0824f3e2dd7a@gmail.com>
Date:   Wed, 23 Mar 2022 18:16:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 02/22] arm64: dts: mt8192: Add spmi node
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
 <20220318144534.17996-3-allen-kh.cheng@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220318144534.17996-3-allen-kh.cheng@mediatek.com>
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
> Add spmi node for mt8192 SoC.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>   arch/arm64/boot/dts/mediatek/mt8192.dtsi | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> index 76428599444e..0f9f211ca986 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> @@ -535,6 +535,23 @@
>   			assigned-clock-parents = <&topckgen CLK_TOP_OSC_D10>;
>   		};
>   
> +		spmi: spmi@10027000 {
> +			compatible = "mediatek,mt6873-spmi";
> +			reg = <0 0x10027000 0 0x000e00>,
> +			      <0 0x10029000 0 0x000100>;
> +			reg-names = "pmif", "spmimst";
> +			clocks = <&infracfg CLK_INFRA_PMIC_AP>,
> +				 <&infracfg CLK_INFRA_PMIC_TMR>,
> +				 <&topckgen CLK_TOP_SPMI_MST_SEL>;
> +			clock-names = "pmif_sys_ck",
> +				      "pmif_tmr_ck",
> +				      "spmimst_clk_mux";
> +			assigned-clocks = <&topckgen CLK_TOP_PWRAP_ULPOSC_SEL>;
> +			assigned-clock-parents = <&topckgen CLK_TOP_OSC_D10>;
> +			#address-cells = <2>;
> +			#size-cells = <0>;

What do we need the address-cells and size-cells for?

Regards,
Matthias

> +		};
> +
>   		scp_adsp: clock-controller@10720000 {
>   			compatible = "mediatek,mt8192-scp_adsp";
>   			reg = <0 0x10720000 0 0x1000>;
