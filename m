Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8CB4F7BD1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 11:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243861AbiDGJkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 05:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236796AbiDGJkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 05:40:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 230A81107C2
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 02:38:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5C916B826ED
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 09:38:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C1A4C385A8;
        Thu,  7 Apr 2022 09:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649324293;
        bh=RI99BPAgswF6Cfe59A2CR3bgDleAJoGPM+phymAh+Tg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=kA6pQFoIwpmKqPZ8gk9RhYAUOJ98dbvcLFv08UJvlsZQWi72FHKfEugz30ORuyQ0/
         y/yRqi3jrY+7AvBwExBTUAvZmUqkkC/R3AjpVmcdeHbYWEpssFDd5i0YdybCLh5FWD
         BMuwaidxaG4IEYVy9BTpSsPLKEWulEZNtjFiyDNE5x+LC2HjxfaLL7fLBxHcj8m0bg
         wE7ikOWNUWmzLtN+xK3B0yq/xctx+8y5u1P4KwlNgfQuVmrWR5C+WHRM+zYfjM6RPa
         PvvIrl2WBhL8xNWebOltM18FHwUzjsgUwurSebLKF2dovK0AUWNXq2qL3ocXKEmYjy
         c7iGKU3hI11GA==
From:   Mark Brown <broonie@kernel.org>
To:     matthias.bgg@gmail.com, steve@sk2.org, lgirdwood@gmail.com
Cc:     wsa@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220405163750.2158916-1-steve@sk2.org>
References: <20220405163750.2158916-1-steve@sk2.org>
Subject: Re: [PATCH] ASoC: mt6660: use simple i2c probe function
Message-Id: <164932429183.3844153.8366397314490115242.b4-ty@kernel.org>
Date:   Thu, 07 Apr 2022 10:38:11 +0100
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

On Tue, 5 Apr 2022 18:37:50 +0200, Stephen Kitt wrote:
> The i2c probe functions here don't use the id information provided in
> their second argument, so the single-parameter i2c probe function
> ("probe_new") can be used instead.
> 
> This avoids scanning the identifier tables during probes.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mt6660: use simple i2c probe function
      commit: b6d7a80d654fe7c03d4fb0227af2a5ae12ed6632

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
