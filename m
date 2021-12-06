Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00F0346A393
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 19:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345766AbhLFSEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 13:04:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345568AbhLFSEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 13:04:06 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE43C061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 10:00:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 33BB3CE1767
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 18:00:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40185C341CA;
        Mon,  6 Dec 2021 18:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638813634;
        bh=P/4KZcHyQBwdHWd9kJQOIqw/zF3r6oRodHZk4R4fOFk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=q4NPdFYsLfErSx+tyEJOQJolerVVKQvIvS8Z32g3CyoGHdf17pItgJIiI1PKD8Qhe
         I3il1FtYhk2bJF4Nb9AQdmcjpu2yWdYBNqH1oKHoEPmZcvrzMvSek0GjV35ZpwTlFz
         tMCcahI3VfxQAUdvPc40chf3oXqwhuJimxz2EzCq3xkIzUczMol1ZR9sPjuWChk5J0
         ZDFdc2xZ1sNGDx9Q+/B3BQGWvtH4tj10HtuNnL8u3vZJyrwMdjboOOANlZtuEUZp7z
         ZYvRKVz8hay/+hIwjhTQc/Mqo91gy6QMDcEPTgGbB8PcpArdmkPhTuU6bdqq0hWkfm
         M1EF+unGma/bw==
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        alsa-devel@alsa-project.org,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        linux-kernel@vger.kernel.org
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>
In-Reply-To: <20211202205612.76216-1-andriy.shevchenko@linux.intel.com>
References: <20211202205612.76216-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/2] ASoC: ti: davinci-mcasp: Get rid of duplicate of_node assignment
Message-Id: <163881363192.2769299.4699480471274162450.b4-ty@kernel.org>
Date:   Mon, 06 Dec 2021 18:00:31 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Dec 2021 22:56:11 +0200, Andy Shevchenko wrote:
> GPIO library does copy the of_node from the parent device of
> the GPIO chip, there is no need to repeat this in the individual
> drivers. Remove assignment here.
> 
> For the details one may look into the of_gpio_dev_init() implementation.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: ti: davinci-mcasp: Get rid of duplicate of_node assignment
      commit: 4db32072b8ab18a8b90191c57c74f42d00bf9991
[2/2] ASoC: ti: davinci-mcasp: Remove unnecessary conditional
      commit: c1a77ba466c0dd0bdf1ec2bbebb8996d7cd7b8f7

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
