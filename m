Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 856BF475387
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 08:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240433AbhLOHM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 02:12:58 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:42496 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240324AbhLOHM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 02:12:57 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1BF7CmG8004608;
        Wed, 15 Dec 2021 01:12:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1639552368;
        bh=0E07cnYE32Qw9adjeQ6gz7L2I4ofg3cqc6UaD9Zk8QM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=TcUHDNfo0ZqIvyqNsxkclSPwtrGB4dK/kzaIzNmvVG+TLm97ZlHogwVZg/qfEJASz
         xS8Gv3N0wZ8JrKYfVDe2doKdklRS6Dhn2zLHr7+UNANIwji+AF+PSkQ3j9H9k5puLM
         YiFCEi+52uRQKu7l07DXdWxLjc46AuzAjeYhFLwA=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1BF7Cm4B120843
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 15 Dec 2021 01:12:48 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 15
 Dec 2021 01:12:48 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 15 Dec 2021 01:12:48 -0600
Received: from uda0132425.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1BF7CjM3001517;
        Wed, 15 Dec 2021 01:12:45 -0600
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     <nm@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <jan.kiszka@siemens.com>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: ti: iot2050: Disable mcasp nodes at dtsi level
Date:   Wed, 15 Dec 2021 12:42:24 +0530
Message-ID: <163955230562.15251.11883711226345772344.b4-ty@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211117053806.10095-1-j-choudhary@ti.com>
References: <20211117053806.10095-1-j-choudhary@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jayesh Choudhary,
 
On Wed, 17 Nov 2021 11:08:06 +0530, Jayesh Choudhary wrote:
> Disable mcasp nodes 0-2 because several required properties
> are not present in the dtsi file as they are board specific.
> These nodes can be enabled via an overlay whenever required.
> 
> 
 
I have applied the following to branch ti-k3-dts-next on [1].
Thank you!
 
[1/1] arm64: dts: ti: iot2050: Disable mcasp nodes at dtsi level
      commit: 277ee96f89d806f110e3011ea324155dd69e798f
 
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

