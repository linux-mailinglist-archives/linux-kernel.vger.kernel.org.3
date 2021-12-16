Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81E1947721B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 13:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236900AbhLPMq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 07:46:57 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:46612 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236918AbhLPMq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 07:46:56 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1BGCknGA101734;
        Thu, 16 Dec 2021 06:46:49 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1639658809;
        bh=0dqtIRR7fLc1fwecjBW5TWGnjcM4SwyPRt4DiDIPExw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=UPnkhVc+k/OeiK7lditCX5yUjzfWaQw9lhuVeeUYNab1d7+Ll1e0l49z8ezlrdhSa
         G4oHbAJVsTN2dCBS/fj/UD5roj12QzMSjfWiOzyzuqvjajbd73YFgp98esJKTO1zHV
         hAs0o/6O0xwoSV4glHqBxViJy80X1aSoSu57tiFo=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1BGCknBm018068
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 16 Dec 2021 06:46:49 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 16
 Dec 2021 06:46:49 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 16 Dec 2021 06:46:49 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1BGCkn65107979;
        Thu, 16 Dec 2021 06:46:49 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Miaoqian Lin <linmq006@gmail.com>
CC:     Nishanth Menon <nm@ti.com>, <ssantosh@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] soc: ti: Fix NULL vs IS_ERR() checking in dma_init
Date:   Thu, 16 Dec 2021 06:46:48 -0600
Message-ID: <163965861934.13354.12315365423760659691.b4-ty@ti.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20211214015544.7270-1-linmq006@gmail.com>
References: <20211213155930.mcxlc5m3niqh77xi@annotate> <20211214015544.7270-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miaoqian Lin,

On Tue, 14 Dec 2021 01:55:44 +0000, Miaoqian Lin wrote:
> Since devm_ioremap_resource() function return error pointers.
> The pktdma_get_regs() function does not return NULL, It return error
> pointers too. Using IS_ERR() to check the return value to fix this.
> 
> 

I have applied the following to branch ti-drivers-soc-next on [1].
Thank you!

[1/1] soc: ti: Fix NULL vs IS_ERR() checking in dma_init
      commit: 1bb0b8b195d821d009bae61248da14f2b17bd44a

Side note: For future reference, I had to fixup your patch for $subject (added
knav_dma) and the usage of --- diffstat section to indicate changes or version
history - see updated patch in [2].

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
[2] https://gist.github.com/nmenon/e6464f84bbcd63a25a7011fd4dbc85ba
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D)/Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

