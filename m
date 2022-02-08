Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2229E4ADC00
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 16:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379462AbiBHPH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 10:07:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379044AbiBHPHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 10:07:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96EB6C061577
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 07:07:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 32759614CD
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 15:07:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFE89C004E1;
        Tue,  8 Feb 2022 15:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644332873;
        bh=Uibn/nvs0txEM63mxxzdwPuACyNUqPDkvUBxEIrRbIc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=NC7Qh1J10M9MCJz3CTRwMU4YPt9o5AZCdi7awXjbgZisY17tNXlQbZZy7/9F/jXWY
         rY+mtmCnaK4VxyEH4nOHEgtYNgZpMePFcxmnyZI92sC2wp1lxsVtddHWdM29wBoq2H
         Sere8vMTpqMPkYJmKWRcdGRz6Gzyk2rzbul7RVmUVfhNje4ek5mzlK/XBgnlaAYETT
         07n5jLkCHjXOHWLG6E3P7GAQq02qISeIvz1NnKZPeXgKuENJT/oFpuJH29Srb0lVf2
         ndy+/s1qYakvW7ar58cl6bCPJX8aKdxFVXc1M3AaghUqQKvaG9unu3y406dZarbfnx
         uNoRO5UR6DwhQ==
From:   Mark Brown <broonie@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>,
        Daniel Golle <daniel@makrotopia.org>,
        linux-kernel@vger.kernel.org,
        James Liao <jamesjj.liao@mediatek.com>,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>
In-Reply-To: <20220207160923.3911501-1-linux@roeck-us.net>
References: <20220207160923.3911501-1-linux@roeck-us.net>
Subject: Re: [PATCH v2] ASoC: Revert "ASoC: mediatek: Check for error clk pointer"
Message-Id: <164433287142.2964899.6109148874743045900.b4-ty@kernel.org>
Date:   Tue, 08 Feb 2022 15:07:51 +0000
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

On Mon, 7 Feb 2022 08:09:23 -0800, Guenter Roeck wrote:
> This reverts commit 9de2b9286a6d ("ASoC: mediatek: Check for error clk
> pointer").
> 
> With this patch in the tree, Chromebooks running the affected hardware
> no longer boot. Bisect points to this patch, and reverting it fixes
> the problem.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-linus

Thanks!

[1/1] ASoC: Revert "ASoC: mediatek: Check for error clk pointer"
      commit: 946eb87114af37c9c13c618a7c1cdaca936905fa

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
