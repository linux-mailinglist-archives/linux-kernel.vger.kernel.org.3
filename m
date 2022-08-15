Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38D6C59325B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 17:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232261AbiHOPpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 11:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232888AbiHOPpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 11:45:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5578517597;
        Mon, 15 Aug 2022 08:45:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 04E94B80F91;
        Mon, 15 Aug 2022 15:45:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26457C433D6;
        Mon, 15 Aug 2022 15:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660578301;
        bh=ND9SRzVyLLhRbgWIaa1lz9WPcq7yD16K64ajmGrbJF4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=q3Ct/LIQ9n8W5I3LZnT7OP3kODzsmElhd6JfZMIue56X8CfuiyzdFwcXVtGHHjGY0
         1gMkZmSLTKCbhU402xkILhBE+g+6dz5OQRJztRz2YDA02HfnEpSiw3qM6/xrWTEMcl
         mGfYfeFpMB88/SLu1xlh0RNop6ebCgZLo4sIwHi9u41tDmBoVkfNzJ+Y65efoenfse
         jRjRZPEUybiGANyvTnKNScoV7bxAZRrJEiXKuBm7MPFWj4/pOtC0f1PtloIiOrhhCc
         uDV3uAkbHhY1g3rkvvX0w7QmhSqjUEoHEf/qNUGV5ms3agZaVdbAuza8M4tELsZ9wc
         dV1KONNlY+IHg==
From:   Mark Brown <broonie@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Conor Dooley <conor.dooley@microchip.com>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-spi@vger.kernel.org
In-Reply-To: <fb894ecec68e03fb7fc9353027c8b1a2610833d7.1659735153.git.christophe.jaillet@wanadoo.fr>
References: <fb894ecec68e03fb7fc9353027c8b1a2610833d7.1659735153.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] spi: microchip-core: Simplify some error message
Message-Id: <166057829988.697678.13235950902894348859.b4-ty@kernel.org>
Date:   Mon, 15 Aug 2022 16:44:59 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fe10a
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Aug 2022 23:33:17 +0200, Christophe JAILLET wrote:
> dev_err_probe() already prints the error code in a human readable way, so
> there is no need to duplicate it as a numerical value at the end of the
> message.
> 
> Moreover, in the case of devm_clk_get() it would only display '0' because
> 'ret' is know to be 0 at this point.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: microchip-core: Simplify some error message
      commit: 7964e817d2311b37b86d6fbf588cd9fbe747b108

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
