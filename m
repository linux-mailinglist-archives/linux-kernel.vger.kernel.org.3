Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8E257E977
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 00:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236720AbiGVWFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 18:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiGVWFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 18:05:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D4472BE5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 15:05:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 243A2621E1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 22:05:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B925C341CE;
        Fri, 22 Jul 2022 22:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658527548;
        bh=oU/aXEm4nJoyqONNRlbDnt9H4TtoyZTFmxF9qtTL25w=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=D/cuEjPr3ARaTBbeeLJyFTN981UU44GqLg/VbzfQWmk5sdYSjMxvejQxyKg9aBQTW
         DZganrXGblOtY6BFf3ahqTgSDcZzmA5h0iAclGx0rpIUJxHYQmVVzuf+I9Fd1JCFVz
         PGurpeKaJSBpFamkef1HElOFijqpJ97p5Va32Pi4CwTiJhIWypaUTtRCDa5JSfYdhq
         ANtbL/9LICjXxTeWi41X6F+41IxyZtU6bhYIRl33aHZk3H7QFO+PG+6TwGwfdQAV8w
         xXzYFyx7Nxvjyxe5dIb+zclOh/jnhB6oOQcjHgdl87vqoAVEkfKpOcgjB4fl0hcEUu
         koUNRNe3o8Pew==
From:   Mark Brown <broonie@kernel.org>
To:     syed sabakareem <Syed.SabaKareem@amd.com>,
        alsa-devel@alsa-project.org
Cc:     open list <linux-kernel@vger.kernel.org>,
        Sunil-kumar.Dommati@amd.com, Jaroslav Kysela <perex@perex.cz>,
        vijendar.mukunda@amd.com, mario.limonciello@amd.com,
        Alexander.Deucher@amd.com,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Takashi Iwai <tiwai@suse.com>, markpearson@lenovo.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Basavaraj.Hiregoudar@amd.com
In-Reply-To: <20220722134603.316668-1-Syed.SabaKareem@amd.com>
References: <20220722134603.316668-1-Syed.SabaKareem@amd.com>
Subject: Re: [PATCH] ASoC: amd: yc: Update DMI table entries
Message-Id: <165852754583.1234289.15095760330208840152.b4-ty@kernel.org>
Date:   Fri, 22 Jul 2022 23:05:45 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-c7731
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jul 2022 19:15:32 +0530, syed sabakareem wrote:
> Removed intel DMI product id's 21AW/21AX/21D8/21D9/21BN/21BQ
> in DMI table and updated DMI entry for AMD platform X13 Gen 3
> platform 21CM/21CN.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216267
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: yc: Update DMI table entries
      commit: be0aa8d4b0fcb4532bf7973141e911998ab39508

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
