Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1CC4F3E38
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 22:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236728AbiDEPWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 11:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347137AbiDEJqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 05:46:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CBB9DCE2E;
        Tue,  5 Apr 2022 02:32:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A41B616E3;
        Tue,  5 Apr 2022 09:32:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1117C385A4;
        Tue,  5 Apr 2022 09:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649151150;
        bh=pwpVhI8k5umqPw1rCqRZHC3hmjlAQwEh7jZoPos1oUE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=UGox+5N0wsUGeWdDZg2mnDqInQ9WZWFTTjg8C68QzublVGk+GLk+65CL8O9G8FYQ1
         4VRIH97uM/8caPtgdElJ6OLDgHLXAWzJ6KBvfXZT6HFHxtRhWGLKGaEpwGlJxh6Qaw
         LepBqp3tc0Ag1p7d4NEtuE8oJN0cR60XqWEJXdZks1XyEb+Sxlb6kxPzXhGPJN9rkt
         3vxfUmh//EuKganUO/UIh5cZ3nGKG7sIN28Ryn474XMeAzYoBCNxJeioLNhMazU/4G
         x/DXTJ9rHtB5eUBLqHwAg44bNmY2YO8/2OEzZQJ1ktCr/RMr5eq203rnZ0R3yPQIS+
         KsYthHxNmJvIA==
From:   Mark Brown <broonie@kernel.org>
To:     christophe.leroy@csgroup.eu
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
In-Reply-To: <5ed3298d8b5b1b5bf681d79584c61cb495852f4e.1648833423.git.christophe.leroy@csgroup.eu>
References: <5ed3298d8b5b1b5bf681d79584c61cb495852f4e.1648833423.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] spi: Prepare cleanup of powerpc's asm/prom.h
Message-Id: <164915114958.276894.7475754044101563566.b4-ty@kernel.org>
Date:   Tue, 05 Apr 2022 10:32:29 +0100
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

On Sat, 2 Apr 2022 11:50:21 +0200, Christophe Leroy wrote:
> powerpc's asm/prom.h brings some headers that it doesn't
> need itself.
> 
> In order to clean it up, first add missing headers in
> users of asm/prom.h
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: Prepare cleanup of powerpc's asm/prom.h
      commit: 02b3024824f48a270f6170901f1abeb1edb1619f

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
