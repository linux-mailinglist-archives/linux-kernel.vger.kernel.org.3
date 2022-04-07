Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 409044F7F8D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 14:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245512AbiDGMzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 08:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245499AbiDGMzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 08:55:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA333259B44
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 05:53:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 36A9DB82737
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 12:53:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB428C385A4;
        Thu,  7 Apr 2022 12:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649335981;
        bh=NjIi+palNCB5NKFeNpaLrrO5MQoqCi/wHwZIXQz57dc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Yha0+acwAFEWSMuRW19XgdEliG1fuGz+oErcq5+SUh7tNOrqxQJp2FGDLPESgfDJg
         ImWoPa2C6B6jdZz9M4qkQhJoJ6Ts7t3E963k3+XNpQoQOmGVbdxo2eXGQnYUk8YTwp
         4Ke7ZLNIj2KYU2lJnJxzBKM5DENRqad6yLakmP1f8KklK/473ZZULJSkncNW3hlIB4
         c/mb13pSINWt/F4KwDyjNcxFAvBtIuP/WLgbFAohi6hqyguzkTXhgQcVcqM0I6WJEl
         QbevRCfILK5msSh5urYtW7KU7DfAeod10vm2KJX8G+Nz2QtYtywepufJ3tj+mru+hb
         empdovuVUE1BA==
From:   Mark Brown <broonie@kernel.org>
To:     dave.stevenson@raspberrypi.com, andriy.shevchenko@linux.intel.com,
        linux-kernel@vger.kernel.org, detlev.casanova@collabora.com
Cc:     Liam Girdwood <lgirdwood@gmail.com>
In-Reply-To: <20220325184508.45670-1-andriy.shevchenko@linux.intel.com>
References: <20220325184508.45670-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] regulator/rpi-panel-attiny: Get rid of duplicate of_node assignment
Message-Id: <164933597968.2466529.532531148275084481.b4-ty@kernel.org>
Date:   Thu, 07 Apr 2022 13:52:59 +0100
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

On Fri, 25 Mar 2022 20:45:08 +0200, Andy Shevchenko wrote:
> GPIO library does copy the of_node from the parent device of
> the GPIO chip, there is no need to repeat this in the individual
> drivers. Remove these assignment all at once.
> 
> For the details one may look into the of_gpio_dev_init() implementation.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator/rpi-panel-attiny: Get rid of duplicate of_node assignment
      commit: 4917e54997b0c5fbf39a3bd574802a16fa705096

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
