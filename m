Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF935A7E38
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 15:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiHaNEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 09:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiHaNEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 09:04:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7F1C1657;
        Wed, 31 Aug 2022 06:04:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A214561A2F;
        Wed, 31 Aug 2022 13:04:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70D3EC433C1;
        Wed, 31 Aug 2022 13:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661951044;
        bh=RSI4EOwQ+8AxbiJ/TcfxFRbL8c6SneehjW86TBWE2t0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=q2nRvBXZwapTVPpgTrknqzCUAIK9LuQlJp085kuXCzQp2GW/xX+EvBvXIS3o/fLVD
         FTcaT4VEtdu4twrIr++RNpEQiryUwCtil+VtQGs1W/kL0fypw2M+HyIeZ2vk5EPe7q
         bbqb5+vFpqoZxss1heRJoYysNEu5Up6B5n9GGAxSRJxDtlpYROVTvAFl/5QkelktFf
         jj/+3hzvuxttQdU9Dp7tyG257flFYRjxuVJPmjYpJvkqOiEzyci+TTRR9WrgvrFZy9
         fotJMvEVPTfXheB4VwXN4ZckJT5hfs0mbmBC0NLKCVoS9h8o0iHvfbbnX0XOLBG9x0
         13yP17Fw4uaBg==
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
In-Reply-To: <20220830182821.47919-1-andriy.shevchenko@linux.intel.com>
References: <20220830182821.47919-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/2] spi: stm32-qspi: Replace of_gpio_named_count() by gpiod_count()
Message-Id: <166195104216.267626.16919953203529886429.b4-ty@kernel.org>
Date:   Wed, 31 Aug 2022 14:04:02 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-0c1df
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Aug 2022 21:28:20 +0300, Andy Shevchenko wrote:
> As a preparation to unexport of_gpio_named_count(), convert the
> driver to use gpiod_count() instead.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: stm32-qspi: Replace of_gpio_named_count() by gpiod_count()
      commit: eea0e7d20d6dab38522ac0a3af61fd92c53c34f6
[2/2] spi: stm32-qspi: Refactor dual flash mode enable check in ->setup()
      commit: c9448aa41ac7dd223a6bef79e71d6c168593ebb7

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
