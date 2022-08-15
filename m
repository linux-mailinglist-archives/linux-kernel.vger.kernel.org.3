Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F199A5933DD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 19:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232098AbiHORKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 13:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiHORKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 13:10:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D3E64DE
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 10:10:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C46E8611D8
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 17:10:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5183EC433C1;
        Mon, 15 Aug 2022 17:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660583434;
        bh=Z1peZpsOzne+2xZ2cYemgCfk0P/mLViWM3YSQUJEJ5k=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=YEyzmZ/rnZ0jopHL7ArzPEu/O+lP9imn53xTDBTvRAZbT1mnVna4JxeGaHhht9Gah
         sDoipyabGe4xZO9OQrZJP5tsL6+kKrDfQFIkTxcJvP+8xrGRD64nHGR8Dlz+78hQal
         vGp+kKHZr9eXNsBuG2Nq0PsuswRLQYFe6Nkh8EPngsac/Kh/lFF/WMn2ClLMOSaPWa
         b1sp8mbQwgN69Dkxcfmba6lDsOf5bJ12qx872NsUgucSzAcSoojBkY5ldBhHEo/a8+
         sEbjuUeMeEunPv4JvMEO7cNzbh2dQabKo7SMig27vsz7fsddDJsk1Wr4RwK8XfbUvM
         /P3Au9iqhakAA==
From:   Mark Brown <broonie@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220815123138.3810249-1-rf@opensource.cirrus.com>
References: <20220815123138.3810249-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: cs42l42: Only report button state if there was a button interrupt
Message-Id: <166058343304.814219.14233923632228992383.b4-ty@kernel.org>
Date:   Mon, 15 Aug 2022 18:10:33 +0100
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

On Mon, 15 Aug 2022 13:31:38 +0100, Richard Fitzgerald wrote:
> Only report a button state change if the interrupt status shows that
> there was a button event.
> 
> Previously the code would always drop into the button reporting at the
> end of interrupt handling if the jack was present. If neither of the
> button report interrupts were pending it would report all buttons
> released. This could then lead to a button being reported as released
> while it is still pressed.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs42l42: Only report button state if there was a button interrupt
      commit: ea75deef1a738d25502cfbb2caa564270b271525

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
