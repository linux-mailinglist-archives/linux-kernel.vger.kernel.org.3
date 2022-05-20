Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E730F52EA9C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 13:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348461AbiETLS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 07:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346848AbiETLSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 07:18:46 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA9D914AA74
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 04:18:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 0F43DCE2A09
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 11:18:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34D0CC34113;
        Fri, 20 May 2022 11:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653045520;
        bh=DbozWUA8l+/nc8nWGrNyayfGeTWLYFZBoyJhygSVS90=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=BCumOtXXJjMUuU8HP8qlOiM/Zn10Qly7EvKIPAhMPl8Nftlg8/T0Noa3BRCsTr0bn
         9zMVhTZONKIfQe7kWxEIasA5phVDb6eK0OQISR80TjzvLeyBX602fk6M/PcvdJd5xm
         7J2ZQytKph1qQW5qNTJ0qPwohdcZnA9FHs7hTMSxUonfM9WLgAgVXhn9c6fZttrLGr
         8YN86Y6WRG8Mf6ZYYYN0EmElK0uA5kf77B1wGojKA20AT6T6X5Wa2zVlqVTzQsfBAR
         XKk7nHVJr/dtXLMJTPpuvbtg48fLohXCP698knh5q1TXYhyiKsXLt8B2PJGALfR9wZ
         RSv4bSNlvJ1qw==
From:   Mark Brown <broonie@kernel.org>
To:     Vsujithkumar.Reddy@amd.com, alsa-devel@alsa-project.org
Cc:     AjitKumar.Pandey@amd.com, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Basavaraj.Hiregoudar@amd.com,
        ajitkumar.pandey@amd.com, Vijendar.Mukunda@amd.com,
        open list <linux-kernel@vger.kernel.org>,
        Sunil-kumar.Dommati@amd.com, Liam Girdwood <lgirdwood@gmail.com>
In-Reply-To: <20220516160619.17832-1-Vsujithkumar.Reddy@amd.com>
References: <20220516160619.17832-1-Vsujithkumar.Reddy@amd.com>
Subject: Re: [PATCH v2 1/2] Revert "ASoC: amd: acp: Set gpio_spkr_en to None for max speaker amplifer in machine driver"
Message-Id: <165304551793.45439.12289149064085038567.b4-ty@kernel.org>
Date:   Fri, 20 May 2022 12:18:37 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 May 2022 21:36:09 +0530, V sujith kumar Reddy wrote:
> ASoC: amd : acp : Set Speaker enable/disable pin through rt1019 codec driver.
> 
> RT1019 codec has two ways of controlling the en_spkr.
> one way is controlling through gpio pin method the another way is through codec register update through driver.
> 
> Now Speaker enable/disable is controlled  through codec register updated by codec driver.
> This patch reverts gpio logic.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] Revert "ASoC: amd: acp: Set gpio_spkr_en to None for max speaker amplifer in machine driver"
      commit: 6107fb660749507d5e02988151e45884b5423cdc
[2/2] Revert "ASoC: amd: acp: Power on/off the speaker enable gpio pin based on DAPM callback."
      commit: 17572892e3beefe68d0875ecfd015eef521c244d

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
