Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2736D5811F4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 13:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233130AbiGZLam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 07:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbiGZLak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 07:30:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B7513CF6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 04:30:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F35536135A
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 11:30:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92203C341C0;
        Tue, 26 Jul 2022 11:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658835038;
        bh=5S7SIX8+8VYQEQQKBE0504g9SamLUXfQF0wD+GwQE6E=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=If6nt4Pne47+rniua7hVbGMTUWoakTPT4G2XWlzFjBmt3SHHB9pdlMwDkjjaDpDON
         k+/nDHRz7+ZNd3ULc+Ac3HPb32+AK8ofzZ8Qp8cdTdfUzhWVUZ18IgTWrZq9c9ONS7
         N80SgCwZsFGGxYOyeWByRcUx50tNTt/q0N1SnyYunee2RCZAfyKKuMoTRZGifVnCOi
         igoi19ltxvQYwuMToUjlEqV/AP040hMjddBLUor89Dl22pPcSzeMmgbjbwk3SeqD5y
         IhhK2XCXKX+a5RXE4Td+AcDgTEupG2u2F7KhdHZrdq6KXpyVBzqvUTKO0DbSa2sFDm
         tDBgtv/QcSkow==
From:   Mark Brown <broonie@kernel.org>
To:     tiwai@suse.com, julianbraha@gmail.com, perex@perex.cz,
        geert+renesas@glider.be, matthias.bgg@gmail.com,
        lgirdwood@gmail.com, tzungbi@kernel.org,
        angelogioacchino.delregno@collabora.com,
        Ren Zhijie <renzhijie2@huawei.com>, trevor.wu@mediatek.com,
        jiaxin.yu@mediatek.com
Cc:     linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org
In-Reply-To: <20220724110619.212774-1-renzhijie2@huawei.com>
References: <20220724110619.212774-1-renzhijie2@huawei.com>
Subject: Re: [PATCH -next] ASoC: mediatek: mt8186: fix Kconfig dependency
Message-Id: <165883503527.86475.6043755927851181413.b4-ty@kernel.org>
Date:   Tue, 26 Jul 2022 12:30:35 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-c7731
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Jul 2022 19:06:19 +0800, Ren Zhijie wrote:
> If CONFIG_SND_SOC_MT8186=y and CONFIG_SND_SOC_MT6358 is not set,
> make ARCH=x86_64 CROSS_COMPILE=x86_64-linux-gnu-, will be failed, like this:
> 
> sound/soc/mediatek/mt8186/mt8186-mt6366-common.o: In function `mt8186_mt6366_init':
> mt8186-mt6366-common.c:(.text+0x4d): undefined reference to `mt6358_set_mtkaif_protocol'
> make: *** [vmlinux] Error 1
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: mt8186: fix Kconfig dependency
      commit: f20d5116b7f3d8d40e1248a59be89e667eaabd62

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
