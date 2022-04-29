Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B817C514ABF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 15:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376321AbiD2NnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 09:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359812AbiD2Nms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 09:42:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E06CABB9
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 06:39:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 293C5B8301B
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 13:39:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45615C385B0;
        Fri, 29 Apr 2022 13:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651239567;
        bh=oTA/bLA09vyo7gZftSiBJgvnmnzNeALY3BscTIa+ohw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=g2iWwYLhZMqK/AT1qsnItdAbEkyJvxxyoA3K1GYJrA+o76kDlvN915Ls+oqDkF2wY
         +KgnKeJ19klqffLx7drnPNtUY2WqKbuwB4pK2wVy/r6R7dRbai8ZiOvEfxHm4tN5Rk
         Oem4Myu40JQW8wpp4vxU0/dH1bRvwPpRu+rWXj2k73S32TqGYx5ym21swq9VIV9O7X
         7RdRDvp6BreO7NYw2BVovviIQdCwbOkuXqHqtZMkM7FlXNr47pKiTFBKyWAjwEA9Rw
         rFsLLEI3hAx5QtZh/vioFxmvYOjKIoELdAUymfRr1RcCFAopZVJMm5fd2zXfWP5h1e
         yXEbTShKn7FiA==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, katsuhiro@katsuster.net,
        frattaroli.nicolas@gmail.com, perex@perex.cz, tiwai@suse.com
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-rockchip@lists.infradead.org
In-Reply-To: <20220427172310.138638-1-frattaroli.nicolas@gmail.com>
References: <20220427172310.138638-1-frattaroli.nicolas@gmail.com>
Subject: Re: [PATCH] ASoC: rk3328: fix disabling mclk on pclk probe failure
Message-Id: <165123956599.69278.1250997560637769759.b4-ty@kernel.org>
Date:   Fri, 29 Apr 2022 14:39:25 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Apr 2022 19:23:11 +0200, Nicolas Frattaroli wrote:
> If preparing/enabling the pclk fails, the probe function should
> unprepare and disable the previously prepared and enabled mclk,
> which it doesn't do. This commit rectifies this.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rk3328: fix disabling mclk on pclk probe failure
      commit: dd508e324cdde1c06ace08a8143fa50333a90703

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
