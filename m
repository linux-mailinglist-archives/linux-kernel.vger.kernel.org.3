Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0733F4CAB09
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 18:01:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243640AbiCBRCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 12:02:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243642AbiCBRCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 12:02:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D79CF387;
        Wed,  2 Mar 2022 09:01:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 80C7BB82104;
        Wed,  2 Mar 2022 17:01:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81B73C340ED;
        Wed,  2 Mar 2022 17:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646240478;
        bh=Zs5wBntKidaaPOmZunJVUcvMcbvcyFX9EXzTcGS2KjQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Qs9Sq6kpS4eBlNYQOTEsTVs3RXAFuEXzRTDItD8yubKcESwXJ1DtFsY95/ZiGtfDl
         qZud9M22xAtQqIJFLweN9n4o8XVolZgBfuCUYFqUv+qBL1YijITkf/Pu7IkCByHpXk
         bqYASr2IRir9XuyUus0mlMIknHTfmD5S8Kgp73QWQlB/0wKsRdkUg9V7wJJBBx5FGW
         cppc1MOJ1HVaIRbqYXY5hwRQA4IB8M+aW96re1jtcUkYbkoPnxhd3QoqayUuyw+CNX
         05uuLEVqw93qXxgWEcJbjXDXwCdAgzgRf/IZC2uW5gpX7vNoM1/cdGDNT6xgO2yIB0
         8bytwm5NW43/A==
From:   Mark Brown <broonie@kernel.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Leilk Liu <leilk.liu@mediatek.com>
Cc:     linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <20220301212358.1887668-1-robh@kernel.org>
References: <20220301212358.1887668-1-robh@kernel.org>
Subject: Re: [PATCH] spi: dt-bindings: mediatek: Set min size for 'mediatek,pad-select'
Message-Id: <164624047624.1145410.7673106466966850861.b4-ty@kernel.org>
Date:   Wed, 02 Mar 2022 17:01:16 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Mar 2022 15:23:57 -0600, Rob Herring wrote:
> The minimum array length defaults to the same size as the maximum. For
> 'mediatek,pad-select', the example has a length of 2 and in-tree .dts
> files have a length of 1, but the schema says the length must be 4.
> 
> There's currently no warning in the example because the schema fixups
> are not handling this case correctly.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: dt-bindings: mediatek: Set min size for 'mediatek,pad-select'
      commit: d149dd2a806b9d11e570c3731eca8bda3c5f6238

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
