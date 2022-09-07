Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB9165B0558
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 15:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbiIGNig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 09:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbiIGNiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 09:38:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA359E11E
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 06:37:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1485DB818B5
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 13:37:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CFEEC43140;
        Wed,  7 Sep 2022 13:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662557871;
        bh=Dd0zVj0VklHGwNIh3GmXrVi5H/IIUqMDQzHTEV3cbZA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=QgYAr6Z2uHWXxHvlO+LwPMImS4gbY9od7AtU48hSnVJAng4RW+NUxEz466vv79vKw
         Aswx5OcFGIBBh8tCaNfVhWpZvt8u3R53kBE81s+z9IRZm27KBDZCVen7ejeLDVeGfF
         5AP2qLQcuBYDrg041WGcqGtbkdwxyHV54VoKxlujRTbmAejHIl4hMTbZJwe5x5F6H/
         yNz2X3mBAzsK+R6wdekjNOuHelAiw0BrSwLDp2JuZNhu6TMtttPfxSqdgelUJdOuW5
         4jIndBJgzVOQDnGg1J23gE7Lxnjfv5ZJPzkV+BmKktI8mhyDCTTd+Z/kUAwuIh2Ppw
         fDsVcQHg4yqwg==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     alsa-devel@alsa-project.org, Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
In-Reply-To: <YxeaITtlJexygQo9@google.com>
References: <YxeaITtlJexygQo9@google.com>
Subject: Re: [PATCH] ASoC: simple-card-utils: switch to using gpiod API
Message-Id: <166255787023.130875.15429372687220294884.b4-ty@kernel.org>
Date:   Wed, 07 Sep 2022 14:37:50 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Sep 2022 12:06:09 -0700, Dmitry Torokhov wrote:
> This patch switches the driver away from legacy gpio/of_gpio API to
> gpiod API, and removes use of of_get_named_gpio_flags() which I want to
> make private to gpiolib.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: simple-card-utils: switch to using gpiod API
      commit: 355beeed9319cf3ceea56c7dec874a8a9c443771

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
