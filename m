Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA0AC4BA850
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 19:34:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244401AbiBQSdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 13:33:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244490AbiBQSd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 13:33:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB0D38A0;
        Thu, 17 Feb 2022 10:32:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C4A161B01;
        Thu, 17 Feb 2022 18:32:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 266F8C340E8;
        Thu, 17 Feb 2022 18:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645122748;
        bh=8YextsepZgUr4+oe5f01LRtpOeJxsq+lsISRRrHwJn0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=VNBraLvw8tzhp5HQKFZZQSD/eEBmA9GYmGDGvVdYGnsnSsO4hMlTzHp8ezULp/NLk
         h7CPFgftAYTLPNyj3edHai5GLyuHYAjLYbMroo6G6AvP4gKXYxxSTkH2BQzpOX63/C
         vuRkB0sdMBQOZRaBPa8ElUHxUVBxqAky1tvm1UkCt2YKRg0qCC3TEPT6v92SD0zqiy
         OeCX8+5JHLVdBgIHsHtg+1e5Cfl1REQXfB018lH2tCaqMm6UAYDJrMAn5EW4TnhdV0
         iUztK2QZBL6h8tvOPfVqOp03wTgeLulMk54ltLJV5eFFkPaVOztdyqnrducnSFHq0n
         /Di2Lbd1EjYnQ==
From:   Mark Brown <broonie@kernel.org>
To:     Jon Lin <jon.lin@rock-chips.com>
Cc:     linux-spi@vger.kernel.org, heiko@sntech.de,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <20220216014028.8123-1-jon.lin@rock-chips.com>
References: <20220216014028.8123-1-jon.lin@rock-chips.com>
Subject: Re: (subset) [PATCH v3 0/6] New support and problem adjustment of SPI rockchip
Message-Id: <164512274685.3993181.4255845764381770585.b4-ty@kernel.org>
Date:   Thu, 17 Feb 2022 18:32:26 +0000
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

On Wed, 16 Feb 2022 09:40:22 +0800, Jon Lin wrote:
> Changes in v3:
> - Support clear the bits of configure bits filed
> 
> Changes in v2:
> - Fix patches should be at the start of the series
> - Fix patches should be at the start of the series
> - Delete useless messages
> - Limit cs-high presetting to the chip select n <= 1
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[3/6] spi: rockchip: Stop spi slave dma receiver when cs inactive
      commit: 869f2c94db92f0f1d6acd0dff1c1ebb8160f5e29
[4/6] spi: rockchip: Preset cs-high and clk polarity in setup progress
      commit: 3a4bf922d42efa4e9a3dc803d1fd786d43e8a501
[5/6] spi: rockchip: Suspend and resume the bus during NOIRQ_SYSTEM_SLEEP_PM ops
      commit: e882575efc771f130a24322377dc1033551da11d
[6/6] spi: rockchip: clear interrupt status in error handler
      commit: 2fcdde56c44fe1cd13ce328128f509bbda2cdb41

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
