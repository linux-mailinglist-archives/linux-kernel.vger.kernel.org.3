Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE4DA4AE1C1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 20:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385678AbiBHTA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 14:00:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385641AbiBHTAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 14:00:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F230C0612C0;
        Tue,  8 Feb 2022 11:00:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF8F7614E5;
        Tue,  8 Feb 2022 19:00:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36010C340EE;
        Tue,  8 Feb 2022 19:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644346821;
        bh=6PCIRyCbJSYAdU2tSFfTL+upTuMx/VBYM1sorzeTYPk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=VbAoq/+Y+DaszATSDNgpyzzBcJErhIFR1r4P3dK6HVKyqF6uTdbTqYK/YkzqlR0eZ
         KJ5HJmk02+V8r5wvdKoFq+STNtHfZn5KKiESEMVoU/2zroLSyNHBuT0cBZJ1votBNY
         oUgvKoxr9zs5F2pDFKFOKg7kOPlLAI5ltt/Yd/Fu7nPwlBL20vLLgiAxUw6oxPw0Wb
         ygnPVgQgMrHxNnzOHDq/pPkcsHeEmH4Wnqr23SCcyVzBnGv9ooKFB7WsjH0wp+cZ7I
         1WXqaqmPxUceYgSWbLF/Q+lT4Jr5ygOBZmdgl1t+6F6vEJzDW00SlJsdB0TMeHsZK7
         +pbGuNDslUQhg==
From:   Mark Brown <broonie@kernel.org>
To:     Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        linux-spi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <20220129040453.8476-1-luizluca@gmail.com>
References: <20220129040453.8476-1-luizluca@gmail.com>
Subject: Re: [PATCH] spi: ath79: add mem_ops for fast-read
Message-Id: <164434681988.1135514.4123730883547423099.b4-ty@kernel.org>
Date:   Tue, 08 Feb 2022 19:00:19 +0000
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

On Sat, 29 Jan 2022 01:04:53 -0300, Luiz Angelo Daros de Luca wrote:
> Reading from memory is 3x faster than bit-bang read operation. Also,
> for tl-wr2543nd, the bit-bang read was sporadically returning random
> data, possibly a HW defect, while fast-read works as expected.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: ath79: add mem_ops for fast-read
      commit: d08de0259dfe172caf073b921c6b27ff089605a9

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
