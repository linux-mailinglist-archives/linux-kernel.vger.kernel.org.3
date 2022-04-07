Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5954F7BD3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 11:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243864AbiDGJkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 05:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241774AbiDGJkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 05:40:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE6AC3FBE2
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 02:38:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7BA23B826FA
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 09:38:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 990C9C385A0;
        Thu,  7 Apr 2022 09:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649324294;
        bh=+d4cnleCUJWpXKCHl6jqTWsLhlnL3DFeNBceY2nkpXw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Fpy5Eq8p52ThFguNBE7cJHBbuzxLCjCchEulvp6c0fu4jkPA9MHc7orUhxOfnXzdR
         gu7BDZzPdN8167K/M2KPBESck9N+KG7Zq2iWFyHXOBLARClBC70SlL7fZh1/X7erNN
         SFETAIGyIpy4M1LD6J+B1YPwm7yS1QP40JhUjl8ZsCFah28RpQZqWzwj7Uo4PsBFHY
         eM8gavPGaJdSQvJkJE3gSofe054phw3OBVepOQdFfNQcVPqLMi3DvJJK9h4+vGVtDa
         JGqejxt8ORRaGh4zEI6f3jjVAiw+e+OOVWsembsUuPJews4UkUuX7vI2xY7waojLsy
         TJjTsiEvXhE3Q==
From:   Mark Brown <broonie@kernel.org>
To:     steve@sk2.org, lgirdwood@gmail.com
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <20220405171158.2168762-1-steve@sk2.org>
References: <20220405171158.2168762-1-steve@sk2.org>
Subject: Re: [PATCH] ASoC: rt1016: enable building
Message-Id: <164932429334.3844153.9301414120139279872.b4-ty@kernel.org>
Date:   Thu, 07 Apr 2022 10:38:13 +0100
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

On Tue, 5 Apr 2022 19:11:58 +0200, Stephen Kitt wrote:
> The rt1016 driver wasn't listed in Kconfig and Makefile, which AFAICT
> means it isn't ever built. This patch adds the appropriate entries to
> Kconfig and Makefile.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rt1016: enable building
      commit: 953b1388a58e8fd70c034c7679d7031d41c7d8ec

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
