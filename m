Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D08249B17E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 11:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347312AbiAYKWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 05:22:24 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:46278 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239137AbiAYKUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 05:20:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 04B59B8174E
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 10:20:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79750C340E0;
        Tue, 25 Jan 2022 10:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643106003;
        bh=nJhy+qOwVi2cuvhFT1z4Bk/6ubjHdACKLf5hmIX9cbQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=TuVNIz4bXFcXHLeO+/nQGAidSWhSr4Ah9Q6oLeO9/O1+4oFj+Yl5MpKfS9ADcfx6J
         UQEjYTge2711+ePf1TZWq5vRuvx0e9rxgo/WSrj+nhKcDQ+AuhrtAjElomrXRCkT5z
         21iiuM9RjCjnx+PEL6JGPJkhSID8NQa3NgdOI8gQ4SdcUtXyeBMRcRvvAUjA1wiV32
         Wv/9wG7sEBkQmyubyxAnhUVHulwX8gOh19pjT09OyDXd84wk7axmHyv+MiODI4QxuR
         0r6P3lVM5W+T481TZNcia9u+h+EPtB1+NOGJKTu8mawd4ygwVl/5qZMBwIoV8NL7+1
         tEjukBPY/ajXg==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
Cc:     Alexander.Deucher@amd.com,
        V sujith kumar Reddy <vsujithkumar.reddy@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>, Sunil-kumar.Dommati@amd.com,
        Vijendar.Mukunda@amd.com, Jaroslav Kysela <perex@perex.cz>,
        Basavaraj.Hiregoudar@amd.com
In-Reply-To: <20220120133605.476138-1-AjitKumar.Pandey@amd.com>
References: <20220120133605.476138-1-AjitKumar.Pandey@amd.com>
Subject: Re: [PATCH] ASoC: amd: acp-mach: Fix Left and Right rt1019 amp devices
Message-Id: <164310600119.74817.7303379317708830215.b4-ty@kernel.org>
Date:   Tue, 25 Jan 2022 10:20:01 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jan 2022 19:06:01 +0530, Ajit Kumar Pandey wrote:
> We're setting wrong card codec conf for rt1019 amp devices in our
> machine driver. Due to this left and right amp channels data are
> reversed in our machines as wrong device prefix results in wrong
> value for "Mono LR Select" rt1019 mixer control. Reverse dev ids
> in codec conf with Left and Right name_prefix to fix such issue.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-linus

Thanks!

[1/1] ASoC: amd: acp-mach: Fix Left and Right rt1019 amp devices
      commit: 248be352bbae1a0f14d0d3511a5b0bb9665097f5

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
