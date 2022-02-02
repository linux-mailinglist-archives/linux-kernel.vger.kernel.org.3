Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53ED24A78E9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 20:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234866AbiBBTtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 14:49:45 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:35158 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231390AbiBBTto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 14:49:44 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 212JnQVY115371;
        Wed, 2 Feb 2022 13:49:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1643831366;
        bh=hvsHZm8OlbAUiFjTn0w2jr5q8Ay/1dFkrjFBr7OmLRA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=D9rfeYal3AfGzQHsLe8fBOMBUWhbKrourowq3QHvXCbODajTyf8ktwoglgFruYlyB
         ufX6Qa7Fg0UzwZ/kDEGrgLldxIvwluWQU176+FuiDrFaCIQ+H5o1iSrQdWCoGgXJGw
         6WKnWfecTbyyMrZebZTrZb/FiidIThrbje70fHCg=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 212JnQoD038094
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 2 Feb 2022 13:49:26 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 2
 Feb 2022 13:49:26 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 2 Feb 2022 13:49:26 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 212JnQ5U042143;
        Wed, 2 Feb 2022 13:49:26 -0600
From:   Nishanth Menon <nm@ti.com>
To:     <ssantosh@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
CC:     Nishanth Menon <nm@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] soc: ti: k3-ringacc: Use devm_bitmap_zalloc() when applicable
Date:   Wed, 2 Feb 2022 13:49:25 -0600
Message-ID: <164383135100.1523.10038747585864521872.b4-ty@ti.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <45544b0d97a7bea7764292852842adf5085a7700.1640276001.git.christophe.jaillet@wanadoo.fr>
References: <45544b0d97a7bea7764292852842adf5085a7700.1640276001.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe JAILLET,

On Thu, 23 Dec 2021 17:14:46 +0100, Christophe JAILLET wrote:
> 'rings_inuse' and 'proxy_inuse' are bitmaps. So use 'devm_bitmap_zalloc()'
> to simplify code and improve the semantic.
> 
> 

I have applied the following to branch ti-drivers-soc-next on [1].
Thank you!

[1/1] soc: ti: k3-ringacc: Use devm_bitmap_zalloc() when applicable
      commit: a8eba8dde5fbf0b9f62a38230af6d66c389c37fc

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

