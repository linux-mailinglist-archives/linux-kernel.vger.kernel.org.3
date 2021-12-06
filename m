Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8451469694
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 14:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243687AbhLFNRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 08:17:37 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:41644 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243677AbhLFNRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 08:17:36 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1B6DE11v069333;
        Mon, 6 Dec 2021 07:14:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1638796441;
        bh=57/1yIMHKGTOQVQFiDYnWahJ3TqzMM1YvgdWyM8QCOE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=O2N9U2h23Wq2XBLf2iNphHoY8S5GyUTFe8WNXir5XMXkF497HAYoLz84f2C/vlfID
         5/BBh8kkkDmo8jSYP6RISdjd7mUuXbaPWYpvlJrcaBlcdxqehSx66u+vlE8xzr105F
         lp9GeCk89wTekw0t4CU1rHg5KO6xdl1M7HRrrSFw=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1B6DE1eo094445
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 6 Dec 2021 07:14:01 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 6
 Dec 2021 07:14:00 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 6 Dec 2021 07:14:00 -0600
Received: from uda0132425.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1B6DDvRW116765;
        Mon, 6 Dec 2021 07:13:58 -0600
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Rob Herring <robh+dt@kernel.org>, Tero Kristo <kristo@kernel.org>,
        Nishanth Menon <nm@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-omap@vger.kernel.org>, Peng Fan <peng.fan@nxp.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH V2] arm64: dts: ti: k3-j7200: Correct the d-cache-sets info
Date:   Mon, 6 Dec 2021 18:43:55 +0530
Message-ID: <163879570035.16658.8331794401790118618.b4-ty@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211113042640.30955-1-nm@ti.com>
References: <20211113042640.30955-1-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nishanth Menon,
 
On Fri, 12 Nov 2021 22:26:40 -0600, Nishanth Menon wrote:
> A72 Cluster (chapter 1.3.1 [1]) has 48KB Icache, 32KB Dcache and 1MB L2 Cache
>  - ICache is 3-way set-associative
>  - Dcache is 2-way set-associative
>  - Line size are 64bytes
> 
> 32KB (Dcache)/64 (fixed line length of 64 bytes) = 512 ways
> 512 ways / 2 (Dcache is 2-way per set) = 256 sets.
> 
> [...]
 
I have applied the following to branch ti-k3-dts-next on [1].
Thank you!
 
[1/1] arm64: dts: ti: k3-j7200: Correct the d-cache-sets info
      commit: a172c86931709d6663318609d71a811333bdf4b0
 
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

