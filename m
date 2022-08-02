Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1C0E588320
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 22:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234774AbiHBU2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 16:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234969AbiHBU2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 16:28:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153CE52DEB
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 13:28:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE3196102D
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 20:27:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 064EBC433C1;
        Tue,  2 Aug 2022 20:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659472079;
        bh=9+uTudOKSevR9wNY63ife8yPw0XoLqdJ5VHxjsyvLOc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=IEdM/T8c2RW0QTzNsieYpVLNgoykjJDlyv//avXW9ZRb9k4zySej4HuKm/zg/kLto
         bFLBHU50b+kAx9B2snWI8pASz+/I56GDipKnI2rYJHxh5jC+g0IovHqWNWaFDG0tK9
         aK7yTzjFUcnwsI+A8rZvKPvGqDDsIVqXWNV4XQdWi+sVPLIgZt/ua8qJuEySx3SfK5
         DlUXU9U2ZaHXFlSZFs4ibTVkobs0azBOL1vATHdXGDGB2Q8J8JKDe4LSswJDqyvRC+
         RqzHzFw6tUVsaS9xXnCwxRcrBFs0jB9s/fKiuXyVEUqJ7nIsyAiLxejo+y8ZcmziyX
         Q36yi7D43nZ4g==
From:   Mark Brown <broonie@kernel.org>
To:     Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        alsa-devel@alsa-project.org
Cc:     Vijendar.Mukunda@amd.com,
        Pananchikkal Renjith <renjith.pananchikkal@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Jaroslav Kysela <perex@perex.cz>, Sunil-kumar.Dommati@amd.com,
        Basavaraj.Hiregoudar@amd.com,
        open list <linux-kernel@vger.kernel.org>
In-Reply-To: <20220802062503.159328-1-Syed.SabaKareem@amd.com>
References: <20220802062503.159328-1-Syed.SabaKareem@amd.com>
Subject: Re: [PATCH] ASoC: amd: yc: Update DMI table entries for AMD platforms
Message-Id: <165947207673.2174889.4273360535834711916.b4-ty@kernel.org>
Date:   Tue, 02 Aug 2022 21:27:56 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fe10a
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Aug 2022 11:55:00 +0530, Syed Saba Kareem wrote:
> From: syed sabakareem <Syed.SabaKareem@amd.com>
> 
> Updated DMI entries 21EM, 21EN, 21J5 and 21J6 for
> AMD platforms P15v Gen 3 and P14s Gen 3.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: yc: Update DMI table entries for AMD platforms
      commit: c0fc96fed7ffa3e58f58b9cdb7158b5c61e026a2

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
