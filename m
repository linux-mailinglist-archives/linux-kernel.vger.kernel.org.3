Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 865744820F3
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 01:13:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242362AbhLaAM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 19:12:57 -0500
Received: from gloria.sntech.de ([185.11.138.130]:48696 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240794AbhLaAM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 19:12:56 -0500
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1n35XK-0007No-QN; Fri, 31 Dec 2021 01:12:46 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Yifeng Zhao <yifeng.zhao@rock-chips.com>
Cc:     robh+dt@kernel.org, jbx6244@gmail.com, devicetree@vger.kernel.org,
        vkoul@kernel.org, michael.riesch@wolfvision.net,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, kishon@ti.com,
        p.zabel@pengutronix.de, cl@rock-chips.com,
        kever.yang@rock-chips.com, lee.jones@linaro.org,
        wulf@rock-chips.com, Yifeng Zhao <yifeng.zhao@rock-chips.com>
Subject: Re: [PATCH v7 1/4] dt-bindings: mfd: syscon: add naneng combo phy register compatible
Date:   Fri, 31 Dec 2021 01:12:45 +0100
Message-ID: <5585789.uSDJEYM7Em@diego>
In-Reply-To: <20211230084815.28110-2-yifeng.zhao@rock-chips.com>
References: <20211230084815.28110-1-yifeng.zhao@rock-chips.com> <20211230084815.28110-2-yifeng.zhao@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yifeng,

Am Donnerstag, 30. Dezember 2021, 09:48:12 CET schrieb Yifeng Zhao:
> From: Johan Jonker <jbx6244@gmail.com>
> 
> Add naneng combo phy register compatible.
> 
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> Signed-off-by: Yifeng Zhao <yifeng.zhao@rock-chips.com>
> ---
> 
> Changes in v7: None
> Changes in v5: None
> Changes in v4: None
> Changes in v3: None
> Changes in v2: None
> 
>  Documentation/devicetree/bindings/mfd/syscon.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
> index fdd96e378df0..e9bb96ab9446 100644
> --- a/Documentation/devicetree/bindings/mfd/syscon.yaml
> +++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
> @@ -52,6 +52,8 @@ properties:
>                - rockchip,rk3288-qos
>                - rockchip,rk3368-qos
>                - rockchip,rk3399-qos
> +              - rockchip,rk3568-pipe-grf
> +              - rockchip,rk3568-pipe-phy-grf

can you please move these to the grf.yaml as discussed in the previous
version.

Background is of course to keep all *-grf compatibles in the same file.

Thanks
Heiko


>                - rockchip,rk3568-qos
>                - samsung,exynos3-sysreg
>                - samsung,exynos4-sysreg
> 




