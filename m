Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E34FD576214
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 14:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232008AbiGOMsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 08:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231371AbiGOMss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 08:48:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4B9BE22
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 05:48:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 34E0D6236A
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 12:48:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFC61C34115;
        Fri, 15 Jul 2022 12:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657889326;
        bh=QAlCB37lDSR1Q6yFY2+peFoU18THXf/wGIKb4Zh3gk8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Qgx9tgv4CIMIfNQhUbFYKuogKUypqrtPm1dfQMWQrzjXe5fgQ1tM3gUREhuYz56nl
         RPX4fNawPIhDcoXqvM5K2K+kEGT0StreRr/ZrRkj3h9VnI1+LxblS+YdOzL/E7Rn8k
         XEmwV53RVgx2FrVBFksCo6ArXD+i/ZOm/oiUra14FabKo8TnRtEovBCsivROVtj3sl
         iIZznQZbtCHUiqBJU6+CIzShQY0yH7AMsvL+MFqEjqBvXxuIbuzVRcWHo8jXzomtZI
         UnNWR8ekqM8eo2nof1w8Tw7pusowo+Y9H0zt+NLkklRtGp70RhN0mzgEM+6qlR1oJg
         oGx7kYh0UPRQA==
From:   Mark Brown <broonie@kernel.org>
To:     claudiu.beznea@microchip.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, lgirdwood@gmail.com, tiwai@suse.com,
        perex@perex.cz
Cc:     linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220715090939.1679963-1-claudiu.beznea@microchip.com>
References: <20220715090939.1679963-1-claudiu.beznea@microchip.com>
Subject: Re: [PATCH] ASoC: atmel_ssc_dai: remove #ifdef CONFIG_PM
Message-Id: <165788932455.2010699.4592648749095007813.b4-ty@kernel.org>
Date:   Fri, 15 Jul 2022 13:48:44 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jul 2022 12:09:39 +0300, Claudiu Beznea wrote:
> Remove #ifdef CONFIG_PM and use pm_ptr() instead.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: atmel_ssc_dai: remove #ifdef CONFIG_PM
      commit: e1d1ffeda697dedf0859f963bc4180b5bb7bf150

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
