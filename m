Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB4546649A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 14:40:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358300AbhLBNoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 08:44:09 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:48574 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358287AbhLBNoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 08:44:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id CAB9ACE22FC
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 13:40:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30603C00446;
        Thu,  2 Dec 2021 13:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638452439;
        bh=pH97v051HvG4h6WMvqgYLd5t3vBlmZgGJRunP35hJzM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=L2RvWu7B0nCxt6PntpOYr06NKE0+WNt/+u75bs3J9GGWHHI5c4ivGCbhd+uHI1xoh
         mYjm26Khz/PspJ+Bke9ARshu3DLAyHwGtZk62dRNLhVBc4h2Qe0LbpT2wTfig0hfhK
         KRKExuWQc2q/rlvDD8l6PiBwyuUWiolLIPEu2K7Qdvvn+QU+ED0Anr2T+A7ew4SZTt
         3YpN2xkWcAvMDIeVS2Y679/DnTlfS8++NJFJic7NgS4VxbZQVo2GLmZBZfisho389A
         kYUq/fYwADtycCRXjhmsGIMoTzXp8YyvSuCMDHip0Qro044ard/Awbcez8wCYFbut3
         bsmJOBLsmHnMA==
From:   Mark Brown <broonie@kernel.org>
To:     Lucas Tanure <tanureal@opensource.cirrus.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>, Len Brown <lenb@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com
In-Reply-To: <20211201174307.1399625-1-tanureal@opensource.cirrus.com>
References: <20211201174307.1399625-1-tanureal@opensource.cirrus.com>
Subject: Re: [PATCH 1/2] ASoC: amd: Fix dependency for SPI master
Message-Id: <163845243689.1057742.11633823789626663814.b4-ty@kernel.org>
Date:   Thu, 02 Dec 2021 13:40:36 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Dec 2021 17:43:06 +0000, Lucas Tanure wrote:
> Select SPI_MASTER as is using CS35L41 SPI driver
> 
> Fixes: 96792fdd77cd1 ("ASoC: amd: enable vangogh platform machine driver build")
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: amd: Fix dependency for SPI master
      commit: 19a628d8f1a6c16263d8037a918427207c8a95a0
[2/2] ASoC: cs35l41: Fix undefined reference to core functions
      commit: 0695ad92fe1a0bb7697eb92c6a145a73c5ab0e24

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
