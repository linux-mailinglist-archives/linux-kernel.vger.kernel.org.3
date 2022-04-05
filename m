Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5B64F3E22
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 22:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389547AbiDEPVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 11:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347104AbiDEJqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 05:46:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34436D4E3;
        Tue,  5 Apr 2022 02:32:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E4A8616AE;
        Tue,  5 Apr 2022 09:32:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 289B6C385A4;
        Tue,  5 Apr 2022 09:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649151143;
        bh=4sUt83BgTOE5J9hysaJUhknfGWeSQ6S+Ynto5f4x3DY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Pm8J9hUCvcDjpvYrEvJzkvHiV/px742+iYYyeBW9xSpfsX1ALiIM519J15mSPWlvd
         QCphgPP/Cep4YhtKPiicISTkYl+4QeLqWrMM9BtEeOGkKUQkz13Bqwe1mH2B7FLUuh
         qdOflx/MdupPABcek0e9lKPBzJ0W2C3RH+pcBZs6o1ZtQfJxUteMyq0/6bUmBDvle8
         J3eKkdjVEtCmA9yR34C/Vzf62Dzc3IHY5h4d1KGO68Cg+3ph+5E00f8Th72kH75ZMx
         wLmCgunuohj4lt1ii5+WDdT3GR19VA1SICgtIwC7PlVH1Yt52e35Esoawppjwfqkb5
         /POA2/BXHzpCw==
From:   Mark Brown <broonie@kernel.org>
To:     leilk.liu@mediatek.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, linux-mediatek@lists.infradead.org,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        matthias.bgg@gmail.com
In-Reply-To: <20220321013922.24067-1-leilk.liu@mediatek.com>
References: <20220321013922.24067-1-leilk.liu@mediatek.com>
Subject: Re: [PATCH V6 0/3] spi: mediatek: add single/quad mode support
Message-Id: <164915114188.276894.4149061684421416704.b4-ty@kernel.org>
Date:   Tue, 05 Apr 2022 10:32:21 +0100
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

On Mon, 21 Mar 2022 09:39:19 +0800, Leilk Liu wrote:
> This series of patches are based on spi for-next, and provide 3 patches to support MT7986.
> 
> V6:
>  1. remove SPI_CFG3_IPM_PIN_MODE_OFFSET.
>  2. add Reviewed-by: AngeloGioacchino Del Regno
> 
> V5:
>  1. remove 3 patches that already applied.
>  2. use devm_clk_get_optional.
>  3. remove of_mtk_spi_parse_dt()
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] spi: mediatek: add spi memory support for ipm design
      commit: 9f763fd20da7d892ffaedac0c58d821922f8a674
[2/3] dt-bindings: spi: support hclk
      commit: a4765dfb80a7333aaac394a5ba20056d11b55636
[3/3] spi: mediatek: support hclk
      commit: a740f4e684c020ea57a8a198a9322d739f7ab6d5

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
