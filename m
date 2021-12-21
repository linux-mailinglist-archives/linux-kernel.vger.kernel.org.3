Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68FE947C73A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 20:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241735AbhLUTMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 14:12:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241721AbhLUTMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 14:12:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01AB4C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 11:12:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BCC1CB81992
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 19:12:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 832E6C36AEA;
        Tue, 21 Dec 2021 19:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640113954;
        bh=PI9JsaIFDN7yqONnNOEbLQVi3YNrLsUoOS1QyXiQQlY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=GlXJ6WBZ+xlzM9rM70oU6/pG/JzGzIuUSiXpuUqZjUZgYLaOf0jNwPuZ+dgcf/NQw
         WK3SLdCLFXJkQ3umVpYzfhQxuBg7V8L8zrY5BfRKBCwtXVsW5BkHe6qb2b2ih1znPw
         M0d8FtlSdCpeYWcO13d76W+qSYX98u2FRkv6TTUbD3v+S25yJcuHGROlXN5Rfzsbdf
         vNgPzucDa1Y7B30uZ6uKMg7lPfDKbmjuIYEMYRXgadIAsWwwYFxzLfrNCFblOOtBlD
         6FUeAgAB056Qk5LWvIuI4t9oEbcv+uRGkQ2fh+aTzRIVp9ji5G30ZRaTclm/YgtoHP
         SDnXBOuo1Zq5w==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Takashi Iwai <tiwai@suse.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        alsa-devel@alsa-project.org, bcm-kernel-feedback-list@broadcom.com,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211221170100.27423-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20211221170100.27423-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v2 0/2] sound/soc: Use platform_get_irq() to fetch IRQ's
Message-Id: <164011395226.93163.12622480659294102609.b4-ty@kernel.org>
Date:   Tue, 21 Dec 2021 19:12:32 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Dec 2021 17:00:58 +0000, Lad Prabhakar wrote:
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
