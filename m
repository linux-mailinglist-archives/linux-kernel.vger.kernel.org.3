Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF0053FBBB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 12:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241522AbiFGKpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 06:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241415AbiFGKpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:45:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B1FE64C3;
        Tue,  7 Jun 2022 03:45:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E7AA61319;
        Tue,  7 Jun 2022 10:45:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1780BC3411E;
        Tue,  7 Jun 2022 10:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654598722;
        bh=H7439HAhKBiBU5PJ0wEYhH+/aj2uOXs88io1cN6Ww+I=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=IZJSFxF3NIi3cewoR1VlvJQkQVHSUj3nrlHYEWLewWIaLDLl3OCLisXwJk8+U6N7k
         xAbXEtMyKf/faeh1lawU5kwfT3E6Wy0rTQ5QERHAt6NVjJ1DdVKsNtwmmB4eXkZumX
         s0qkSMeKyQbAiOT5ozjwAxPlyPDV7Zg+to24SS0nvp7oex+F10NyB+ax9Vn5ShVvzK
         Z8te27GrRgIwob/Vi5X2zadr+Q2ACUKhB7gIN56o+pBApMCXIO8IYkSbX8jz5zYd0m
         MMukOD4clitxdcEa2BeAq79ezlu9vZ9bFljGbxJpy3pQ63EFOdkNheKmQL3yMnzbUJ
         c5nRjaoG4seVw==
From:   Mark Brown <broonie@kernel.org>
To:     olivier.moysan@foss.st.com, Julia.Lawall@inria.fr
Cc:     linux-arm-kernel@lists.infradead.org, arnaud.pouliquen@foss.st.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        alexandre.torgue@foss.st.com,
        linux-stm32@st-md-mailman.stormreply.com,
        mcoquelin.stm32@gmail.com, linux-kernel@vger.kernel.org,
        Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org
In-Reply-To: <20220521111145.81697-76-Julia.Lawall@inria.fr>
References: <20220521111145.81697-76-Julia.Lawall@inria.fr>
Subject: Re: [PATCH] ASoC: stm32: dfsdm: fix typo in comment
Message-Id: <165459871980.301808.7235614685174421255.b4-ty@kernel.org>
Date:   Tue, 07 Jun 2022 11:45:19 +0100
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

On Sat, 21 May 2022 13:11:26 +0200, Julia Lawall wrote:
> Spelling mistake (triple letters) in comment.
> Detected with the help of Coccinelle.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: stm32: dfsdm: fix typo in comment
      commit: 2685d5046962f018b1a155b3eef316562414638b

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
