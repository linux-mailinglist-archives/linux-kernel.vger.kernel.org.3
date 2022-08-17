Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF77597135
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 16:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240169AbiHQObd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 10:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240142AbiHQObP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 10:31:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3D0923E1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 07:31:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ADC99B81DF6
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 14:31:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EB88C4314C;
        Wed, 17 Aug 2022 14:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660746668;
        bh=WQSEZi/ZThfpTh3nKayykvCckCTb+dDa/U+rPQf6mQM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=dlSU1hK7riqxokULnT4opq7DBwokkzZ9sLHnQi+h8AQgYWkFjkeDfS3vWa87ET/hW
         UFb+OzMBm9VIeWblR5iJP3PcQU+9bY5n6SPPUxiLRpjTg0GGvuaKjBNGlf0pbxe/pK
         aHUslcb1xABNBQZMmMOFTgBggpwqVMOMABoNZa3KsUjfM0YgyYkQF3gpPDbEEX5emB
         j7jx8RY+BY2/bsiQ7mORRua0D2bHePWTHv0k1D58thvlVwn4s4JXp4obByPAttD4UF
         sqLAd3lOy7ytkl7QQngsFJ7hvplaFb7kLgbxTPyaWh3HBPmplKCReNh88q4I0HGDNW
         ymMHCFuAhvTAQ==
From:   Mark Brown <broonie@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     zhuning@everest-semi.com, yangxiaohua@everest-semi.com
In-Reply-To: <20220817091519.2487385-1-yangyingliang@huawei.com>
References: <20220817091519.2487385-1-yangyingliang@huawei.com>
Subject: Re: [PATCH -next] ASoC: codecs: es8326: change es8326_regmap_config to static
Message-Id: <166074666705.210979.15448004360447274699.b4-ty@kernel.org>
Date:   Wed, 17 Aug 2022 15:31:07 +0100
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

On Wed, 17 Aug 2022 17:15:19 +0800, Yang Yingliang wrote:
> es8326_regmap_config is only used in es8326.c now, change it to static.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: es8326: change es8326_regmap_config to static
      commit: 5c69f11ce85d4a8ea985a6d266574577e94c6506

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
