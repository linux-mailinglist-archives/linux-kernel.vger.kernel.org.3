Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61E9053FBF2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 12:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241787AbiFGKsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 06:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241823AbiFGKrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:47:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3668ED739;
        Tue,  7 Jun 2022 03:46:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2AC57B81F01;
        Tue,  7 Jun 2022 10:46:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D8B8C34114;
        Tue,  7 Jun 2022 10:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654598795;
        bh=gUjC3aiKPc4Wm/fxnWPvnnwtZIrF9JVhru67X50cUcA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Xu0RIlB5CNVFAcJAVrHDxDaScdOkZ2LCTKdyH2iFbXS5RXdbcCRNOgK+LvMovMfMP
         7sLFAyAd0C51iQbAXEmbLu4kPsUe4WSnYkCyuleru8IBk1U9NYvQkh6aY/kDN46VSW
         +qeOn89j0Z8GAXJsolaG+kFJbRInlGuV+aejsJfQzYaZlFloMzMCWhGjf8Zqhsl4um
         ByH/Zj5Sio9T5vlfEkggJW8TAvxhF0dfYSJnAr8PXWTNpyAErBX84IffPGzU8Hho12
         x/0yglBZmEf88KydKCOapnUnFN7jPH9H5yQUeJAFWYu3fa/RZ+bezaxaDzH7DAe8bC
         fwQtiMEbdhTsg==
From:   Mark Brown <broonie@kernel.org>
To:     amit.kumar-mahapatra@xilinx.com
Cc:     linux-kernel@vger.kernel.org, michal.simek@xilinx.com,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        git@xilinx.com
In-Reply-To: <20220512145820.20425-1-amit.kumar-mahapatra@xilinx.com>
References: <20220512145820.20425-1-amit.kumar-mahapatra@xilinx.com>
Subject: Re: [PATCH] spi: spi-zynqmp-gqspi: Add two chip select support
Message-Id: <165459879429.302078.13267893267335834216.b4-ty@kernel.org>
Date:   Tue, 07 Jun 2022 11:46:34 +0100
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

On Thu, 12 May 2022 20:28:20 +0530, Amit Kumar Mahapatra wrote:
> ZynqMP GQSPI controller can support up to two chip selects but the current
> GQSPI driver only support CS0. With this update and num-cs DT property set
> to 2 GQSPI driver can now support two slave devices each connected to one
> chip select.
> 
> GQSPI driver configures the Lower CS and Upper CS based on the reg DT
> property.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-zynqmp-gqspi: Add two chip select support
      commit: dd9c232d47277960aba0c603c87a1cfd85d69438

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
