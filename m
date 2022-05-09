Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23962520595
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 21:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240770AbiEIUBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 16:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240708AbiEIUBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 16:01:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F3718B21;
        Mon,  9 May 2022 12:57:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 906C4616B1;
        Mon,  9 May 2022 19:57:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C267C385B2;
        Mon,  9 May 2022 19:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652126264;
        bh=xKlmdHLZkImPaVJ0vEbDOGtDhEjWXzfx0mxKGKDFUxc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=PmlGsU9so7KVEDdzDsc5qWpNV6GzoLmKQ6M4uuNs8KZuP0ur01kpRPaWxJjBIrj4C
         VTUypkjSTLbcXK/sqFIa+cG4DdtdT0ZHSgb1zjjtqReoLiBMxYg3F98jmahaWTJ/mw
         ViU7DHcDQjd8O4A5KasMR2Xhn3l+aLeh1cDdxPr5tTu28ef5wADDfTFG7czn/SI/u0
         eUY2/ax3Hbbj/Al8z3DVlz7DZl4dEI2jqqDtSYcXC4ad6ovWhoRTYMdvxDR7GQGcZL
         Km4bRMrYIgbwzqfwcN1sNTCnqg7qyxdIZP5odFp5cvLoBsTqDXR90PYRC3fQwVG3LA
         RrfjZNnHmH+zQ==
From:   Mark Brown <broonie@kernel.org>
To:     nfraprado@collabora.com
Cc:     angelogioacchino.delregno@collabora.com,
        linux-arm-kernel@lists.infradead.org, matthias.bgg@gmail.com,
        robh+dt@kernel.org, jiaxin.yu@mediatek.com,
        alsa-devel@alsa-project.org, shane.chien@mediatek.com,
        lgirdwood@gmail.com, linux-mediatek@lists.infradead.org,
        kernel@collabora.com, krzk+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20220509185625.580811-1-nfraprado@collabora.com>
References: <20220509185625.580811-1-nfraprado@collabora.com>
Subject: Re: [PATCH] Revert "ASoC: dt-bindings: mediatek: mt8192: Add i2s-share properties"
Message-Id: <165212626102.1478109.3697258153804528211.b4-ty@kernel.org>
Date:   Mon, 09 May 2022 20:57:41 +0100
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

On Mon, 9 May 2022 14:56:25 -0400, Nícolas F. R. A. Prado wrote:
> This reverts commit e056cf4341ae3f856f1e38da02b27cb04de4c69b. The commit
> was merged while the property name and definition were still being
> discussed. Revert the commit for now and a follow up commit will re-add
> the property after it is further discussed and reviewed.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] Revert "ASoC: dt-bindings: mediatek: mt8192: Add i2s-share properties"
      commit: d94d1486952b860dcedd04d0ff8ade2176418905

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
