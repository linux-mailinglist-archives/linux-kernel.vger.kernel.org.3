Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78EAC561ED2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 17:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235543AbiF3PKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 11:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235514AbiF3PKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 11:10:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7752AE26
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 08:10:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5BF5160E94
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 15:10:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED6AFC3411E;
        Thu, 30 Jun 2022 15:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656601815;
        bh=l7KxMBhRvrNgW0srsiaNIvYfDYhR6onbRDyQH5tjYrY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=qbm2u+66ATk65SMpLsZsZXOONGGNVrOO3u2KGQ+DXjFczwYDnwYVvV/qViNmxVJl0
         Gl7pqNZtw3Er1FMXGZszn78zFZTVox92IYFqtK6p6pE9ZZ+fbJbC2Kcdf6fCS0zUvC
         Pg6BQGyKpQchJFBB1WdZm5IqiCO92eqJ1L/qfhLdpcVP7762XrZ6D9iNrdeGZ2JpbA
         r/r37P5Rscz7zKHecYdISAb+22HAZChxx3LUSzcppwGyv0MIxakv4EGtYd3FauMghW
         /H58VYSXnziRshuHgMMBxSWphRGy5ZzhHpMAPkmR+yCR4L2gZQuFw1ZZ9rBjmQEJeq
         cc7EF/f0kfoFQ==
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>, trix@redhat.com, perex@perex.cz,
        krzysztof.kozlowski@linaro.org, lgirdwood@gmail.com,
        s.nawrocki@samsung.com, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220629201811.2537853-1-trix@redhat.com>
References: <20220629201811.2537853-1-trix@redhat.com>
Subject: Re: [PATCH] ASoC: samsung: change neo1973_audio from a global to static
Message-Id: <165660181358.664251.18405607325309660233.b4-ty@kernel.org>
Date:   Thu, 30 Jun 2022 16:10:13 +0100
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

On Wed, 29 Jun 2022 16:18:11 -0400, Tom Rix wrote:
> sparse reports
> sound/soc/samsung/neo1973_wm8753.c:347:24: warning: symbol 'neo1973_audio' was not declared. Should it be static?
> 
> neo1973_audio is only used in neo1973_wm8753.c, so it's
> storage class specifier should be static.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: samsung: change neo1973_audio from a global to static
      commit: 871325d800ed532ba5874257f04bb4ae75125bc4

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
