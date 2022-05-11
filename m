Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75346523CDC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 20:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346483AbiEKSuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 14:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbiEKSuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 14:50:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837671ACFAC;
        Wed, 11 May 2022 11:50:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C137360F2F;
        Wed, 11 May 2022 18:49:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1788C340EE;
        Wed, 11 May 2022 18:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652294999;
        bh=1/F7wsDez0z3wrk2Ax/t4Z3pU9oQk4PfJkSQFlB07kQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=cDqvRFyyAsMQPyM+khdB7N1GbvetpBwd8gw7x9bIgfAfpQNYRE1n6r/kuH2fdisZg
         p6jpzPYr30KC6DqpclR9v9tZzG3vbscidCN78WL38Zp/YbYgW9yuhxEIs2nsboIgqQ
         3QQiJYl798OmTnUS2DFlN9Q9dDg5IbLRLTf83HeaBWc9XcA3f08TWaM02S4KzVJ6ek
         wsW2nF2upA4jm84EIDyps12Xb/KmAt4HSQdsiEk4m41cC7Cb92dZG71GNa0L0kfyFv
         f/S1UTOD3IuHq0s76crG73KqsbLA5u1mEwBb3RQBYFh+VvNaZUbZI3T9I30fLo2uog
         0cNAkNhAZ0Ncg==
From:   Mark Brown <broonie@kernel.org>
To:     alexandre.torgue@foss.st.com, patrice.chotard@foss.st.com
Cc:     linux-stm32@st-md-mailman.stormreply.com,
        christophe.kerello@foss.st.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
In-Reply-To: <20220511074644.558874-1-patrice.chotard@foss.st.com>
References: <20220511074644.558874-1-patrice.chotard@foss.st.com>
Subject: Re: [PATCH 0/3] spi: stm32-qspi: flags management fixes
Message-Id: <165229499740.364474.10772649163744226308.b4-ty@kernel.org>
Date:   Wed, 11 May 2022 19:49:57 +0100
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

On Wed, 11 May 2022 09:46:41 +0200, patrice.chotard@foss.st.com wrote:
> From: Patrice Chotard <patrice.chotard@foss.st.com>
> 
> This series update flags management in the following cases:
>   - In APM mode, don't take care of TCF and TEF flags
>   - Always check TCF flag in stm32_qspi_wait_cmd()
>   - Don't check BUSY flag when sending new command
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] spi: stm32-qspi: Fix wait_cmd timeout in APM mode
      commit: d83d89ea68b4726700fa87b22db075e4217e691c
[2/3] spi: stm32-qspi: Always check SR_TCF flags in stm32_qspi_wait_cmd()
      commit: 0cf8d32600cf5660ee45d421f1b6e3a129ca58b6
[3/3] spi: stm32-qspi: Remove SR_BUSY bit check before sending command
      commit: ae16cc18f37bcdea7d4ef57a5e526a60b09a1506

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
