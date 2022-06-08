Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D744C543DB6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 22:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbiFHUq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 16:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232990AbiFHUqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 16:46:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89904EC30F;
        Wed,  8 Jun 2022 13:46:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 613A7B82B3E;
        Wed,  8 Jun 2022 20:46:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74EBBC3411E;
        Wed,  8 Jun 2022 20:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654721194;
        bh=I7MP7j+Aj8ecZXgCH/5MDZumKTh3JqfwRQjdSTkXqeQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=YpXF9XUE70oWUW9tz9pcLM0j9BO5yfijhA/pOGZqHYElexVcVDLl9AZHCCzFDqeEo
         sNJYyZbs/gGYPIIQb1j9p2zY6ps8BkEBe6L7Xw2tu6l5Jcx3wckj8EnHdzuwMe9IrR
         arVV0LEGF0nqTNSFG3czryY6XvEI0VUEqD4bjKQcznikRaYwJljSg0d5f0tfzcAczy
         B6PIzqwK6BJhmzAfeAYXHpp6l41cEoIainVcU3pEdZfJzm+vaeJqqQaKb8yxeXESAh
         v6L1nmEfKnkcI8oMthAXbHQtC0rtUJwm4HUazD6DAkUUwW7R4N5Kt3KynekA1VxB4s
         Kq4TB4MmDHOWQ==
From:   Mark Brown <broonie@kernel.org>
To:     amartinz@shiftphones.com, ~postmarketos/upstreaming@lists.sr.ht
Cc:     stephan@gerhold.net, krzysztof.kozlowski+dt@linaro.org,
        me@dylanvanassche.be, Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
        caleb@connolly.tech, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, robh@kernel.org
In-Reply-To: <20220607074329.13129-1-amartinz@shiftphones.com>
References: <20220607074329.13129-1-amartinz@shiftphones.com>
Subject: Re: [PATCH v2 1/2] ASoC: dt-bindings: nxp,tfa989x: Add tfa9890 support
Message-Id: <165472119120.3018072.2563361398863658752.b4-ty@kernel.org>
Date:   Wed, 08 Jun 2022 21:46:31 +0100
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

On Tue, 7 Jun 2022 09:43:29 +0200, Alexander Martinz wrote:
> Document TFA9890 binding for tfa989x.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: dt-bindings: nxp,tfa989x: Add tfa9890 support
      commit: d0da7c8668dc19df157d927a67721ca00e29ff2b
[2/2] ASoC: codecs: tfa989x: Add support for tfa9890
      commit: ef6c320942a2f057204702d769d507186fd7f0b7

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
