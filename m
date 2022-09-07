Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC8305B04FB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 15:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiIGNQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 09:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiIGNPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 09:15:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269602FFDA;
        Wed,  7 Sep 2022 06:15:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B624618DB;
        Wed,  7 Sep 2022 13:15:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E9ABC433C1;
        Wed,  7 Sep 2022 13:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662556525;
        bh=JBAi7JLrrdWUKHjzT300EPybodfqmv9GKPkr2asT8Iw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=azO/O0NXPMQ5Ph8hFxwQ79Yy2jKhSNQbDHISva/cRe82+CH1UNtnLpXhRcdyypN/i
         vIlx1NkLMYhRtKtoi8+Bq6lgnNOl49FAuIoHi96oN2mexqBcbYHo4gGDRytIEgAxpB
         miYRSUpuv1VboerSzDXMLrJcmWWX6bmovAqGy787nHQo9dAEj/Xz5VpV4mfd60fv5e
         1dR+oFzOEDyfJdNi3M19XPE3MB0vkaDF23IX4nYR6gGqmBsH+N7k3HrO4f+7m0HBDc
         R6ynHGWH9S3Pccn3WieFz8n7udXWpzVc9avZRLwlfpaQP+Z820mpXLoPh5bQPVqR+R
         dO6vmEW9GbBAA==
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Michael Walle <michael@walle.cc>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Cc:     Han Xu <han.xu@nxp.com>, Haibo Chen <haibo.chen@nxp.com>,
        Yogesh Gaur <yogeshgaur.83@gmail.com>
In-Reply-To: <20220906161048.39953-1-andriy.shevchenko@linux.intel.com>
References: <20220906161048.39953-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] spi: nxp-fspi: Do not dereference fwnode in struct device
Message-Id: <166255652417.107207.11951981829518419145.b4-ty@kernel.org>
Date:   Wed, 07 Sep 2022 14:15:24 +0100
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

On Tue, 6 Sep 2022 19:10:48 +0300, Andy Shevchenko wrote:
> In order to make the underneath API easier to change in the future,
> prevent users from dereferencing fwnode from struct device. Instead,
> use the specific dev_fwnode() API for that.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: nxp-fspi: Do not dereference fwnode in struct device
      commit: 4b9ef436383e8aa910b71927b3f25ede9b190707

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
