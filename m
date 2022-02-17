Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E74C04BA5A6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 17:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237400AbiBQQXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 11:23:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243087AbiBQQXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 11:23:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D9D91D9A81;
        Thu, 17 Feb 2022 08:22:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4C36DB8236B;
        Thu, 17 Feb 2022 16:22:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CD63C340E8;
        Thu, 17 Feb 2022 16:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645114967;
        bh=WdbxnQytOJyFGKv/5Vdo8JVuxQQcHwb/2yJR9P+3OUU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=MQGFC60n2jBDWLwIZ3rq3bUFlfWZHDDeM04QnUnmEq3EZy4AT4bVB2yAK8tINWZRX
         5yyZoymrJIp3YKQIsYEadHe5ug8dYbReYeKcU04c5fHo9pRqp1ul+pAyVO+T7DRdVH
         ocSIHsTV7PXwKPdkbG3FoLs+aTqhwNvaPXJz/pjypPjkQsLPvVWd98OH127aCNzx7F
         HoCuKqJnea7b39bJMd34xDSFb0UwwPPxtB+4HfiXf8AMYDHhuVL/dxnh7sGiGO3utF
         fBf+DZ4hQ2LHut0+L0iCChPA9EAWoUAj/OfjNC3nG6CoVX7DbO9jBNppE48w7WnGsO
         4+FZY1qhknxKQ==
From:   Mark Brown <broonie@kernel.org>
To:     Jon Lin <jon.lin@rock-chips.com>
Cc:     heiko@sntech.de, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220216014028.8123-1-jon.lin@rock-chips.com>
References: <20220216014028.8123-1-jon.lin@rock-chips.com>
Subject: Re: (subset) [PATCH v3 0/6] New support and problem adjustment of SPI rockchip
Message-Id: <164511496635.1843820.10942141701559024729.b4-ty@kernel.org>
Date:   Thu, 17 Feb 2022 16:22:46 +0000
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

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-linus

Thanks!

[1/6] spi: rockchip: Fix error in getting num-cs property
      commit: 9382df0a98aad5bbcd4d634790305a1d786ad224
[2/6] spi: rockchip: terminate dma transmission when slave abort
      commit: 80808768e41324d2e23de89972b5406c1020e6e4

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
