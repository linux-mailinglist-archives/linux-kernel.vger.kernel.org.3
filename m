Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 651264FE74F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 19:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358500AbiDLRlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 13:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358481AbiDLRkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 13:40:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167D362A36
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 10:38:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2CA1619D7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 17:38:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4F98C385A5;
        Tue, 12 Apr 2022 17:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649785098;
        bh=HD2LcDKvmyG1fX0S/usHPsdJIssyypdemdstvg2vvdw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=gqoXRvUimZcFcceovn2J+Rf0GqMz1odxtZPMaghx4ByR0cKWfTWG5VEM2QrVeBYH1
         npd9mnieADkXqady/jsxlCiUZNyO3H1Fb8/8MIVfRg58BELqI/sFUv6e80KNj3f/ln
         YGDdmdqlVQilOFekgWKjXfw/XYyjj0gQENx6LwaD2HeyY8Ty8MEagMBL1g1giCdRhg
         BLPA7o6y6XTBh743y7nn8IJlBCze24QHMaWADOrpBKh7SZ/VhLNzhKeWz05rwi9+Ed
         wJkuwyvditcl0ucOyA+bG6E43tHGpppAk+5hOoV4X9ymQjf1kdT8gP3bXSveDJc4Wx
         ltUG7WEEPRamQ==
From:   Mark Brown <broonie@kernel.org>
To:     mchehab@kernel.org, alsa-devel@alsa-project.org
Cc:     pierre-louis.bossart@linux.intel.com, cezary.rojewski@intel.com,
        linux-kernel@vger.kernel.org, yang.jie@linux.intel.com,
        yung-chuan.liao@linux.intel.com, hdegoede@redhat.com,
        Takashi Iwai <tiwai@suse.com>, peter.ujfalusi@linux.intel.com,
        liam.r.girdwood@linux.intel.com, Jaroslav Kysela <perex@perex.cz>
In-Reply-To: <cover.1649357263.git.mchehab@kernel.org>
References: <cover.1649357263.git.mchehab@kernel.org>
Subject: Re: [PATCH v5 0/4] Make headphone work on Huawei Matebook D15
Message-Id: <164978509553.404572.15488518886546999478.b4-ty@kernel.org>
Date:   Tue, 12 Apr 2022 18:38:15 +0100
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

On Thu, 7 Apr 2022 20:49:55 +0200, Mauro Carvalho Chehab wrote:
> Huawei Matebook D15 uses two different GPIOs are used to control the output:
> 
> 	- gpio0 controls the speaker output;
> 	- gpio1 controls the headphone output.
> 
> Changing both at the same time cause spurious events that are mis-interpreted
> as input events, causing troubles on apps. So, a delay is needed before turning
> on such gpios.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] ASoC: Intel: sof_es8336: simplify speaker gpio naming
      commit: 890a4087a6c2045911b5002566d1528f710cd723
[2/4] ASoC: Intel: sof_es8336: support a separate gpio to control headphone
      commit: 6e1ff1459e0086312e61c2d1ff8b74395a082fcb
[3/4] ASoC: Intel: sof_es8336: add a quirk for headset at mic1 port
      commit: 7c7bb2a059b226ebadb14ce07460f6357023d56c
[4/4] ASoC: Intel: sof_es8336: Add a quirk for Huawei Matebook D15
      commit: c7cb4717f641db68e8117635bfcf62a9c27dc8d3

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
