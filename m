Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 874E34BE939
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379057AbiBUPYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 10:24:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236633AbiBUPYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 10:24:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CED91DA7B
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 07:24:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DA3D7B80E9B
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 15:24:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3748C340EC;
        Mon, 21 Feb 2022 15:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645457061;
        bh=MW2Yg1Kfyp2Pc04JtrMTt1mmSjFcqsfeEWHrq1tp5ZI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=MvuEPI44YNV4uqrNek4yRX2u1HAYJGNNWEu43R2dUulIfG5gN1QZHBsP6WqsvHAFT
         8Ae6IJu1Um68cL+p+W3fum2eTncELXcdvLN8/3sr0i2etvMD2EZ3nUMPgzfbUbGSpt
         gbDmLBI/LdEXPECp06YZqtHhaba3kvvc8wssvL30qVZGCow+zUFl3WjTY9qJFX0kT9
         CMjrBKeEc9MFXwOmCUA6fUpmXMbxcQqLqfzjBuGkCEvYsSO2mavrPu2hGDhQeVpVm0
         iYZunii92i7zNygEvuFNPbBEYtLL4Lyl+LhQthU3KHDHQmFbRoSPEASU/xcTLtJRfO
         3cvw6U0n1hzBQ==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org, Brent Lu <brent.lu@intel.com>
Cc:     Ajye Huang <ajye_huang@compal.corp-partner.google.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Curtis Malainey <cujomalainey@chromium.org>,
        linux-kernel@vger.kernel.org,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        sound-open-firmware@alsa-project.org
In-Reply-To: <20220221064005.1752500-1-brent.lu@intel.com>
References: <20220221064005.1752500-1-brent.lu@intel.com>
Subject: Re: [PATCH v2] ASoC: SOF: Intel: Add topology overwrite for Felwinter
Message-Id: <164545705858.730905.4275248547658138991.b4-ty@kernel.org>
Date:   Mon, 21 Feb 2022 15:24:18 +0000
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

On Mon, 21 Feb 2022 14:40:05 +0800, Brent Lu wrote:
> From: Ajye Huang <ajye_huang@compal.corp-partner.google.com>
> 
> The Felwinter uses four max98360a amplifiers on corresponding CH0~CH3.
> There are four amps on the board connecting to headphone to SSP0 port,
> amp to SSP1,and the DAI format would be DSP_A,8-slots, 32 bit slot-width.
> 
> CH0: L(Woofer), CH1:R(Woofer), CH2:L(Tweeter), CH3:R(Tweeter)
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: Intel: Add topology overwrite for Felwinter
      commit: b9afe038b1fba24e815000606d5877de97f9f154

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
