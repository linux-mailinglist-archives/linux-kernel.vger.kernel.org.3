Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA85159C3AF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 18:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235929AbiHVQFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 12:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235772AbiHVQFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 12:05:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49EB2ED4C;
        Mon, 22 Aug 2022 09:05:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61F16611D3;
        Mon, 22 Aug 2022 16:05:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C15FFC433C1;
        Mon, 22 Aug 2022 16:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661184338;
        bh=uuMiUaC5/wvKmXz9DTRGlt3cPWVNksaOjRNpLBZP8II=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=hi3kF0hk4m5sv1XhA3aC5qpqdDppodyhGdiKBL1yZWmGWuoeEgxkjpI23WNPC+Hvw
         d9O85NGNVWGsEedFea2NXA8lfmH8+Z7N3yu3GL+DKLIQsPosVd9DUAtyC2JgTQqQHV
         Ko/HaPwo28OYbjHzUn0PMaA7xPvmTiJ/omsXiZddhDQWsXPk9xC1JNCNw/fNFIAooO
         5FSyszZo89cqH5MxPrPGnQteJN0vjYDk4o4uGV+ZZosE8AaimFpM2eLUtf2unWk/Cd
         G7VDUkUHZUkX+Yst5nVqc9tEeU2hIMHVHUcNudIeJ/mISAvBSe89YYkbPmQ0mXffnH
         +8+hI5q81Qwhg==
From:   Mark Brown <broonie@kernel.org>
To:     patrice.chotard@foss.st.com, krzysztof.kozlowski+dt@linaro.org,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        robh+dt@kernel.org
Cc:     christophe.kerello@foss.st.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
In-Reply-To: <20220810093215.794977-1-patrice.chotard@foss.st.com>
References: <20220810093215.794977-1-patrice.chotard@foss.st.com>
Subject: Re: (subset) [PATCH v2 0/2] spi: stm32_qspi: use QSPI bus as 8 lines communication channel
Message-Id: <166118433650.209120.13370601331472107366.b4-ty@kernel.org>
Date:   Mon, 22 Aug 2022 17:05:36 +0100
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

On Wed, 10 Aug 2022 11:32:13 +0200, patrice.chotard@foss.st.com wrote:
> From: Patrice Chotard <patrice.chotard@foss.st.com>
> 
> 
> The goal of this series is to allow to use QSPI bus as a 8 lines communication
> channel for specific purpose.
> 
> The QSPI block offers the possibility to communicate with 2 flashes in
> parrallel using the dual flash mode, 8 data lines are then used.
> Usage of DT parallel-memories property is needed to enable dual flash mode.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: stm32_qspi: Add transfer_one_message() spi callback
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
