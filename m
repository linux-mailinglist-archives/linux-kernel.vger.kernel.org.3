Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45248480562
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 01:48:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234215AbhL1Ash (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 19:48:37 -0500
Received: from gloria.sntech.de ([185.11.138.130]:35058 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230257AbhL1Asg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 19:48:36 -0500
Received: from p57b77d8b.dip0.t-ipconnect.de ([87.183.125.139] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1n20fE-0001p0-SA; Tue, 28 Dec 2021 01:48:28 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Johan Jonker <jbx6244@gmail.com>,
        Ondrej Jirman <megous@megous.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        linux-rockchip@lists.infradead.org, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v3 0/8] phy-rockchip-inno-usb2: support rk356x usb2phy
Date:   Tue, 28 Dec 2021 01:48:27 +0100
Message-Id: <164065249086.1985132.4031278620113773485.b4-ty@sntech.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211215210252.120923-1-pgwipeout@gmail.com>
References: <20211215210252.120923-1-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Dec 2021 16:02:44 -0500, Peter Geis wrote:
> Good Afternoon,
> 
> This is my series to support the usb2 phy devices on the rk356x.
> The rk356x phy has a single muxed interrupt and has moved the usb2phy
> nodes out of the grf and into their own nodes.
> The phy needs to tie back into the grf for register control, similar to
> the rv1108.
> By moving the phys into their own nodes, they now have full
> #address_cells = 2 register addresses, but they still reside below the 32bit
> mmio range.
> 
> [...]

Applied, thanks!

[1/8] dt-bindings: soc: rockchip: add rk3568-usb2phy-grf
      commit: 0c8662341dfdda1e0a59692e4d78ecb087f09da1
[7/8] arm64: dts: rockchip: add usb2 nodes to rk3568 device tree
      commit: cca4da59db28cdd284d34835be9f109f37bf0803
[8/8] arm64: dts: rockchip: add Quartz64-A usb2 support
      commit: 80d44c01e56943fcf9d0b5267ccfaa9487ac8067

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
