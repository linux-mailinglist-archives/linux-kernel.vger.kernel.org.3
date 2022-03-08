Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D77F64D1EFF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 18:25:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349219AbiCHRZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 12:25:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349567AbiCHRXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 12:23:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247345677E;
        Tue,  8 Mar 2022 09:21:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DE9DDB81BB0;
        Tue,  8 Mar 2022 17:21:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 806F8C340EB;
        Tue,  8 Mar 2022 17:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646760091;
        bh=4DDmbcnxMbPZ4/OUCsZnW42d00r9CZfGtAFTcWbJUzM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Y6bEl0B+ymTzuclyFZYk+616SVn+o7ySD3pyR+CXnhifplYlboTEEHAf1H/jTgeCA
         QAUja9Sgzcf7zOdoGTSZKfSkF3SZ4rXUVdZaUTneEwqOjVhadlqixe0OPfpJydcqFe
         QetY+U0BCPECsvajrWU2pQjxGhWQ7G0yWnkGfqhUvffU2kILHqZO/oghgMtbnIHBBF
         T/Z/ib/sEI9XV3gv4Uf4BnasJXfi+UOgUnrsnCTV8cuHGvcJenL3bS5oPngxTpjznr
         Rbbu/8yhFIbAHxymmmLJDm5S5Lf2l63L9isy/c5KOx51wT2R4zP69FCQHUuco/0n+B
         1RYsfdBQ5X5TQ==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-spi@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20220307173740.80996-1-andriy.shevchenko@linux.intel.com>
References: <20220307173740.80996-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] spi: topcliff-pch: Prevent usage of potentially stale DMA device
Message-Id: <164676009024.54618.554477208922214231.b4-ty@kernel.org>
Date:   Tue, 08 Mar 2022 17:21:30 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Mar 2022 19:37:40 +0200, Andy Shevchenko wrote:
> DMA device is expected to be available while SPI transfer is ongoing.
> 
> Prevent usage of potentially stale DMA device by keeping reference
> count till the end of the transfer.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: topcliff-pch: Prevent usage of potentially stale DMA device
      commit: 80ab9012bbf1011f57c06b3c6e4ac3816c4a86f5

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
