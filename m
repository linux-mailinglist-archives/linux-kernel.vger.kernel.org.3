Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3D3051AF67
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 22:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378132AbiEDUky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 16:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233195AbiEDUku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 16:40:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BEE219032;
        Wed,  4 May 2022 13:37:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CF4D9B82940;
        Wed,  4 May 2022 20:37:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3457AC385A5;
        Wed,  4 May 2022 20:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651696630;
        bh=rvGFtzDUMdxkwhX/QNE/Ypl5Aws2l6MReGUI5o+GqFA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=YL9ninoW5G4S5NnKRM9YU5i27m74E5PiA2pszB2EL6uBlt6P2nVSpYeBYXHj+FLFf
         c+TThsNBYtNJHD+kMnhIp065fv5jj3hslWi65PUVqyhJfUTJSqXfK+kMt3WKETZhun
         joDcYqFo53p6fPcLvbCKD96laCXHRZcCUMD4oZiyH9Wv9qvKPGH8VxgKdSnR1ssSVI
         F1YvdOrHi4wGcgSUMCY4MZLKiVSjny6i/8X8oewxMdxsjt1/1RMyrbolAqk73T0SOG
         o4cgehrMTC0MoL3dczTmu/aC6AI0muCUm/t7lndLCY/yBxEKWvxN5WboQ9AKLUA1y/
         1LhhsxWdtKkEQ==
From:   Mark Brown <broonie@kernel.org>
To:     nfraprado@collabora.com
Cc:     matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        hsin-hsiung.wang@mediatek.com, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, kernel@collabora.com,
        linux-mediatek@lists.infradead.org, lgirdwood@gmail.com,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <20220429201325.2205799-1-nfraprado@collabora.com>
References: <20220429201325.2205799-1-nfraprado@collabora.com>
Subject: Re: [PATCH] dt-bindings: regulator: mt6315: Enforce regulator-compatible, not name
Message-Id: <165169662791.1744767.17732308037249256443.b4-ty@kernel.org>
Date:   Wed, 04 May 2022 21:37:07 +0100
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

On Fri, 29 Apr 2022 16:13:24 -0400, Nícolas F. R. A. Prado wrote:
> The MT6315 PMIC dt-binding should enforce that one of the valid
> regulator-compatible is set in each regulator node. However it was
> mistakenly matching against regulator-name instead.
> 
> Fix the typo. This not only fixes the compatible verification, but also
> lifts the regulator-name restriction, so that more meaningful names can
> be set for each platform.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] dt-bindings: regulator: mt6315: Enforce regulator-compatible, not name
      commit: 6d435a94ba5bb4f2ad381c0828fbae89c66b50fe

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
