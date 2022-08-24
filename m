Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8AB059FF6B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 18:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238163AbiHXQY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 12:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231866AbiHXQY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 12:24:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC934BA68;
        Wed, 24 Aug 2022 09:24:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 45DA1B825C1;
        Wed, 24 Aug 2022 16:24:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D854C433C1;
        Wed, 24 Aug 2022 16:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661358263;
        bh=Y4eBdkGZIGqWLszQ5IONiL0dwf3AHaygY1nAw/brFPI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=RU2ONLK9WOfTtDPX11OYiLJ72DJnnMM4Y0r91FKLDOBr+sTrgSkpwknaS2Cxdnc4D
         ro0B6Gvrvb91B5wBX49rJhAL2yRg+X/tblzBnIv9JRunK421naPc7yvEy16n8u4MGV
         EKvm6J9BfGWiayrPQlUofDwLCKJVY4hRVK9tTanC9+YuDxoSMNGyE2qbmTQ2scVi2d
         hepqZ0JdD/ItPatE9Svg3Xu4kpNPtm8yj/QeovDdlViNNJYS0jAFpOKM8UxsSV+k+n
         0+rV9XJJZtumbZOS3h5fOKe7xOSjYWdCgktKRM5cfHXkYzAJwVfCjQnYDgQWSsMF2l
         PgfkIHbh5Ea0A==
From:   Mark Brown <broonie@kernel.org>
To:     nfraprado@collabora.com, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, Chunxu Li <chunxu.li@mediatek.com>
Cc:     project_global_chrome_upstream_group@mediatek.com,
        jiaxin.yu@mediatek.com, lgirdwood@gmail.com,
        devicetree@vger.kernel.org, matthias.bgg@gmail.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
In-Reply-To: <20220820075343.13993-1-chunxu.li@mediatek.com>
References: <20220820075343.13993-1-chunxu.li@mediatek.com>
Subject: Re: [PATCH 0/2] dt-bindings: sound: Add SOF field for mt8186
Message-Id: <166135826016.480875.10489482967868732209.b4-ty@kernel.org>
Date:   Wed, 24 Aug 2022 17:24:20 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-0c1df
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Aug 2022 15:53:41 +0800, Chunxu Li wrote:
> From: "chunxu.li" <chunxu.li@mediatek.com>
> 
> These patches add SOF field for mt8186 machine driver
> 
> chunxu.li (2):
>   ASoC: mediatek: dt-bindings: modify machine bindings for SOF
>   ASoC: mediatek: dt-bindings: modify machine bindings for SOF
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: mediatek: dt-bindings: modify machine bindings for SOF
      commit: 1173107d7c129ff87224814fd38fce5db023aaa0
[2/2] ASoC: mediatek: dt-bindings: modify machine bindings for SOF
      commit: 1173107d7c129ff87224814fd38fce5db023aaa0

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
