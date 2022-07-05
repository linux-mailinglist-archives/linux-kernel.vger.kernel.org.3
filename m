Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20AAA5676DC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 20:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232603AbiGESwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 14:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiGESwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 14:52:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93BE318370
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 11:52:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 32A1F61A33
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 18:52:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09986C341C7;
        Tue,  5 Jul 2022 18:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657047136;
        bh=W7RTkFS6YzkGkD3g5OYSBQmH5HUSU27tkgRa/tx7oxQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=RYKVH3FENZs6v0A6Q3yi9Jv7n4j8GGqcq9dXknpgBFC+khxvV8JW7puPVPrBCSjbG
         xSTDbY357Y7IudSfSuO5TjUFyNEB1O1hrEy+nCiKYdwMciwJMtjNM2edBHI1QYOUZT
         OgARrgLzacgA5d1MRfIfUqvFLwBLG2Wdp1Pq3WJ+7m4x7S7NxZrGpHJDyk4mE74HcZ
         Aw7ShyGA5vfzshaaZtex7PYjYs5mzRZrBZy5tWIvtBca1kkRZ5jdBQP1oQLWflqvrg
         r2XhLFoVO4ZAcaWlAU3bzU5tKcuxQfcIlYqovF5S2gloUR/F7zWfjStqp3wjIrsBXh
         mPM1LcKkCvxlA==
From:   Mark Brown <broonie@kernel.org>
To:     patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com
Cc:     rf@opensource.cirrus.com, tiwai@suse.com,
        ckeepax@opensource.cirrus.com, perex@perex.cz
In-Reply-To: <20220603170707.48728-1-andriy.shevchenko@linux.intel.com>
References: <20220603170707.48728-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] ASoC: madera: Replace kernel.h with the necessary inclusions
Message-Id: <165704713474.1050281.11786579808671554712.b4-ty@kernel.org>
Date:   Tue, 05 Jul 2022 19:52:14 +0100
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

On Fri, 3 Jun 2022 20:07:07 +0300, Andy Shevchenko wrote:
> When kernel.h is used in the headers it adds a lot into dependency hell,
> especially when there are circular dependencies are involved.
> 
> Replace kernel.h inclusion with the list of what is really being used.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: madera: Replace kernel.h with the necessary inclusions
      commit: dcc165d6179c3934b93b8c3bffde1ed9710fd7ef

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
