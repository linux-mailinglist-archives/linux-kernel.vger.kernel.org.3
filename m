Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CCEE46557C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 19:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352480AbhLASfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 13:35:33 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:55722 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352482AbhLASfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 13:35:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4917EB820FC
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 18:32:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97D32C53FCF;
        Wed,  1 Dec 2021 18:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638383527;
        bh=V6YRKpSIrVHzwm9o+oYBP5E3FknqANMjKoHFfd/iP20=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=G2mspX2Gj2RAB2bqOT1DEejPw0xs/OrOFnx3DVvosKwwXTk0jNTs4Lv7L0qanmOKN
         de7zfozXCy8KiCvrXdtokZVjU4qeFD/dSXjEUUJ+UQX0cb9sHLDn4Iu9eIoBSOucTl
         B/V4uP52tDEVmvp2zxbZhGi60GIjVne18x7PBwxLdJXvCXiy5FPQ0Y5kOlWetdNcpt
         9HMUamr2qMV4t9a1Iw8kdno5lc5owAAEhp8YwBqGtyDppNgykHYTaqhIwSHjKD+F0Q
         8JS1czRTsYFKqYbZsikJ21zFL65w70mj4oFtm7nNF/klQgxv17zXu/W4bgELeHaSpN
         q+dWJxt6STRog==
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-kernel@vger.kernel.org, perex@perex.cz,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        pierre-louis.bossart@linux.intel.com, tiwai@suse.com
In-Reply-To: <20211130163110.5628-1-srinivas.kandagatla@linaro.org>
References: <20211130163110.5628-1-srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v2] ASoC: qdsp6: q6routing: Fix return value from msm_routing_put_audio_mixer
Message-Id: <163838352534.2179725.3915150186055501532.b4-ty@kernel.org>
Date:   Wed, 01 Dec 2021 18:32:05 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Nov 2021 16:31:10 +0000, Srinivas Kandagatla wrote:
> msm_routing_put_audio_mixer() can return incorrect value in various scenarios.
> 
> scenario 1:
> amixer cset iface=MIXER,name='SLIMBUS_0_RX Audio Mixer MultiMedia1' 1
> amixer cset iface=MIXER,name='SLIMBUS_0_RX Audio Mixer MultiMedia1' 0
> 
> return value is 0 instead of 1 eventhough value was changed
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-linus

Thanks!

[1/1] ASoC: qdsp6: q6routing: Fix return value from msm_routing_put_audio_mixer
      commit: 4739d88ad8e1900f809f8a5c98f3c1b65bf76220

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
