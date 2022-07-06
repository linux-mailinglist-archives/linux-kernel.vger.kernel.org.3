Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF3E8568665
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 13:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232997AbiGFLID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 07:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232920AbiGFLH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 07:07:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E513C25EAC
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 04:07:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A28B4B81BF0
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 11:07:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 461D8C341CA;
        Wed,  6 Jul 2022 11:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657105676;
        bh=4zHuh7F5byl2nEPHnYTUbXvbtKodYNHadkpLFgUS4D8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=hYxx8Tehs7AmPsTysQ6czl9Kxyix/jOttDeKm8zJyZGMw/nRLfXlG4CexEZYiMTpl
         spfMy1sybYG6UUHOETIJBE2RiqHuSk5p5YTSqpKwUIH7+dni69ipqZCVpE3bUf60aG
         GNIyTtdTFW7tSwSsfeBnApKSCGc7I6iJh0rKk5rApl6PujvQ89TLY8a4ERnvccQPzp
         hIHZhdeTniLkDq3NW9uTUPwWtsMm0QAMqvMOCiYkqDsK8rBRwl6kO3GQkRrlyvGge9
         qMsW101toZmR9EfuR/l/IoNMTGTBYdArbWSXcmgQDqNaS6piqBBhzToh4DG3m/tFll
         zKXIeNGLD5z8Q==
From:   Mark Brown <broonie@kernel.org>
To:     heiko@sntech.de, judyhsiao@chromium.org
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, wenst@chromium.org,
        Jaroslav Kysela <perex@perex.cz>,
        linux-arm-kernel@lists.infradead.org,
        Liam Girdwood <lgirdwood@gmail.com>, briannorris@chromium.org
In-Reply-To: <20220701021427.3120549-1-judyhsiao@chromium.org>
References: <20220701021427.3120549-1-judyhsiao@chromium.org>
Subject: Re: [PATCH v1] FROMGIT: ASoC: rockchip: i2s: Fix error code when fail to read I2S_CLR
Message-Id: <165710567400.237380.4691352154008052318.b4-ty@kernel.org>
Date:   Wed, 06 Jul 2022 12:07:54 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Jul 2022 02:14:27 +0000, Judy Hsiao wrote:
> Add the error code '-EBUSY' when fail to read I2S_CLR
> in rockchip_snd_rxctrl() and rockchip_snd_txctrl()
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] FROMGIT: ASoC: rockchip: i2s: Fix error code when fail to read I2S_CLR
      commit: 0ff9f8b9f59208332c6707e37d5739c57c7f7bce

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
