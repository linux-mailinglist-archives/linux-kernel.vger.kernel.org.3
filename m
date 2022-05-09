Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C20C520423
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 20:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240012AbiEISJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 14:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239974AbiEISJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 14:09:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A0B289BF4
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 11:05:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 998AEB818DF
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 18:05:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECFC9C385B2;
        Mon,  9 May 2022 18:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652119532;
        bh=Kf5T/f0XKjbYWD/C6hVkJzR5NvVs2HNYRz/qFkL+TjE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=kMNw81pkTL4sG8Wuk7JEHYFIO0qbaJknS/iK55lckBFARqfzLyO6pRMx4Z1wC9nzN
         8OQjcYHu+N+N8P8AoDXEnFDQhFR+sGvoJ3K9iLyyPB50yvudUUWumkIQiA6a4pjzo0
         FgwGKfxKug410pw97pmvs9Uj34mBsW+I1ypxepI6ExayyeoroF2hi9in6IWkDQ5A3w
         dJrY5Kr3tOowIVUTem+dISVXh0zxSzHoFoEYpcd8xDG8+gJyRULyANdH/dsU6cKkgb
         n25kFx++efiOYW/1kJ1vjP8oec7wpSj2aOQIgQQ774ByTG8Ys94XJRq9Ybyd3wy+Cz
         11gWG0Ntne4dw==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, yuehaibing@huawei.com,
        Arnd Bergmann <arnd@arndb.de>,
        angelogioacchino.delregno@collabora.com, perex@perex.cz,
        tzungbi@google.com, matthias.bgg@gmail.com, trevor.wu@mediatek.com,
        tiwai@suse.com
Cc:     linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org
In-Reply-To: <20220509120918.9000-1-yuehaibing@huawei.com>
References: <20220509120918.9000-1-yuehaibing@huawei.com>
Subject: Re: [PATCH v3 -next] ASoC: mediatek: mt8195: Fix build warning without CONFIG_OF
Message-Id: <165211952969.1181242.10041450382891029022.b4-ty@kernel.org>
Date:   Mon, 09 May 2022 19:05:29 +0100
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

On Mon, 9 May 2022 20:09:18 +0800, YueHaibing wrote:
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
