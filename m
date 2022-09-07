Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD60F5B0514
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 15:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiIGN0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 09:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiIGN0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 09:26:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2639D7859F
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 06:26:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DDE12B818B5
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 13:26:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72982C433D7;
        Wed,  7 Sep 2022 13:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662557197;
        bh=iZw1nTU67Ivs2AqLpW+3y33SN9k0HxrKZmxm1kghL14=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=hYBXbEtKwB6aB6nJAA6XofbPpCzm6yRWzZjncZCemaT+EFz7F9fTDtEdsyjFDxnCR
         i9KTjMJv9gtUzRcRLN2Rw9j5HrK/6qCZrRVSUPPoVdYIafgF+MP9Sz8BIUGe1EAexl
         gzncy9SkT044i6PQEWB8COVVajxNEN8lM/aHvS0ZyBKVzoVIASMFU1wj02ipwpGqAn
         ZVc51uzdfYpVpM8VaRfzkYkjnJ6uz3K7WlJBaonVRXQCymTttWV2gi431Apd93XSYX
         dbbB71cJ/G1wQ+vbes7AWqokC4fV7ggjqcsyL76fAWf4rh/3FEyyIgJgMgWUj01Ld2
         U2dQ+s4OddYnw==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
In-Reply-To: <20220831212744.56435-1-andriy.shevchenko@linux.intel.com>
References: <20220831212744.56435-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 1/3] swab: Add array operations
Message-Id: <166255719616.121632.16915236431944164557.b4-ty@kernel.org>
Date:   Wed, 07 Sep 2022 14:26:36 +0100
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

On Thu, 1 Sep 2022 00:27:42 +0300, Andy Shevchenko wrote:
> For now, some simple array operations to swab.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/3] swab: Add array operations
      commit: 2d4697375dea514be202abf563a9419e74489c25
[2/3] regmap: mmio: Use swabXX_array() helpers
      commit: 400dceb6f8b56472b36c5c2c8c3e0cbb7557d019
[3/3] regmap: spi-avmm: Use swabXX_array() helpers
      commit: 26cc2a788a1903da3ccff97061099f091255ecaf

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
