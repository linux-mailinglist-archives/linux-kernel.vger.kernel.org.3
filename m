Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF20453A5CE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 15:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353186AbiFANTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 09:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353169AbiFANTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 09:19:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA84E13D19;
        Wed,  1 Jun 2022 06:19:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B4E861593;
        Wed,  1 Jun 2022 13:19:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AE54C385A5;
        Wed,  1 Jun 2022 13:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654089578;
        bh=AB7EZgXlN9wIn76rEJlVjIqNkZbMCh4G/EPQNV4hDR8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=RmH1k1IdRE52GGhRi6NwB/MUQcH15odU8MF6mBRtcHhq6b5eInXHD47F/E4obFqIN
         Nm7y0FRyStwxrARgI4gSk3QyGCsZaGxdBibmuLjl4yVNZHhl6bUaLpPXLov5/Gq1od
         cRJVdUAeLleeiAaGDGgWqGfiOfuMQT4hN/SVxL9zRUBLvKehwdJRsKJZ9h8rtYH32l
         V3fIUMiPfaZqxn6czqK9RN8CtP+i3b7Ev8jhm1ge1uN6RVFtmShMdev4+JGLLE0k20
         WPkvpyLthHchAwCxYajAF/7etV36lh4cpE2BH78R2vbxQO9Fnt8gwWx2tiNVEUOQNR
         IXj0GM7xPHx+g==
From:   Mark Brown <broonie@kernel.org>
To:     hsin-hsiung.wang@mediatek.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lgirdwood@gmail.com,
        matthias.bgg@gmail.com, fparent@baylibre.com
Cc:     linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
In-Reply-To: <20220529154613.337559-1-fparent@baylibre.com>
References: <20220529154613.337559-1-fparent@baylibre.com>
Subject: Re: [PATCH] dt-bindings: regulator: mt6315-regulator: fix invalid allowed mode
Message-Id: <165408957615.3063838.14643425310508733291.b4-ty@kernel.org>
Date:   Wed, 01 Jun 2022 15:19:36 +0200
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

On Sun, 29 May 2022 17:46:13 +0200, Fabien Parent wrote:
> In the binding example, the regulator mode 4 is shown as a valid mode,
> but the driver actually only support mode 0 to 2:
> 
> This generates an error in dmesg when copy/pasting the binding example:
> [    0.306080] vbuck1: invalid regulator-allowed-modes element 4
> [    0.307290] vbuck2: invalid regulator-allowed-modes element 4
> 
> [...]

Applied to

   broonie/regulator.git for-linus

Thanks!

[1/1] dt-bindings: regulator: mt6315-regulator: fix invalid allowed mode
      commit: 28cbc2d4c54c09a427b18a1604740efb6b2cc2d6

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
