Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 825DE4A313F
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 18:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352986AbiA2R5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 12:57:47 -0500
Received: from gloria.sntech.de ([185.11.138.130]:49008 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235697AbiA2R5l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 12:57:41 -0500
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nDryj-0005eg-3V; Sat, 29 Jan 2022 18:57:37 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 0/4] Quartz64-A fixes and enablement from 5.17-rc1
Date:   Sat, 29 Jan 2022 18:57:39 +0100
Message-Id: <164347899463.1472860.246056649344007753.b4-ty@sntech.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220128003809.3291407-1-pgwipeout@gmail.com>
References: <20220128003809.3291407-1-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jan 2022 19:38:04 -0500, Peter Geis wrote:
> Good Evening,
> 
> This is the first of several patch series for further expanding
> Quartz64-A support.
> 
> This series has the following patches:
> Fix the ddr regulator voltage.
> Add pmu_io_domains to permit sdio and high speed emmc support.
> Add sdmmc1 node for wifi support.
> Annotate con40 functions and enable i2c3.
> 
> [...]

Applied, thanks!

[1/4] arm64: dts: rockchip: fix Quartz64-A ddr regulator voltage
      commit: 8c318aaa20000bcfb9dc115c2a8e08c2e77ad439
[2/4] arm64: dts: rockchip: add Quartz64-A pmu_io_domains
      commit: 827dfba89ae150cd0fd88bc13117540cb4882943
[3/4] arm64: dts: rockchip: add Quartz64-A sdmmc1 node
      commit: 2ed1e35457a1917a9c567c186a5adc7ce6341b6e

With a minimal reordering (sdio-* comes before spdif alphabetically)

[4/4] arm64: dts: rockchip: add Quartz64-A con40 hardware
      commit: 2943660fe301aa650cdf60226a2a350d09145823

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
