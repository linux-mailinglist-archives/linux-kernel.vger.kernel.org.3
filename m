Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D83284D9C7A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 14:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348803AbiCONmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 09:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348742AbiCONmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 09:42:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15FF52E60;
        Tue, 15 Mar 2022 06:41:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 777DFB81681;
        Tue, 15 Mar 2022 13:41:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B45D3C340F4;
        Tue, 15 Mar 2022 13:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647351664;
        bh=5GoPK5Absvivj6zbGvAbFgfXegOGh3wNX8cSwc4rE2Y=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=FFPImUwRJDbCvfgkde1ZiY2E0xqIjyt/nvkBKcHsOjugP7pKiun2GTEwDpXKDjgWd
         qUCchZh0HdRwzgcAf45YNfb5V5Rz0QQfy/z7RKj/nkiS1b1VAcpGO6n1yLM9DDdyxg
         gufGGq0vA4UVMec8WGGNppyO/+ljNlWuD2PGTsbHoVtqcfF952wuzQkx0dcufty8ex
         7Wt6uJThbhFpuDZhDTSeZOewBpCQGFMtSoAsYXIGxwfLEJ81Wiu4DKSsf6stTOCnFG
         oTDFe54ar9QIoh2ii89I/+1OHRskZ3kVrM0bZr4Jqlysk4Q5F/2ICmv3ccM1EduMWK
         0LYb/Ks7S8lqA==
From:   Mark Brown <broonie@kernel.org>
To:     Leilk Liu <leilk.liu@mediatek.com>
Cc:     devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20220315032411.2826-1-leilk.liu@mediatek.com>
References: <20220315032411.2826-1-leilk.liu@mediatek.com>
Subject: Re: (subset) [PATCH V4 0/6] spi: mediatek: add single/quad mode support
Message-Id: <164735166243.3687547.12763908878922774952.b4-ty@kernel.org>
Date:   Tue, 15 Mar 2022 13:41:02 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Mar 2022 11:24:05 +0800, Leilk Liu wrote:
> This series of patches are based on spi for-next, and provide 6 patches to support MT7986.
> 
> v4:
>  1. fix Rob comment in v3;
>  2. use "mediatek,mt7986-spi-ipm","mediatek,spi-ipm"
> 
> v3:
>  1. add Rob Acked-by in "dt-bindings: spi: Add compatible for MT7986 with single mode";
>  2. add a fix patch "spi: mediatek: support tick_delay without enhance_timing";
>  3. fix Angelogioacchino comments;
>  4. use mt7986 instead of ipm in dt-binding.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/6] spi: mediatek: support tick_delay without enhance_timing
      commit: 03b1be379dcee2e9c866c2a455a1a4a9581b3efd
[2/6] dt-bindings: spi: Add compatible for MT7986
      commit: da40a352db2bae470a3eea038cc53454c24e67f3
[3/6] spi: mediatek: add ipm design support for MT7986
      commit: 7e963fb2a33ce488e65258ab5be38a4855923033

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
