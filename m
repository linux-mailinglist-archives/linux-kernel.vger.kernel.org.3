Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA9552EF3B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 17:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350872AbiETPap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 11:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237360AbiETPam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 11:30:42 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 454FD163284;
        Fri, 20 May 2022 08:30:41 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id 39C971F465BE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653060640;
        bh=dmXpaV9RK7EYK65SYc1PAFlcJQ/aHD8qMN7i1zER+tw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VbyuiG1v+Mr9AKQMrqb8TVYlX4tVx7W+7mp5NVMkcvS7/CV2JBCyyMIhembjTUTyn
         +fgiKAhdfvgKszDd68j3idCylD1QNocFstG5dNF6NTIqAtyrQN4e/MQw54XJp9ZbWK
         LcyvU0i9eK7N664xdkRKg+W2NewfLLjDRwszIDtO7w1ABcHtRQM/Ko91NtJAxNeGXL
         FPztcYtRiMJrq7cK+fumdCIx84uxWK7f4f/ofJpvf6ODDOK8csLOIZubgIf9Dugeio
         f1rJfNYAZGff3BTfJT+DK4ApT76g9CObBvliJB/fpmhRZpKcyVau9C0ZIXQ4unJhDJ
         MA2b3jVHh+BpQ==
Date:   Fri, 20 May 2022 11:30:34 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, matthias.bgg@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        p.zabel@pengutronix.de, angelogioacchino.delregno@collabora.com,
        chun-jie.chen@mediatek.com, wenst@chromium.org,
        runyang.chen@mediatek.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v7 16/19] arm64: dts: mediatek: Add infra #reset-cells
 property for MT8195
Message-ID: <20220520153034.v4dvh4bn2pon6nnr@notapiano>
References: <20220519125527.18544-1-rex-bc.chen@mediatek.com>
 <20220519125527.18544-17-rex-bc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220519125527.18544-17-rex-bc.chen@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rex,

On Thu, May 19, 2022 at 08:55:24PM +0800, Rex-BC Chen wrote:
> We will use mediatek clock reset as infracfg_ao reset instead of
> ti-syscon. To support this, remove property of ti reset and add
> property of #reset-cells for mediatek clock reset.
> 
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8195.dtsi | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> index b57e620c2c72..8e5ac11b19f1 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> @@ -10,7 +10,6 @@
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/phy/phy.h>
>  #include <dt-bindings/pinctrl/mt8195-pinfunc.h>
> -#include <dt-bindings/reset/ti-syscon.h>
>  
>  / {
>  	compatible = "mediatek,mt8195";
> @@ -295,17 +294,7 @@
>  			compatible = "mediatek,mt8195-infracfg_ao", "syscon", "simple-mfd";

I believe the 'simple-mfd' compatible was added only to make the
reset-controller subnode probe (at least this was the case for mt8192), so it
might make sense to drop it here as well.

Thanks,
Nícolas

>  			reg = <0 0x10001000 0 0x1000>;
>  			#clock-cells = <1>;
> -
> -			infracfg_rst: reset-controller {
> -				compatible = "ti,syscon-reset";
> -				#reset-cells = <1>;
> -				ti,reset-bits = <
> -					0x140 18 0x144 18 0 0 (ASSERT_SET | DEASSERT_SET | STATUS_NONE) /* pcie */
> -					0x120 0  0x124 0  0 0 (ASSERT_SET | DEASSERT_SET | STATUS_NONE) /* thermal */
> -					0x730 10 0x734 10 0 0 (ASSERT_SET | DEASSERT_SET | STATUS_NONE) /* thermal */
> -					0x150 5  0x154 5  0 0 (ASSERT_SET | DEASSERT_SET | STATUS_NONE) /* svs gpu */
> -				>;
> -			};
> +			#reset-cells = <1>;
>  		};
>  
>  		pericfg: syscon@10003000 {
> -- 
> 2.18.0
> 
> 
