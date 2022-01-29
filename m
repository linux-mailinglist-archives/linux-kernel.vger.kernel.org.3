Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9124A313D
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 18:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346268AbiA2R5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 12:57:41 -0500
Received: from gloria.sntech.de ([185.11.138.130]:48998 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229895AbiA2R5i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 12:57:38 -0500
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nDryi-0005eg-Pg; Sat, 29 Jan 2022 18:57:36 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Michael Riesch <michael.riesch@wolfvision.net>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Liang Chen <cl@rock-chips.com>, sha@pengutronix.de
Subject: Re: [PATCH 1/2] arm64: dts: rockchip: fix vcc3v3_lcd{0,1}_n regulators in rk3568-evb1-10
Date:   Sat, 29 Jan 2022 18:57:38 +0100
Message-Id: <164347899463.1472860.17650444631712126787.b4-ty@sntech.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220129162440.5415-1-michael.riesch@wolfvision.net>
References: <20220129162440.5415-1-michael.riesch@wolfvision.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Jan 2022 17:24:39 +0100, Michael Riesch wrote:
> The voltages VCC3V3_LCD{0,1} can be enabled with the pins GPIO0_C7 and
> GPIO0_C5, respectively. This patch modifies the device tree in order to
> reflect this.

Applied, thanks!

[1/2] arm64: dts: rockchip: fix vcc3v3_lcd{0,1}_n regulators in rk3568-evb1-10
      commit: 9ade1ab4d85f5fc31a5d6cf5147702ed5c1b5b10
[2/2] arm64: dts: rockchip: add the touchscreen controller to rk3568-evb1-v10
      commit: 922237a6c211d9fe46b5dfb56307872cdced386d

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
