Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1D0B4C2B95
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 13:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234265AbiBXMWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 07:22:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233483AbiBXMWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 07:22:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E02814A226
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 04:22:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 36F3CB825AD
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 12:22:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB28BC340EF;
        Thu, 24 Feb 2022 12:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645705337;
        bh=ikkN2YoGGWogUak8Lx7mLrwtFejuueYGRl1XesvHbbc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ZLSc7lw1sTED5X1uFF6me+c7UIvKmPBVYfnyP0XKIOIMWpENY1OBOuMHinQEN1DiX
         pjRy50SetB0w0agqTqCbu6nbpOZNQ2SkXaB30USdOvlxuyFeICy4NOxyHov48UWz3J
         CbAto/2k9+71MNPcDOaTJV/e9rJok7KCThR1dp0R1TXBAOmjnUYbKt8OgvX/8znTl+
         U7Ih39PVhN/bH41LVRz/W3GpKo2H2/VTJ34TAIcuXdicgXTpErCEryuGBNeKOL8bQa
         WI/Kab1GNz3Nm9wlokGh6r+ekGFy2mc+qv7POI66yzTYt4O36YikEzpImm8UvEuSag
         OrasTihSOMCEQ==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc:     Takashi Iwai <tiwai@suse.com>, Alexander.Deucher@amd.com,
        krisman@collabora.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>, Sunil-kumar.Dommati@amd.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        open list <linux-kernel@vger.kernel.org>, wtli@nuvoton.com
In-Reply-To: <20220223071959.13539-1-Vijendar.Mukunda@amd.com>
References: <20220223071959.13539-1-Vijendar.Mukunda@amd.com>
Subject: Re: (subset) [PATCH 1/9] ASoC: amd: vg: fix for pm resume callback sequence
Message-Id: <164570533555.1194769.3668536221336070255.b4-ty@kernel.org>
Date:   Thu, 24 Feb 2022 12:22:15 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Feb 2022 12:49:30 +0530, Vijendar Mukunda wrote:
> The previous condition is used to cross check only the active
> stream status for I2S HS instance playback and capture use cases.
> 
> Modified logic to invoke sequence for two i2s controller instances.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-linus

Thanks!

[1/9] ASoC: amd: vg: fix for pm resume callback sequence
      (no commit info)
[2/9] ASoC: amd: vangogh: refactor i2s master mode clock sequence code
      commit: 5ca4cf2c83dac27768f1d7d3e2404f5a17830ca5
[3/9] ASoC: nau8821: enable no_capture_mute flag
      commit: aa9753a4677d0a2c53e7e46ca173c985a3f7b83e
[4/9] ASoC: amd: vg: update platform clock control sequence
      commit: 9a617f0e109cfba2017d76f807ebb3a00c47bdca
[5/9] ASoC: amd: vg: apply sample bits pcm constraint
      commit: 0c38cc1dd17e766eada0aa44be4c1a47bcbb7bc3
[6/9] ASoC: amd: vg: update acp init and deinit sequence
      commit: a9230ccc0c6f5fca0b94f57729dc61e0a6098a0a

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
