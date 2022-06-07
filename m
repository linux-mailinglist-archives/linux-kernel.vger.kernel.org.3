Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56E8F53FBE6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 12:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240288AbiFGKrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 06:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241692AbiFGKqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:46:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54CDFEFF2C;
        Tue,  7 Jun 2022 03:46:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF88461552;
        Tue,  7 Jun 2022 10:46:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0AA1C34114;
        Tue,  7 Jun 2022 10:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654598781;
        bh=sBaYugq1xPFjZqPwbsR8mD4Kd6QBYOF8Y29dQgVIFnI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=JVBFUfY3oP35uoMtrbJHwJUl6atnmUZ7r/majx+Lt7m2x3lavEwY6Y1inlSGqCMii
         EeChp+GadknXLHlYN4zehy6nTZ4TGtf5N8GSnaAr5ol6PBuUKG7stJlFXy/cOZYdSf
         H4mJP1REcjwf41T4IxYR3kQzHiQq1kkD0rRL3hdHsiH5eDVxzxPqKp4+sA6Il6SqjB
         sfQXfejgVNpG8EM0JavqKyqh2yWTWDK//PnvgfG8n2I0QiF3N2Jba9FUh6WXnutf9e
         KP6CGKP4ht5ezYXbIMQJoTNClU2zYbmFqXhpDyljusgcZiX/883aqEzRMzokliiNZH
         YXVoQp3Sf0OjA==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>,
        tglx@linutronix.de, christophe.jaillet@wanadoo.fr,
        Jaroslav Kysela <perex@perex.cz>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
In-Reply-To: <84d94977c57deee9e85249f18394ebf8d72497bc.1653724723.git.christophe.jaillet@wanadoo.fr>
References: <84d94977c57deee9e85249f18394ebf8d72497bc.1653724723.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] ASoC: ux500: Remove some leftover from the "Replace GPLv2 boilerplate/reference with SPDX" rules
Message-Id: <165459877943.301808.15291099978666980985.b4-ty@kernel.org>
Date:   Tue, 07 Jun 2022 11:46:19 +0100
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

On Sat, 28 May 2022 09:59:22 +0200, Christophe JAILLET wrote:
> The "Replace GPLv2 boilerplate/reference with SPDX" has left some empty
> "License terms" paragraphs.
> Remove them as well.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: ux500: Remove some leftover from the "Replace GPLv2 boilerplate/reference with SPDX" rules
      commit: 8466579b63cc9aa957b7b4f273087512f989d2a1

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
