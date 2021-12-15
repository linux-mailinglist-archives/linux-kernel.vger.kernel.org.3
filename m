Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75C52475384
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 08:11:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240422AbhLOHL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 02:11:29 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:34934 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240324AbhLOHL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 02:11:28 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1BF7BPO4006062;
        Wed, 15 Dec 2021 01:11:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1639552285;
        bh=fzLrObu4QQ2w1s05QCj4JKHTmvRT2kiduvK6HOXTsvQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=P3lGoSbBM/ofDJ5NMG/1MdYfthB4yZ8MCzylCZwhoHJBvZavbKd5823qt7rrG/3wG
         MfPq6QGSnm7WkW9kNhFZZ5PNmr6Ujkbsc0wyLSOkgzm8ta4Vb0qFlXIDlV8AI4wzTX
         N9MU6uEawAHDCVZbttyEFxpQ4OHTOwl13JFPaprs=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1BF7BPmU012735
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 15 Dec 2021 01:11:25 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 15
 Dec 2021 01:11:25 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 15 Dec 2021 01:11:25 -0600
Received: from uda0132425.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1BF7BNpZ029448;
        Wed, 15 Dec 2021 01:11:23 -0600
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Aswath Govindraju <a-govindraju@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] arm64: defconfig: Increase the maximum number of 8250/16550 serial ports
Date:   Wed, 15 Dec 2021 12:41:09 +0530
Message-ID: <163955131474.14033.3915304006426054820.b4-ty@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211208080737.10761-1-a-govindraju@ti.com>
References: <20211208080737.10761-1-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aswath Govindraju,
 
On Wed, 8 Dec 2021 13:37:35 +0530, Aswath Govindraju wrote:
> On some TI SoCs the number of UART instances used can be greater than 4.
> For example in TI's J721S2 SoC, 11th instance of UART is used as console.
> So, increase the maximum number of instances to 16.
> 
> 
 
I have applied the following to branch ti-k3-config-next on [1].
Thank you!
 
[1/1] arm64: defconfig: Increase the maximum number of 8250/16550 serial ports
      commit: 8e799ff45baebab781cf392be51a54b1f3fceb23
 
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

