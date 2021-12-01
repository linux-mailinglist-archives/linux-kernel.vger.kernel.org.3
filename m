Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A99346557D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 19:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352471AbhLASfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 13:35:41 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:55668 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352477AbhLASf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 13:35:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6D14AB820FD
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 18:32:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA9EFC53FAD;
        Wed,  1 Dec 2021 18:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638383525;
        bh=p+gM64NP+iunNzUXn4I/RtPaQ0kGiLpth9TxehEubfU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=mE1MsPlf+7tnToA7MTm76YtwYt3RtcQbGfqmYIJW0kXuXpWjy6cLFI5BGVZjTt0B9
         xqBcXAf5dGNCj3ZiMBuHYIO4tCZ1R77hpfUeIS/K2vlPYeKpSlShJoRH+wvWWqumwV
         25ibl2r0RaZkyhY7uEMXiLNxklrsy3G9L5J/eNY9nqEH/W4AhIZWc0djf2dWwqxURf
         4drtUYbDMXghIy/BJyOrpsfSlxWcP9vmzeOqa8t04b+OT/xTgf109e5Z7XxDSwjBiU
         aoeBylv0+6rOvikIwlLTVkGSLjt/DUbDJ5v4TjvW1pV9OU41ETpKiHhtLU0wwxajeE
         MWYvvQfRSQJBQ==
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-kernel@vger.kernel.org, perex@perex.cz,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        pierre-louis.bossart@linux.intel.com, tiwai@suse.com
In-Reply-To: <20211130160507.22180-1-srinivas.kandagatla@linaro.org>
References: <20211130160507.22180-1-srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 0/4] ASoC: codecs: Qualcomm codecs fix kcontrol put return values
Message-Id: <163838352348.2179725.18246298333579842383.b4-ty@kernel.org>
Date:   Wed, 01 Dec 2021 18:32:03 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Nov 2021 16:05:03 +0000, Srinivas Kandagatla wrote:
> Some recent testing found few issues with wcd934x and wsa881x codec drivers that
> are not handling kcontrol put correctly. This patchset fixes those instances.
> Along with this there is also a bug fix for the way channel list was updated for
> wcd934x dais.
> 
> --srini
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-linus

Thanks!

[1/4] ASoC: codecs: wcd934x: handle channel mappping list correctly
      commit: 23ba28616d3063bd4c4953598ed5e439ca891101
[2/4] ASoC: codecs: wcd934x: remove redundant ret variable
      (no commit info)
[3/4] ASoC: codecs: wcd934x: return correct value from mixer put
      commit: d9be0ff4796d1b6f5ee391c1b7e3653a43cedfab
[4/4] ASoC: codecs: wsa881x: fix return values from kcontrol put
      commit: 3fc27e9a1f619b50700f020e6cd270c1b74755f0

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
