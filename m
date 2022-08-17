Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA5145974C2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 19:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241039AbiHQRFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 13:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237189AbiHQRFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 13:05:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A80901A1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 10:05:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4DB9A6111F
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 17:05:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF0DDC433D6;
        Wed, 17 Aug 2022 17:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660755948;
        bh=Xg5LiDPzkPQzU8ExdTp8O5VM1GoQ2K7H+Z2oHuhkWD0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=IshtAORFEenqWgi/fygyaLiAXU1G80EdkzNJm8s7dH6Q9hYeay2N+lCl5JZt7grlr
         eMIS1yEUieQL2xQ/p08CXsU2eF9j1lCVIuaKROKeEyg18zYkAemyVMLF3/+5jwqlR2
         qLVw+nAZPl7eFwI3It3JZDED7WM0CECUKxD8CvBk6tCHtwtR5hi5h0fjjqllGR8xQU
         EcrgdJ86kYdeSV+kk44v/hdlJPxrjFWzYM68Hhmk/+qFOpYGDKlmAbVnGh7RlpuMn/
         7nGAvy+ZQsGdKV5RPYjwwN04IHRqMep3U2GFPahCgPPKfqTHY92uOdnDiJiRF7Ef6+
         2UtyAB1pkvyqQ==
From:   Mark Brown <broonie@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        alsa-devel@alsa-project.org
In-Reply-To: <20220817122347.1356773-1-rf@opensource.cirrus.com>
References: <20220817122347.1356773-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH 0/5] ASoC: cs42l42: Some small code improvements
Message-Id: <166075594756.566556.10171156201538682053.b4-ty@kernel.org>
Date:   Wed, 17 Aug 2022 18:05:47 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fe10a
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Aug 2022 13:23:42 +0100, Richard Fitzgerald wrote:
> This is a collection of minor improvements to the code or comments.
> 
> Richard Fitzgerald (5):
>   ASoC: cs42l42: Don't include kernel.h
>   ASoC: cs42l42: Add include dependencies to cs42l42.h
>   ASoC: cs42l42: Move cs42l42_supply_names to .c file
>   ASoC: cs42l42: Fix comment typo in cs42l42_slow_start_put()
>   ASoC: cs42l42: Use snd_soc_tdm_params_to_bclk()
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/5] ASoC: cs42l42: Don't include kernel.h
      commit: 8ccaa7eb76742579864ddf834a8ea9c036c2cc5a
[2/5] ASoC: cs42l42: Add include dependencies to cs42l42.h
      commit: b48d1da00fc8f32f7f75b8a34eb484f08b39ffaa
[3/5] ASoC: cs42l42: Move cs42l42_supply_names to .c file
      commit: dbd231732c99e336c2ece4a70896139e7f5a51a7
[4/5] ASoC: cs42l42: Fix comment typo in cs42l42_slow_start_put()
      commit: db568aab37c1af80057c12c97e6af049495c3e4a
[5/5] ASoC: cs42l42: Use snd_soc_tdm_params_to_bclk()
      commit: c2683ecfd1850cc99829691b2e1d90f1a6d75b8b

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
