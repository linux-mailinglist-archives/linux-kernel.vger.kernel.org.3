Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7A82525293
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 18:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356500AbiELQcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 12:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356491AbiELQcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 12:32:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826EC63BE3;
        Thu, 12 May 2022 09:32:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 413E5B829B3;
        Thu, 12 May 2022 16:32:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F02A4C34100;
        Thu, 12 May 2022 16:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652373122;
        bh=LWdTtVqYchwjszzCAS1sWFBPgcYklK8169G7dA5jGtY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Wq5cBn0hHsPaDFNBu3wpOjn2Niu4AI1GT2qkBO7PnxQVeR89X9E2FQX/4pX6hfTvF
         +1U92h/fs1DCkJtT7pI+h1O0CeZg3rNQ8MpHSqyBREA4S62KSjjJN19eOxjvhqbIuf
         ZHdeaVrUfohZzF3S1K6WffC+9Hem+mm4uH0Yd4zytZE/ecZ8iLJ/Ixp8CZ8T8uMJtI
         a/5xj+0H5kBfIBGx0kf6bsYerykDV+dNx5RyLPnW8DTyQZlOwJmJ2WIb35mZojP75K
         q5hK1j97qTvzt0VJJsN0V8vjuD3mocW4/WE8pBlTtyPJQ8DGp4DeKkrk7+NU4x7LWV
         LFPr7b9iVFO/Q==
From:   Mark Brown <broonie@kernel.org>
To:     sfr@canb.auug.org.au, skhan@linuxfoundation.org,
        siddhpant.gh@gmail.com
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <4e6187a4-d0f8-4750-e407-e09cc1c91789@gmail.com>
References: <4e6187a4-d0f8-4750-e407-e09cc1c91789@gmail.com>
Subject: Re: [PATCH] spi: Doc fix - Describe add_lock and dma_map_dev in spi_controller
Message-Id: <165237312070.1053498.16178641624638760904.b4-ty@kernel.org>
Date:   Thu, 12 May 2022 17:32:00 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 May 2022 20:06:45 +0530, Siddh Raman Pant wrote:
> This fixes the corresponding warnings during building the docs.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: Doc fix - Describe add_lock and dma_map_dev in spi_controller
      commit: 75d6fe48a21a0ea1565228c12b9c16f3fb37b673

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
