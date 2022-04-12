Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC51A4FE75A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 19:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358535AbiDLRlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 13:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358480AbiDLRke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 13:40:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E5862BE2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 10:38:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA82B61A5C
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 17:38:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15DADC385A1;
        Tue, 12 Apr 2022 17:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649785095;
        bh=KwPW9yKy3O6s/y56BuSot0lytzFBzBqLRaUF9YdWAXs=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=YHN6zySvezGKOHP/bquwZaPKRVqXDwopc/4F9jNjlyTPeO5xSsCa5C7GF16MowhEZ
         DTi1E/B6ACn44IhpUaC9Nsnft95GAo/r9DcnYo7yFxBobPCmOnY7bteGI3YudtK/KP
         2FfwPEZcvLITAUiUPqZ5ZaUNyIzc7NJVJRGhb+GEWiMPgKE2trAv38n+GB8W8olSqP
         TvmK1cUPP/S4GPvXNMSJykVIfKZfyb5JNHZ9OIgcwwJrIKJ6qsFLflVRLUw6BGAMGZ
         JSFPM1aeKalMWhdu0ksLBNVcVOLo7i9QcxwQfDQnr7F9vqFpUFLCW/L+GaI8DY8Msk
         KTCkkxtUH/CZA==
From:   Mark Brown <broonie@kernel.org>
To:     "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, mario.limonciello@amd.com
Cc:     Vijendar.Mukunda@amd.com, open list <linux-kernel@vger.kernel.org>
In-Reply-To: <20220411134532.13538-1-mario.limonciello@amd.com>
References: <20220411134532.13538-1-mario.limonciello@amd.com>
Subject: Re: [PATCH 0/2] Allow detecting ACP6x DMIC via _DSD
Message-Id: <164978509381.404572.11948454165750728359.b4-ty@kernel.org>
Date:   Tue, 12 Apr 2022 18:38:13 +0100
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

On Mon, 11 Apr 2022 08:45:30 -0500, Mario Limonciello wrote:
> It's not possible to probe for the presence of a DMIC, so the ACP6x
> machine driver currently has a hardcoded list of all the systems known
> to have a DMIC connected to the ACP.
> 
> Although this design works it means that the acp6x driver needs to always
> grow with more systems and worse, if an OEM introduces a new system there
> will be a mismatch in time that even if the driver (otherwise) works fine
> it needs their system added to the list to work.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: amd: Add driver data to acp6x machine driver
      commit: e521f087780d07731e8c950f2f34d08358c86bc9
[2/2] ASoC: amd: Add support for enabling DMIC on acp6x via _DSD
      commit: 5426f506b58424f8ab2cd741bacf4b18b5fe578e

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
