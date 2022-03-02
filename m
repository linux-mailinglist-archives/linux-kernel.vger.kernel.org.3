Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58EE04CAB06
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 18:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236980AbiCBRCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 12:02:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243621AbiCBRCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 12:02:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F8B4CA0FC;
        Wed,  2 Mar 2022 09:01:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F54B618F6;
        Wed,  2 Mar 2022 17:01:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44BD4C340F2;
        Wed,  2 Mar 2022 17:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646240476;
        bh=R7s0AMOa7GDvMxpmv+G+a/sc5zOq6biTNWXkA0JoM78=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=I/HK2mGI7maxJLti9J7yhnXtaAavSh/jQkfCsoWv+rbjHsC+7V00kfJ/LXYk7PRzr
         8doE0pEoM6aJ3ts8uEI61Ig5ShuZS3SdLawCpRHKKoKnBkpRRPN/3PKXvrrc8++OO/
         gRocGsEWTm+s8GkUSgvXE7VCh9Pe+pwhTdZ+T6O46W6P7ykki/5tqpPdFgN+s6Ky8+
         k/XwwoPM7v8d2Vqr7kMMxtt67rO/LWte3FywMnoG5rjlZCEzhubuBaqRWrTmgv4PCy
         VblErclFRFDpQlRDB4nJlIzNO48WouFllVdFgeJAze2sYlvWwts7i1BbJ7mL7Zvk4N
         0BwjNxn5k2VOw==
From:   Mark Brown <broonie@kernel.org>
To:     linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        devicetree@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>
In-Reply-To: <20220301134244.20174-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220301134244.20174-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH] spi: dt-bindings: renesas,rspi: Drop comment for generic compatible string
Message-Id: <164624047399.1145410.13640737643937611609.b4-ty@kernel.org>
Date:   Wed, 02 Mar 2022 17:01:13 +0000
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

On Tue, 1 Mar 2022 13:42:43 +0000, Lad Prabhakar wrote:
> Drop comment "# RZ/A and RZ/G2{L,LC}" for generic compatible string
> "renesas,rspi-rz" as this will avoid changing the line for every new SoC
> addition.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: dt-bindings: renesas,rspi: Drop comment for generic compatible string
      commit: ee8ad9440f18478796dbd7e0891efcc44376ab70

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
