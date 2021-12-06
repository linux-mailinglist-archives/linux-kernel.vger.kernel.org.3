Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C18884696FC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 14:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244535AbhLFNaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 08:30:07 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:41116 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244456AbhLFNaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 08:30:00 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1B6DQSUa010670;
        Mon, 6 Dec 2021 07:26:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1638797188;
        bh=KFZ22+H0OqmLIZYkJNpGRzkei8pu5Su4ASlo7UAmV3w=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=JamZGvWA87/eg/UXT26gSJ4XvvVlc+9xSrGYR87KNVAx2dKFA5QmJit9/hpTRwuBa
         w/eAOwlteyCs52W7FNQkCYUppaxgoyxpP/lMCilQtTvYIDD1JAqADnqFN0HqJMUS3t
         iTdCP4VtLVn9/IY/KPMnMM8h00mQoAG478ZIzh34=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1B6DQSPV072039
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 6 Dec 2021 07:26:28 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 6
 Dec 2021 07:26:27 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 6 Dec 2021 07:26:27 -0600
Received: from uda0132425.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1B6DQODJ104130;
        Mon, 6 Dec 2021 07:26:25 -0600
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Nishanth Menon <nm@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, Tero Kristo <kristo@kernel.org>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH 0/2] Fix 'dtbs_check' in serdes_ln_ctrl (syscon subnode)
Date:   Mon, 6 Dec 2021 18:56:22 +0530
Message-ID: <163879706325.19472.15532224462001394739.b4-ty@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211126084555.17797-1-kishon@ti.com>
References: <20211126084555.17797-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kishon Vijay Abraham I,
 
On Fri, 26 Nov 2021 14:15:53 +0530, Kishon Vijay Abraham I wrote:
> Fix 'dtbs_check' in serdes_ln_ctrl (syscon subnode) node in both j7200
> and j721e.
> 
> Kishon Vijay Abraham I (2):
>   arm64: dts: ti: j7200-main: Fix 'dtbs_check' in mux@4080 node
>   arm64: dts: ti: j721e-main: Fix 'dtbs_check' in mux@4080 node
> 
> [...]
 
I have applied the following to branch ti-k3-dts-next on [1].
Thank you!
 
[1/2] arm64: dts: ti: j7200-main: Fix 'dtbs_check' serdes_ln_ctrl node
      commit: 4d3984906397581dc0ccb6a02bf16b6ff82c9192
[2/2] arm64: dts: ti: j721e-main: Fix 'dtbs_check' in serdes_ln_ctrl node
      commit: 3f92a5be6084b77f764a8bbb881ac0d12cb9e863
 
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

