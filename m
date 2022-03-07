Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 153084D087D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 21:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245295AbiCGUkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 15:40:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245287AbiCGUkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 15:40:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469CA66CB8;
        Mon,  7 Mar 2022 12:39:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C28CF61520;
        Mon,  7 Mar 2022 20:39:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C49B9C340EF;
        Mon,  7 Mar 2022 20:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646685543;
        bh=1tPC7Vjo747OpXcH2m5vzgTDvgtK+G4DbkC9Mgxsp8Q=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Vts6hToDphdrAOTX3rEMyPPPiFWDKk10FZNzS70wvL7IMup0nQMPAhHSKHR20XPLO
         pCzTnRiZsNan8RiU+KMsm4a22qaDZHNPJA9uKESneezSIozRjDV4T03PnbcFx8fh1A
         H+wlnPYgGWfCWauVVrHKYG/gq0HdbTKw/RUyB9yVS+F7LGg4/5dMHcvZCS+GmCgePO
         JZ+/ZZO5bPWu3UrmMPq4TIrvsy++9PaPfulkc3vIMUKloqtjLQTxaZqE/DAMfa4jUM
         h9R5cVvm11hEdZIqozyqltdnMg6BlL2HYXAw2IQN2vWcYVTQ4G3AbKUSqo/VqrkRXd
         9f6MLQvI/oKJw==
From:   Mark Brown <broonie@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>,
        kuninori.morimoto.gx@renesas.com, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org
In-Reply-To: <20220228172754.453783-1-rf@opensource.cirrus.com>
References: <20220228172754.453783-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH V3 0/2] ASoC: audio_graph_card2: Support variable slot widths
Message-Id: <164668554153.3137316.2454343353845940191.b4-ty@kernel.org>
Date:   Mon, 07 Mar 2022 20:39:01 +0000
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

On Mon, 28 Feb 2022 17:27:52 +0000, Richard Fitzgerald wrote:
> This adds support for I2S/TDM links where the slot width varies
> depending on the sample width, in a way that cannot be guessed by
> component hw_params().
> 
> A typical example is:
> 
> - 16-bit samples use 16-bit slots
> - 24-bit samples use 32-bit slots
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: dt-bindings: audio-graph-port: Add dai-tdm-slot-width-map
      commit: 26e5366dd30569a469e1a87998b866b814deccf8
[2/2] ASoC: audio_graph_card2: Add support for variable slot widths
      commit: 1e974e5b82b3d75069b50445cd248cee0199654e

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
