Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D60C561ED6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 17:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235564AbiF3PK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 11:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235588AbiF3PKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 11:10:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24AEA2AE13
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 08:10:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CD4A7B82B67
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 15:10:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77277C3411E;
        Thu, 30 Jun 2022 15:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656601819;
        bh=zeFJ3+bVEU+Sxu4AmXvCkorfkIgB7pbCnM8thSAH86I=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=O68hkQ3/IxDKaXUH64kz8FlHdQ7+j4rTN+euMINPLKf0TAbcAkokA4jeih23NGMmd
         DF7DbKzDJxuTcqxQgHA7UCfe5yNk6YcvMpXunyZ+Bq3xVvxMowe8M7CRbr1xaMbmVN
         tFodIaM1RiORCOj62wDt+Uba/fa2bm8Eh/SHWWuhWllEM3gin8u6XwQfxnaNCfhBpd
         tpXcLRx50EvUO2Ab4pcwyjabWlu0Gq4vG1bP1J/RGL7jvZXIBiVdJ8rNrLUuDrK0kQ
         5cWdk3fvTqQBR41YdpFVEH5CCsOa3uZ9/YMwTNofWxqsr/zDLxTwHdOATb0j4hukTd
         fdIQPGM8tAQQQ==
From:   Mark Brown <broonie@kernel.org>
To:     ckeepax@opensource.cirrus.com
Cc:     alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com
In-Reply-To: <20220630101459.3442327-1-ckeepax@opensource.cirrus.com>
References: <20220630101459.3442327-1-ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: wm_adsp: Minor clean and redundant code removal
Message-Id: <165660181820.664251.9414397371469322240.b4-ty@kernel.org>
Date:   Thu, 30 Jun 2022 16:10:18 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Jun 2022 11:14:59 +0100, Charles Keepax wrote:
> The cs_dsp core will return an error if passed a NULL cs_dsp struct so
> there is no need for the wm_adsp_write|read_ctl functions to manually
> check that. The cs_dsp core will also check the data is within bounds of
> the control so the additional bounds check is redundant too. Simplify
> things a bit by removing said code.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: wm_adsp: Minor clean and redundant code removal
      commit: e8010efc7b83038d1c18abe1b8d171e3c7d4ed92

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
