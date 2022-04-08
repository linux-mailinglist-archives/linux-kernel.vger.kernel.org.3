Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3DC74F9888
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 16:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237178AbiDHOta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 10:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237085AbiDHOtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 10:49:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF48FC13B
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 07:47:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C108461E12
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 14:47:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83655C385A3;
        Fri,  8 Apr 2022 14:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649429236;
        bh=uFnBK08Qb+sRg8CpeU7lutMdHslM9UrQV5P3vlPmCTo=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=SR14bS9XZdZlWBPdwJk2dhc0y7mJ3szTSdJQBHqgk7Dzg2tKGWt7uvap5xdqLKfbW
         vUrsxRBZge/RaZlppUwlKeylWmzUoBV1vw7+vjMR4jZucZNy/qCvaLK8vpYgpKjoUU
         Xf3KkLTFwji71kNfzl2Eirl4xanWmsxRmMZAjhFm75lB43/+w8u+hZ91Z4f6vYhkvK
         k4xsG7An4L/Ot7YhrlvX7wjJyq/GOEndRnvUspEO36JGWOzRFsUg1hcBqrCvQ5ROwK
         lPnFop0aQZQfP+FnltShJ05o8Eq5Oa29RoJYPd+KZI+hTWJUGTvFsDu4cTKeuTSptd
         YerGw4ef56s1Q==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, perex@perex.cz, cgel.zte@gmail.com
Cc:     trevor.wu@mediatek.com, tzungbi@google.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        zealci@zte.com.cn, matthias.bgg@gmail.com, tiwai@suse.com,
        alsa-devel@alsa-project.org, lv.ruyi@zte.com.cn,
        linux-mediatek@lists.infradead.org,
        angelogioacchino.delregno@collabora.com
In-Reply-To: <20220408100309.2495462-1-lv.ruyi@zte.com.cn>
References: <20220408100309.2495462-1-lv.ruyi@zte.com.cn>
Subject: Re: [PATCH] ASoC: mediatek: mt8195: Make sure of_device_id table are NULL terminated
Message-Id: <164942923326.1424253.13615107780674647897.b4-ty@kernel.org>
Date:   Fri, 08 Apr 2022 15:47:13 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Apr 2022 10:03:09 +0000, cgel.zte@gmail.com wrote:
> From: Lv Ruyi <lv.ruyi@zte.com.cn>
> 
> Fix the following coccicheck review:
> ./sound/soc/mediatek/mt8195/mt8195-mt6359.c:1657:1-2:
> mt8195_mt6359_dt_match is not NULL terminated at line 1657
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: mt8195: Make sure of_device_id table are NULL terminated
      commit: a2c11c5b68f49b36be9ad4a60165bfbeca5cbb1d

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
