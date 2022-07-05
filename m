Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6924E5676DD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 20:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbiGESwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 14:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232836AbiGESwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 14:52:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7091CFE0;
        Tue,  5 Jul 2022 11:52:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1A03FB8182F;
        Tue,  5 Jul 2022 18:52:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 303C5C341C7;
        Tue,  5 Jul 2022 18:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657047141;
        bh=yI0MSQYt/2idYq5077oft4Ko3AKuq2lB9fmiQNZBdv0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=rfzbtF7es33J4ZWS3ihPhg0w1qCtpvFpMU/qDwjfwbnzcFn8lTwXPBom3UWuLTSqY
         Gogb/BCK0IvwTzQtNyStAvLafvyeWLg5cF2i6E3RO2WMFcd0gYu5UrGWXB+NWTUtdQ
         rOTPuEIlKtdgM3VdlACvJhmP6CDdR4yS6gspxdvbQ6mYX+/ctTiSJ5v+MlAILbF3Wn
         5ntLlLvx2rWJZ37RW8GIAafECM01nX7vi8JhwklRRNDpkQBKswdKb/8UjjznaeCRqD
         5o+Wnf9+x8R1dpiBxW2n6t2j/Xvngrui2suJ/9b2ZH1KsEiOizC4igzVJeGUs9Xm/q
         XkweOITeQ/hhA==
From:   Mark Brown <broonie@kernel.org>
To:     amadeuszx.slawinski@linux.intel.com, lukas.bulwahn@gmail.com,
        cezary.rojewski@intel.com, alsa-devel@alsa-project.org
Cc:     peter.ujfalusi@linux.intel.com, liam.r.girdwood@linux.intel.com,
        pierre-louis.bossart@linux.intel.com,
        ranjani.sridharan@linux.intel.com, yung-chuan.liao@linux.intel.com,
        tiwai@suse.com, linux-kernel@vger.kernel.org, perex@perex.cz,
        kernel-janitors@vger.kernel.org, kai.vehmanen@linux.intel.com
In-Reply-To: <20220705103238.7484-1-lukas.bulwahn@gmail.com>
References: <20220705103238.7484-1-lukas.bulwahn@gmail.com>
Subject: Re: [PATCH] ASoC: Intel: avs: correct config reference for I2S test board
Message-Id: <165704713892.1050281.16411314466657755512.b4-ty@kernel.org>
Date:   Tue, 05 Jul 2022 19:52:18 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Jul 2022 12:32:38 +0200, Lukas Bulwahn wrote:
> Commit e39acc4cfd92 ("ASoC: Intel: avs: Add I2S-test machine board") adds
> the config "SND_SOC_INTEL_AVS_MACH_I2S_TEST", but in the Makefile refers
> to  config "SND_SOC_INTEL_AVS_MACH_i2s_TEST" (notice the uppercase and
> lowercase difference).
> 
> Adjust the Makefile to refer to the actual existing config.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: avs: correct config reference for I2S test board
      commit: f4ba35b79bd0104f00e8e21e400b980bfaa2f17e

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
