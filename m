Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82F8555384B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 18:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234914AbiFUQ7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 12:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231492AbiFUQ7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 12:59:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 811B720F52
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 09:59:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0E9B9B81AB2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 16:59:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DAD2C3411C;
        Tue, 21 Jun 2022 16:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655830766;
        bh=gz5wvjLREIHx/PcjdvwdM3efMCKqQmb35YJK7xuaEyQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=dWDVvb0w24LzUtfi+7R0D41bEpMfhRNyrtZiLkHV/ks0pBQLMb6tLiJtdQugmYK9t
         OAiX+XmTyG1pG46Y6r176B1iBf0FG8fEiApZcTS/EySP5+kIjOivluCK9Tu4rKq3/x
         dIQUtlx9tftnh3vkxUcyLvFVpgYevuDmSBC630VZUoswDc3tfo08ka8pKN2W0Id84j
         fyzssS+5bheE3zt6tIKq3fIkcgqa63iOxhoIZjcWVJ+jSjrsWYQiVOJbI4NFq9XTYC
         ZDh2zmb7xza9aDqqeu4zQwrwyV2ubIhECie3Sjfx0A/dVx6i9Tg2W6SGrbJupedU8y
         3gifDCRNWkrug==
From:   Mark Brown <broonie@kernel.org>
To:     ckeepax@opensource.cirrus.com
Cc:     david.rhodes@cirrus.com, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com, james.schulman@cirrus.com,
        lgirdwood@gmail.com, alsa-devel@alsa-project.org
In-Reply-To: <20220621102041.1713504-1-ckeepax@opensource.cirrus.com>
References: <20220621102041.1713504-1-ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH 1/4] ASoC: wm_adsp: Fix event for preloader
Message-Id: <165583076515.271995.18026911532153153999.b4-ty@kernel.org>
Date:   Tue, 21 Jun 2022 17:59:25 +0100
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

On Tue, 21 Jun 2022 11:20:38 +0100, Charles Keepax wrote:
> The preloader controls on ADSP should return a value of 1 if the
> preloader value was changed, update to correct this.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] ASoC: wm_adsp: Fix event for preloader
      commit: 81d74ddae83fbd85c9006835f36c362114127a7a
[2/4] ASoC: wm5110: Fix DRE control
      commit: 630cc5983740d784a1a6458f9dc2112c43fe0931
[3/4] ASoC: cs35l41: Correct some control names
      commit: 87912e97a1678d62877aab353ecfd201bc92b372
[4/4] ASoC: core: Add new SOC_DOUBLE_SX_TLV macro
      commit: 6b183919f7051294dc5fc331bb608d5d7f29f5da

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
