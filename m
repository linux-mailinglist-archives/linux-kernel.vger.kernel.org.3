Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19951524F9A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 16:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355110AbiELOMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 10:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354210AbiELOMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 10:12:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE9C62CD4
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 07:12:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A60061A01
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 14:12:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FCFDC34117;
        Thu, 12 May 2022 14:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652364766;
        bh=tLRm1gt0dfdj3Zg1SK1amryfSa02+W6LQsgnP3iGSlw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=dX09OXXu36Oyp6S5k1oT1e2eO9k85/jNMHbJr5d64l93qQR54dZf4/+FjjQG4R3Ht
         WvxpVK+rmiONY0vw+FjvPux3sA1YB2WcWeCNOsYDVGRTOhSYnjYEFjbre/xP4Ct6VZ
         MUGFh2/eOKIrx8EZFfciVFmDq3oropMtsWy02lw/soYMR9A3SZd3QWHk2LHIP4A/z1
         +UnbMKTsq3IwlbWfCoNE5GgPd+sAsXVcvcwqj671i/KWpPTMuu5clz5iZjTgzQp/ni
         iH71sBB0ZVzpbJeDF6h6EdL/80WvIantJt/kVqsgAM2wIPD+N7HROyyPyfbng+kI66
         w0obt0/3us2WA==
From:   Mark Brown <broonie@kernel.org>
To:     tanureal@opensource.cirrus.com, lgirdwood@gmail.com,
        perex@perex.cz, james.schulman@cirrus.com,
        rf@opensource.cirrus.com, oder_chiou@realtek.com, tiwai@suse.com,
        zheyuma97@gmail.com, david.rhodes@cirrus.com
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com
In-Reply-To: <20220510153251.1741210-1-zheyuma97@gmail.com>
References: <20220510153251.1741210-1-zheyuma97@gmail.com>
Subject: Re: [PATCH 0/6] ASOC: Fix the error handling code of the probe
Message-Id: <165236476384.1016627.11149997612368396008.b4-ty@kernel.org>
Date:   Thu, 12 May 2022 15:12:43 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 May 2022 23:32:45 +0800, Zheyu Ma wrote:
> These drivers mishandle the regulator resource in the probe function,
> failing to disable the regulator for probing failure.
> 
> Zheyu Ma (6):
>   ASoC: cs42l52: Fix the error handling of cs42l56_i2c_probe()
>   ASoC: cs35l36: Fix the error handling of cs35l36_i2c_probe()
>   ASoC: rt5645: Fix the error handling of rt5645_i2c_probe()
>   ASoC: tas571x: Fix the error handling of tas571x_i2c_probe()
>   ASoC: tas6424: Fix the error handling of tas6424_i2c_probe()
>   ASoC: wm8903: Fix the error handling of wm8903_i2c_probe()
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/6] ASoC: cs42l52: Fix the error handling of cs42l56_i2c_probe()
      commit: c1ce4ba5021a9730c00bab6f8122702deb69d37e
[2/6] ASoC: cs35l36: Fix the error handling of cs35l36_i2c_probe()
      commit: cf7250e95d309ae518918613fb904a4565ffc85d
[3/6] ASoC: rt5645: Fix the error handling of rt5645_i2c_probe()
      commit: 7883c193d7ae1ccc20ee4c06d2a1fea40074e454
[4/6] ASoC: tas571x: Fix the error handling of tas571x_i2c_probe()
      commit: ef1878fd0cd61f0f3fafdf518bb8f1df742ef760
[5/6] ASoC: tas6424: Fix the error handling of tas6424_i2c_probe()
      commit: 68cacb5cf5cf04aaa95be1fd76eff728dfddc613
[6/6] ASoC: wm8903: Fix the error handling of wm8903_i2c_probe()
      commit: 83d1b65d4cbe6fb0bbdacc18c1f4ad0450275d8f

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
