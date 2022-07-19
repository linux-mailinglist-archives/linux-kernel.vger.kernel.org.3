Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8F457A4B1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 19:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237731AbiGSRME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 13:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237528AbiGSRMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 13:12:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F90115F
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 10:11:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2841A60FE8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 17:11:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55A60C341C6;
        Tue, 19 Jul 2022 17:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658250716;
        bh=5iVcq8tomxnH4tiYclWNXIGQuQpwgkJRPWeb2ZiE01A=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=MPAvBpo64jh3a8A+OlzLppzXqbuzrZVCnoPU4KDrhloSbf/6Km0YyCiSAWBiRIg3M
         u2qCSlFjitInByiBd3M995qJwwwmhs3U87n6sYevpxiSS+h1cTG9AvErk0sMDDSef5
         H3H6a6TRK4NHeQwPQIQmw9+ZqE5vh+SFrcwmw2HMV0kLJ00uMthx6pTWS44IrBYNAU
         TmJo+OptvGHwU5dEkUg0HXD704s3xOCicw2v9laJkMFAWU9MLUpUKbSHlxvYlkUZLg
         OMtgUqXC1ouFZMciTmSCLNxUypYqJEgAe75Q15aRh8zuUg2EmYdijad3A9ldApJl4h
         Nh6qj9UY9o9jw==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, tiwai@suse.com, jiwang_wang@mentor.com,
        perex@perex.cz,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     Dean_Jenkins@mentor.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, jiada_wang@mentor.com,
        erosca@de.adit-jv.com
In-Reply-To: <20220718110404.1529085-1-jiwang_wang@mentor.com>
References: <20220718110404.1529085-1-jiwang_wang@mentor.com>
Subject: Re: [PATCH v1 1/1] rsnd: ssiu: add missing .quit callback for gen2
Message-Id: <165825071404.372578.3185771887733235033.b4-ty@kernel.org>
Date:   Tue, 19 Jul 2022 18:11:54 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Jul 2022 20:04:04 +0900, Jiada Wang wrote:
> From: Wang Jiada <jiada_wang@mentor.com>
> 
> commit 83b220cf8eb2a ("ASoC: rsnd: implement BUSIF related
> code in ssiu.c") moved BUSIF related code in ssiu.c
> which added .quit callback in ssiu.c to disable error irq
> when ssiu quits.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] rsnd: ssiu: add missing .quit callback for gen2
      commit: 11e9318ff7486f375cf246c172c3206a731a2254

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
