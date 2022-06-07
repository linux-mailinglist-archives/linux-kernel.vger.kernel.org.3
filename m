Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0325753FC0C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 12:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240912AbiFGKsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 06:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241714AbiFGKro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:47:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B19F45E1;
        Tue,  7 Jun 2022 03:46:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 44A2A61556;
        Tue,  7 Jun 2022 10:46:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38F1CC385A5;
        Tue,  7 Jun 2022 10:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654598806;
        bh=0XbIFrMxz3J5HCy9+gf4RCodZycEv9+xgNZt/QFGOT8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=RvTsaVHpVrxLyCqoN3OqP6I5RvBLFqnyRRCM/ZrDvSxdHEotVyNTlHVeQU6XvRyLz
         KT3R3++Q0CPyn+LXqZpjWcXBLDmDmms6NP5jlGoYLePioqIpeRlKY0Yo1xiuYc2i7y
         hsk9ZeEm2+jGKJp8kpSlsnGpHgPLBUSPEPE0NhpeZZKAh4LryiNwthoY8x8tMoV4rd
         YItPN64avShfiNMbSNN7ZtkT+HdXjyhJ/SkvIJuCc6gv4OZL3xpGS6mmOWwmNdwjrV
         dcAs/wgO9OxVnNy2DP+MNEGPmFrHlP4mmPQMA1ZPe5EIErt640bJodo8IyYtPv02fi
         WDC/YWP+fLJPA==
From:   Mark Brown <broonie@kernel.org>
To:     alexandre.torgue@foss.st.com, patrice.chotard@foss.st.com
Cc:     linux-kernel@vger.kernel.org, christophe.kerello@foss.st.com,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
In-Reply-To: <20220602092540.369604-1-patrice.chotard@foss.st.com>
References: <20220602092540.369604-1-patrice.chotard@foss.st.com>
Subject: Re: [PATCH v2 0/3] spi: stm32-qspi: Remove unused parameters
Message-Id: <165459880493.302078.4977236000024044341.b4-ty@kernel.org>
Date:   Tue, 07 Jun 2022 11:46:44 +0100
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

On Thu, 2 Jun 2022 11:25:37 +0200, patrice.chotard@foss.st.com wrote:
> From: Patrice Chotard <patrice.chotard@foss.st.com>
> 
> This series cleans up spi-stm32-qspi driver by removing unused parameters
> 
> Changes since v1:
>   _ add missing patch which removes unused param for stm32_qspi_wait_poll_status()
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] spi: stm32-qspi: Remove stm32_qspi_get_mode() unused parameter
      commit: 5945ff905764ceba7eb721bac7f61c7c5ce16a50
[2/3] spi: stm32-qspi: Remove stm32_qspi_wait_cmd() unused parameter
      commit: 75c28a43a43f2c09f8feeb58413449d65a77968b
[3/3] spi: stm32-qspi: Remove stm32_qspi_wait_poll_status() unused parameter
      commit: 6ce7061a75f7edeebe8710502042810109698619

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
