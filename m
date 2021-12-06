Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18D0B469707
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 14:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244490AbhLFNdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 08:33:33 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:41480 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244021AbhLFNdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 08:33:31 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1B6DTrV8011520;
        Mon, 6 Dec 2021 07:29:53 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1638797393;
        bh=AkzDdriUGxQiwAqQmJA42Ef15ui8ESE81FZMjz4HunE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=KApRLcweQCVw4ts6entfdsNy7WVPtmMDZ+NTKe2yBi+WNxaZ3D31QOY28ERLWkO+i
         S9riroP1Gfju/81AhYK079+Kr95OIyIWdAYc1ZxiHmPhEq3iabaeGEmoLx7Ywnkbix
         5ti2HrXzmaJtHd0qMjAN+waUeo6fYh+W4cbzN7X4=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1B6DTqFl001589
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 6 Dec 2021 07:29:52 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 6
 Dec 2021 07:29:52 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 6 Dec 2021 07:29:52 -0600
Received: from uda0132425.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1B6DTml2109056;
        Mon, 6 Dec 2021 07:29:49 -0600
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     <robh+dt@kernel.org>, <s-anna@ti.com>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, <kristo@kernel.org>,
        <nm@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, Peng Fan <peng.fan@nxp.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: k3-j721e: correct cache-sets info
Date:   Mon, 6 Dec 2021 18:59:22 +0530
Message-ID: <163879723385.20240.9306599472058265234.b4-ty@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211112063155.3485777-1-peng.fan@oss.nxp.com>
References: <20211112063155.3485777-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peng Fan (OSS),
 
On Fri, 12 Nov 2021 14:31:55 +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> A72 Cluster has 48KB Icache, 32KB Dcache and 1MB L2 Cache
>  - ICache is 3-way set-associative
>  - Dcache is 2-way set-associative
>  - Line size are 64bytes
> 
> [...]
 
I have applied the following to branch ti-k3-dts-next on [1].

Fixed $subject as suggested by Nishanth.

Thank you!
 
[1/1] arm64: dts: k3-j721e: correct cache-sets info
      commit: 7a0df1f969c14939f60a7f9a6af72adcc314675f
 
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

