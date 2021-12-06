Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9A2546A392
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 19:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345665AbhLFSEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 13:04:05 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:52798 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345568AbhLFSED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 13:04:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 80F4BCE1767;
        Mon,  6 Dec 2021 18:00:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2940AC341C6;
        Mon,  6 Dec 2021 18:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638813631;
        bh=rm4lpoorN4GW0idvvHmReqqBpZmjcTOc1YuUVO0Ac2g=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=jjRc2MYZzQIjUrOw+DzK8UGJnqGKL0Ip5yQ3sGBlCfirVCbHtuH2LDwOooZQOO/u8
         GwYLoxXv33XLoRjiDt7tGJuoFH7JLJOjFT+q7SAbN5EN79RK6lIlN6SmI2jY5MGi/f
         Qz5WKSO+j3PTvt7rYLfEqGD2cBVau4VGy3IxObW7ZKs5naIGxpXb6NGHSrmsKr35zA
         phvlGHIzdQl9LGUXf/sAUQsGpwdzkjpJn8o5IwXJ8CdD0R1WiYK0z2ZHkD9tClBVZn
         Ob2piYABpjZbSjuUNNaByxEtaXgO4cazAIEAfShSH7rjPpkbIgstdMVLKr1JHcPGx/
         Y8BhLRBOd3IMg==
From:   Mark Brown <broonie@kernel.org>
To:     robh+dt@kernel.org, matthias.bgg@gmail.com, tiwai@suse.com,
        Trevor Wu <trevor.wu@mediatek.com>
Cc:     alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, yc.hung@mediatek.com
In-Reply-To: <20211130053905.28470-1-trevor.wu@mediatek.com>
References: <20211130053905.28470-1-trevor.wu@mediatek.com>
Subject: Re: [PATCH 0/2] ASoC: mediatek: support memory-region assignment
Message-Id: <163881362873.2769299.4647182629013116105.b4-ty@kernel.org>
Date:   Mon, 06 Dec 2021 18:00:28 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Nov 2021 13:39:03 +0800, Trevor Wu wrote:
> This series of patches adds support for memory-region assignment, so the
> access region of DMA engine could be restricted.
> Patches are based on broonie tree "for-next" branch.
> 
> Trevor Wu (2):
>   ASoC: mediatek: mt8195: support reserved memory assignment
>   dt-bindings: mediatek: mt8195: add memory-region property
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: mediatek: mt8195: support reserved memory assignment
      commit: 4d408ea0282c374a304ce402866cb7b8a56c6b05
[2/2] dt-bindings: mediatek: mt8195: add memory-region property
      commit: 2da636247bb6f4fc3a9842ade04757790753fd2c

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
