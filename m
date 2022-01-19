Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1EE3493F87
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 19:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356597AbiASSCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 13:02:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356594AbiASSCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 13:02:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D70ABC06161C;
        Wed, 19 Jan 2022 10:02:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A05BFB81AD7;
        Wed, 19 Jan 2022 18:02:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80FFFC340E1;
        Wed, 19 Jan 2022 18:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642615370;
        bh=9tsmIKk0A/T3ybmJ17Mz4x6hwbmwrWo01oEf1EtfEjU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=jJWykbxU+FJqWWtuK0PcUFRanCqkBGyLrRziCzQSf8plu+pluU/Td6H73cHNYxCIA
         m7zrsja+9y3cuPn1YZ5ctXGN+WLrMGbh6z5u0n61QO4yrnAhEHiQCxNVl1Mv/pwRDH
         hubnVMBsBy5e79ejxoFmyQgdE8g7R2qQ4DLtCyT5oNIIALvuANtSuiLL1ZG9uVZdfS
         zK3fWvRC4mVfe/tqu9xazLzJXMCcxfwEmPNBOT9sGWv4NcCm7ARJZ5NbBQqSPwDLj/
         +XgkUObaFXIJ0kchLJboPIIY26VT0A+MTBwPVwhsTfQUcuQk5D1i1ROi57vDXZIktL
         KKNmtFl3Su42w==
From:   Mark Brown <broonie@kernel.org>
To:     amelie.delaunay@foss.st.com,
        Alain Volmat <alain.volmat@foss.st.com>
Cc:     alexandre.torgue@foss.st.com, fabrice.gasnier@foss.st.com,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, mcoquelin.stm32@gmail.com,
        linux-stm32@st-md-mailman.stormreply.com
In-Reply-To: <20220119093245.624878-1-alain.volmat@foss.st.com>
References: <20220119093245.624878-1-alain.volmat@foss.st.com>
Subject: Re: [PATCH 0/2] spi: stm32: comments & SIMPLEX_RX fixes
Message-Id: <164261536824.2816943.11806763183667927602.b4-ty@kernel.org>
Date:   Wed, 19 Jan 2022 18:02:48 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jan 2022 10:32:43 +0100, Alain Volmat wrote:
> This series contains 2 fixes within the spi-stm32.c driver.  One is
> removing comments regarding struct variables that do not exist and the
> second one correct a previous STM32F4 related commit for SIMPLEX_RX which
> happens to break SIMPLEX_RX for H7 since it enforces MUST_TX flags.
> 
> Alain Volmat (2):
>   spi: stm32: remove inexistant variables in struct stm32_spi_cfg
>     comment
>   spi: stm32: make SPI_MASTER_MUST_TX flags only specific to STM32F4
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-linus

Thanks!

[1/2] spi: stm32: remove inexistant variables in struct stm32_spi_cfg comment
      commit: 3cefddb72f80dc8d49ce605628ceb6525cfd64da
[2/2] spi: stm32: make SPI_MASTER_MUST_TX flags only specific to STM32F4
      commit: 9df15d842a0f77f2b8ee29386f6d714e4220df57

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
