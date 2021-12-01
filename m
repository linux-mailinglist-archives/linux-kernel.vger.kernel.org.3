Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64DD1465586
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 19:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352534AbhLASg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 13:36:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352504AbhLASfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 13:35:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC17C061758;
        Wed,  1 Dec 2021 10:32:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E6C38B82101;
        Wed,  1 Dec 2021 18:32:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D46D9C53FD0;
        Wed,  1 Dec 2021 18:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638383546;
        bh=8QeTRR6fzbW3YoUdz05s4uoxupr6A3ZHABdEKS5V9Dg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=uBi1dA24wNF5B9tBTaVUh5fYvwRi+pViAkAyYfZDTypTtrzxTLi+QBODQ1l+gYRJT
         BrXMz/ToKakeZRJWOqeZB3cjN6vZv46nQY/mqTNVeTaOzHudv29qHLmsu1Tx/kOrPP
         8g7XRSsrMc3M4BzC1WhMKAPcinmMOjIp04NJny4SfP0P1go34n+LaQpUHSGwRcX7uX
         c/lPzuiFPUMQH1ixZEKOEcN83AYl6fYPAndecKangqzXq37skBXQ7Wbt+UydUXTkVT
         rvwcw7TC56hv+GmV3oUV7xui9/k/jTPImocbkJ/NiLGcGBZjgYDNxyWyd77EjMLE4k
         0d5XZ5dfuclVQ==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, perex@perex.cz,
        Sameer Pujar <spujar@nvidia.com>, tiwai@suse.com
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        alsa-devel@alsa-project.org, jonathanh@nvidia.com,
        thierry.reding@gmail.com
In-Reply-To: <1638278605-28225-1-git-send-email-spujar@nvidia.com>
References: <1638278605-28225-1-git-send-email-spujar@nvidia.com>
Subject: Re: [PATCH v2] ASoC: tegra: Add master volume/mute control support
Message-Id: <163838354459.2179787.6061621614012995607.b4-ty@kernel.org>
Date:   Wed, 01 Dec 2021 18:32:24 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Nov 2021 18:53:25 +0530, Sameer Pujar wrote:
> The MVC module has a per channel control bit, based on which it decides
> to apply channel specific volume/mute settings. When per channel control
> bit is enabled (which is the default HW configuration), all MVC channel
> volume/mute can be independently controlled. If the control is disabled,
> channel-0 volume/mute setting is applied by HW to all remaining channels.
> Thus add support to leverage this HW feature by exposing master controls
> for volume/mute.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: tegra: Add master volume/mute control support
      commit: 0d242698fa693ab8cb98c11ba7cf7fc8f7242c0b

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
