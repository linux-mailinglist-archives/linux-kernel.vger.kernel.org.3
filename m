Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B95E253FC9C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 13:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242358AbiFGK76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 06:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242279AbiFGK7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:59:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A204101920
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 03:54:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BA74DB81F02
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 10:54:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 269DBC385A5;
        Tue,  7 Jun 2022 10:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654599294;
        bh=ju/thgHaZCbsHEzLfcSKTct+dzcKTeAOXbp1o1LwCQM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=L6xt5hVuwzBV7LAzSmGLfvgwJXVojmrbNxtvGFtE1f00OM1L+m2M2H8tTgpqdJybB
         MuIxhN4w+yE53pJAtHEGe5qYxtlpvlQoSOSCbOytRga9WyZsFN9X8csn2xp/a2tco9
         abxMo71A1hiHKx541Ql2ZTZrlkKU0P/52J/0HMyeCT2kVw4JcfCPScWx9bDe9U3r5/
         C2VMduevRuenRg2+veqMhAMsdnjXpbYkdm/Vrv1gEfiow3X93mnPC/Z7yO5L0pXwem
         YvPEQQHuWA4d60dOGdJO6sjX1ICbHs9EqDmyo0bYJ7w1VDCHd0AkQ0TEKsQFkbin4L
         2IFfCXBiYkciw==
From:   Mark Brown <broonie@kernel.org>
To:     perex@perex.cz, tiwai@suse.com, vitalyr@opensource.cirrus.com
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com
In-Reply-To: <20220427150720.9194-1-vitalyr@opensource.cirrus.com>
References: <20220427150720.9194-1-vitalyr@opensource.cirrus.com>
Subject: Re: (subset) [PATCH 00/26] ALSA: hda: cirrus: Add initial DSP support and firmware loading
Message-Id: <165459929286.399031.12191464826134197101.b4-ty@kernel.org>
Date:   Tue, 07 Jun 2022 11:54:52 +0100
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

On Wed, 27 Apr 2022 16:06:54 +0100, Vitaly Rodionov wrote:
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
