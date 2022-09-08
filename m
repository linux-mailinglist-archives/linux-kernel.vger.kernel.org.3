Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8336B5B21DF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 17:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiIHPTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 11:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbiIHPTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 11:19:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E89AB4E9;
        Thu,  8 Sep 2022 08:19:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 772B7B8211C;
        Thu,  8 Sep 2022 15:19:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F7C1C433D7;
        Thu,  8 Sep 2022 15:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662650343;
        bh=z8j68nxyK0f6QczSNdTQYDCsqrT713RdRpnt06vCzug=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=C7CldveaUicjNiCGVSAWOOzfRvDLu1MZIPZ6U9c6yYZGEmj4qMDndTTNEs69Ck390
         SAgwsXvTqd446k+kVReOqCPBipIW1asdXKuJOIFYSYP341vLcBaYwABd0otULIjRfp
         UfjLIht3Lx/ccu9pueLBiGZOIaVppBi4zXW8CmMkFcuhQhXgwLBwEMmhyHUx8rPI4k
         a3o3HcxH+3aj4j+pBKQfVxdwSr3H2wr53g+tBaP6mB9fsylyeJG0YN9VoQVTIAlIkf
         M69jPauM57SJJLLa0GlqhpJgw52c1ptOlvD3mG4TvaNMTg2Z5SyEO3jveO6WuGJg/f
         gsSO/6HA5vCWw==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220908130518.32186-1-andriy.shevchenko@linux.intel.com>
References: <20220908130518.32186-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 1/1] spi: Group cs_change and cs_off flags together in struct spi_transfer
Message-Id: <166265034217.279752.9696540140354935094.b4-ty@kernel.org>
Date:   Thu, 08 Sep 2022 16:19:02 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Sep 2022 16:05:18 +0300, Andy Shevchenko wrote:
> The commit 5e0531f6b90a ("spi: Add capability to perform some transfer
> with chipselect off") added a new flag but squeezed it into a wrong
> group of struct spi_transfer members (note that SPI_NBITS_* are macros
> for easier interpretation of the tx_nbits and rx_nbits bitfields).
> 
> Group cs_change and cs_off flags together and their doc strings.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: Group cs_change and cs_off flags together in struct spi_transfer
      commit: 86432b7f8f92b784c2e4af5b02766fb44052abf7

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
