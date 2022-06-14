Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED88054AE3C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 12:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354716AbiFNKZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 06:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354793AbiFNKZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 06:25:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7467347ACB
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 03:25:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 31D26B8184F
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 10:25:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1194C341C0;
        Tue, 14 Jun 2022 10:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655202314;
        bh=/4wjBN/XD9r9d8fn277nelFLTt+axEseUdjXrsmW1cU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=JdeSQWXLchu9QxQUVDqhSTbVyAhOjuRuArsn0syriXa+9Qq9BrxzCpSbML5WI6MvX
         rieOOwWnvg/qq0YjsQmfXXIgeK6bx8mQHr+Cp7jItHCN2TGh12ndouxY2FFFPOMzoV
         OIj9Mb9xNVeeg7e7EYjwZAe452Iwx8BRu9WNpRbfAaEvucIA6+u0M2XLRpTQgF4owu
         hkJKkhk4nlzqH98aZNLkIRN8piFSAYzExErE7j+l41MzNbTwRZ3EqFPXUSTgcaT58B
         RjsjdaMcL3qclOjPvMSkjIE7/PkiKj4D6GIXIZdSp95ObCXd5jSt0nEnh7dDi9Gs33
         rlAatUrbYIFqw==
From:   Mark Brown <broonie@kernel.org>
To:     ckeepax@opensource.cirrus.com, samuel@sholland.org
Cc:     linux-mediatek@lists.infradead.org, linux-sunxi@lists.linux.dev,
        patches@opensource.cirrus.com, jernej.skrabec@gmail.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        wens@csie.org, lgirdwood@gmail.com, matthias.bgg@gmail.com
In-Reply-To: <20220613161552.481337-1-ckeepax@opensource.cirrus.com>
References: <20220613161552.481337-1-ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH 1/2] ASoC: sun8i-codec: Partial revert to fix clock specifiers
Message-Id: <165520231251.3607327.1586830877046934824.b4-ty@kernel.org>
Date:   Tue, 14 Jun 2022 11:25:12 +0100
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

On Mon, 13 Jun 2022 17:15:51 +0100, Charles Keepax wrote:
> Recent updates accidentally updated the clock producer/consumer
> specifiers on this device as part of refactoring the CPU side of the DAI
> links. However, this device sits on the CODEC side and shouldn't have
> been updated. Partially revert the changes keeping the switch to the new
> clock terminology but going back to the CODEC defines.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: sun8i-codec: Partial revert to fix clock specifiers
      commit: beb89d1d49e9ae1188356d6e37581e5f0b5f62b4
[2/2] ASoC: mediatek: mt8186: Use new direct clock defines
      commit: 845a215558647acd4290dd773b9c0de62c123335

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
