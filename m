Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3218F4C7894
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 20:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiB1TQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 14:16:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiB1TQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 14:16:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B046E4D0D
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 11:15:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E2629B8162E
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 19:15:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73FECC340F3;
        Mon, 28 Feb 2022 19:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646075752;
        bh=cMbSw8Fb7GWoqvCsagH+i3hAKkm+1SuWh32xT/umKsE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=CRk5bysDvfwYe58YEv2XrSE90z6K9q1CUrz/HEhuuyFt06SWE1qsGMQanTOsfduEC
         nMsnpXddH6OdGlZwI8YvzGFfzkBXBodzgpWvJk0fhlVoS4hvhg/Nna+SMttc9bl7up
         1BgsnMWmhJltgaC0z81T5TX67WG+z1fivjxEnIqFGob6U4H5KwBxTNKt27X88+QxFq
         BRrFU3qdrWHI8Dwrni+tcCUIk97sMyg6hvaQyW91PVGNQ1qolk/vvRq9OdQsDKJPUQ
         BA5NAXgGC8PwW3iATE6kOU018u783WqebHDcpd2JttVY/qeYr2DS+VQFUMDvtXFFUc
         TC4ns6ICflyWQ==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sunil-kumar.Dommati@amd.com, Jaroslav Kysela <perex@perex.cz>,
        Alexander.Deucher@amd.com, dan.carpenter@oracle.com,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>, krisman@collabora.com,
        open list <linux-kernel@vger.kernel.org>
In-Reply-To: <20220225193054.24916-1-Vijendar.Mukunda@amd.com>
References: <20220225193054.24916-1-Vijendar.Mukunda@amd.com>
Subject: Re: [PATCH V2 1/4] ASoC: amd: vg: fix for pm resume callback sequence
Message-Id: <164607575019.3538791.4372801541502826813.b4-ty@kernel.org>
Date:   Mon, 28 Feb 2022 19:15:50 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Feb 2022 01:00:22 +0530, Vijendar Mukunda wrote:
> The previous condition is used to cross check only the active
> stream status for I2S HS instance playback and capture use cases.
> 
> Modified logic to invoke sequence for two i2s controller instances.
> 
> This also fixes warnings reported by kernel robot:
> "warning: variable 'frmt_val' set but not used"
> "warning: variable 'reg_val' set but not used"
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] ASoC: amd: vg: fix for pm resume callback sequence
      commit: 83b713619ee1b15e09eae11a92a7f3305534223d
[2/4] ASoC: amd: vg: update DAI link name
      commit: 5363d7304e31692f8f6da86ed7a49d3c28a2e32a
[3/4] ASoC: amd: vg: remove warnings and errors pointed out by checkpatch pl
      commit: 728a592619cfb9be8b66600d04ef9fee9237fe7e
[4/4] ASoC: amd: vangogh: fix uninitialized symbol warning in machine driver
      commit: 6f989800639a7a29ab9a02e165b04dc144dd4f2b

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
