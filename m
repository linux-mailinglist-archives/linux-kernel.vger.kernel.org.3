Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B10956850B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 12:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233003AbiGFKRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 06:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232397AbiGFKRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 06:17:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C497124BFF
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 03:17:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A54B61DD6
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 10:17:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B79C9C3411C;
        Wed,  6 Jul 2022 10:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657102629;
        bh=tzHUM5AbMxYYDOX4wtqvv6WhtlHhikUXAgRZwor5N2k=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ISFrSBBUjkxuuslNUrgH8+OGaSErg64jDORerQhk/d/aobeWM2wJVbprS6x7zm/IG
         36alyjqv1hvDfrbjPd90lMgJxg69CwrUNY7V1ZK8x5Vig+AN5B2khbH2YMx2rp4cPO
         WJVYMgQJ6NToY6xJDhRDPc6Cam3J5iFZLnAYf5tjfaGT41uRKqo6k2I3fdoxleLeDm
         tPu9avGiexae8T7GqSIXNXs1g8bX/41sW6IC0hGZvqE7RSiJnKsrHvciZs03bOytzg
         DvuVXsIlFAK0dcRi9lM1uO4LmW63fULkdBDqeTRfoGp9K4zVQUn5kAxwIPxyBP/+uN
         aTedKCQWUEpJQ==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, jiaming@nfschina.com
Cc:     renyu@nfschina.com, linux-kernel@vger.kernel.org,
        liqiong@nfschina.com
In-Reply-To: <20220705071445.21124-1-jiaming@nfschina.com>
References: <20220705071445.21124-1-jiaming@nfschina.com>
Subject: Re: [PATCH] regulator: Fix parameter declaration and spelling mistake.
Message-Id: <165710262848.218847.17997439381141698785.b4-ty@kernel.org>
Date:   Wed, 06 Jul 2022 11:17:08 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Jul 2022 15:14:45 +0800, Zhang Jiaming wrote:
> Use Complete data type declaration of 'sel' in ti_abb_set_voltage_sel().
> Fix spelling of 'are'nt' in comments.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: Fix parameter declaration and spelling mistake.
      commit: d08412328e4ff4928a60438e62e34e67f687a740

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
