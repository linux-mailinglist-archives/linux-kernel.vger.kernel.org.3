Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84D1C4972A8
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 16:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237971AbiAWPk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 10:40:58 -0500
Received: from gloria.sntech.de ([185.11.138.130]:46996 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237934AbiAWPkw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 10:40:52 -0500
Received: from p508fcdea.dip0.t-ipconnect.de ([80.143.205.234] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nBez1-0005OB-3z; Sun, 23 Jan 2022 16:40:47 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Frank Wunderlich <linux@fw-web.de>,
        linux-rockchip@lists.infradead.org
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Peter Geis <pgwipeout@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Riesch <michael.riesch@wolfvision.net>
Subject: Re: [PATCH v2] arm64: dts: rk3568: drop pclk_xpcs from gmac0
Date:   Sun, 23 Jan 2022 16:40:45 +0100
Message-Id: <164295214820.418606.1356481887548959776.b4-ty@sntech.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220123133510.135651-1-linux@fw-web.de>
References: <20220123133510.135651-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Jan 2022 14:35:10 +0100, Frank Wunderlich wrote:
> pclk_xpcs is not supported by mainline driver and breaks dtbs_check
> 
> following warnings occour, and many more
> 
> rk3568-evb1-v10.dt.yaml: ethernet@fe2a0000: clocks:
>     [[15, 386], [15, 389], [15, 389], [15, 184], [15, 180], [15, 181],
>     [15, 389], [15, 185], [15, 172]] is too long
> 	From schema: Documentation/devicetree/bindings/net/snps,dwmac.yaml
> rk3568-evb1-v10.dt.yaml: ethernet@fe2a0000: clock-names:
>     ['stmmaceth', 'mac_clk_rx', 'mac_clk_tx', 'clk_mac_refout', 'aclk_mac',
>     'pclk_mac', 'clk_mac_speed', 'ptp_ref', 'pclk_xpcs'] is too long
> 	From schema: Documentation/devicetree/bindings/net/snps,dwmac.yaml
> 
> [...]

Applied as fix for 5.17, thanks!

[1/1] arm64: dts: rk3568: drop pclk_xpcs from gmac0
      commit: 85a8bccfa945680dc561f06b65ea01341d2033fc

I've adapted the subject to
    arm64: dts: rockchip: drop pclk_xpcs from gmac0 on rk3568
though. Please use prefixes matching the subsystem
(i.e. arm64: dts: rockchip: ... in this case)


Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
