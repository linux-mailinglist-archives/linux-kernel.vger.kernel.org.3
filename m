Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFCB55B0834
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 17:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbiIGPMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 11:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbiIGPMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 11:12:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BCBF67461;
        Wed,  7 Sep 2022 08:12:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9438FB81AE4;
        Wed,  7 Sep 2022 15:12:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DB84C433D6;
        Wed,  7 Sep 2022 15:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662563530;
        bh=umcLMRkkYompkiF1mSXN5QNbnOas155czyaghChe86o=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=BpyjC8gSENHg/vNSAkTDmazsLWGtiRROoB1+62GLaY8sBYPMGZRUlao+snpzeETK4
         ja3ZyGaZesjAyGej4OfV3iT26Y+g3caNw44AplGgfnflOrRHBmz50o83ZjyyC5iPts
         cOluOrz1D6ls+KoY41R83aXElcPiaqWFb3YSWtUhFBLhN+pSErYceMumhdASbUgItA
         CvymEuFEcIFPOAMs15iYYYkE+DQn0MAAeP6i6rjX7I8qcmXd/1t66YCTSHy/V/7sHa
         iPSr2RGqn06gYl6Yp/ygq2EF/Zl5GAQZlgfPBwCjSPpIFIM1tka2w6RwUpcXOhaCRJ
         PG2c+XvQ7RGxw==
From:   Mark Brown <broonie@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <fabbc87627e5ddc2c913b368ae99386668d8dcfb.1660830866.git.christophe.leroy@csgroup.eu>
References: <fabbc87627e5ddc2c913b368ae99386668d8dcfb.1660830866.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v3] spi: Add capability to perform some transfer with chipselect off
Message-Id: <166256352877.169525.10010392957549857688.b4-ty@kernel.org>
Date:   Wed, 07 Sep 2022 16:12:08 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Aug 2022 15:57:49 +0200, Christophe Leroy wrote:
> Some components require a few clock cycles with chipselect off before
> or/and after the data transfer done with CS on.
> 
> Typically IDT 801034 QUAD PCM CODEC datasheet states "Note *: CCLK
> should have one cycle before CS goes low, and two cycles after
> CS goes high".
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: Add capability to perform some transfer with chipselect off
      commit: 5e0531f6b90ac096fedaf5bd0eae0bb4e5a39da5

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
