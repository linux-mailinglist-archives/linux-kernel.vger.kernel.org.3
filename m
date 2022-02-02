Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5FF84A78F1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 20:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347001AbiBBTvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 14:51:16 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:45102 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236734AbiBBTvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 14:51:14 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 212Jp8LS128254;
        Wed, 2 Feb 2022 13:51:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1643831468;
        bh=0gjEM2UzENE9r+9jEBufBpH7/PtClM6NN05Lx6PZ8tY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=bDmoOiXPeeViNPmfLLWyDG9DJxutjbshEclk25PS6BuGpnHShqpJwbe1SJO9F6XQm
         fJcDq3801vJegeRRRONTLHM+WykO3FJaFh4T15PQQ7J/1NonTK/aHBwJcqA8kdJ9la
         dZibUUeFrBf9nQ5urWEBKnMROqYnNhyP5RQPeCEs=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 212Jp8lB005853
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 2 Feb 2022 13:51:08 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 2
 Feb 2022 13:51:08 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 2 Feb 2022 13:51:08 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 212Jp8Mg095982;
        Wed, 2 Feb 2022 13:51:08 -0600
From:   Nishanth Menon <nm@ti.com>
To:     <linux-kernel@vger.kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Dave Gerlach <d-gerlach@ti.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Tony Lindgren <tony@atomide.com>
CC:     Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] soc: ti: wkup_m3_ipc: Fix IRQ check in wkup_m3_ipc_probe
Date:   Wed, 2 Feb 2022 13:51:03 -0600
Message-ID: <164383145850.2040.4786368708815305819.b4-ty@ti.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220114062840.16620-1-linmq006@gmail.com>
References: <20220114062840.16620-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miaoqian Lin,

On Fri, 14 Jan 2022 06:28:40 +0000, Miaoqian Lin wrote:
> platform_get_irq() returns negative error number instead 0 on failure.
> And the doc of platform_get_irq() provides a usage example:
> 
>     int irq = platform_get_irq(pdev, 0);
>     if (irq < 0)
>         return irq;
> 
> [...]

I have applied the following to branch ti-drivers-soc-next on [1].
Thank you!

[1/1] soc: ti: wkup_m3_ipc: Fix IRQ check in wkup_m3_ipc_probe
      commit: c3d66a164c726cc3b072232d3b6d87575d194084

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

[1] git://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

