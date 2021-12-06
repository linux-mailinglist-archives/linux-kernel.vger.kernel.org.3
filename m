Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A70A4696D3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 14:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244573AbhLFNZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 08:25:37 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:40622 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244369AbhLFNZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 08:25:36 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1B6DLvaj009276;
        Mon, 6 Dec 2021 07:21:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1638796918;
        bh=o4RttUSCrTmPAxrbzFqdWgBnrZ+5Ctc0eO9fvzF3r/8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=CVY+kjxLcal5VD0gYjXm7gLMjJSTIJfgHH09dWqSwcbDuhA0iI4PTvNxteE1KVlTA
         4PEpkFVmEmJSQRTSZdevFXRqsdf90zZygza7+5J08J41wUIs43kGgkxxQREvlf2K7/
         TJO7JIj8ukx3rl6u+wx89wJQIecd5dgLPJplb1w8=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1B6DLvLS122651
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 6 Dec 2021 07:21:57 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 6
 Dec 2021 07:21:57 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 6 Dec 2021 07:21:57 -0600
Received: from uda0132425.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1B6DLsHF091959;
        Mon, 6 Dec 2021 07:21:55 -0600
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-am642: Fix the L2 cache sets
Date:   Mon, 6 Dec 2021 18:51:34 +0530
Message-ID: <163879687338.18805.990123917091132995.b4-ty@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211113043635.4296-1-nm@ti.com>
References: <20211113043635.4296-1-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nishanth Menon,
 
On Fri, 12 Nov 2021 22:36:35 -0600, Nishanth Menon wrote:
> A53's L2 cache[1] on AM642[2] is 256KB. A53's L2 is fixed line length
> of 64 bytes and 16-way set-associative cache structure.
> 
> 256KB of L2 / 64 (line length) = 4096 ways
> 4096 ways / 16 = 256 sets
> 
> Fix the l2 cache-sets.
> 
> [...]
 
I have applied the following to branch ti-k3-dts-next on [1].
Thank you!
 
[1/1] arm64: dts: ti: k3-am642: Fix the L2 cache sets
      commit: a27a93bf70045be54b594fa8482959ffb84166d7
 
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

