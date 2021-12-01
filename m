Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3A546557E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 19:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352466AbhLASfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 13:35:44 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:57542 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352499AbhLASfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 13:35:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D245FCE1DEA
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 18:32:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5AC7C53FAD;
        Wed,  1 Dec 2021 18:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638383533;
        bh=eTOf0ZAeC2V3Egfrxq0AtFk5umjjg4bM+zXOg1szGO8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=pwPBym3FzHDRdjW5tMGiY94PqpsZLY9uKdAHxfA4l/S523ERoo8MMcRb69hktUyhH
         kxC5IXV36IbXQxHoWqCYjn3baMTMnLqZcSj0MfLEhforwkcj1bHlc/RqYCVTk3ALot
         mvVoSH4lLT6sy4BIoTCnziff8J4UzBfMKHWflGVSu1xG9hi5NAOwYEfH08KWNYjp14
         XnuY5TsI3sh+PUMLD6aQQW8ZBSn2OsUT5k5oPklkLJ97p0x9xPbumNo8RwbDm8TU/3
         JiJfDMZhjECT57LezoK3hTGoYcf5M9nqLIKxBWilEEHYs6xpZD0fhGSH/hIy+QQeMK
         F9avyv7KKXDXA==
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>
Cc:     linux-kernel@vger.kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        alsa-devel@alsa-project.org,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>
In-Reply-To: <20211127091954.12075-1-rikard.falkeborn@gmail.com>
References: <20211127091954.12075-1-rikard.falkeborn@gmail.com>
Subject: Re: [PATCH] ASoC: intel: boards: bytcht*: Constify static snd_soc_ops
Message-Id: <163838353065.2179787.7204772157932440988.b4-ty@kernel.org>
Date:   Wed, 01 Dec 2021 18:32:10 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Nov 2021 10:19:54 +0100, Rikard Falkeborn wrote:
> These are only assigned to the ops fields in the snd_soc_dai_link struct
> which is a pointer to const struct snd_soc_ops. Make them const to allow
> the compiler to put them in read-only memory.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: intel: boards: bytcht*: Constify static snd_soc_ops
      commit: 10b155fd413d31c89057986d0fc3d4ceef8e0e9f

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
