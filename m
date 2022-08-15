Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C320593328
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 18:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233084AbiHOQ0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 12:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232514AbiHOQZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 12:25:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A706C25C7C;
        Mon, 15 Aug 2022 09:23:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 63450B80EA5;
        Mon, 15 Aug 2022 16:23:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C375FC433C1;
        Mon, 15 Aug 2022 16:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660580591;
        bh=LmpGns7c5wLoId8LSEZ+UEolch41Y3wjGy4mOteOmBE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=IMAiOSv3VHv6/nNPdcMyK5VmhwP5QuIWADxtgV9ax/xQb3nqmUS3h4QniqMkXpSAk
         zXEiX5DngrWuz8mT+sNsut/FFBGEFRF+XmU3AfR++4P8+tM/Z0fOKPMDEXoolJz0Pv
         EwII4+u6PoHS/3RuEX8PxT8iczF6n0jryTf5QDs2+Ram8ZhwtCnSyjNAVSEYjTUXtj
         2zHH9rgAPb/yKy1rigi2YBN15XAUtn03PRNcPcBeh4LBdZZw5XMzMtEXX199GD8EFk
         0CdfEgpXowpOP1EUVBlxqofhjrJRuc8HDlyDOiAiiCimlMxQAz1MQVDFSkRmTe91+I
         MUVRnNpu73N3w==
From:   Mark Brown <broonie@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     kernel-janitors@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <fb959b3bda689aa47e1fbe9948de957b77530b24.1659764734.git.christophe.jaillet@wanadoo.fr>
References: <fb959b3bda689aa47e1fbe9948de957b77530b24.1659764734.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] ASoC: sam9g20_wm8731: Simplify some error message
Message-Id: <166058058851.769843.12342144572880656518.b4-ty@kernel.org>
Date:   Mon, 15 Aug 2022 17:23:08 +0100
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

On Sat, 6 Aug 2022 07:45:48 +0200, Christophe JAILLET wrote:
> dev_err_probe() already prints the error code in a human readable way, so
> there is no need to duplicate it as a numerical value at the end of the
> message.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: sam9g20_wm8731: Simplify some error message
      commit: 7d67657cb472a80d54457362bc421f2b57ee250b

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
