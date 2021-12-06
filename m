Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C331746965E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 14:11:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243876AbhLFNOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 08:14:50 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:41388 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241808AbhLFNOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 08:14:49 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1B6DBCkS068713;
        Mon, 6 Dec 2021 07:11:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1638796272;
        bh=XpW8C+Npy/fS/z+5zc4yNKkgBO7jqb7oSvghV5APEtU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Nz7u/A7Sqs//hWz/kkXshsx0bI5UoRiG1EsxayZ7Px2NFtJyOUoZ9pNRdubshxj9u
         NDNWRFvhSrYkRUuSdvGYqqvSlCt0sE51gxM4Tsb0dPZENrpjzv3x5SvOM+ZeXmvYYs
         F9gZmTlcWB7BDQFgHINoYLPX6skRL6dXXoMB+RjU=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1B6DBB9m091663
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 6 Dec 2021 07:11:12 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 6
 Dec 2021 07:11:11 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 6 Dec 2021 07:11:11 -0600
Received: from uda0132425.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1B6DB8jM072137;
        Mon, 6 Dec 2021 07:11:09 -0600
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Rob Herring <robh+dt@kernel.org>, Tero Kristo <kristo@kernel.org>,
        Nishanth Menon <nm@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-omap@vger.kernel.org>, Peng Fan <peng.fan@nxp.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: ti: k3-j7200: Fix the L2 cache sets
Date:   Mon, 6 Dec 2021 18:40:18 +0530
Message-ID: <163879570036.16658.17037182694525892897.b4-ty@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211113043638.4358-1-nm@ti.com>
References: <20211113043638.4358-1-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nishanth Menon,
 
On Fri, 12 Nov 2021 22:36:38 -0600, Nishanth Menon wrote:
> A72's L2 cache[1] on J7200[2] is 1MB. A53's L2 is fixed line length of
> 64 bytes and 16-way set-associative cache structure.
> 

Replaced A53 referenc with A72 locally and applied.

> 1MB of L2 / 64 (line length) = 16384 ways
> 16384 ways / 16 = 1024 sets
> 
> Fix the l2 cache-sets.
> 
> [...]
 
I have applied the following to branch ti-k3-dts-next on [1].
Thank you!
 
[1/1] arm64: dts: ti: k3-j7200: Fix the L2 cache sets
      commit: d0c826106f3fc11ff97285102b576b65576654ae
 
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

