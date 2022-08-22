Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72CEA59C3AE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 18:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236013AbiHVQFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 12:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235733AbiHVQFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 12:05:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E622CDD8;
        Mon, 22 Aug 2022 09:05:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F11BCB80923;
        Mon, 22 Aug 2022 16:05:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40845C433D6;
        Mon, 22 Aug 2022 16:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661184340;
        bh=gqT9434pJDJBgp83uIgtBxn6Y1xaO9KrAPT5xfVuuqw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=QEEgOLXBJThejd3iRvAl30EPrElptaov3qykr/J29ggHNVM4tozz5mQZgp2Ht4Kyj
         w7c1UNp085nzZrp1fi3a4YAwV++K3sIPl3eWWdfyqtMVFzt+F07HBj/GTAZC9QpR3w
         hl9yuO7//8j6kghtvbROtnk0hUuQvPxGZKxBeObyqiRZ9FNSWW4QzIdxchCJWxDPve
         z7es/0qJJA1FjnL/0jcxYZQj0S5ojLfqYm6EF75z0x3moatpP1qdTF2V4Y85CMnLt2
         BBkebH6IE963Be7d1/RcIJopJaKxGgZOled837d0afohXUM9Cx687hxkQa3GbAL1AE
         5wt1wiB12UL2Q==
From:   Mark Brown <broonie@kernel.org>
To:     patrice.chotard@foss.st.com,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     christophe.kerello@foss.st.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
In-Reply-To: <20220816161344.2599908-1-patrice.chotard@foss.st.com>
References: <20220816161344.2599908-1-patrice.chotard@foss.st.com>
Subject: Re: (subset) [PATCH v3 0/2] spi: stm32_qspi: use QSPI bus as 8 lines communication channel
Message-Id: <166118433897.209120.16190099503428270567.b4-ty@kernel.org>
Date:   Mon, 22 Aug 2022 17:05:38 +0100
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

On Tue, 16 Aug 2022 18:13:42 +0200, patrice.chotard@foss.st.com wrote:
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
