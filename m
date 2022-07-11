Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 288925706CF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 17:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbiGKPS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 11:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiGKPS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 11:18:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 891B6DE8A
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 08:18:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 20CFA615CE
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 15:18:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C18E4C341C8;
        Mon, 11 Jul 2022 15:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657552735;
        bh=/A3PTdW5tYRvqp6LbUd4hnfzACdhbSnZU5uWQJBjF6E=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Bil69G3QZKz9IFDmv3QykqamC6u2h62z9Pms8eDjeSG2NbOyaKiDfAyQtuvFzGCFD
         1S8XLqdM6HzqJFTl9NFsbxTQLiCFn5cXm8BONNLgalr137E2iWIYL6uIL82Aw9pvGq
         asAE4ykf9jtGnA7nQzVAkDBdXQsrekBHlRa3bdC1rvoNdBVHosL2dXdxjBHkPUBDUv
         Q1qLXCZ0WVt95khiC6h1+yPjOmoTX0/LvpP3iHrqOodMgUQKmq9YyXumao1n1NMNeI
         aBoRMYlD1fVZPqa2YYqpl3/vaPNfX2y2r9w7s3L2z8zXleBFRn3/vqWcTd0UCUWI8s
         FH9rvqvDXEzFw==
From:   Mark Brown <broonie@kernel.org>
To:     claudiu.beznea@microchip.com, perex@perex.cz, tiwai@suse.com,
        lgirdwood@gmail.com
Cc:     alexandre.belloni@bootlin.com, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, nicolas.ferre@microchip.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220711112212.888895-1-claudiu.beznea@microchip.com>
References: <20220711112212.888895-1-claudiu.beznea@microchip.com>
Subject: Re: [PATCH] ASoC: atmel: mchp-pdmc: remove space in front of mchp_pdmc_dt_init()
Message-Id: <165755273352.520536.8724051987921046485.b4-ty@kernel.org>
Date:   Mon, 11 Jul 2022 16:18:53 +0100
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

On Mon, 11 Jul 2022 14:22:12 +0300, Claudiu Beznea wrote:
> Remove extra space in front of mchp_pdmc_dt_init().
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: atmel: mchp-pdmc: remove space in front of mchp_pdmc_dt_init()
      commit: 375f53566cf04324825b7a0f545aeb4405963bd0

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
