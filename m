Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F32584FE92B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 21:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbiDLT6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 15:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbiDLT5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 15:57:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3DA5E172;
        Tue, 12 Apr 2022 12:50:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED08A61BEF;
        Tue, 12 Apr 2022 19:50:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2128C385A1;
        Tue, 12 Apr 2022 19:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649793037;
        bh=nT93jamfbYnoTsEm4Lz28WvUjv7TcUJr8AkbHMTMDsE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=FFTT6xhZR3P/Za71GH6f8NdS9a3R+L4wdP/9Dnnt9P9nSVQMSXWkFM2e/xJok2D+w
         BoUuK5stxD3hBYUF2nP+768waVpkiZtg1kz1Y+50upJV2x2JWRyb0Bxdrj41Gr9+so
         8cEA4J9JScVxL2v3NJJiV0OK+6FUGIDqnrydku9ZE8tX47x2Ef5skrIpNOlqpIIzjI
         9ZIW0MJYtT9veiko9WPcNEBI7mc/F5MO0MXiKOyFqPBhYrLQKnaPbyhh1yv2FRlg6h
         KP6iWtKTADlDuw9lwfVhDiOteHLpemmKzcYva+0WDI/ijYl2upquQg/EUsr/Sv++/O
         /ktC1HEV/ziBA==
From:   Mark Brown <broonie@kernel.org>
To:     allen-kh.cheng@mediatek.com, ikjn@chromium.org,
        matthias.bgg@gmail.com
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-spi@vger.kernel.org
In-Reply-To: <20220412115743.22641-1-allen-kh.cheng@mediatek.com>
References: <20220412115743.22641-1-allen-kh.cheng@mediatek.com>
Subject: Re: [PATCH] spi: spi-mtk-nor: initialize spi controller after resume
Message-Id: <164979303551.449574.9303978009033918270.b4-ty@kernel.org>
Date:   Tue, 12 Apr 2022 20:50:35 +0100
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

On Tue, 12 Apr 2022 19:57:43 +0800, Allen-KH Cheng wrote:
> After system resumes, the registers of nor controller are
> initialized with default values. The nor controller will
> not function properly.
> 
> To handle both issues above, we add mtk_nor_init() in
> mtk_nor_resume after pm_runtime_force_resume().
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-mtk-nor: initialize spi controller after resume
      commit: 317c2045618cc1f8d38beb8c93a7bdb6ad8638c6

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
