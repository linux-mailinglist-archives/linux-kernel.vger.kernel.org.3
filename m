Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5692D59EAC9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 20:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233844AbiHWSRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 14:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233482AbiHWSQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 14:16:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC7447C334;
        Tue, 23 Aug 2022 09:32:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3118E616A9;
        Tue, 23 Aug 2022 16:32:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31110C433D6;
        Tue, 23 Aug 2022 16:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661272323;
        bh=117FuunxK9nAZbdA1dcbtm4Lkr0VrP7QV1M9APPUUI0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=RkBNgbhX6PxMVcKvDdVO+u0Z8gqJVkX/zRxbPjEXinSZugcF64k8KwSRiO+34K7F9
         NP8LRYfLB4/DYxHgTzdo0oRzfek7u1ILw0CoooHislelP78tlszP6bGbqWnB0LRgaF
         KjzZHzVX1MRRaXgedZoh59YyouAVYH0INA14OVI0Y9TTYq7OZ+A0AQrNZA/Zkn1iZF
         0G+8xhoxdenKEMxucbKHsKwAx2fuyZ17CQlU0IS2ufJAJL2AXTuyMY4PpGPdkSWOQe
         5f9zf+UFBiocXiP9nkTvoue3Hz86hYqWea4XoXgjwRQbGnVLzF4nssRfxOpsOIpxsW
         by1as5RMK+Nrg==
From:   Mark Brown <broonie@kernel.org>
To:     patrice.chotard@foss.st.com,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        christophe.kerello@foss.st.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220823075850.575043-1-patrice.chotard@foss.st.com>
References: <20220823075850.575043-1-patrice.chotard@foss.st.com>
Subject: Re: (subset) [PATCH v4 0/2] spi: stm32_qspi: use QSPI bus as 8 lines communication channel
Message-Id: <166127232192.398080.13725379647685257288.b4-ty@kernel.org>
Date:   Tue, 23 Aug 2022 17:32:01 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-0c1df
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Aug 2022 09:58:48 +0200, patrice.chotard@foss.st.com wrote:
> From: Patrice Chotard <patrice.chotard@foss.st.com>
> 
> The goal of this series is to allow to use QSPI bus as a 8 lines communication
> channel for specific purpose.
> 
> The QSPI block offers the possibility to communicate with 2 flashes in
> parrallel using the dual flash mode, 8 data lines are then used.
> Usage of cs-gpios populated and spi-tx-bus-width / spi-rx-bus-width both set to 8,
> is needed to enable dual flash mode.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[2/2] spi: stm32_qspi: Add transfer_one_message() spi callback
      commit: b051161f44d414e736fa2b011245441bae9babd7

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
