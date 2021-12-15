Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD7324750B1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 03:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239051AbhLOCEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 21:04:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238932AbhLOCEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 21:04:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E84C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 18:04:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2683DB81E03
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 02:04:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B723C34605;
        Wed, 15 Dec 2021 02:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639533845;
        bh=IWMYBLB6oHRGoxE2RfsNrXH5WTs9ttS/9AQJni+86hM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=UkeJK+3ITlTp/bUTmZ6vJeVXFz0gnCoPyPL1FKhAsJGVrdAmDfGkWeSrzsCaeyyzw
         00z0KkfglsBuV+tJ5Ij8DWdFFzzvvBBstj0M/+p8eGlo4vjsiiObv/JHJj8FYuqxI9
         82MhBYVueq4ZeP6XTmSK8YPjxQsS7KHkw5fuY9/WE81xNVQtRHMBnHVkvgyn1zYiUI
         +rrxAhqoATlM3ARuR40wvdGeylIAOjREytNZXKxiUvRw2ozQQXn8WGDCHxbStJvizN
         JJtjBNb10sMs73xKkNOa+dVqCWdSoCayZFdppw2+BbN+4lNk5KF0AfgaGIaiQ25af/
         KB/EaE4686kUA==
From:   Mark Brown <broonie@kernel.org>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
        Jaroslav Kysela <perex@perex.cz>,
        Banajit Goswami <bgoswami@codeaurora.org>
In-Reply-To: <20211211065840.1221-1-linmq006@gmail.com>
References: <20211211065840.1221-1-linmq006@gmail.com>
Subject: Re: [PATCH] ASoC: qdsp6: Fix an IS_ERR() vs NULL bug
Message-Id: <163953384289.1515253.11852619993223419677.b4-ty@kernel.org>
Date:   Wed, 15 Dec 2021 02:04:02 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Dec 2021 06:58:29 +0000, Miaoqian Lin wrote:
> The function gpr_alloc_port return ERR_PTR on errors, it doesn't return
> null.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: qdsp6: Fix an IS_ERR() vs NULL bug
      commit: 59716aa3f9764144cdd558c64f04cb83001b71ac

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
