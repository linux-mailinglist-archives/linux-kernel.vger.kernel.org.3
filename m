Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2878F57C0AE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 01:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbiGTXMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 19:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231583AbiGTXMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 19:12:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C934B0D0;
        Wed, 20 Jul 2022 16:12:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 69747B8222C;
        Wed, 20 Jul 2022 23:12:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04523C341D0;
        Wed, 20 Jul 2022 23:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658358736;
        bh=tkIAwLdRLlKrtzjlA/APq42GsWiNdQp09ixV23X/Y0A=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ffPRcU+OPp7EMgkx+QqIwS+b6gFBjuR7vxPCXU1BDNgOc0WFvq0UBKI/w6vtF8t7v
         WhaW+BWSJP6FgFJFkC/ujfH8SeNoOCIUjfTcsGhNziirtxP3ZDX5GgU7KcjSMVvnFX
         jieK5b5NMA5hPP1D1Eua17LNp7WMwOijLJ/XNx35ZT7xAwag+rjdWDWYIaSg4jNCwB
         +VPeAcxblFpRgPMXpgor10j7ln720X0Gc8F0bP9jppUFNRen2/u2/3D4LJqHtWsCoR
         GGg+VMWJfmGAnugQM2JYeD8ggQY8DXozrLjEMaP0XieToVXxeOvlu9BaioLk8sbpnY
         e0LQVNOVpsHBQ==
From:   Mark Brown <broonie@kernel.org>
To:     perex@perex.cz, tiwai@suse.com, paul@crapouillou.net,
        lgirdwood@gmail.com, aidanmacdonald.0x0@gmail.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
In-Reply-To: <20220708160244.21933-1-aidanmacdonald.0x0@gmail.com>
References: <20220708160244.21933-1-aidanmacdonald.0x0@gmail.com>
Subject: Re: (subset) [PATCH v4 00/11] ASoC: cleanups and improvements for jz4740-i2s
Message-Id: <165835873474.1007579.2143422827851423635.b4-ty@kernel.org>
Date:   Thu, 21 Jul 2022 00:12:14 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Jul 2022 17:02:33 +0100, Aidan MacDonald wrote:
> This series is a preparatory cleanup of the jz4740-i2s driver before
> adding support for a new SoC. The two improvements are lifting
> unnecessary restrictions on sample rates and formats -- the existing
> ones appear to be derived from the limitations of the JZ4740's internal
> codec and don't reflect the actual capabilities of the I2S controller.
> 
> I'm unable to test the series on any JZ47xx SoCs, but I have tested
> on an X1000 (which is the SoC I'll be adding in a followup series).
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[02/11] ASoC: jz4740-i2s: Remove unused 'mem' resource
        commit: cd57272c4e686d4ad2d2e775a40a3eac9f96ec7c
[04/11] ASoC: jz4740-i2s: Simplify using regmap fields
        (no commit info)
[05/11] ASoC: jz4740-i2s: Use FIELD_PREP() macros in hw_params callback
        (no commit info)
[06/11] ASoC: jz4740-i2s: Align macro values and sort includes
        (no commit info)
[07/11] ASoC: jz4740-i2s: Make the PLL clock name SoC-specific
        (no commit info)
[08/11] ASoC: jz4740-i2s: Support S20_LE and S24_LE sample formats
        (no commit info)
[09/11] ASoC: jz4740-i2s: Support continuous sample rate
        (no commit info)
[10/11] ASoC: jz4740-i2s: Move component functions near the component driver
        (no commit info)

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
