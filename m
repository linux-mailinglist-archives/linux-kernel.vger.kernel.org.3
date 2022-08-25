Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6AB5A10F8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 14:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239853AbiHYMrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 08:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242041AbiHYMpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 08:45:23 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACFBB21804
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 05:45:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 69DDFCE27E9
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 12:45:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6653C433D7;
        Thu, 25 Aug 2022 12:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661431514;
        bh=ElHYmszbwnSEnunCPdIUSiZIw9jDr1XaG2phyYXOQts=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=NcCCQ6h/n3nIxjvQEHGsHGwZTHi7S0oQbaYzgNXgNsxRH8/vR6NQw+xPLU8qaeJ0f
         TwoPbvqXZBmjN92JannXJ5Dv8FmZl4e4YZYmLbdQLmrDeXo0ynbD2fCECqH10eyA/k
         3XXQlTDTpScLdJM0La2gaxbbSMUqHoU749QPqk/Y+o6qGlMarEHtznZN4ydfBpEcB5
         bh1UEqZ49xzInzxr+LHk05C+pWW8H1Ij6Zlx9akJ+qlIraboihP8nfXi8XN7qlqYQ1
         pfgEzRDQQmTNpazM7dmc0GYiOwQSB4fWg9k3HZGZJSTEezFCocUcSKcW6zgYQQ1KI/
         LxblKQD4Q+7fg==
From:   Mark Brown <broonie@kernel.org>
To:     Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
Cc:     linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        linuxfancy@googlegroups.com, Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, linux-amarula@amarulasolutions.com,
        Jaroslav Kysela <perex@perex.cz>, Stephen Kitt <steve@sk2.org>
In-Reply-To: <20220825101714.81580-1-tommaso.merciai@amarulasolutions.com>
References: <20220825101714.81580-1-tommaso.merciai@amarulasolutions.com>
Subject: Re: [PATCH] ASoC: max98088: add support for noise gate reg
Message-Id: <166143151246.98448.3045084214547332329.b4-ty@kernel.org>
Date:   Thu, 25 Aug 2022 13:45:12 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-0c1df
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Aug 2022 12:17:13 +0200, Tommaso Merciai wrote:
> Add support for Noise Gate Threshold reg (ANTH reg 0x40 bit 4 to 7)
> 
> References:
>  - https://datasheets.maximintegrated.com/en/ds/MAX98089.pdf, p75
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: max98088: add support for noise gate reg
      commit: 671d119e75c8dfbf25c1813a167eeb2616c8acd5

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
