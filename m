Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38C6F5A522D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 18:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbiH2Qus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 12:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbiH2QuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 12:50:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5D1564EB;
        Mon, 29 Aug 2022 09:50:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9350161277;
        Mon, 29 Aug 2022 16:50:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 232C1C43140;
        Mon, 29 Aug 2022 16:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661791819;
        bh=t4wMul9vxfMvuUg8UI41DbmTAkYSK1yPK94NKJG8a+4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=AOkVqZMNHdQziyPJMVzg7Yp67/LOAN0l6Z4abhJmwpvjIcKMX8ClVYkDUW5c4KLbR
         t3Kkv4AfYhJ7jOea8Ho8NL6Wgcveo5xmBjHYV2wgH58ZkTw+rCb1lol2rOxxv74kZr
         dMf/bZi9PlEdFnCTU+K2ktiIzrghD+YJoYLptFB2g1YeGrnpJc7iZwfDcgllEByka4
         YhlV4TkuZVxkEm+t678KidmkOoB4SpDXbS9rTAI7R+cCRt4JY9KMSLnTATharY486r
         iRzY1qDSy8C6vVP67eY6KKYSwpyaEE06VpuKGq68dt7i3xMwFCxgKKlEWt9vbD+ro4
         iHKU0zF8+FDIA==
From:   Mark Brown <broonie@kernel.org>
To:     patrice.chotard@foss.st.com
Cc:     linux-kernel@vger.kernel.org, christophe.kerello@foss.st.com,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
In-Reply-To: <20220829123250.2170562-1-patrice.chotard@foss.st.com>
References: <20220829123250.2170562-1-patrice.chotard@foss.st.com>
Subject: Re: [PATCH] spi: stm32-qspi: Fix pm_runtime management in stm32_qspi_transfer_one_message()
Message-Id: <166179181682.898839.326483296605925659.b4-ty@kernel.org>
Date:   Mon, 29 Aug 2022 17:50:16 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-65ba7
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Aug 2022 14:32:50 +0200, patrice.chotard@foss.st.com wrote:
> From: Patrice Chotard <patrice.chotard@foss.st.com>
> 
> ctrl->auto_runtime_pm was wrongly set to true when adding
> transfer_one_message() callback.
> As explained in commit 6e6ccb3d4cdc ("spi: stm32-qspi: Add pm_runtime support")
> the expected behavior is to prevent runtime suspends between each transfer.
> 
> [...]

Applied to

   broonie/spi.git for-next

Thanks!

[1/1] spi: stm32-qspi: Fix pm_runtime management in stm32_qspi_transfer_one_message()
      commit: 47c32b2b7fcfa97f7224df222f439fc0ccf94ffe

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
