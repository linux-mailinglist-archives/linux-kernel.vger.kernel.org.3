Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6299F520429
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 20:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239993AbiEISJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 14:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239944AbiEISJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 14:09:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 841442878FD
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 11:05:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1EBCB615D7
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 18:05:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15C6FC385B4;
        Mon,  9 May 2022 18:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652119529;
        bh=GNYW0f/0zhn3bNQV9q7pmTN0Wu2f6KlNa5abquY9vdA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=NacPhBskHAN4/3dE2A/9GW4Of2q4u87w654c1DT0X2jVS1stteLCl3si0gz3hWTAN
         IkuNw42c1oEwSNPAQi3OqpUvAuasU+IkNiOLiGlhUEKNajPqWUPuPcHT/Hof+VnphJ
         HgwcQXnCdmIPE9eXPEJAdnRySH5v7mueDVP26yCtj9T9D0reRkQNpQmlvK6CSPAket
         DMh5p6PRNzBP6Zsc3wN2l4Q7Z4kShMr0iTjLxO3v/ap3ZeFjQ8gvXb645tMyevJ0vV
         lwig9qFOd5yR6yURhawMB1gsSMxMo/nfOzDdiSuE7bsfVyT4g+XIhJ/jT23fMG2Wm1
         VkyOnNyGw5CWw==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, yuehaibing@huawei.com,
        Arnd Bergmann <arnd@arndb.de>,
        angelogioacchino.delregno@collabora.com, perex@perex.cz,
        tzungbi@google.com, matthias.bgg@gmail.com, trevor.wu@mediatek.com,
        tiwai@suse.com
Cc:     linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org
In-Reply-To: <20220507021424.12180-1-yuehaibing@huawei.com>
References: <20220507021424.12180-1-yuehaibing@huawei.com>
Subject: Re: [PATCH v2 -next] ASoC: mediatek: mt8195: Fix build warning without CONFIG_OF
Message-Id: <165211952680.1181242.3361665632308552172.b4-ty@kernel.org>
Date:   Mon, 09 May 2022 19:05:26 +0100
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

On Sat, 7 May 2022 10:14:24 +0800, YueHaibing wrote:
> sound/soc/mediatek/mt8195/mt8195-mt6359.c:1639:32: warning: ‘mt8195_mt6359_max98390_rt5682_card’ defined but not used [-Wunused-variable]
>  1639 | static struct mt8195_card_data mt8195_mt6359_max98390_rt5682_card = {
>       |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> sound/soc/mediatek/mt8195/mt8195-mt6359.c:1634:32: warning: ‘mt8195_mt6359_rt1011_rt5682_card’ defined but not used [-Wunused-variable]
>  1634 | static struct mt8195_card_data mt8195_mt6359_rt1011_rt5682_card = {
>       |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> sound/soc/mediatek/mt8195/mt8195-mt6359.c:1629:32: warning: ‘mt8195_mt6359_rt1019_rt5682_card’ defined but not used [-Wunused-variable]
>  1629 | static struct mt8195_card_data mt8195_mt6359_rt1019_rt5682_card = {
>       |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: mt8195: Fix build warning without CONFIG_OF
      commit: 0e63a2be5651e2b34e5c2505992e58be0e9c4bb1

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
