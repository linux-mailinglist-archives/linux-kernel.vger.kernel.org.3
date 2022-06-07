Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 444C353FC11
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 12:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241594AbiFGKt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 06:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241839AbiFGKrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:47:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D08ED8F0;
        Tue,  7 Jun 2022 03:46:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6CB1CB81F0A;
        Tue,  7 Jun 2022 10:46:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AE1FC385A5;
        Tue,  7 Jun 2022 10:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654598797;
        bh=X6+5xiOE4qz4XMcdhWNAGw1qU87NWDS8qS5BzQ/8XE8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=JCgHrS5CDjnhl/jAOf3aQuKjo45BwkzqWGT0qBdLvfCtOjZCnp8pVpryVVMvqs5Xd
         RIHZeRHacdRAT4H9OjX6jbjz98WFwnaJTw39FWTslAxBDiE0Cfbi+zv07GeqYfoLAQ
         LYfUg5GMJSkCXhYaMrb1pjLB54NjTTtLt5YrFCAXqtojvTL+Q/TyVPbA7sFsPmB4W6
         3meYz+OU3W1vYu3iXAAT2MAUbZXfpODvLRuBYR1tU2poisSNdPjfqdcFkYfwY6mvmt
         SuoJcLz/3+N+hj70knrbroLm/OsDy+GF/YHD+ivwNl3UqR/X+TYUVar+kn4FoK6Ow6
         CVrwfkeAwvOQg==
From:   Mark Brown <broonie@kernel.org>
To:     christophe.jaillet@wanadoo.fr
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
In-Reply-To: <d114558dd0351b863ced8cc01b31754a5a4b960d.1653116362.git.christophe.jaillet@wanadoo.fr>
References: <d114558dd0351b863ced8cc01b31754a5a4b960d.1653116362.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] spi: intel: Use correct order for the parameters of devm_kcalloc()
Message-Id: <165459879602.302078.11011502384282095003.b4-ty@kernel.org>
Date:   Tue, 07 Jun 2022 11:46:36 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 May 2022 08:59:35 +0200, Christophe JAILLET wrote:
> We should have 'n', then 'size', not the opposite.
> This is harmless because the 2 values are just multiplied, but having
> the correct order silence a (unpublished yet) smatch warning.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: intel: Use correct order for the parameters of devm_kcalloc()
      commit: 1f19a2d1d6b9a5796182874eecdd5a67dd94b90c

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
