Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6B55A607D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 12:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbiH3KPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 06:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbiH3KNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 06:13:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7BE92DED;
        Tue, 30 Aug 2022 03:09:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 87577B811B3;
        Tue, 30 Aug 2022 10:09:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD727C433D6;
        Tue, 30 Aug 2022 10:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661854152;
        bh=0GgQSfiovxbB6DlRH1/NdKZX2aHBw5Zag6bneKmYBJY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=B6J2RmE3b6y2cRIRMNi1f8wV0jciD7CxkwjjVWXNProlo5pvQEGBpq1/2Chl1N7yX
         jni8dMRa5VpsyBwz/wvxM40nOveqTbavwKNdzpslr8FKI0nnY/j0PeWHPv1QZYHfK4
         f6p3aKXQuThtqgJT1/tyhNigUiFbDEKkJ3CHHMmsgGf3HmAk8L5pFKXQyVdRbKjwyj
         OfikAdOlOPAmw0/1iWjVH8S3F+TQXRXAsTxmmaPlD3AaZZ9HdTkTHMK7rJTY1Dmpx9
         /vmDMV3x8BxRqsjPWFr+3RNHL5mlFJdnjkxDEWvalxa7QRDaAJHaTmc+yKGcqTnLkS
         59zkbokSBOzCQ==
From:   Mark Brown <broonie@kernel.org>
To:     linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
In-Reply-To: <20220824094327.33685-1-wsa+renesas@sang-engineering.com>
References: <20220824094327.33685-1-wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH 0/3] spi: add generic R-Car Gen4 and specific r8a779f0 support
Message-Id: <166185415042.1099942.6942703458061199839.b4-ty@kernel.org>
Date:   Tue, 30 Aug 2022 11:09:10 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-65ba7
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Aug 2022 11:43:23 +0200, Wolfram Sang wrote:
> Here are the patches to enable MSIOF on R-Car S4-8. They also introduce
> generic Gen4 support and move V3U to Gen4 (which it really is).
> 
> Wolfram Sang (3):
>   spi: renesas,sh-msiof: Add generic Gen4 and r8a779f0 support
>   spi: sh-msiof: add generic Gen4 binding
>   spi: renesas,sh-msiof: R-Car V3U is R-Car Gen4
> 
> [...]

Applied to

   broonie/spi.git for-next

Thanks!

[1/3] spi: renesas,sh-msiof: Add generic Gen4 and r8a779f0 support
      commit: e1e62f05d5d9d7726349e00562299d829e478ce9
[2/3] spi: sh-msiof: add generic Gen4 binding
      commit: ea9d001550abaf2f4c75cf4fcd936ea19f932b84
[3/3] spi: renesas,sh-msiof: R-Car V3U is R-Car Gen4
      commit: b076fdd02133e6a31db167f8acc368edc2530cc0

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
