Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB65352EA9D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 13:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348474AbiETLTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 07:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348465AbiETLSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 07:18:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2709A14CDCF
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 04:18:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A8D2761DB4
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 11:18:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2804EC385A9;
        Fri, 20 May 2022 11:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653045532;
        bh=hm92cqByreXas/bEgQfVySkccwSgtlqkEkhn8E2dpuM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ZmBUhPxgtXVt+6ijlPIB99zHWNb0nh7K1KxOfUBgRbh97A0FhYDvhf+e43+2GiHf8
         nHI4l/eaA2ZysNMKUIYndvy7w+9PPKRg/dMnBywjdq6FSzcfLsbOy4Vns6UZqX5F2f
         cvSOmfanHnjS69MMP/PojwUIgNqd2pv566t6WKUivZJWhl+FgsfwyAjt0lV0meiNdX
         FmSwK/gxjFbfZtctPC1AXDqIn0am6gCbHhsph9gl5jvgRXKn0EZeRJFmRiLIIZy78d
         qyF6MOa0K/YPtiGTr8uWdmoph3wTvCloGK+7c4qe8tNIoroVeOBz+I75WG2+f2Luov
         j4/JCu6zcVQLQ==
From:   Mark Brown <broonie@kernel.org>
To:     tiwai@suse.com, u0084500@gmail.com, perex@perex.cz
Cc:     oder_chiou@realtek.com, cy_huang@richtek.com,
        ritchie_hsieh@richtek.com, allen_lin@richtek.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        lgirdwood@gmail.com
In-Reply-To: <1652926418-8519-1-git-send-email-u0084500@gmail.com>
References: <1652926418-8519-1-git-send-email-u0084500@gmail.com>
Subject: Re: [PATCH 0/2] ASoC: rt9120: Fix 3byte read logic and optimize 'PWDN' control
Message-Id: <165304552987.45439.3493847954121004579.b4-ty@kernel.org>
Date:   Fri, 20 May 2022 12:18:49 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 May 2022 10:13:36 +0800, cy_huang wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Hi,
> 
> This patch series try to fix two things.
> - 3byte read logic bug
> - Use regcache and pm_runtime to optimize 'PWDN' control
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: rt9120: Fix 3byte read, valule offset typo
      commit: 57f68f2168988e574133fb5abcd73949bf1d1df2
[2/2] ASoC: rt9120: Use pm_runtime and regcache to optimize 'pwdnn' logic
      commit: 80b949f332e331b67c3ae4f323daf2cb91e743e5

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
