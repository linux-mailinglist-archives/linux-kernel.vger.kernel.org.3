Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE08A53FCC4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 13:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242010AbiFGLBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 07:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240564AbiFGK7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:59:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E080101938
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 03:54:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3ADCEB81ED8
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 10:54:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEDA9C34115;
        Tue,  7 Jun 2022 10:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654599296;
        bh=xbOX5mYkYBdJEqOXhSxMTeZkmlq7lnOk2/ZsAiL1Tyo=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=qyplBmBShWIbJyMIvseP/yZMDi+AHH5oxkL11uIwH2u7nYCWOVENTQ3eAH3XMTSc2
         ll9493erhcvy7CTionMdJK/T8tZ2IZfo+cal/sJs7oO12Tk0C8nAU8gv7rMGiUhgp6
         e4/Bvu3xaBJoT/ZxqRvDDX/0qE59iDOxGZ4DqO2al8t3uVNmxO8NFD61BPSNoHTYdR
         +QtrF2NmVd47US0OMol8d3hmlSF/5JXLmOh8j9lofcWRwUU89xLoIH9l2DGdNqIDk1
         3ZxHm3wT+G7FMfTW8ffgvlaXAdI6vEBWiGRHf2uIe+AnPuzTRe2TlkTeGhtQFndJMZ
         0gfUYZkIqkG4w==
From:   Mark Brown <broonie@kernel.org>
To:     perex@perex.cz, tiwai@suse.com, vitalyr@opensource.cirrus.com
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com
In-Reply-To: <20220509214703.4482-1-vitalyr@opensource.cirrus.com>
References: <20220509214703.4482-1-vitalyr@opensource.cirrus.com>
Subject: Re: (subset) [PATCH v2 00/26] *ALSA: hda: cirrus: Add initial DSP support and firmware loading
Message-Id: <165459929457.399031.11506855716693117654.b4-ty@kernel.org>
Date:   Tue, 07 Jun 2022 11:54:54 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 May 2022 22:46:37 +0100, Vitaly Rodionov wrote:
> The CS35L41 Amplifier contains a DSP, capable of running firmware.
> The firmware can run algorithms such as Speaker Protection, to ensure
> that playback at high gains do not harm the speakers.
> Adding support for CS35L41 firmware into the CS35L41 HDA driver also
> allows us to support several extra features, such as hiberation
> and interrupts.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[06/26] ASoC: cs35l41: Move cs35l41_set_cspl_mbox_cmd to shared code
        (no commit info)
[07/26] ASoC: cs35l41: Move cs35l41 fs errata into shared code
        (no commit info)
[08/26] ASoC: cs35l41: Move cs_dsp config struct into shared code
        (no commit info)
[18/26] ASoC: cs35l41: Move cs35l41 exit hibernate function into shared code
        commit: 94e0bc317ad241c022a6bb311b3a28b4d51ea8b6
[19/26] ASoC: cs35l41: Do not print error when waking from hibernation
        commit: 97076475e2fdf471348b9ce73215cdbceeb4390f
[20/26] ASoC: cs35l41: Add common cs35l41 enter hibernate function
        commit: e341efc308e5374ded6b471f9e1ec01450bcc93e

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
