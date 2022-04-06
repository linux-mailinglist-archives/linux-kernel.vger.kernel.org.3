Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6358E4F645B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 18:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbiDFQAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 12:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236958AbiDFP7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 11:59:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD13946E60F
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 06:28:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4EBFDB823C3
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 13:28:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC0FDC385A9;
        Wed,  6 Apr 2022 13:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649251720;
        bh=SapR/NGS0zHiukVcEi1sjt1o5RguCptFWulxy98tqWA=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=qBE6vy/DKRlrqfk8OWxSirFDZMVqiTSuBzW8DuegVviTNxduBA/czlteRsefSFsju
         eSrQDuT2Ri3W/8znnOPz1dvd1XS/CKOpYwo+Jhnp6pN7MOLE0pCWzsRAOnBULnwH4e
         SKuCZe+6Rlj52sdtm7QHPgTA6voOO9HfsmcvwvZZw0s8ngISWe7xCOVHSyXXiram29
         kvF9DVx4oFqWVMUXaHEcPzoXsU5mrmyxBjjTeXG1zpOuYQ9ArjNN5/M6emcLTRncEd
         ZCuW/AagOexFfhZQvjMoZfr0PGCR3AoHwup6HCUj9sn/rikJv1ifAcPGA/CLBmo90l
         XdYzf/YmcFq5w==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        tiwai@suse.com, jiaxin.yu@mediatek.com,
        linux-mediatek@lists.infradead.org, linmq006@gmail.com,
        koro.chen@mediatek.com, lgirdwood@gmail.com,
        matthias.bgg@gmail.com, perex@perex.cz,
        alsa-devel@alsa-project.org, tzungbi@google.com
In-Reply-To: <20220404092903.26725-1-linmq006@gmail.com>
References: <20220404092903.26725-1-linmq006@gmail.com>
Subject: Re: [PATCH] ASoC: mediatek: Fix error handling in mt8173_max98090_dev_probe
Message-Id: <164925171747.83821.17392124533479234810.b4-ty@kernel.org>
Date:   Wed, 06 Apr 2022 14:28:37 +0100
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

On Mon, 4 Apr 2022 09:29:01 +0000, Miaoqian Lin wrote:
> Call of_node_put(platform_node) to avoid refcount leak in
> the error path.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: Fix error handling in mt8173_max98090_dev_probe
      commit: 4f4e0454e226de3bf4efd7e7924d1edc571c52d5

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
