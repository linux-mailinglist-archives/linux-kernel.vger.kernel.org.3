Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9A584F411D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 23:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240617AbiDEPZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 11:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347201AbiDEJqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 05:46:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF21DD96E;
        Tue,  5 Apr 2022 02:32:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5A60CB81CB3;
        Tue,  5 Apr 2022 09:32:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 735BBC385A3;
        Tue,  5 Apr 2022 09:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649151154;
        bh=cg99cbuB8hB++j+fhgEa4ZdrqC7Cu38pehUZLH1w4KY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=IIgjUBS99lYPqvwHgyFLa1h4B+7F7O2C9jIzDXHtBh4yXjL/VM5gyaqNRq/qVMVce
         i6tJBXscdBWey2Qx0IHyiShR+AkNqxnxyrUSfgVC/JL69cuW1Er4dd+IP/QV2TAFJB
         5N6HGtShxQqUbmLMshbvgbmhA8NnZK6O+W3oz+XRPr++uL07hQoTwk53wTXuEkQP4R
         MkssquhUvVngM0wKXwsdAx0jQmvbuojxswkDIgZhOh46AkmfHITAb6TLu8SzVA9M8v
         5/NLbwjd8FdUqQaDNY7uOhbyytzZJLBA/+DhcN7rYRzuC27tdUnGKwRlxRQ+frUPcM
         kWO7h/NlW9i4Q==
From:   Mark Brown <broonie@kernel.org>
To:     leilk.liu@mediatek.com
Cc:     linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        matthias.bgg@gmail.com
In-Reply-To: <20220401071616.8874-1-leilk.liu@mediatek.com>
References: <20220401071616.8874-1-leilk.liu@mediatek.com>
Subject: Re: [PATCH V7 0/3] spi: mediatek: add single/quad mode support
Message-Id: <164915115220.276894.6481675196400953567.b4-ty@kernel.org>
Date:   Tue, 05 Apr 2022 10:32:32 +0100
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

On Fri, 1 Apr 2022 15:16:13 +0800, Leilk Liu wrote:
> This series of patches are based on spi for-next, and provide 3 patches to support MT7986.
> 
> V7:
> 1. add Reviewed-by: Rob Herring
> 
> V6:
>  1. remove SPI_CFG3_IPM_PIN_MODE_OFFSET.
>  2. add Reviewed-by: AngeloGioacchino Del Regno
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] spi: mediatek: add spi memory support for ipm design
      commit: 9f763fd20da7d892ffaedac0c58d821922f8a674
[2/3] dt-bindings: spi: support hclk
      (no commit info)
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
