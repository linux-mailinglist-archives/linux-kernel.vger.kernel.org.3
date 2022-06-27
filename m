Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC0155CD17
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241322AbiF0UdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 16:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241315AbiF0UdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 16:33:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A30215FBF;
        Mon, 27 Jun 2022 13:33:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5C10FB81B1A;
        Mon, 27 Jun 2022 20:33:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF69CC385A5;
        Mon, 27 Jun 2022 20:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656361994;
        bh=UGNf3JQBQA1G3N3IKKt0DxZWbqRY9n/yeyxP0VBx39A=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=ToXkyagZiDbV2GVROo8aBKcl0Ma0D2GA7XJf36txPJmqqvFuuz0FRiQ/WxfA6qL7d
         EkAK64B8DJ/ocfOM19SHtgE+ZyDYEqmS4iDzCVaVUJznvFoCSr6Jzvn4bkIevDECWT
         DcD3GhVIxXvUgt8WUO9cGN20DW7qIudPOQj7M28i5NCJt9J/skW42u7cpHtOesrfZm
         iBQLt13GIwsQdk/FdnvW6n9R+crurrX+5ws+f7pKsDKQOEc5IfbbkCGmPM3yGex2Mm
         /TK2xtaodexcBDaFTsnJPS51NmSyQ3+xt5AxX1SG5HAJrnTh/81iJQkz9xkLZC376H
         HysY2i4h5GkBw==
From:   Mark Brown <broonie@kernel.org>
To:     andi@etezian.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        krzysztof.kozlowski@linaro.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org
In-Reply-To: <20220626112838.19281-1-krzysztof.kozlowski@linaro.org>
References: <20220626112838.19281-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] spi: dt-bindings: samsung: Add Exynos4210 SPI
Message-Id: <165636199250.4094756.9720956481733870534.b4-ty@kernel.org>
Date:   Mon, 27 Jun 2022 21:33:12 +0100
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

On Sun, 26 Jun 2022 13:28:38 +0200, Krzysztof Kozlowski wrote:
> Document samsung,exynos4210-spi compatible which is already used on
> several Exynos SoCs.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: dt-bindings: samsung: Add Exynos4210 SPI
      commit: 595d68c1b7a81c6cfbdd7c8b50c1e047dc1087ac

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
