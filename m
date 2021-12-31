Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB325482460
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 15:40:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbhLaOkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 09:40:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbhLaOkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 09:40:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1022C061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Dec 2021 06:39:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 91196617CD
        for <linux-kernel@vger.kernel.org>; Fri, 31 Dec 2021 14:39:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F8EFC36AF0;
        Fri, 31 Dec 2021 14:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640961599;
        bh=lAxyCxUkQlETTh2egsQpr5ZWqt6MG6luXxuJleTC4Pk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=r/FWhMvqFHATTAndSxG3zmrOdPr6YgnaMsrO/ijlgdOg6yKa/ejJvd9NU4f972sDn
         aWQleQrjD7dcnLtwnF4KQqR1zbhm4+m/rMDjfpBshkMa+wrTdHIziNj6BvkwWpOkjl
         OMs/QAkR0z+mOUsuiiLHZC1w/0lJrw2K8siV7Rdx4vek9JApq74KfVkLjR+zO7xWNQ
         LdgpuzBTqb/EcKVF+Z5zUtXxSjqV/Xbh3lO8zjVwSI8M8vHsJV/IrCISovfnuPdKhk
         89M0a2toxISI5ZH6Atb1GsKpPl+6lkQfORkyADEaF9IOdMC/TP4QBqW0aIU4zNtBWV
         GwkZp8rIlhbvw==
From:   Mark Brown <broonie@kernel.org>
To:     Trevor Wu <trevor.wu@mediatek.com>, matthias.bgg@gmail.com,
        tiwai@suse.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org
In-Reply-To: <20211230084731.31372-1-trevor.wu@mediatek.com>
References: <20211230084731.31372-1-trevor.wu@mediatek.com>
Subject: Re: [PATCH 0/2] ASoC: mediatek: mt8195: repair pcmif BE dai
Message-Id: <164096159738.2355590.6915184863464134873.b4-ty@kernel.org>
Date:   Fri, 31 Dec 2021 14:39:57 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Dec 2021 16:47:29 +0800, Trevor Wu wrote:
> This series of patches repairs some problems for pcmif BE dai.
> The unexpected control flow is corrected, and the missing playback
> support of DPCM is added.
> 
> Patches are based on broonie tree "for-next" branch.
> 
> Trevor Wu (2):
>   ASoC: mediatek: mt8195: correct pcmif BE dai control flow
>   ASoC: mediatek: mt8195: add playback support to PCM1_BE dai_link
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: mediatek: mt8195: correct pcmif BE dai control flow
      commit: 2355028c0c54c03afb66c589347f1dc9f6fe2e38
[2/2] ASoC: mediatek: mt8195: add playback support to PCM1_BE dai_link
      commit: db5e1c209b92a67ab7c1d7771a48294c9c093f7c

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
