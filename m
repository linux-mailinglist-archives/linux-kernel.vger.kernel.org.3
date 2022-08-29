Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C21315A55D4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 22:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiH2Uyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 16:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiH2UyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 16:54:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05D09C2D1;
        Mon, 29 Aug 2022 13:54:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4835A611C1;
        Mon, 29 Aug 2022 20:54:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 170FAC433D6;
        Mon, 29 Aug 2022 20:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661806463;
        bh=kQN0K1JdQf+wETbVKAjAg7qcB5LeYW6ExuLEV5ZgUug=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=mLeNaRBVUBII8aBY8A2zCbDN/yXsfnpQolkq1xfmEPimrFjXrjbTbZ8Dr9J8lGdq2
         ACREAuOoMj0wQyXSELbvaDCgN8WoFEji16ma9bJBWTqTVmkBbXkZgWNBLIsxsclSgm
         9GPrlwhngaM9vBSZub395LOeJ5Jyfh67awglIyaAWbT8HseyO1AhzIbBWokfGXm8TL
         gYQO2LheCAApV91RxXY2jpPNsYkGZF1yYzeh+4OpNLv7DMgIBVEJ25dcOzSo5X4vr0
         u1Mi2dGgCjAGAtghvA0AuBX3+W/EpHx9OKtwzJb1fIeVvwCw4UsgR8WC3aXviHthoC
         82yzwtgD9pBcQ==
From:   Mark Brown <broonie@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        neil@brown.name, matthias.bgg@gmail.com,
        gregkh@linuxfoundation.org, blogic@openwrt.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-mediatek@lists.infradead.org
In-Reply-To: <cover.1661599671.git.christophe.jaillet@wanadoo.fr>
References: <cover.1661599671.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH 0/4] spi: mt7621: Fix an erroneous message + clean-ups
Message-Id: <166180645965.972874.4626638273769561589.b4-ty@kernel.org>
Date:   Mon, 29 Aug 2022 21:54:19 +0100
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

On Sat, 27 Aug 2022 13:41:39 +0200, Christophe JAILLET wrote:
> Patch 1 fixes an issue about an error code that is erroneously logged.
> 
> Patch 2-4 are just clean-ups spotted while fixing it.
> 
> Additional comments are added below --- in patches 2 and 3.
> 
> Christophe JAILLET (4):
>   spi: mt7621: Fix an error message in mt7621_spi_probe()
>   spi: mt7621: Use the devm_clk_get_enabled() helper to simplify error
>     handling
>   spi: mt7621: Use devm_spi_register_controller()
>   spi: mt7621: Remove 'clk' from 'struct mt7621_spi'
> 
> [...]

Applied to

   broonie/spi.git for-next

Thanks!

[1/4] spi: mt7621: Fix an error message in mt7621_spi_probe()
      commit: 2b2bf6b7faa9010fae10dc7de76627a3fdb525b3
[2/4] spi: mt7621: Use the devm_clk_get_enabled() helper to simplify error handling
      commit: 3d6af96814d753f34cf897466e7ddf041d0cdf3b
[3/4] spi: mt7621: Use devm_spi_register_controller()
      commit: 30b31b29a866d32fc381b406d4c4f5db2636e5ec
[4/4] spi: mt7621: Remove 'clk' from 'struct mt7621_spi'
      commit: 4a5cc683543f5f6ed586944095c65cb4da4b9273

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
