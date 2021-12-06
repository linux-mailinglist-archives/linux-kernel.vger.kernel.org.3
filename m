Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 254A146968A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 14:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243985AbhLFNQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 08:16:58 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:39690 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244135AbhLFNQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 08:16:55 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1B6DDC7l007221;
        Mon, 6 Dec 2021 07:13:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1638796392;
        bh=pYddrYXJDPAFBh5ZxgKQltpBvrTtJhPxeuFlwIUqGrQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=lbUorVoQfhLEQEPl0kRruM+/uehG1lEJZO0ZMQk6c/RV5/+YwhP0wsO8mib34Oo3v
         OdPosVu3L9ImLn1GcobeQrfbhT8toAps6XpVhF497aoc72/ih9ux7YvkiFwblo1MhE
         3I9FJXqWUbkwf4Xd5qEIQ7N5dIie+COQo3j/TGyg=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1B6DDCQN050638
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 6 Dec 2021 07:13:12 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 6
 Dec 2021 07:13:12 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 6 Dec 2021 07:13:12 -0600
Received: from uda0132425.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1B6DD9BU115824;
        Mon, 6 Dec 2021 07:13:09 -0600
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Rob Herring <robh+dt@kernel.org>, Tero Kristo <kristo@kernel.org>,
        Nishanth Menon <nm@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-omap@vger.kernel.org>, Peng Fan <peng.fan@nxp.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: ti: k3-j721e: Fix the L2 cache sets
Date:   Mon, 6 Dec 2021 18:43:06 +0530
Message-ID: <163879570036.16658.15551378280556472124.b4-ty@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211113043639.4413-1-nm@ti.com>
References: <20211113043639.4413-1-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nishanth Menon,
 
On Fri, 12 Nov 2021 22:36:39 -0600, Nishanth Menon wrote:
> A72's L2 cache[1] on J721e[2] is 1MB. A53's L2 is fixed line length of
> 64 bytes and 16-way set-associative cache structure.
> 

Replaced A53 reference with A72 locally and applied.


> 1MB of L2 / 64 (line length) = 16384 ways
> 16384 ways / 16 = 1024 sets
> 
> Fix the l2 cache-sets.
> 
> [...]
 
I have applied the following to branch ti-k3-dts-next on [1].
Thank you!
 
[1/1] arm64: dts: ti: k3-j721e: Fix the L2 cache sets
      commit: e9ba3a5bc6fdc2c796c69fdaf5ed6c9957cf9f9d
 
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

