Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 442B359ECCB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 21:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbiHWTra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 15:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbiHWTqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 15:46:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98FF2D9EB3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 11:50:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D8FB2B82075
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 18:50:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD378C433C1;
        Tue, 23 Aug 2022 18:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661280618;
        bh=/xv4OXPsvPMkUzwbd/AWtLyj0uWi/jiA2ATVA8TWE4k=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=mpNJ/EG/TqO3lfmwvJTa7aGTqPMHdTXS3Rf+ENbEj92mySCtv0t/twhfGz5xNNDy5
         f7Vn8WmmA7jF9lCC+6daoPf0Y367FNpoNvhELxLR0NGvnwilpT6GUFoCDQm81yjcvn
         neagGHcDTXf0y5g9O9WqgEW0wmHYBXyhrmn/vfOadkpdTfTWwMruT6AyYOvxgZN0a8
         gTj4pOcxwJfY38OXPHNqf4WAjCKltR4A4cppObItZjKgBGPShoUpqsxFKstnZPqgSu
         0nzzy53pxh7bgbKGwIW5QbBsexPBNokJtAc6AfMW8YmkgO4WZbDQzkKerVsXEX+b6E
         9ZSwFuCBMxfQQ==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
In-Reply-To: <20220823135700.265019-1-linus.walleij@linaro.org>
References: <20220823135700.265019-1-linus.walleij@linaro.org>
Subject: Re: [PATCH] regmap: check right noinc bounds in debug print
Message-Id: <166128061762.1031868.7908972361165797075.b4-ty@kernel.org>
Date:   Tue, 23 Aug 2022 19:50:17 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-0c1df
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Aug 2022 15:57:00 +0200, Linus Walleij wrote:
> We were using the wrong bound in the debug prints: this
> needs to be the number of elements, not the number of bytes,
> since we're indexing into an element-size typed array.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: check right noinc bounds in debug print
      commit: b7059927c3e32c96d2ff50c206549d8fac0ba69e

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
