Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1D245018F7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 18:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237814AbiDNQoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 12:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238132AbiDNQmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 12:42:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C253410EDFA;
        Thu, 14 Apr 2022 09:12:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0DAABB82A7D;
        Thu, 14 Apr 2022 16:12:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91DE2C385A9;
        Thu, 14 Apr 2022 16:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649952735;
        bh=A8+Hd4LUylBX9Ympns5AtofQeZ2djkNsDkrod7uIVw0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=aFvA5ryAyuecc7diC3xU/PXHHmdgc8VgyRrG2VxOr2oKO7h0ELHChZpkamB2mKXEV
         vo4qMt27uYDeaYhdtrzu0VA1RgS1ImxSst2PWTgtfH/a7eluzTsNVYDtD0MRcr2MI7
         VofkoWyDuQp2Q0tCBScWyV8cUmUEit4Z17H2rrRjLtPwOcVToQm4ShB/UFNu/VTPi4
         +sIZpBk/RIG5vlfWtQq9my0Nzf2NzWrNm3WHTmvzIo9zyY4DdnTVopCiuzZ8FDWRr2
         mXRF5qWBTQbQerKoa/9S72STTbMQ3BIsw/A8sTsF755lEyaNn4NKPmo5qTp2vV4cDZ
         HxhxpxYmTuD0w==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, paul.kocialkowski@bootlin.com,
        linux-spi@vger.kernel.org
Cc:     thomas.petazzoni@bootlin.com, dan.carpenter@oracle.com
In-Reply-To: <20220414084040.975520-1-paul.kocialkowski@bootlin.com>
References: <20220414084040.975520-1-paul.kocialkowski@bootlin.com>
Subject: Re: [PATCH] spi: core: Initialize returned status in spi_setup
Message-Id: <164995273428.1502382.15341436161467838466.b4-ty@kernel.org>
Date:   Thu, 14 Apr 2022 17:12:14 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Apr 2022 10:40:40 +0200, Paul Kocialkowski wrote:
> The previous commit that made bits-per-word validation conditional
> results in leaving no unconditional affectation of the status variable.
> 
> Since the variable is returned at the end of the function, initialize
> it to avoid returning an undefined value.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: core: Initialize returned status in spi_setup
      commit: 73f93db5c49b9f52c902e5dc6c750bf9832e0450

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
