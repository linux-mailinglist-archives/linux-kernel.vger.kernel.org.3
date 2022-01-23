Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC2354972A4
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 16:40:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237947AbiAWPkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 10:40:52 -0500
Received: from gloria.sntech.de ([185.11.138.130]:46986 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237925AbiAWPkv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 10:40:51 -0500
Received: from p508fcdea.dip0.t-ipconnect.de ([80.143.205.234] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nBez0-0005OB-Pp; Sun, 23 Jan 2022 16:40:46 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Frank Wunderlich <linux@fw-web.de>,
        linux-rockchip@lists.infradead.org
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Frank Wunderlich <frank-w@public-files.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Riesch <michael.riesch@wolfvision.net>
Subject: Re: [PATCH v1] arm64: dts: rk356x: fix dma-controller warning
Date:   Sun, 23 Jan 2022 16:40:44 +0100
Message-Id: <164295214820.418606.10641294516834022045.b4-ty@sntech.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220123133615.135789-1-linux@fw-web.de>
References: <20220123133615.135789-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Jan 2022 14:36:15 +0100, Frank Wunderlich wrote:
> DMA-Cotrollers defined in rk356x.dtsi do not match the pattern in bindings.
> 
> arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dt.yaml:
>   dmac@fe530000: $nodename:0: 'dmac@fe530000' does not match '^dma-controller(@.*)?$'
> 	From schema: Documentation/devicetree/bindings/dma/arm,pl330.yaml
> arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dt.yaml:
>   dmac@fe550000: $nodename:0: 'dmac@fe550000' does not match '^dma-controller(@.*)?$'
> 	From schema: Documentation/devicetree/bindings/dma/arm,pl330.yaml
> 
> [...]

Applied as fix for 5.17, thanks!

[1/1] arm64: dts: rk356x: fix dma-controller warning
      commit: 2ddd96aadbd0412040ef49eda94549c32de6c92c

I've adapted the subject to
    arm64: dts: rockchip: fix dma-controller node names on rk356x
though. Please use prefixes matching the subsystem
(i.e. arm64: dts: rockchip: ... in this case)

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
