Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9778647F00A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 17:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353145AbhLXQR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 11:17:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbhLXQR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 11:17:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D2AC061401
        for <linux-kernel@vger.kernel.org>; Fri, 24 Dec 2021 08:17:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8705B620C7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Dec 2021 16:17:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6197AC36AE5;
        Fri, 24 Dec 2021 16:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640362645;
        bh=mJLIP+3iPkvpArcj3EuZodobAtm/gAMmCj0NsAAWPRk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=s8jrUB+HKocAO50S6nP0C/EMzuFNoji/WPsn8iPAAiwD6Gwc6BsHQ6L0M19Iq0k5D
         59azYjMEkbajAF99j7ftN3MfepCZ41RFrbbb2zDe+M/wqKawY3DB6eB+gfGZsAHMbC
         oJuxzzhGQKDzo+NRSvNT6Tbykrur79YP7mJOVre5iZ0vhXJMamrDzXZzB6RZhMJCKP
         IWQUrtCgGoRkdTcMuNIfEm24IhO850RmCLDU6hqO8No/sofM3ruZShX5ZLlFHoID4m
         LCGvylBJvLNQ4KyxrL4f5zehlQ68/w4Sap6IWOTF10QWYFRmIWws2Ch0+gN60uXseh
         IkSI/cDX4oUig==
From:   Mark Brown <broonie@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     linux-kernel@vger.kernel.org, srinivas.kandagatla@linaro.org,
        tiwai@suse.de, vinod.koul@linaro.org, gregkh@linuxfoundation.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com,
        sanyog.r.kale@intel.com
In-Reply-To: <20211213054634.30088-1-yung-chuan.liao@linux.intel.com>
References: <20211213054634.30088-1-yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH 0/7] ASoC/SoundWire: improve suspend flows and use set_stream() instead of set_tdm_slots() for HDAudio
Message-Id: <164036264309.3720027.15998614082881107063.b4-ty@kernel.org>
Date:   Fri, 24 Dec 2021 16:17:23 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Dec 2021 13:46:27 +0800, Bard Liao wrote:
> This series contains three topics.
> 1. SoundWire: Intel: remove pdm support
> 2. ASoC/SoundWire: dai: expand 'stream' concept beyond SoundWire
> 3. ASoC/SOF/SoundWire: fix suspend-resume on pause with dynamic pipelines
> 
> The topics are independent but the changes are dependent. So please
> allow me to send them in one series.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/7] ASOC: SOF: Intel: use snd_soc_dai_get_widget()
      commit: da893a93eaf8eb2bce03862e00b9998463eeaecf
[2/7] ASoC/soundwire: intel: simplify callbacks for params/hw_free
      commit: b86947b52f0d0e5b6e6f0510933ca13aad266e47
[3/7] soundwire: intel: improve suspend flows
      commit: 8ddeafb957a9a6dd33b2c80309d726d3141df08f
[4/7] ASoC/SoundWire: dai: expand 'stream' concept beyond SoundWire
      commit: e8444560b4d9302a511f0996f4cfdf85b628f4ca
[5/7] ASoC: Intel/SOF: use set_stream() instead of set_tdm_slots() for HDAudio
      commit: 636110411ca726f19ef8e87b0be51bb9a4cdef06
[6/7] soundwire: intel: remove unnecessary init
      commit: 9283b6f923f3bdd92bdeaf259c6b7a5e9dac6900
[7/7] soundwire: intel: remove PDM support
      commit: 63a6aa963dd01b66019b7834cc84d032e145bb00

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
