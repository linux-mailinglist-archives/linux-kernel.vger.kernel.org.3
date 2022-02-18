Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1A8D4BB989
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 13:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235380AbiBRMzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 07:55:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235382AbiBRMzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 07:55:49 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE222B4D88;
        Fri, 18 Feb 2022 04:55:21 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 07B791F46724
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645188915;
        bh=Tpe2RPwvbdCojJ6DWrGoQuw8qWJegr0r7DlDrw/eAPk=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=BOWv9ZVUqUaglIggPkiRNn+3+u/HWW0z7myKhXZ2wmX8NSgYTYnonZ7n1U8zAt2ox
         eSEiSdSF+HjFhaQo8rdhdFgzKZPxIHJ8cugi/wS3e7fW8hQ3giP91irMtWg+o65iNZ
         9KZ6ZH4S5g5eGfN/nZjT4qCkleGoMN+iW0OOqvp9oR46xU7PcF2n2F6TkcBiV3Ez4q
         bz3MNL1QIZik43JPuB3BxVL55/aF6iOpp+/ZTkrCfcLmttKI2txBThKwNe4YuNyWXM
         N3nhIr3iuDEeBHcB+GiTM+lw3jxDnsunAaqHjq+O7liLrzhnckFpxEBISQQD6CEkcF
         +Mqi1YtJ4gqEA==
Message-ID: <932bb7da-fc2e-4562-a0fc-308a7c19343e@collabora.com>
Date:   Fri, 18 Feb 2022 13:55:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2 05/23] arm64: dts: mt8192: Add SCP node
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        --to=Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>,
        Ryder Lee <ryder.lee@kernel.org>,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
References: <20220218091633.9368-1-allen-kh.cheng@mediatek.com>
 <20220218091633.9368-6-allen-kh.cheng@mediatek.com>
Content-Language: en-US
In-Reply-To: <20220218091633.9368-6-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 18/02/22 10:16, Allen-KH Cheng ha scritto:
> Add SCP node for mt8192 SoC.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> ---
>   arch/arm64/boot/dts/mediatek/mt8192.dtsi | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> index f92d8d7afa5d..61aadd7bd397 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> @@ -706,6 +706,18 @@
>   			status = "disabled";
>   		};
>   
> +		scp: scp@10500000 {
> +			compatible = "mediatek,mt8192-scp";
> +			reg = <0 0x10500000 0 0x100000>,
> +			    <0 0x10700000 0 0x8000>,
> +			    <0 0x10720000 0 0xe0000>;

Please fix indentation:
			reg = <0 0x10500000 0 0x100000>,
			      <0 0x10700000 0 0x8000>,
			      <0 0x10720000 0 0xe0000>;



> +			reg-names = "sram", "l1tcm", "cfg";
> +			interrupts = <GIC_SPI 435 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clocks = <&infracfg CLK_INFRA_SCPSYS>;
> +			clock-names = "main";
> +			status = "disabled";
> +		};
> +
>   		nor_flash: spi@11234000 {
>   			compatible = "mediatek,mt8192-nor";
>   			reg = <0 0x11234000 0 0xe0>;



