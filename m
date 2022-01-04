Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5B8C4845B9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 17:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233839AbiADQCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 11:02:13 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:49456 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233715AbiADQCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 11:02:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 68CD66151A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 16:02:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADA46C36AE9;
        Tue,  4 Jan 2022 16:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641312131;
        bh=9KxTeCJsKsjATFxUvGibyDM6eKFv4bAjCOg9AG/Ir1U=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ir698UmBabo+QGYf/X1gZM9FVfEJrrw7rJOf8j5Oxt4IG3DeEqNDL88fb2CZ0bgvl
         B76WoYfC2inrl2w/mlVX4UrnrQc4V+7ZLpy7DPO3l2Sk2ZqoXEBid/oke4KvQlPuoo
         /5uxnJGx0CHf1tomRGW7fw1qyjMqg8zPLCzK5LRVqXJxkUKV1GqbfN7A3rilm8RpDX
         k2zSbK6XqKN1KYlGrBfyhIIcfHnvGiELYszYTlbQc0fmcfmT7c3V9oJrtcpoAYi2Cx
         V3tiiFy9MWlBH7FO+fpjljVMRHqQFeFgImyDYz04veWmmcwUxgQMCNn4P4O5FOC1kS
         b7F/P95Zt4cCw==
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Fabio Estevam <festevam@gmail.com>, Alyssa Ross <hi@alyssa.is>,
        Xiubo Li <Xiubo.Lee@gmail.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        "open list:FREESCALE SOC SOUND DRIVERS" 
        <linuxppc-dev@lists.ozlabs.org>,
        "moderated list:FREESCALE SOC SOUND DRIVERS" 
        <alsa-devel@alsa-project.org>
In-Reply-To: <20220104132218.1690103-1-hi@alyssa.is>
References: <20220104132218.1690103-1-hi@alyssa.is>
Subject: Re: [PATCH] ASoC: fsl_mqs: fix MODULE_ALIAS
Message-Id: <164131212940.2665058.488131982799251609.b4-ty@kernel.org>
Date:   Tue, 04 Jan 2022 16:02:09 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jan 2022 13:22:16 +0000, Alyssa Ross wrote:
> modprobe can't handle spaces in aliases.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_mqs: fix MODULE_ALIAS
      commit: 9f3d45318dd9e739ed62e4218839a7a824d3cced

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
