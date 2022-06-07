Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEEBB53FBE8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 12:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241678AbiFGKry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 06:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241802AbiFGKqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:46:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 335F5F1357
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 03:46:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD2196152A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 10:46:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0DB8C34114;
        Tue,  7 Jun 2022 10:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654598786;
        bh=0D+tn4T5VwkAbtlCnkNSQiUQ+Bka36vahBMW9yn7jWs=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=XN4OtEC1ReiFN5hrpvP9Cq0PlQPq7YfJvoOUz4LGPyKKlCkjQsrmUKdomdFAAM9Te
         fyZcmp7oO2ftDXjge+iSNiy13lm0+l8lD0CsQ6V6jnWbkgwr52PaswPwc5atqcLSH4
         3ABphjfscleAu/awS3918OV5qLYnVhXgoS5Gh74VzTsQmI2bajgKp66YztbgS5lnu6
         hAhGwTsVAnbjIF/70ySUiM/TwVhYdRKQCm+HbtRuKN5UVKpIgZrmgmUIfoEnoC3QiZ
         VqOvuz+DlJdyKmMonFsv0vuS+1wK8VF8xdTS9l9csNkz1nt+fgRXZApaosIZDCcEPn
         5ihB1ZNmT3Rnw==
From:   Mark Brown <broonie@kernel.org>
To:     aford173@gmail.com, alsa-devel@alsa-project.org
Cc:     aford@beaconembedded.com, open list <linux-kernel@vger.kernel.org>,
        ckeepax@opensource.cirrus.com, Liam Girdwood <lgirdwood@gmail.com>,
        chi.minghao@zte.com.cn, Takashi Iwai <tiwai@suse.com>,
        "open list:WOLFSON MICROELECTRONICS DRIVERS" 
        <patches@opensource.cirrus.com>, steve@sk2.org,
        geert+renesas@glider.be, Jaroslav Kysela <perex@perex.cz>
In-Reply-To: <20220526182129.538472-1-aford173@gmail.com>
References: <20220526182129.538472-1-aford173@gmail.com>
Subject: Re: [PATCH] ASoC: wm8962: Fix suspend while playing music
Message-Id: <165459878357.301808.15345032675363899374.b4-ty@kernel.org>
Date:   Tue, 07 Jun 2022 11:46:23 +0100
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

On Thu, 26 May 2022 13:21:28 -0500, Adam Ford wrote:
> If the audio CODEC is playing sound when the system is suspended,
> it can be left in a state which throws the following error:
> 
> wm8962 3-001a: ASoC: error at soc_component_read_no_lock on wm8962.3-001a: -16
> 
> Once this error has occurred, the audio will not work again until rebooted.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: wm8962: Fix suspend while playing music
      commit: d1f5272c0f7d2e53c6f2480f46725442776f5f78

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
