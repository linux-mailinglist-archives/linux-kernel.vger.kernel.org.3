Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00E9A56020C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 16:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233931AbiF2OGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 10:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233883AbiF2OGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 10:06:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F5A2B185
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 07:06:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E513FB82426
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 14:06:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56FFDC341CC;
        Wed, 29 Jun 2022 14:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656511562;
        bh=hQ4GAhXdMgF49WKm+/UqfK/ikb/wVg3umyPPuTJc5B4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=hiVpqZ5ooSG23Egrz8t0eRL5wRs4x59r5mR3X6pG1Biqem7zx+KjCFGD5aj3bnSLE
         evU6B9jOfOUqR6VyXKFqDfwxWniVsJmlTh5z7C/TsrAa5j5VwuMv/4xs22e0Uq+N6e
         bs35PYcgw2+ZnlKf/gPY0IxBi2CVBlIXc0D6fdslkM5VvmIt+eb4PqRCqCb+pEaKBT
         LJlpyWa0XjiPAF31i9So3nKSCyiLOfMzxUZ6N8awFxNi6529aFAecYXIvtOdbH8gAl
         hH6UQKeineRn3/Om8AnmpfmZSQwFg3VVcI6LqRDi65zz9k9vZDktcL39E172GJWUiK
         OQiZcKk7860WA==
From:   Mark Brown <broonie@kernel.org>
To:     heiko@sntech.de, judyhsiao@chromium.org
Cc:     alsa-devel@alsa-project.org, wenst@chromium.org,
        Rob Herring <robh+dt@kernel.org>, briannorris@chromium.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>
In-Reply-To: <20220629080421.2427933-1-judyhsiao@chromium.org>
References: <20220629080421.2427933-1-judyhsiao@chromium.org>
Subject: Re: [PATCH v1 1/2] ASoC: rockchip: i2s: Remove unwanted dma settings in rockchip_i2s_probe
Message-Id: <165651156008.1437597.7188024938057495855.b4-ty@kernel.org>
Date:   Wed, 29 Jun 2022 15:06:00 +0100
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

On Wed, 29 Jun 2022 08:04:21 +0000, Judy Hsiao wrote:
> Remove the unwanted dma settings in rockchip_i2s_probe.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: rockchip: i2s: Remove unwanted dma settings in rockchip_i2s_probe
      commit: d6910eaa6fc71c0307e16b310a07cdb347d26d7d

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
