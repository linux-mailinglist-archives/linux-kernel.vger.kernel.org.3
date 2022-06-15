Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6004A54CF65
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 19:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349855AbiFORIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 13:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349750AbiFORIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 13:08:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684EE31DFD;
        Wed, 15 Jun 2022 10:08:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E757061A5A;
        Wed, 15 Jun 2022 17:08:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47EC1C3411C;
        Wed, 15 Jun 2022 17:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655312922;
        bh=DPZwDt3Nv5YY6FK0uIajES+SPNgbum9OCK2ZeVuuc3E=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=m+2gl1eG0rkpPNEDof9eCnIJUG7ua6jSTK4EbkN8S8jLdsFCOguYthoEcxAQYDOuC
         2k4UfGx6ahOGA72MmCFb0pGSLXdQ6qjjqV4vK7Bfrc/smT3x17Yd5td8+2uXgeFM1B
         2I5TcodJlJuxYwYeKN4SL5SDZpwzklE5SBAoNuJyd2Cd5EnOkR9j99JDHPlmT9JNyh
         asH4YF9U9KhFEQu2xy/CIqoC/In8uS3323aH/hEa6o1CIH7kudjaMnzCZhEElvB70T
         ZGslPtmBk7H00zKctc/RfQaTf00tlr/vlrymbUQ8xN9KUIZdWCcP1vAUVd+CJmJLRW
         NfLQaBZLC1kLg==
From:   Mark Brown <broonie@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, tiwai@suse.com,
        linus.walleij@linaro.org, lgirdwood@gmail.com, perex@perex.cz,
        linux-kernel@vger.kernel.org, samuel@sholland.org, wens@csie.org,
        linux-gpio@vger.kernel.org, rafael@kernel.org,
        linux-sunxi@lists.linux.dev, patrice.chotard@foss.st.com,
        jernej.skrabec@gmail.com, p.zabel@pengutronix.de,
        lchen.firstlove@zohomail.com, gregkh@linuxfoundation.org
In-Reply-To: <180eef39205.122d47c8260721.2430302798386025245@zohomail.com>
References: <180e702a15f.e737e37e45859.3135149506136486394@zohomail.com> <180eef39205.122d47c8260721.2430302798386025245@zohomail.com>
Subject: Re: (subset) [PATCH v3 0/4] Add regmap_field helpers for simple bit operations
Message-Id: <165531291902.3574042.11922477626271961172.b4-ty@kernel.org>
Date:   Wed, 15 Jun 2022 18:08:39 +0100
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

On Sun, 22 May 2022 20:26:21 -0700, Li Chen wrote:
> From: Li Chen <lchen@ambarella.com>
> 
> This series proposes to add simple bit operations for setting, clearing
> and testing specific bits with regmap_field.
> 
> Li Chen (4):
>   regmap: provide regmap_field helpers for simple bit operations
>   ASoC: sunxi: Use {regmap/regmap_field}_{set/clear}_bits helpers
>   pinctrl: bcm: Use regmap_field_{set/clear}_bits helpers
>   pinctrl: st: Switch to use regmap_field_test_bits
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] regmap: provide regmap_field helpers for simple bit operations
      commit: f67be8b7ee90c292948c3ec6395673963cccaee6
[2/4] ASoC: sunxi: Use {regmap/regmap_field}_{set/clear}_bits helpers
      commit: b23662406b1b225847b964e4549a5718c45f20d6

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
