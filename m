Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79B7F46A394
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 19:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345807AbhLFSEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 13:04:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345727AbhLFSEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 13:04:09 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A42C061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 10:00:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 66142CE16C3
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 18:00:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E49EFC341C5;
        Mon,  6 Dec 2021 18:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638813636;
        bh=AiU1xc1Jnt2ICB58kMPE7QKt3CB5Vizbk3iw6XtQqK0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=mciFNq34peMArE3urpNFdCWCDAh3GA2RtbopuFzoJI381ImLflVp3/sRmyQ8N8AKY
         lsvSmqFCQVnA5lg0wbHGGC0xVvPQgzTI2HlV9taN6Jnb+jN9k5ocZCJ0DiY4TjSKVo
         42w4slGBBURvfyjvXZ8xmkc5jwAxwXRx8a3R8dVJ4tW8NiaBcMA6+3Sm004OpAthWI
         Q/hhxHZhId6sHYlDymMjFP3/KxsNr6khJgZIlEsCeYtjd5hPNm8Pu88ygoBdVKCxfI
         ockfAzoleyIi0iro5iLPrqg+2YN0vDu4vwEj4OP5z/z7U6+TxUuHtdF2itkBd8Sjak
         u/u9kGzzlMbwg==
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>
In-Reply-To: <20211202204838.75287-1-andriy.shevchenko@linux.intel.com>
References: <20211202204838.75287-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] ASoC: zl38060: Setup parent device and get rid of unnecessary of_node assignment
Message-Id: <163881363460.2769299.5427691491147846285.b4-ty@kernel.org>
Date:   Mon, 06 Dec 2021 18:00:34 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Dec 2021 22:48:38 +0200, Andy Shevchenko wrote:
> Some of the drivers do not set parent device. This may lead to obstacles
> during debugging or understanding the device relations from the Linux
> point of view. Assign parent device for GPIO chips created by these
> drivers.
> 
> While at it, let GPIO library to assign of_node from the parent device.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: zl38060: Setup parent device and get rid of unnecessary of_node assignment
      commit: 766cc7f12078fe80dd88469e3dfe045e49bdf2bb

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
