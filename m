Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 513C747545E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 09:38:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240857AbhLOIi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 03:38:26 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:53776 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbhLOIiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 03:38:25 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1BF8cI9R027337;
        Wed, 15 Dec 2021 02:38:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1639557498;
        bh=77J8uhE8DpJv8ppHfDAq421hJxuLaHcdCaWhrTzQBGY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=VTTwix71dpK4zFkkuE8YpvzTp8Yn8yOiTC71OA8dkNRjdYJr9vb1svyJIIxs5/WX4
         Fy2nlRBekMC68zhZ6v0/B3XLkRg6CiavXgGOxce5ddNbEvUhr5qSA2QuE8HpyJ+e+O
         VDJv5YrsJBUD9hbUAPQ3TeyjGjck33bLzvCC27Ek=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1BF8cIbM004245
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 15 Dec 2021 02:38:18 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 15
 Dec 2021 02:38:18 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 15 Dec 2021 02:38:18 -0600
Received: from uda0132425.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1BF8cFKp057995;
        Wed, 15 Dec 2021 02:38:15 -0600
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Aswath Govindraju <a-govindraju@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 0/5] J721S2: Add initial support
Date:   Wed, 15 Dec 2021 14:08:04 +0530
Message-ID: <163955230562.15251.10921015972649910083.b4-ty@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211207080904.14324-1-a-govindraju@ti.com>
References: <20211207080904.14324-1-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aswath Govindraju,
 
On Tue, 7 Dec 2021 13:38:59 +0530, Aswath Govindraju wrote:
> The J721S2 SoC belongs to the K3 Multicore SoC architecture platform,
> providing advanced system integration in automotive ADAS applications and
> industrial applications requiring AI at the network edge. This SoC extends
> the Jacinto 7 family of SoCs with focus on lowering system costs and power
> while providing interfaces, memory architecture and compute performance for
> single and multi-sensor applications.
> 
> [...]
 
I have applied the following to branch ti-k3-dts-next on [1].
Thank you!
 
[1/5] dt-bindings: arm: ti: Add bindings for J721s2 SoC
      commit: 6b1caf4dea3e0a961b7a11cff6757ff74c1c34ea
[2/5] dt-bindings: pinctrl: k3: Introduce pinmux definitions for J721S2
      commit: beba81faad86fc2bad567b1c029d6a000a43ca78
[3/5] arm64: dts: ti: Add initial support for J721S2 SoC
      commit: b8545f9d3a5426a5f76814c8aaebc5cb46a3213a
[4/5] arm64: dts: ti: Add initial support for J721S2 System on Module
      commit: d502f852d22af1ca33e7a2fedd7426831f6dbaef
[5/5] arch: arm64: ti: Add support J721S2 Common Processor Board
      commit: effb32e931dd4feb8aa3cee7b5b4ddda43c8b701
 
All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent up the chain during
the next merge window (or sooner if it is a relevant bug fix), however if
problems are discovered then the patch may be dropped or reverted.
 
You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.
 
If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.
 
Please add any relevant lists and maintainers to the CCs when replying
to this mail.
 
[1] https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git
--
Vignesh

