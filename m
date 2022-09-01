Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0867B5A9624
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 14:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232939AbiIAMAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 08:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbiIAMAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 08:00:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7FB4C629
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 05:00:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 78B64B825CD
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 12:00:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BC42C433D6;
        Thu,  1 Sep 2022 12:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662033644;
        bh=I2YcNy/LQ9DJXgnVrsxQO9sNuDEkqdgvN1fXue0mYXM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=sONoq7eL4xBkKXtUSHvjG7NmPdmVvjgBy7DXixgG0Z7qKgmjTf37BJXkib9t5hp2I
         mJn7phYF8qOMrKMZ6awFInOk+kTnOmea8/zZOytpSm2TQMiZYZaZoHdRWgxjCFOAs2
         fe+UKz38ZfMg6JmajxOvltUOY1nGOO6DQFK+cu8pFuneICU+Jc/tBMn/YiCYQwq2Md
         Sosn1ef6K8fN8XmMFneZjQo/9iub6efUNqNzMwT5mATHoX+tNfvzAZtX+gem1KRzQu
         VzOgTTtPZ3Xb8Nxz62nl1lNbYG3U8SahKciPlLG0ZCaGc9ZbHzDJVsA5EqGd84adqk
         GsAoTy5U3MssQ==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@intel.com>
In-Reply-To: <20220831141303.501548-1-linus.walleij@linaro.org>
References: <20220831141303.501548-1-linus.walleij@linaro.org>
Subject: Re: [PATCH] regmap: mmio: Fix rebase error
Message-Id: <166203364321.46725.14616363536013598249.b4-ty@kernel.org>
Date:   Thu, 01 Sep 2022 13:00:43 +0100
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

On Wed, 31 Aug 2022 16:13:03 +0200, Linus Walleij wrote:
> A dangling pointless "ret 0" was left in and some unneeded
> whitespace can go too.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: mmio: Fix rebase error
      commit: d57f2035c0455dfd5e4d29caa0266fad6febe6d6

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
