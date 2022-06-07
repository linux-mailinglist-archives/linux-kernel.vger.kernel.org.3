Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63DC853FBDA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 12:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241534AbiFGKrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 06:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241611AbiFGKqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:46:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F94DEF044
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 03:46:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2BA8961552
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 10:46:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BC6BC34115;
        Tue,  7 Jun 2022 10:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654598771;
        bh=7hyUoDD8U/8SSRsc3zmtGqzvEKN++qYD6+Qv3iS5Xhc=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=SuY6LaVu/gau0DpI7Q8R6xBJsfAfYKiB2tzYXBqpju6IK2algZNMjsISeFm2c5mcf
         04kJDOvZtD20nCeo/ySGr9a6ZtiXymq42zEVVheBgn4ryHMKDJep4rde4QyOwQPaK/
         NjP/fFnu5XCKAaeJIHiCFKUb8wPcrHx9e7BOwjeYfYeRZv7donfF1xSYEjnM2ZRPSf
         JEydpVrI9LTVF3VRtRKSx1E4UvCFRCMdkJ9y+7te4dD2193R/TC6duY+LwF07ajZQ3
         imwWFFORep06HVYBmlSmUi9cMwF8HkcsmycD8ELFEYi5cuHkoxQB2BvE4UbxEPBZQL
         PlxPo9YHEPBHQ==
From:   Mark Brown <broonie@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, linmq006@gmail.com,
        Liam Girdwood <lgirdwood@gmail.com>, tzungbi@google.com,
        Takashi Iwai <tiwai@suse.com>,
        linux-mediatek@lists.infradead.org, jiaxin.yu@mediatek.com,
        koro.chen@mediatek.com, akihiko.odaki@gmail.com,
        matthias.bgg@gmail.com, linux-kernel@vger.kernel.org,
        Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org
In-Reply-To: <20220602034144.60159-1-linmq006@gmail.com>
References: <20220602034144.60159-1-linmq006@gmail.com>
Subject: Re: [PATCH] ASoC: mediatek: mt8173: Fix refcount leak in mt8173_rt5650_rt5676_dev_probe
Message-Id: <165459876882.301808.14719420011203139333.b4-ty@kernel.org>
Date:   Tue, 07 Jun 2022 11:46:08 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Jun 2022 07:41:42 +0400, Miaoqian Lin wrote:
> of_parse_phandle() returns a node pointer with refcount
> incremented, we should use of_node_put() on it when not need anymore.
> Fix missing of_node_put() in error paths.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: mt8173: Fix refcount leak in mt8173_rt5650_rt5676_dev_probe
      commit: ae4f11c1ed2d67192fdf3d89db719ee439827c11

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
