Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21F974F4005
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 23:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350605AbiDEPYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 11:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347159AbiDEJqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 05:46:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE30DCE2B;
        Tue,  5 Apr 2022 02:32:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 98173615E5;
        Tue,  5 Apr 2022 09:32:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 014EDC385AC;
        Tue,  5 Apr 2022 09:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649151152;
        bh=JncMrmfzGwPQjE8v5Pu7YmvmRGLYwvdId2BOQWsQm3g=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Lwe2vorGKyGz1bl2S5iuUkKHrbRH7fJipkVD/5CprU9IVf1St+0vLejwdA5JNej4E
         2TC2gE/DAVvJijHf6f7ncy2/3gEaLoHAFsKOEMM/kJcoGijA1Sth6yuHjqq91Rwqf+
         a+I311V25B6/YKfySaEQMlVHnDJYeGHiwn/5zvQ29TLp13jMHvPBmA2SjSVWgIx/sC
         R31xZuDvm8NqXlplbULmp0BI6pXvcUTJyGpEcw8HxQsPBbPfUps8N8ltJIm8vsLyjS
         KmwSwVK3BXUHZAmyMVJVTBhvJy7fNRutKOlxp+JPb10YAYlr7ZgF/VB9Wbb5O0n5Vx
         9J/T+CMQJqRNQ==
From:   Mark Brown <broonie@kernel.org>
To:     miquel.raynal@bootlin.com, christophe.jaillet@wanadoo.fr
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        kernel-janitors@vger.kernel.org
In-Reply-To: <09c81f751241f6ec0bac7a48d4ec814a742e0d17.1648980664.git.christophe.jaillet@wanadoo.fr>
References: <09c81f751241f6ec0bac7a48d4ec814a742e0d17.1648980664.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] spi: mxic: Fix an error handling path in mxic_spi_probe()
Message-Id: <164915115073.276894.2017003822406152149.b4-ty@kernel.org>
Date:   Tue, 05 Apr 2022 10:32:30 +0100
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

On Sun, 3 Apr 2022 12:11:13 +0200, Christophe JAILLET wrote:
> If spi_register_master() fails, we must undo a previous
> mxic_spi_mem_ecc_probe() call, as already done in the remove function.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: mxic: Fix an error handling path in mxic_spi_probe()
      commit: 35d516bdcd92fde46202d06b68df1166760208fd

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
