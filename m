Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 725155813D8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 15:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238763AbiGZNHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 09:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238712AbiGZNHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 09:07:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B34B255B5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 06:07:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E641EB81620
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 13:07:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2880C341C8;
        Tue, 26 Jul 2022 13:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658840865;
        bh=BZmZhFMvhLCfzVe94NTIXknZfxg09pwJ9ByOmnsT3gU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=lmDZxIKquK0sZqC17xEg183oakX/provokEGWmoKdwdMwjXP+0KfY9ggxIuKmXJkj
         BYEIJbqUCJKXUZxZT4PiyPjSfMoNUmS6VoD60zT38EE+HeC5o2eNs9apFLpwOiMon9
         PF5k/qX5x7/74H5IoXKlKatJ7EKL1Tx28OswV58LhTsyqYYhpjkCiMJGb3pU6WDQPB
         jx/h22t6v9srB68kmhDvH5NyVruMgO64EZ91N4Gz0ZBbutD8PGV94O5kdjvl02Fa68
         7GVR7cZv2l2BxUh+jQA/DpmTI49jNBPBfbj97QS7W//2jT/dWRTqzsK1bYu5pKVRQ5
         MeSQl1Qs2xFhA==
From:   Mark Brown <broonie@kernel.org>
To:     tiwai@suse.com, lgirdwood@gmail.com, alexandre.belloni@bootlin.com,
        perex@perex.cz, nicolas.ferre@microchip.com,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <20220725130925.1781791-1-claudiu.beznea@microchip.com>
References: <20220725130925.1781791-1-claudiu.beznea@microchip.com>
Subject: Re: [PATCH v2 0/5] ASoC: atmel: one fix and few cleanups
Message-Id: <165884086364.21705.11925129890328770083.b4-ty@kernel.org>
Date:   Tue, 26 Jul 2022 14:07:43 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-c7731
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jul 2022 16:09:20 +0300, Claudiu Beznea wrote:
> The series adds one fix for mchp-spdifrx and few cleanups for
> mchp-spdifrx and mchp-spdifrx drivers.
> 
> Thank you,
> Claudiu Beznea
> 
> Changes in v2:
> - s/tag/tab in the title of patch 2/5
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/5] ASoC: mchp-spdifrx: disable end of block interrupt on failures
      (no commit info)
[2/5] ASoC: mchp-spdifrx: use single tab indent for structure
      commit: 24e89d6d7da52f8678dc111ffb0ae3590b678ef0
[3/5] ASoC: mchp-spdiftx: remove references to mchp_i2s_caps
      (no commit info)
[4/5] ASoC: mchp-spdiftx: return directly ret
      commit: d346a4ad305bf3f99e5824e0c132fac7e0b53657
[5/5] ASoC: mchp-spdiftx: add and remove black line around MODULE_DEVICE_TABLE()
      commit: 96f6017d652a78e06e34e535526826a22aa69dfa

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
