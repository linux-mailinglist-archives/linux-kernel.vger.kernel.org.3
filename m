Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF15B55384C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 18:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236768AbiFUQ7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 12:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233936AbiFUQ7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 12:59:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1FB21FCDC
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 09:59:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E4DD61548
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 16:59:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9054DC3411C;
        Tue, 21 Jun 2022 16:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655830771;
        bh=lmiWAcqBGF009l5Gs571NJGOJ8UGNGQUNmtknNwqWDs=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=uLuwfksU+hlYfMlUGekAGUfxxB6eErGQomsklnOQF2lMY9JMDlr9QnhZ5FdSKwRVQ
         +TVielA9x07BfwCcx+1rHL5v8ifn7eidBhCvimyWoBSXR7qn8DpHW+APIWB5i6t5K7
         f6Fi2Cd4BphilV6F86Ws8tw4vWWk7jxC3zgu73IXjRjfAcpNXdbLG30jn/fs5A1sE5
         WDyH7b9dF4/9PiQSvhG84rYFji4hbHTV2CrFEDa31RZbs/TfcSDT8URZpEq8BuJvy4
         apKjwdnqv/hYIPkn2ebIxPFO4m7GYT7JzyUdaj18UivmCGa1S03bTWY0DHPNT01tXb
         v2lR/rcJJbxpA==
From:   Mark Brown <broonie@kernel.org>
To:     judyhsiao@chromium.org, heiko@sntech.de
Cc:     perex@perex.cz, linux-kernel@vger.kernel.org, wenst@chromium.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, briannorris@chromium.org,
        robh+dt@kernel.org, alsa-devel@alsa-project.org
In-Reply-To: <20220619095324.492678-1-judyhsiao@chromium.org>
References: <20220619095324.492678-1-judyhsiao@chromium.org>
Subject: Re: (subset) [PATCH v4 0/3] ASoC: rockchip: i2s: switch BCLK to GPIO
Message-Id: <165583076931.271995.9857794745310978104.b4-ty@kernel.org>
Date:   Tue, 21 Jun 2022 17:59:29 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Jun 2022 09:53:21 +0000, Judy Hsiao wrote:
> The patches series is to fix the unexpected large DC output
> voltage of Max98357a that burns the speakers on the rockchip
> platform when BCLK and SD_MODE are ON but LRCLK is OFF.
> 
> Changes Since V4:
>     -- Fix indentation in the driver. (Align parameters with the parenthesis
>        placement.)
>     -- Fix incorrect return type of rockchip_snd_rxctrl.
> Changes Since V3:
>     -- Fix indentation in the documentation.
>     -- Put pinctrl-1 right after pinctrl-0 in dtsi.
>     -- Fix indentation in the driver.
>     -- Remove unnecessary dev_dbg() in the driver.
> Changes Since V2:
>     -- Add documents of i2s pinctrl-names.
>     -- Fix dtsi syntax error.
>     -- Include the dtsi change and the driver change in the same series.
>     -- Ensure that driver gets both bclk_on and bclk_off states before using them.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: rockchip: i2s: switch BCLK to GPIO
      commit: 44f362c2cc6dd0c5e3cb499c4fb4ed45b63a6196
[3/3] ASoC: dt-bindings: rockchip: Document pinctrl-names for i2s
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
