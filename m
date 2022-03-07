Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF8B4D0889
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 21:39:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245366AbiCGUki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 15:40:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245309AbiCGUkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 15:40:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35E3723DB
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 12:39:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D0DA614C1
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 20:39:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87BFFC340E9;
        Mon,  7 Mar 2022 20:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646685563;
        bh=A56E0vmOp/YT5PrfBwMSlSMazuSnJdz9v37YbJ9aDww=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=M0L1B7yR/TkazCfrocdu5z7peB/y/WVFKIBpsqCyho1foIs0y6gJ/uLkxF5Lvb6Dy
         ay4Vc4UMjglO7kb+d0Dqoy31WdEug48X/JWr3xIItQ/PyIAtvmwBzhbhP0iBd3cjxO
         xlxpC7RP9Bs6EhCY5s5qa0GY32H6aRUGdAJSeSmusW2r88l5d9w010z3LalZ1anZYZ
         CPumO7Qi+h1ZR8UDvmUx7OesVjCpEDkbUcR1rlWGzc1YFzLhbiP76YDK1jNTQOu+1N
         WCoFjBZowdtrN7GY2X/gUYEJwMxD+1lvTyUERryE8bjbldK2XUbExTQkFsAzVjdjLQ
         aAP9+jDdJBtaw==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Bo Shen <voice.shen@atmel.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Jaroslav Kysela <perex@perex.cz>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        alsa-devel@alsa-project.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>
In-Reply-To: <20220307124539.1743-1-linmq006@gmail.com>
References: <20220307124539.1743-1-linmq006@gmail.com>
Subject: Re: [PATCH] ASoC: atmel: Add missing of_node_put() in at91sam9g20ek_audio_probe
Message-Id: <164668556128.3137316.11962793804624015559.b4-ty@kernel.org>
Date:   Mon, 07 Mar 2022 20:39:21 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Mar 2022 12:45:39 +0000, Miaoqian Lin wrote:
> This node pointer is returned by of_parse_phandle() with refcount
> incremented in this function.
> Calling of_node_put() to avoid the refcount leak.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: atmel: Add missing of_node_put() in at91sam9g20ek_audio_probe
      commit: f590797fa3c1bccdd19e55441592a23b46aef449

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
