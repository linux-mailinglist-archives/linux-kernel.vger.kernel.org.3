Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C89554BE27C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:55:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379060AbiBUPYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 10:24:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236633AbiBUPYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 10:24:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C421DA7B
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 07:24:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 011B661050
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 15:24:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DEDEC340E9;
        Mon, 21 Feb 2022 15:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645457058;
        bh=61j2DG9XsjT6XMPvA8okjWZ5trrMT2Q8ZLz9fkWalkI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=rPXIGliSXsd2BgfOyQQQhlXqEN46OgFAjIs5HNM3FQl44c+7IB5PJdBOX2+a1rF51
         547imM4xzdjobpmrsTtqnaDe5Hrm0OPoKbQWjFqTfED9FRnLSVPaHzYEw9vH4f6hsr
         enFX7ObBCDsUdKY9OwEnsyl57Tdsp/iOmX7UlpCNaZYnhPgP9jGn97TVIfrKxtyEe3
         9w2IV1AdL8dL/7C5nfSjyTJaajh+6J5jznpUTT39IjOE03MmrscguWA6fH/HVRML9S
         HPlszUDLDPADY6PSOEz4K5gRcWRJf/NjQVQhPKBi8TwMM+yln/6K1pqY00wqMKc8kP
         gGXJgfPSjazjg==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org, Brent Lu <brent.lu@intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Ajye Huang <ajye_huang@compal.corp-partner.google.com>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        sound-open-firmware@alsa-project.org
In-Reply-To: <20220218082741.1707209-1-brent.lu@intel.com>
References: <20220218082741.1707209-1-brent.lu@intel.com>
Subject: Re: [PATCH] ASoC: SOF: Intel: Add topology overwrite for Felwinter
Message-Id: <164545705583.730905.504549990237487794.b4-ty@kernel.org>
Date:   Mon, 21 Feb 2022 15:24:15 +0000
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

On Fri, 18 Feb 2022 16:27:41 +0800, Brent Lu wrote:
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
