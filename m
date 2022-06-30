Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDCB7561986
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 13:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235120AbiF3Lq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 07:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235134AbiF3LqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 07:46:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8445A46C
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 04:46:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE8A061674
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 11:46:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DB84C3411E;
        Thu, 30 Jun 2022 11:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656589573;
        bh=0ym2LTs77ZRWFWozd0cF2LZIZ6ITiiE1pQFIzfSs02Y=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=uO1few8ys8A95Q356DB5H9/5+9MUnUUEB4C5mzkDqZq3BaGmy6409Ed8daWH20QiP
         KO6lzVtXL5Ex4z7t8xxUTysvnaC0cJfMODkciv1P9vwmkeURdHGrVsWpYeUJybhK3o
         mcvs0dhfPdc4VEiygsYmqBkWIe5vLCM9D5teMkYUcy5ssjyyPWuCLKGxD+UqTklAg8
         etToLp0rrE2+v+hPitJyHC1XRexOQ491WoCiORxUdDCxlSTAEJ9XMBf3RktHbOrLhq
         7Si87jrs8Tpu/k/AYqE+YZY5HCS4Xbqilkg524vjcmlQq8ZL644u1os5teZHuusgWf
         YWqtb6H0B7MNA==
From:   Mark Brown <broonie@kernel.org>
To:     s.nawrocki@samsung.com, lgirdwood@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, perex@perex.cz, trix@redhat.com,
        tiwai@suse.com, krzysztof.kozlowski@linaro.org
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
In-Reply-To: <20220629185345.910406-1-trix@redhat.com>
References: <20220629185345.910406-1-trix@redhat.com>
Subject: Re: [PATCH] ASoC: samsung: change gpiod_speaker_power and rx1950_audio from global to static variables
Message-Id: <165658957136.346792.13129934394557088460.b4-ty@kernel.org>
Date:   Thu, 30 Jun 2022 12:46:11 +0100
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

On Wed, 29 Jun 2022 14:53:45 -0400, Tom Rix wrote:
> sparse reports
> sound/soc/samsung/rx1950_uda1380.c:131:18: warning: symbol 'gpiod_speaker_power' was not declared. Should it be static?
> sound/soc/samsung/rx1950_uda1380.c:231:24: warning: symbol 'rx1950_audio' was not declared. Should it be static?
> 
> Both gpiod_speaker_power and rx1950_audio are only used in rx1950_uda1380.c,
> so their storage class specifiers should be static.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: samsung: change gpiod_speaker_power and rx1950_audio from global to static variables
      commit: d2294461b90e0c5b3bbfaaf2c8baff4fd3e2bb13

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
