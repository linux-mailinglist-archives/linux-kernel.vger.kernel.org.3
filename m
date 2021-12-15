Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B32647538B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 08:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240456AbhLOHOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 02:14:06 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:35232 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240324AbhLOHOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 02:14:05 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1BF7Dwop006734;
        Wed, 15 Dec 2021 01:13:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1639552438;
        bh=hWXrVHqnSfNLhVFhHdX81yptBTVHLTOcBW+DyPMOc1w=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=H785nSbHKR8HenpbxxEwW5cP+7FbYsrA3/JzqwQMrmQUol/TjsiPukWHx7mw7DCpB
         CzLXrGAtAq9SKWnIatyynop3VEC9G3sexeLPpxp8CbOberac7dXaC+4eMMqYGOgyFP
         Yaok1Z0tSWOBaDdvVA+EQh9H50F0YTRGSDBKKysE=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1BF7DvfQ026685
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 15 Dec 2021 01:13:57 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 15
 Dec 2021 01:13:57 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 15 Dec 2021 01:13:57 -0600
Received: from uda0132425.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1BF7Dsq1011923;
        Wed, 15 Dec 2021 01:13:54 -0600
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Aswath Govindraju <a-govindraju@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <kristo@kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v5 0/6] CAN: Add support for CAN in AM65,J721e and AM64
Date:   Wed, 15 Dec 2021 12:43:52 +0530
Message-ID: <163955230562.15251.12488906107335306384.b4-ty@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211122134159.29936-1-a-govindraju@ti.com>
References: <20211122134159.29936-1-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aswath Govindraju,
 
On Mon, 22 Nov 2021 19:11:52 +0530, Aswath Govindraju wrote:
> The following series of patches add support for CAN in SoC's AM65, J721e
> and AM64.
> 
> changes since v4 -
> - Rebased the series on top of ti-k3-dts-next branch
> 
> changes since v3 -
> - Rebased the series on top of ti-k3-dts-next branch
> 
> [...]
 
I have applied the following to branch ti-k3-dts-next on [1].
Thank you!
 
[1/6] arm64: dts: ti: k3-am65-mcu: Add Support for MCAN
      commit: c3e4ea557ddb0a7fa431564bb1bb023ffbf823f4
[2/6] arm64: dts: ti: am654-base-board/am65-iot2050-common: Disable mcan nodes
      commit: f533bb82def8b923668df97c36c1f8fe6a3a8f1f
[3/6] arm64: dts: ti: k3-j721e: Add support for MCAN nodes
      commit: 4688a4fcb7a20d347a52c1f2dc9bc6fad9df1174
[4/6] arm64: dts: ti: k3-j721e-common-proc-board: Add support for mcu and main mcan nodes
      commit: 87d60c4663b6eb964cca6a03adfcf8976f374559
[5/6] arm64: dts: ti: k3-am64-main: Add support for MCAN
      commit: 9c4441ad3da1fad75aabfd68e90558c20a2818d2
[6/6] arm64: dts: ti: k3-am642-evm/sk: Add support for main domain mcan nodes in EVM and disable them on SK
      commit: 2f474da98caf9a75d7777c5465d281240c706bc6
 
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

