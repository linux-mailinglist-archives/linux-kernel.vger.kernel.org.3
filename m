Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1B2655526A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 19:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376908AbiFVRaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 13:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239201AbiFVRaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 13:30:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3FE30F68
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 10:30:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 29204B8205A
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 17:30:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EC7AC3411B;
        Wed, 22 Jun 2022 17:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655919007;
        bh=WpJxGSkPnoTmSLwPwAWBaxy5WCwKFsEXIi5/wZIjC5Q=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=O8jxIq/LPamDMoq3ZB2j4wKsgadFaOqNRR2sr+IiON6+3oKt+nbysJU5zpEoBOByl
         fHmubXbbNGi5HsAVhjywJjEsxEmjTw71SSTsJr5e/wmXA3GWk4Ki9vdn6oQlVG3jqT
         QQtlHrEY+c3CoRRr0TmpuAJ0g9VGIpx7EfPEqG+U6cuTP5Sz4PgZiwIMmkffuNxd0U
         64ztA/4TMUpRS4RSCgoXh85rrTNo9jaNjhEzenVzLKNeYpjLIXHfH90Osum6p7LKOb
         v/wPfk30TGijakLXclDCK7BscWP31fN8u3E4QnoSIoaDYuWRk7S9IcE1e5M6Zg+yy+
         KMyCln03Hi57A==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, heiko@sntech.de, wens@kernel.org,
        tiwai@suse.com, perex@perex.cz
Cc:     linux-kernel@vger.kernel.org, wens@csie.org,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, judyhsiao@chromium.org
In-Reply-To: <20220621185747.2782-1-wens@kernel.org>
References: <20220621185747.2782-1-wens@kernel.org>
Subject: Re: [PATCH] ASoC: rockchip: i2s: Fix crash on missing pinctrl
Message-Id: <165591900483.1405752.13168398437677956332.b4-ty@kernel.org>
Date:   Wed, 22 Jun 2022 18:30:04 +0100
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

On Wed, 22 Jun 2022 02:57:47 +0800, Chen-Yu Tsai wrote:
> From: Chen-Yu Tsai <wens@csie.org>
> 
> Commit 44f362c2cc6d ("ASoC: rockchip: i2s: switch BCLK to GPIO") added
> pinctrl lookups, but did not skip the lookup if there was no pinctrl
> device tied to the I2S controller. As a result, the lookup was done
> on an invalid pointer in such cases, causing a kernel panic.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rockchip: i2s: Fix crash on missing pinctrl
      commit: c3b5fd7fbb698496461f280728b456d9927f22af

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
