Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9B254AF87
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 13:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243229AbiFNLvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 07:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242907AbiFNLvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 07:51:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B12344F0;
        Tue, 14 Jun 2022 04:51:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E36AD61323;
        Tue, 14 Jun 2022 11:51:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D40B0C3411B;
        Tue, 14 Jun 2022 11:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655207464;
        bh=U5tf7D/ZsG6cScTwHNdYzzDqh2YZNCvrjVSqDQlRGv4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=B9nd1YaSd62i8nYu83WdU1JHozmtnHj35NbOYpqs+LaozTlC5VnXK/GREic93wtfp
         IFgcnvVytFZr07lcANaS9UC8MloAczK50s7iTMf0ac+S0iNMvliHGI3nZK0wgYfhze
         wwZDGlGff4aC5de8g+CHu+TliN7F/TCqR2HUZg5Z+X4sy70qO7SaG/Ay+M0kQyjPuN
         QYGrttG2pRisArkFZcRoy/+y6/ZTzb+3/f6XKUewPKrTAMgVVusuRvPULOLJ19/RF7
         WIJnJVzoKbcWbEJ8lzz7m7v7Qlzqvj989TOGuBmdRLT0YHrtIi/HVruiNr9aFS9Cw7
         Ti2zstXVbM9dA==
From:   Mark Brown <broonie@kernel.org>
To:     conor.dooley@microchip.com
Cc:     linux-riscv@lists.infradead.org, linux-spi@vger.kernel.org,
        lewis.hanly@microchip.com, daire.mcnamara@microchip.com,
        linux-kernel@vger.kernel.org, yang.lee@linux.alibaba.com
In-Reply-To: <20220614065809.1969177-1-conor.dooley@microchip.com>
References: <20220614065809.1969177-1-conor.dooley@microchip.com>
Subject: Re: [PATCH] spi: microchip-core: fix potentially incorrect return from probe
Message-Id: <165520746259.620958.8052145626827236977.b4-ty@kernel.org>
Date:   Tue, 14 Jun 2022 12:51:02 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jun 2022 07:58:10 +0100, Conor Dooley wrote:
> If platform_get_irqi() returns 0, the error case will be triggered but
> probe() will return 0 rather than an error. Ape the other drivers using
> this pattern and return -ENXIO.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: microchip-core: fix potentially incorrect return from probe
      commit: d38dc01a4e68133e11ae74af7585d2c4bbd5803d

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
