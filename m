Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89028593421
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 19:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbiHORm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 13:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiHORmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 13:42:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B9027FDA
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 10:42:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E446261234
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 17:42:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3B8FC43470;
        Mon, 15 Aug 2022 17:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660585369;
        bh=2r85ODvUsNTQAUIN97OiV/A9DsKU2cJVhh2WGEalit4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Y+PKS9MK8VHC1m0TeflFtfO+1rMmERVTkTYkp8ks3AuwhF5k2EPivELOxjdzQ7aDR
         tswc26h3uGFaTYzm76ZQEdOaZGbMlmStSmixlwJKspPKnd2+gA7zr7E69FeCvAotr/
         LXW/CHwRNqSKcZ64Yrp2l8DvJyHOZi5+9JHopiBpaxHuOb3h8K9cTKptO2NO23Ri6s
         CK1JAYaEowrKVo+0VU2J9dxS6Lnmd8Z8Qo58kdKHJ4ngsfuvf8sm3KXyKyaFujoxmL
         sOu1MS9ZqJBeQJ+P8s+/mzuC6nh8ZJjLQPm91rLJW4fzEWfcMspCINFyH2ypXDIGK5
         HNztmdk3ud8Kg==
From:   Mark Brown <broonie@kernel.org>
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     William Breathitt Gray <william.gray@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
In-Reply-To: <20220808203401.35153-1-andriy.shevchenko@linux.intel.com>
References: <20220808203401.35153-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 0/4] regmap: mmio: Extending to support IO ports
Message-Id: <166058536764.839346.5393585450268456676.b4-ty@kernel.org>
Date:   Mon, 15 Aug 2022 18:42:47 +0100
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

On Mon, 8 Aug 2022 23:33:56 +0300, Andy Shevchenko wrote:
> Currently regmap MMIO doesn't support IO ports, while being inconsistent
> in used IO accessors. Fix the latter and extend framework with the
> former.
> 
> Changelog v2:
> - dropped the first two patches (Mark)
> - split the last patch to two (Mark)
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/4] regmap: mmio: Remove mmio_relaxed member from context
      commit: ada79bca380009a85d1e643e5a4da0c079f28225
[2/4] regmap: mmio: Get rid of broken 64-bit IO
      commit: 159dfabd207628c983e0c3c5ef607f496ff5e6a5
[3/4] regmap: mmio: Introduce IO accessors that can talk to IO port
      commit: 93ce557679e1cf7742ad327d40a1499e7d8535b7
[4/4] regmap: mmio: Fix MMIO accessors to avoid talking to IO port
      commit: 7e7ba58c94127efa97c249e38cc2d1c0ed78b58f

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
