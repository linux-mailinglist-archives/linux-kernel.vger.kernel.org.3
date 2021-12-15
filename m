Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1F28475380
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 08:09:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240361AbhLOHJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 02:09:25 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:34586 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240334AbhLOHJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 02:09:24 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1BF79BGl005519;
        Wed, 15 Dec 2021 01:09:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1639552151;
        bh=AAm38rIk4hKi1n68MDqHYDtUqllINYyiuRP+KqfsQns=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=lcyBA9Pd8pxPLHK6Qa5DxS3sim3PlPwDLLZEExnG7LTr2iFoReSzealn6rDLIWwOC
         4PdaL80RIiB92IJw8o00tHkXDCWRBk85hTSlFg4GigIU+E0zqMRIcCU40oaUDbrMhH
         dUy4RcfR+MX2XQl4+9u1QRSMPbGuNuVEFEof4L7k=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1BF79Bms009867
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 15 Dec 2021 01:09:11 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 15
 Dec 2021 01:09:11 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 15 Dec 2021 01:09:11 -0600
Received: from uda0132425.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1BF7982M009383;
        Wed, 15 Dec 2021 01:09:09 -0600
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Will Deacon <will@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Nishanth Menon <nm@ti.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] arm64: defconfig: Enable USB, PCIe and SERDES drivers for TI K3 SoC
Date:   Wed, 15 Dec 2021 12:37:06 +0530
Message-ID: <163955131473.14033.7244198185344623653.b4-ty@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211208060856.16106-1-vigneshr@ti.com>
References: <20211208060856.16106-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vignesh Raghavendra,
 
On Wed, 8 Dec 2021 11:38:56 +0530, Vignesh Raghavendra wrote:
> Enable Cadence PCIe, Cadence USB, TI USB and PCIe wrappers and required
> SERDES drivers to support USB and PCIe on TI K3 SoCs.
> 
> 
 
I have applied the following to branch ti-k3-config-next on [1].
Thank you!
 
[1/1] arm64: defconfig: Enable USB, PCIe and SERDES drivers for TI K3 SoC
      commit: 8d73aedca28cbed8030067b0d9423a0694139b9c
 
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

