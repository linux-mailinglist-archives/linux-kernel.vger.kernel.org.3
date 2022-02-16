Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6E4C4B8FCD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 19:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237398AbiBPSCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 13:02:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237396AbiBPSCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 13:02:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7272CCA4;
        Wed, 16 Feb 2022 10:02:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 535D361229;
        Wed, 16 Feb 2022 18:02:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E00ACC340E8;
        Wed, 16 Feb 2022 18:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645034525;
        bh=0RPzGkqaulryzzUFTedNd/YW9tsR4nH6x1mJcKe4Kc8=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=iodmdVb7k2uEAmmaJY0bbHZN/l/i5+dv56IMwnV6KwPp1XvLGrZmLnBWb/SWFyUSZ
         u58bn2HTu+qkLuzuswqwwLiz5NunwMAAbO5Yb8RAqmVLTfG+416+3eM42jPQWNRh3h
         NvyrKZ91ps+qOC/Dss/r5MtiEukQ+/M7V6+iSuHj6sQgUs1wc4yPCUP1frB+vKFc8e
         yBanqB7Mfop6YyRXID42VyRlIZrcA8/kWmQ2WSz9W6ks7sThfAagcicZGoDHiahzGq
         C5JMWhDzU4Uw0Ymry920OB2YCUuyk2ij9b2V7t7uaBDO38ar5Xe+i6cVj/L170goOs
         3CffTXseX/quA==
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
In-Reply-To: <20220215135139.4328-1-andriy.shevchenko@linux.intel.com>
References: <20220215135139.4328-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 1/1] spi: intel-pci: Add support for Intel Ice Lake-N SPI serial flash
Message-Id: <164503452464.3088984.20078715577588354.b4-ty@kernel.org>
Date:   Wed, 16 Feb 2022 18:02:04 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Feb 2022 15:51:39 +0200, Andy Shevchenko wrote:
> Intel Ice Lake-N has the same SPI serial flash controller as Ice Lake-LP.
> Add Ice Lake-N PCI ID to the driver list of supported devices.
> 
> The device can be found on MacBookPro16,2 [1].
> 
> [1]: https://linux-hardware.org/?probe=f1c5cf0c43
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: intel-pci: Add support for Intel Ice Lake-N SPI serial flash
      commit: 47b34f495b8b75475952f12c521c4c1fc2fa09b4

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
