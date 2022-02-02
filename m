Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF454A78F0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 20:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346998AbiBBTuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 14:50:55 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:45070 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236734AbiBBTuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 14:50:54 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 212JoleT128181;
        Wed, 2 Feb 2022 13:50:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1643831447;
        bh=tH9m0yOE8pM/q+DfJ1CNCI8WNauocuyfR/BpoG+xeHI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ZpQ6LfegaDwMOfpD+5pBjnBQKwOe/IiygBFMmTCRYVweQFEo4wd7mxjM7PuS4SX4C
         leqqHVa/q2GajMwXUMjRnPRPjE7LOn85lmuhrzQv9QdYirrNDTprdz9LXxOjE5W68S
         k3p8wR4+DC0lSo8wureVcW5ZV53xlAAmhPKDKjm8=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 212Jolkp106891
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 2 Feb 2022 13:50:47 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 2
 Feb 2022 13:50:46 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 2 Feb 2022 13:50:46 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 212Jok7a004548;
        Wed, 2 Feb 2022 13:50:46 -0600
From:   Nishanth Menon <nm@ti.com>
To:     <ssantosh@kernel.org>, <kristo@kernel.org>,
        Peiwei Hu <jlu.hpw@foxmail.com>
CC:     Nishanth Menon <nm@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] firmware: ti_sci: inproper error handling of ti_sci_probe
Date:   Wed, 2 Feb 2022 13:50:46 -0600
Message-ID: <164383144097.1944.17032975343526415419.b4-ty@ti.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <tencent_0D5124AF8235001703711A7A09703F918806@qq.com>
References: <tencent_0D5124AF8235001703711A7A09703F918806@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peiwei Hu,

On Tue, 28 Dec 2021 18:01:03 +0800, Peiwei Hu wrote:
> goto out instead of returning directly in error exiting
> 
> 

I have applied the following to branch ti-drivers-soc-next on [1].
Thank you!

[1/1] firmware: ti_sci: inproper error handling of ti_sci_probe
      commit: a181bcfca937b34467e6cd63d7de6073176616e1

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

