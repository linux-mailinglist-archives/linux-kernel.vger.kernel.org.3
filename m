Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD29474365
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 14:26:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234377AbhLNNZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 08:25:36 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:44550 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234376AbhLNNZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 08:25:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0CEB0B819AC
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 13:25:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CD7BC34601;
        Tue, 14 Dec 2021 13:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639488329;
        bh=CXlirWpNtiv8wz5K4EzPuevYWM3pXeCBCGuXbnoMg4g=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=m0eIIm1lOkOQ7SFJ5VEJ7buHuN/A1tRSn/wawPe1l3lOyt4uehRzvT8zXz7KlQIMl
         Q8S/lz4qY6I2NxYzqY3ES7nWfyQi3V2mnpFg82Pzzbx/vSKtyxBf4zPGGhRT5p4OO4
         O2+gPFN4w8gnhm6dQVdXkvsjPsjtbdeBx2AzOwHtv4RblmbPqhI8onVDuV7KQKjtBB
         +oaKVyTQmstzYeawV1vUyGqacxDp7nysczgtQ2gxwi5Ku5rGoV3DOuFeyWWHpWxfgi
         2mpSXy9pJwylCc+Kuwt9t8NpgzbSJveh8FoNeRNFYwk0hmXleFgVyJxbs83yuQzlXC
         TZIV+as0AG5yg==
From:   Mark Brown <broonie@kernel.org>
To:     Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Jaroslav Kysela <perex@perex.cz>,
        sound-open-firmware@alsa-project.org, linux-kernel@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
In-Reply-To: <20211204203220.54712-1-rikard.falkeborn@gmail.com>
References: <20211204203220.54712-1-rikard.falkeborn@gmail.com>
Subject: Re: [PATCH] ASoC: SOF: sof-probes: Constify sof_probe_compr_ops
Message-Id: <163948832737.2865729.1547928501780400598.b4-ty@kernel.org>
Date:   Tue, 14 Dec 2021 13:25:27 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Dec 2021 21:32:20 +0100, Rikard Falkeborn wrote:
> The only usage of sof_probe_compr_ops is to assign its address to the
> cops field in the snd_soc_dai_driver struct (in
> sound/soc/sof/intel/hda-dai.c). Make it const to allow the compiler to
> put it in read-only memory.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: sof-probes: Constify sof_probe_compr_ops
      commit: ec247fea7380244626d7095dfc1a0bb6c1f84f29

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
