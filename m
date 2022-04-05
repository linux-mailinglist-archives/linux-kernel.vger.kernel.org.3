Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0A2C4F455B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 00:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389461AbiDEPVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 11:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347108AbiDEJqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 05:46:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A67765BF;
        Tue,  5 Apr 2022 02:32:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 731B261368;
        Tue,  5 Apr 2022 09:32:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 323E3C385A3;
        Tue,  5 Apr 2022 09:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649151144;
        bh=gtg/844s9h3xTR3RsnVeF76EQtCjsTf/GUDiVtKfzvU=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=nbpOslMFh3wAVvyI1MDcj5Gw8snqyEQfPeUqmHfu4GytZ8DNo5u0p1hm/bkjqUu7+
         B3EcJ7ibOeswMRU4BaRu32dxDivhAGhbxIasYyyRts8KoC1vLwmRHiSQRoGm3z1eba
         DefGXezAbeDsLl8LpgPADIfEURE4ShIC8jaH96jTREzi5J/5pjmWexY32o6IQmhQyX
         QsnNCd7RwsXWaN1sZdlwlke05yc/02aOd8rsadaYIHSwolrwOZDQ2XEV8+MxZ9wYxW
         nuxJ5CDAhxfviCNIB32CFhm9jzFkbvY1i4PRYU8xGKOLpbaeZqpye/LyqJ/j690g2a
         kRbIGR46Abi8w==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        andriy.shevchenko@linux.intel.com
In-Reply-To: <20220323140215.2568-1-andriy.shevchenko@linux.intel.com>
References: <20220323140215.2568-1-andriy.shevchenko@linux.intel.com>
Subject: Re: (subset) [PATCH v1 1/4] spidev: Do not use atomic bit operations when allocating minor
Message-Id: <164915114392.276894.5947563879065898122.b4-ty@kernel.org>
Date:   Tue, 05 Apr 2022 10:32:23 +0100
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

On Wed, 23 Mar 2022 16:02:12 +0200, Andy Shevchenko wrote:
> There is no need to use atomic bit operations when allocating a minor
> number since it's done under a mutex. Moreover, one of the operations
> that is in use is non-atomic anyway.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[2/4] spidev: Convert BUILD_BUG_ON() to static_assert()
      commit: d21b94bf3ac44aa7759c0de6f72c0a887eb9e23b
[3/4] spidev: Replace ACPI specific code by device_get_match_data()
      commit: 2a7f669dd8f6561d227e724ca2614c25732f4799
[4/4] spidev: Replace OF specific code by device property API
      commit: 88a285192084edab6657e819f7f130f9cfcb0579

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
