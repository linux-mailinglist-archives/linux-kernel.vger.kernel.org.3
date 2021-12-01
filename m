Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1448246557F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 19:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352532AbhLASft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 13:35:49 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:57612 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352477AbhLASfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 13:35:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A150FCE1DED
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 18:32:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA88FC53FCF;
        Wed,  1 Dec 2021 18:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638383538;
        bh=DbZYTt6Xk61X6E64B2G6G9w0VkROaHjiFX2uaD0wNNg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=SJ2EG+xrdvPZD6skv01hvMRDI4+2RGv4Ig9DI5MvpgJJwYwEA/gXuwPd/+5a1nNt4
         YRDybhqIWZvXurkJ1nLrP9zW7NBOXg18zY4GKgRuslx5x1DaGvJ0hB1DwyWr/OobpR
         SLBK8Yy59XdZMd4qdnz4KmTFGjIeyPZ35teoIpGAlx4yLvCOg/3OqgW9ho4Z7bBlfZ
         GyPU5C6AjZk6eJy04VHI6kOGbBzD7rMwLzQFTc2aSrn2ntTJtmLaXh89WUxg+rPaJc
         +hMf44lEJneiKx1V/gFEkWa8sFXy0XjhVkZ9Iy6nJLaX30r6oBpHY4/KZc8FY/MEYj
         iPMwW1ofG6MJA==
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org,
        Bixuan Cui <cuibixuan@huawei.com>,
        Trevor Wu <trevor.wu@mediatek.com>
In-Reply-To: <20211127093147.17368-1-rikard.falkeborn@gmail.com>
References: <20211127093147.17368-1-rikard.falkeborn@gmail.com>
Subject: Re: [PATCH] ASoC: mediatek: mt8195: Constify static snd_soc_ops
Message-Id: <163838353641.2179787.17471282072655140099.b4-ty@kernel.org>
Date:   Wed, 01 Dec 2021 18:32:16 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Nov 2021 10:31:47 +0100, Rikard Falkeborn wrote:
> These are only assigned to the ops field in the snd_soc_dai_link which
> is a pointer to const struct snd_soc_ops. Make them const to allow the
> compiler to put them in read-only memory.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: mt8195: Constify static snd_soc_ops
      commit: 8752d9a82fd065ef60c9a0e0e8ec820327509382

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
