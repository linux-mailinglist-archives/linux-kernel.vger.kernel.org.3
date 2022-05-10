Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223D5521DD1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 17:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345358AbiEJPPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 11:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345246AbiEJPPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 11:15:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D98DF1A448F;
        Tue, 10 May 2022 07:49:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C39E6197B;
        Tue, 10 May 2022 14:49:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26016C385C2;
        Tue, 10 May 2022 14:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652194184;
        bh=It5LLlICcgWLjJuklqPrLH1pvoYxAaNwnpQSgLllmnU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=b11528v5YQ8ayowHOlkGxTtGo++/KZ3UDF8Z7W5+1uQRupdqQzm2vtjiKE0Pvqjp9
         aAI7MXj4AvAiuUj+n/9b1yZSfDnthP2jSU1zop+EWCHo95IXjv5gkpmlyw7fqWdjFE
         956KAiKoyf/SXtitwqPuqcfe4aulZeyvK3GtgNa9vwUWPyya9CRBcAyYhoNFRjIvZH
         unbCETr3l28jC7D7ukm9ioNygeQ2W8oADjSIyt6Lf5IV0Ta2JOFSdiit2CQSyHUKDw
         emrmnEjuficE1nvnau4EV2LecUHRdM1Yxk3XYUJImWcy+QV7sVEkPg0IHmf0z51PqH
         QpzZ4vjGtQgrg==
From:   Mark Brown <broonie@kernel.org>
To:     abbotti@mev.co.uk, linux-spi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <20220510115141.212779-1-abbotti@mev.co.uk>
References: <20220510115141.212779-1-abbotti@mev.co.uk>
Subject: Re: [PATCH 0/2] spi: cadence-quadspi: a couple of minor cleanups
Message-Id: <165219418387.389013.6193637410235087757.b4-ty@kernel.org>
Date:   Tue, 10 May 2022 15:49:43 +0100
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

On Tue, 10 May 2022 12:51:39 +0100, Ian Abbott wrote:
> Just a couple of trivial source code cleanups.
> 
> Ian Abbott (2):
>   spi: cadence-quadspi: Add missing blank line in
>     cqspi_request_mmap_dma()
>   spi: cadence-quadspi: remove unnecessary (void *) casts
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: cadence-quadspi: Add missing blank line in cqspi_request_mmap_dma()
      commit: 76159e2f9a0fa29fd9fccb262687d95282985b49
[2/2] spi: cadence-quadspi: remove unnecessary (void *) casts
      commit: 0d8688298d6a43f2e187dad1e45871248123764f

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
