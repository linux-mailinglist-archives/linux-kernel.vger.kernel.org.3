Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 715F74ADC01
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 16:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379480AbiBHPIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 10:08:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379469AbiBHPIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 10:08:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54142C06157A
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 07:08:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E5666614D9
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 15:07:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AA00C004E1;
        Tue,  8 Feb 2022 15:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644332879;
        bh=rvW0eaRso68NXB1Fho4YVGkeZl0TIcN2idEPs76SQEs=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=bsWDZyWPCVG9SH5FDg7+0dVqGi06KioplLvxS0QA5EzgABFsKlzlcARpgTSw6/MmC
         H9oxCZ+/4NrDkLlsotuvKTFM9v1pvQQ+XF+CFSAxsKSMs6YW/JVzogYV99AJbWAfec
         4uHzDkqDdaKlOkCLsVxiw0dUchyD5qETi1fa29nwaSExT35Ot8A2QTokfDkl0sbm4g
         VhZ0ph2jdX+c10/+bqQS4g2KWM9r8FbJ0s/8DvEbenVTGBnxODBL0UZWg0g0ENrFVM
         QHNQoicFwzq+AO427ofVrGfdGsk5qkmenv9UWrz4AYLKvdXqwRJYDdySZGf2Q/FW03
         KTlYMbJK/L4zw==
From:   Mark Brown <broonie@kernel.org>
To:     Oliver Barta <o.barta89@gmail.com>, linux-kernel@vger.kernel.org
Cc:     Pi-Hsun Shih <pihsun@chromium.org>,
        Rolf Evers-Fischer <Rolf.Evers.Fischer@aptiv.com>,
        Oliver Barta <oliver.barta@aptiv.com>,
        Liam Girdwood <lgirdwood@gmail.com>
In-Reply-To: <20220208084645.8686-1-oliver.barta@aptiv.com>
References: <20220208084645.8686-1-oliver.barta@aptiv.com>
Subject: Re: [PATCH] regulator: core: fix false positive in regulator_late_cleanup()
Message-Id: <164433287788.2964991.4272324071658669274.b4-ty@kernel.org>
Date:   Tue, 08 Feb 2022 15:07:57 +0000
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

On Tue, 8 Feb 2022 09:46:45 +0100, Oliver Barta wrote:
> From: Oliver Barta <oliver.barta@aptiv.com>
> 
> The check done by regulator_late_cleanup() to detect whether a regulator
> is on was inconsistent with the check done by _regulator_is_enabled().
> While _regulator_is_enabled() takes the enable GPIO into account,
> regulator_late_cleanup() was not doing that.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-linus

Thanks!

[1/1] regulator: core: fix false positive in regulator_late_cleanup()
      commit: 4e2a354e3775870ca823f1fb29bbbffbe11059a6

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
