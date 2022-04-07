Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E51E4F7BDB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 11:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242590AbiDGJlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 05:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243860AbiDGJk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 05:40:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4A61B2154;
        Thu,  7 Apr 2022 02:38:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 89590B826EC;
        Thu,  7 Apr 2022 09:38:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00DF9C385A9;
        Thu,  7 Apr 2022 09:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649324301;
        bh=uIwgR3pVWQ2tLhHj07s4Etx3NDjbjW6eqYEftcbaJ9w=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ewszGuCnjWBBxeWe2aGzoWNNNNMjuHKnmxSX+XWKgZNRjVicp+Ep0zw9knfu4lVdC
         flciZcPQ8r1QqzTVPlfDRekWIPuEd2P1cR6ldDpo4Ve3dLeXr2ITVmLt/gMGrexJMf
         Ssa4x1iRBOPlHg21pxLfbxk5xxyN8+CFAYz5TI5wek43ZpehMNNWfyO68rhXWj0bXi
         7KjYlpMqFhyMFMBMLloAOTVgG+EWWZ8DTFij3snbVsi12vbwMDblHlsmLf1aJhUvXb
         Al+EWZ3ASFhSoy6VhYA44n9D66mrSacxhgOc3WFp8B1ulSwVWVbn97H5hbMpgLp0dT
         ovGl2UlfDlaFA==
From:   Mark Brown <broonie@kernel.org>
To:     daniel.baluta@nxp.com, Jaroslav Kysela <perex@perex.cz>,
        lgirdwood@gmail.com, christophe.jaillet@wanadoo.fr,
        Takashi Iwai <tiwai@suse.com>,
        pierre-louis.bossart@linux.intel.com,
        ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com
Cc:     sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <3bbf03cfd1966bc6fb6dd0939e039fc161078a61.1647757329.git.christophe.jaillet@wanadoo.fr>
References: <3bbf03cfd1966bc6fb6dd0939e039fc161078a61.1647757329.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] ASoC: SOF: topology: Avoid open coded arithmetic in memory allocation
Message-Id: <164932429871.3844153.12183120087286124160.b4-ty@kernel.org>
Date:   Thu, 07 Apr 2022 10:38:18 +0100
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

On Sun, 20 Mar 2022 07:22:26 +0100, Christophe JAILLET wrote:
> Use kcalloc() instead of kzalloc()+open coded multiplication.
> This is safer and saves a few lines of code.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: topology: Avoid open coded arithmetic in memory allocation
      commit: 0a480df0b87a75b315cc6eef62bfb597111ee630

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
