Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD6147C737
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 20:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241715AbhLUTMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 14:12:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbhLUTMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 14:12:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF698C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 11:12:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9FBDDB81110
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 19:12:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3146DC36AE8;
        Tue, 21 Dec 2021 19:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640113949;
        bh=O3S5FDEGvUEzy2gVtEQoUg/vvqyOLdya7T8+6tn8dX4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=o8EF2woBDzix9iVnoMUBlDsEqv1BCjY4u754dRFAHvRPXI5MtHoYiW9+CQi2rD+t/
         KJAsf94f+LYVatapcCiUHunUP2Mf6FrWejNuXsFSfqMVuVmk2vOih3es1ka8H0BIIF
         CVnxGptIYRAXJSynlxZtlAQtc6voJLhyuYQai3zGdL4nlsMe79L5LTthRM5GPJBxvR
         egWjwb+ORUVnZ+0WgysqFfuA3H2PcZHgSJJRcPp8647twl5dG3SVaHyrOakKM8G2e6
         PVxYBgByJJ4vEmk97mx4StQCCJMkKRfoRmcqZMzr+W4iyJUKeSKiS4wFmf1XkQFFq+
         Y9tuM1axhm/kw==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Takashi Iwai <tiwai@suse.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211219181039.24812-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20211219181039.24812-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 0/2] sound/soc: Use platform_get_irq() to fetch IRQ's
Message-Id: <164011394691.93163.1449464407728800638.b4-ty@kernel.org>
Date:   Tue, 21 Dec 2021 19:12:26 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Dec 2021 18:10:37 +0000, Lad Prabhakar wrote:
> This patch series aims to drop using platform_get_resource() for IRQ types
> in preparation for removal of static setup of IRQ resource from DT core
> code.
> 
> Dropping usage of platform_get_resource() was agreed based on
> the discussion [0].
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: xlnx: Use platform_get_irq() to get the interrupt
      commit: c2efaf8f2d53ffa2ecc487e21c62d13bbb8d88c3
[2/2] ASoC: bcm: Use platform_get_irq() to get the interrupt
      commit: 5de035c270047e7ae754fbfb69031707aa5b54f7

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark
