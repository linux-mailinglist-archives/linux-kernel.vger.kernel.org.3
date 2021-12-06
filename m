Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF1FC46A19F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 17:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbhLFQrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 11:47:45 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:52826 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbhLFQro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 11:47:44 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id 662451F44A89
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1638809054; bh=ufMGzqUKc1mGqbbGMtqGtAVoPTm0PrwEkwUigbsiWY0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kGwUZsG9ZmN6Mrdube3jPYJgM7ujw1upKTTelviEXnpaNU7H5RobrlpF/PHOv3Ri9
         MshRGVw+rpAjAMaCO3iDXo6JQdKqGtReYineNQvDZ1DnqCfkpfDhxsjke720/vhRZq
         NR4kzR1ZUr9ZvNs17oQf7zICtoCMcVFLYZ+HVLyH8qs4BXBwkSdZ62okpUTgIisnKt
         paswEhNyF1T9Kjl57r5vGjOf4GPAoJywy9ammZLuxUVTyh/rg29n6JxK8dtuk9GP+q
         5GUUXC9qqp+ORk5C/wf7jkX7lTjRxCDQqWJFkygb3sWaCCMI39g6gF4oufPiPGUFOM
         Wz0hrLAE2KkrQ==
Date:   Mon, 6 Dec 2021 11:44:09 -0500
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Chun-Jie Chen <chun-jie.chen@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [v1 2/5] arm64: dts: mediatek: Correct UART clock of MT8192
Message-ID: <20211206164409.oua5i77odmzmaqfs@notapiano>
References: <20210825011120.30481-1-chun-jie.chen@mediatek.com>
 <20210825011120.30481-3-chun-jie.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210825011120.30481-3-chun-jie.chen@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Aug 25, 2021 at 09:11:17AM +0800, Chun-Jie Chen wrote:
> update uart0 and uart1 bus clock to the real one.

With the same commit message improvement from patch 1:

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Thanks,
Nícolas

> 
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8192.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> index 2b63d2ea6cb6..31d135e18784 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> @@ -327,7 +327,7 @@
>  				     "mediatek,mt6577-uart";
>  			reg = <0 0x11002000 0 0x1000>;
>  			interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH 0>;
> -			clocks = <&clk26m>, <&clk26m>;
> +			clocks = <&clk26m>, <&infracfg CLK_INFRA_UART0>;
>  			clock-names = "baud", "bus";
>  			status = "disabled";
>  		};
> @@ -337,7 +337,7 @@
>  				     "mediatek,mt6577-uart";
>  			reg = <0 0x11003000 0 0x1000>;
>  			interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH 0>;
> -			clocks = <&clk26m>, <&clk26m>;
> +			clocks = <&clk26m>, <&infracfg CLK_INFRA_UART1>;
>  			clock-names = "baud", "bus";
>  			status = "disabled";
>  		};
> -- 
> 2.18.0
> 
> 
