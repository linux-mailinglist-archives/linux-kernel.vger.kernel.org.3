Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84BA94A8419
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 13:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350640AbiBCMwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 07:52:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236476AbiBCMwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 07:52:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911B0C061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 04:52:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8CE52617C3
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 12:52:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8881C340EF;
        Thu,  3 Feb 2022 12:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643892735;
        bh=MX6s01rx/OdEQk4J2Dq8jkWD7sSlbsMea8gvpLM4cko=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=HYobC6OAV25jU4TLHmN98rYtmMP+gXpealy44ooOuiTZcjhNsSmac8mlmHdw6tRq5
         XjOKsYb+f4mcf1E1sEhkrpxW5MjX/yqr7JFMIdTFg6Zrwv3TSGM29vc0gcYszfQqau
         iraoFNF+2Sm051YqSgxWIK9DXySP/j4IoQ8h9J0X5vYslNOfoLll40O4e88jk1Grco
         IYSVdOoRNEP6f3vTPGFnTmdWA3B2IRzpXZ2NsexB860Rm0QIXYLPoh+LaQtA/3EBzd
         AfTbxagjSBpbYsBMARh/OCvS6l5nYsLtr903wzDIEwRc72nIy2r0J7RSTjNhJJ1Pi8
         OAhTDiSD+ermw==
From:   Mark Brown <broonie@kernel.org>
To:     V sujith kumar Reddy <vsujithkumar.reddy@amd.com>,
        alsa-devel@alsa-project.org
Cc:     ajitkumar.pandey@amd.com, Vijendar.Mukunda@amd.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Takashi Iwai <tiwai@suse.com>, Basavaraj.Hiregoudar@amd.com,
        Jaroslav Kysela <perex@perex.cz>, Sunil-kumar.Dommati@amd.com
In-Reply-To: <20220131203225.1418648-1-vsujithkumar.reddy@amd.com>
References: <20220131203225.1418648-1-vsujithkumar.reddy@amd.com>
Subject: Re: [PATCH] ASoC: amd: acp: Set gpio_spkr_en to None for max speaker amplifer in machine driver
Message-Id: <164389273260.1027470.16661556291810590077.b4-ty@kernel.org>
Date:   Thu, 03 Feb 2022 12:52:12 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Feb 2022 02:02:15 +0530, V sujith kumar Reddy wrote:
> Maxim codec driver already enabling/disabling spk_en_gpio in form of sd_mode gpio
> hence remove such gpio access control from machine driver to avoid conflict
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-linus

Thanks!

[1/1] ASoC: amd: acp: Set gpio_spkr_en to None for max speaker amplifer in machine driver
      commit: 7fa5c33d043160eba3be9fb8e21588dff2a467c7

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
