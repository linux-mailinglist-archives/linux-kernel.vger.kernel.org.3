Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F32053C959
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 13:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244000AbiFCL3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 07:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237380AbiFCL3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 07:29:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54BD93C701
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 04:28:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6CFF76114D
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 11:28:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5E76C34114;
        Fri,  3 Jun 2022 11:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654255738;
        bh=/oL3L0OBazgj3LDtq29j/fp994lk3tQDa86GHQ4cVEE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=avUZKNn9J7evYn5IHsokkhCD6kgE1eOjXVvCeUk68ZRVKR1INvHnTn1jG5Wt7aWFV
         8CvMGNIDXVC1WZx+Y8/YoPwEu/5UL4kMNL41AMmOWlocg1vXqKQk1Fmr6nY7f8sU1y
         CGlwOveRtzFmrAxFGW0YNAOIifN7rJKqWmFJGDixQ19WwRbQm7ucFLMsGnsWZfL2nj
         sBLf7TBcvGqKp4f6ATNqWxJhNXb6l2bmH5rn2lS0WxCsJe/9A+Dl7LxXKwTMR7XwJI
         tULxB6AJnhIGdLShrRK+y1gOvcX34oNiHoZOkzALIQQzmkIcG90XBadAdTwE0wrfJO
         COjMh5fxL7T9A==
From:   Mark Brown <broonie@kernel.org>
To:     ckeepax@opensource.cirrus.com
Cc:     james.schulman@cirrus.com, lgirdwood@gmail.com,
        patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, david.rhodes@cirrus.com
In-Reply-To: <20220602162119.3393857-1-ckeepax@opensource.cirrus.com>
References: <20220602162119.3393857-1-ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH 0/6] Fixup Cirrus SX control usage
Message-Id: <165425573673.3864268.13153479722172115782.b4-ty@kernel.org>
Date:   Fri, 03 Jun 2022 13:28:56 +0200
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

On Thu, 2 Jun 2022 17:21:13 +0100, Charles Keepax wrote:
> Mostly the usage of the SX controls seems to match the lowest gain
> value + number of gain levels expected. The one notable exception
> there being cs53l30 as David noted. However, there are a couple of
> other places where the minimum value/TLVs are slightly incorrectly
> specified.
> 
> There are two I couldn't quite work out yet, any input on these
> greatly appreciated:
> 
> [...]

Applied to

   broonie/sound.git for-linus

Thanks!

[1/6] ASoC: cs42l52: Fix TLV scales for mixer controls
      commit: 8bf5aabf524eec61013e506f764a0b2652dc5665
[2/6] ASoC: cs35l36: Update digital volume TLV
      commit: 5005a2345825eb8346546d99bfe669f73111b5c5
[3/6] ASoC: cs53l30: Correct number of volume levels on SX controls
      commit: 7fbd6dd68127927e844912a16741016d432a0737
[4/6] ASoC: cs42l52: Correct TLV for Bypass Volume
      commit: 91e90c712fade0b69cdff7cc6512f6099bd18ae5
[5/6] ASoC: cs42l56: Correct typo in minimum level for SX volume controls
      commit: a8928ada9b96944cadd8b65d191e33199fd38782
[6/6] ASoC: cs42l51: Correct minimum value for SX volume control
      commit: fcb3b5a58926d16d9a338841b74af06d4c29be15

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
