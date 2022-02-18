Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EAF44BB9A3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 13:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235474AbiBRM4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 07:56:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235496AbiBRM4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 07:56:09 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D857A2B5217;
        Fri, 18 Feb 2022 04:55:47 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 36BB21F46724
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645188946;
        bh=gJeBHmxNUcShhM9B80s0rTYRD0AkGGRVSNN9sHVW228=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=nZVEQtNuhdxqtX/k3VDOxfsE8KyU+gqBGGFR9AuZaywEySAwrfK1XjW69cBFy/+FP
         DJi/qQQ5sNiFMyL0J1flBsGwIAjH+NHquG5GNN6zkkaDUdiG0inaKFUT2FqQulQoEC
         Lz0sURCnEvZbKNxDc0a72tFBqnNBnQqFMM40q2+82rSN7GkLK7jdLd4deDfI62aG1+
         NJgEhU0FBMt0niNPjhKyBzEqhwv2L8ELSrCN0bit/ErtfdQ7GhH9P3o06ArA3t+5Tc
         IZh7qR+pKgKUZYqNI2VSzIARTPUrQb3EjZZhZcR634njYq8UUitUoGOz3qBJMAJ0Up
         vv3hr6JQiPD8w==
Message-ID: <c84ec638-3134-fc1c-4761-7f1ec8381a39@collabora.com>
Date:   Fri, 18 Feb 2022 13:55:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2 09/23] arm64: dts: mt8192: Add infracfg_rst node
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        --to=Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>,
        Ryder Lee <ryder.lee@kernel.org>
References: <20220218091633.9368-1-allen-kh.cheng@mediatek.com>
 <20220218091633.9368-10-allen-kh.cheng@mediatek.com>
Content-Language: en-US
In-Reply-To: <20220218091633.9368-10-allen-kh.cheng@mediatek.com>
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
> add infracfg_rst node for mt8192 SoC.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>

For v3, please mention that you're adding simple-mfd to allow probing the
ti,syscon-reset node.

After the commit description fix:
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   arch/arm64/boot/dts/mediatek/mt8192.dtsi | 18 ++++++++++++++++--
>   1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> index f93fe3779161..a935a22babbb 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> @@ -12,6 +12,7 @@
>   #include <dt-bindings/pinctrl/mt8192-pinfunc.h>
>   #include <dt-bindings/phy/phy.h>
>   #include <dt-bindings/power/mt8192-power.h>
> +#include <dt-bindings/reset/ti-syscon.h>
>   
>   / {
>   	compatible = "mediatek,mt8192";
> @@ -267,10 +268,23 @@
>   			#clock-cells = <1>;
>   		};
>   
> -		infracfg: syscon@10001000 {
> -			compatible = "mediatek,mt8192-infracfg", "syscon";
> +		infracfg: infracfg@10001000 {
> +			compatible = "mediatek,mt8192-infracfg", "syscon", "simple-mfd";
>   			reg = <0 0x10001000 0 0x1000>;
>   			#clock-cells = <1>;
> +
> +			infracfg_rst: reset-controller {
> +				compatible = "ti,syscon-reset";
> +				#reset-cells = <1>;
> +
> +				ti,reset-bits = <
> +					0x120 0 0x124 0 0 0	(ASSERT_SET | DEASSERT_SET | STATUS_NONE) /* 0: lvts_ap */
> +					0x730 12 0x734 12 0 0	(ASSERT_SET | DEASSERT_SET | STATUS_NONE) /* 1: lvts_mcu */
> +					0x140 15 0x144 15 0 0	(ASSERT_SET | DEASSERT_SET | STATUS_NONE) /* 2: pcie phy */
> +					0x730 1 0x734 1 0 0	(ASSERT_SET | DEASSERT_SET | STATUS_NONE) /* 3: pcie top */
> +					0x150 5 0x154 5 0 0	(ASSERT_SET | DEASSERT_SET | STATUS_NONE) /* 4: svs */
> +				>;
> +			};
>   		};
>   
>   		pericfg: syscon@10003000 {



