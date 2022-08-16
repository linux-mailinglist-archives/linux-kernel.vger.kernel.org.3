Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54DF8595DA8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 15:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiHPNs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 09:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233131AbiHPNsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 09:48:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C37371B9
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 06:48:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 84AD960C43
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 13:48:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37E2AC433D7;
        Tue, 16 Aug 2022 13:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660657694;
        bh=7r20AGsazUzPg0ulESzlqOX6il38BWeJeZEkiDi+x04=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=NTmkYvAE2HvNcZlO1wCA6+Q8eVevQJ3VeQpro4skup/hCqUJqsSB+lGV5ZPLvJwdO
         oNIV8EXUTw9F9Q2zFsUhM+3DeC9RHGfMyZ4a7vZf20nKFFYOMG6F3PPv4c4VmYrwpy
         V1rZl4NX7wXSYk5Tp3snwBInZP6sRUg5x+EvTdFK4y5ubxzgF4XKLXw9h1+M+zjdq7
         AOaoXfBk/I6z8OklMDeNDT15KGt3HFy+baxG11RHTXBrUcKnRv7nNcSTTaK310BqJZ
         ushCETFEJ9y5Fq7zf3dqRYiMoOOK2ppuUvt5oKfMJYf4sG278VN6zELA7+hwoe/i6l
         7PUdCxE4d/0HQ==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org,
        Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
Cc:     vsujithkumar.reddy@amd.com, ssabakar@amd.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
        open list <linux-kernel@vger.kernel.org>,
        V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
        Vijendar.Mukunda@amd.com, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
In-Reply-To: <20220805060420.813053-1-venkataprasad.potturu@amd.com>
References: <20220805060420.813053-1-venkataprasad.potturu@amd.com>
Subject: Re: [PATCH v2] ASoC: amd: acp: Add TDM support for acp i2s stream
Message-Id: <166065769185.1387305.16269791852523528497.b4-ty@kernel.org>
Date:   Tue, 16 Aug 2022 14:48:11 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fe10a
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Aug 2022 11:34:12 +0530, Venkata Prasad Potturu wrote:
> Add callback and code changes to enable ACP I2S controller in TDM
> mode. Add new fields in acp_stream and acp_dev_data struct to configure
> tdm related registers for ACP i2s controllers.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: acp: Add TDM support for acp i2s stream
      commit: 12229b7e50cfa95fda55b83a2617eafd6ac4c8c5

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
