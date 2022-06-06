Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF1E53EB4D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241634AbiFFQNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 12:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241592AbiFFQNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 12:13:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39FF410053B;
        Mon,  6 Jun 2022 09:13:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA50260C96;
        Mon,  6 Jun 2022 16:13:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADA68C3411D;
        Mon,  6 Jun 2022 16:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654532014;
        bh=WtLr248+J7VRb1dQKlsA2bJrbWka+yrYlrb3vKRa3bk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=rOiSpAV8rl4fpjVsZ2A+wbNptvo9Rt0NP8DnKg4Ob9JjuyMnef2usBKN1lEpg2SbJ
         8/z62jfj9z+BAd0yDqDOZqLFGS65aHTMlEzG4o3+wpraI0RJpJz+5TXhKAmnfWLc7p
         PFnYKBBtbTy6+x2HKVtuzR3te00KOPG7KoD+Jst1Q3E4iwve0miQGDsaO+hEQ7Vrv4
         qQnGdQG6gGWJ0OV8/NevHANxoJ43N8JuT/3kZLhrGfSV+u+afy59ueKFeBPq16+9pj
         doKdSQUWhFAESksZzp4i3X70816DTWZWnAKFyU72OsJMbYuqBq3Vu2LAnFYyhtutyR
         KBPY0hcTQMOFA==
From:   Mark Brown <broonie@kernel.org>
To:     alexandre.torgue@foss.st.com, patrice.chotard@foss.st.com
Cc:     christophe.kerello@foss.st.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <20220602091022.358127-1-patrice.chotard@foss.st.com>
References: <20220602091022.358127-1-patrice.chotard@foss.st.com>
Subject: Re: [PATCH 1/1] spi: spi-mem: Fix spi_mem_poll_status()
Message-Id: <165453201241.2010189.6032534787869283638.b4-ty@kernel.org>
Date:   Mon, 06 Jun 2022 17:13:32 +0100
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

On Thu, 2 Jun 2022 11:10:22 +0200, patrice.chotard@foss.st.com wrote:
> From: Patrice Chotard <patrice.chotard@foss.st.com>
> 
> In spi_mem_exec_op(), in case cs_gpiod descriptor is set, exec_op()
> callback can't be used.
> The same must be applied in spi_mem_poll_status(), poll_status()
> callback can't be used, we must use the legacy path using
> read_poll_timeout().
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-mem: Fix spi_mem_poll_status()
      commit: 2283679f4c468df367830b7eb8f22d48a6940e19

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
