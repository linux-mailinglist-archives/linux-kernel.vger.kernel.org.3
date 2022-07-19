Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94CD557A6B5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 20:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238024AbiGSSsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 14:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233818AbiGSSse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 14:48:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68848550E0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 11:48:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 002276178A
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 18:48:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 736CDC341CA;
        Tue, 19 Jul 2022 18:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658256512;
        bh=iLkyIO36BtPDxrnI/KP8mvv3f7QkRffWakG9ZfudIYU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=tz1ywMkODwlR0jWUvlWwRIysL39S+1FD5SJfKm4VtmQzpLbHv8k3gM2rciwr7FQH8
         l6i1sUVHQvf4fOL9/UXV0pbHaxZ5ycd/JS2oQGXYQt5TkD99XhvPltjN0Y+HDzH0Bo
         NvgffZtuyyaDJ86sXqMj+MeENoeqwJD8qLkXRv6+sioiI//VyzkcQnueH1UdiCa1Mx
         sSwxkP5GADS8hQX7zSm40ZbUs2ncMNFH2TsczkkfF7VEtZLRoQWhCPJQrAOEh7rWDR
         xTbtL+thGezuL2xj/yLyCC7nqUKFOH5nxhMb0YzyrI8Bp9prplyROkcpHrHqeyFBKF
         ijhjqMOYahidw==
From:   Mark Brown <broonie@kernel.org>
To:     christian@kohlschuetter.com
Cc:     linux-kernel@vger.kernel.org, lgirdwood@gmail.com
In-Reply-To: <3270C618-E361-4BC1-B63A-917AE09DA60E@kohlschuetter.com>
References: <E25D6465-6475-42B4-90EB-3D2C3CAF3B20@kohlschuetter.com> <YtVTyzLREdkzYiKS@sirena.org.uk> <3270C618-E361-4BC1-B63A-917AE09DA60E@kohlschuetter.com>
Subject: Re: [PATCH REBASE] regulator: core: Fix off-on-delay-us for always-on/boot-on regulators
Message-Id: <165825651119.448796.12422626259219989252.b4-ty@kernel.org>
Date:   Tue, 19 Jul 2022 19:48:31 +0100
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

On Mon, 18 Jul 2022 19:24:37 +0200, Christian Kohlschuetter wrote:
> Regulators marked with "regulator-always-on" or "regulator-boot-on"
> as well as an "off-on-delay-us", may run into cycling issues that are
> hard to detect.
> 
> This is caused by the "last_off" state not being initialized in this
> case.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: core: Fix off-on-delay-us for always-on/boot-on regulators
      commit: 218320fec29430438016f88dd4fbebfa1b95ad8d

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
