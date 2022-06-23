Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0096E557D63
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 15:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbiFWN64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 09:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbiFWN6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 09:58:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066B63B031
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 06:58:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8301561DE8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 13:58:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84E18C3411D;
        Thu, 23 Jun 2022 13:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655992733;
        bh=2mVrmGmg0xr+Ozcvo3SQuzInJWS43tMd2u0JvspqRZY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=VfDbK+9xXR0NUdvVobxenGV/aPApAVTZ9kOoVcXuGXY4rLTPo7/ydth9gXKOuC5iP
         rfgMFrGZUnvRShxQbc5Gy2CKaUtV9a+fkRPWeUW0h/pi4OlfakqhiwGhO5GWcfVjrm
         7zp6uT2Gs5JohG5a2ru+g5GNyBKSuTSJR9In/JWC+EqLVtAC0i04AcIKpFc/v4A0xd
         QmqpeettfwY0aY1LxRulZrmBvBRnIvkDN6Q/tNBY+JApGKhQ+zX2o0dJAjfFR2c4Sk
         E31R06UEA4tXld+JtP2xo4WPARl7WmefM4Us3MW1XgotY7ysASsaxqBcmvUqGJNOnl
         66m0FG9WUsoog==
From:   Mark Brown <broonie@kernel.org>
To:     ckeepax@opensource.cirrus.com
Cc:     david.rhodes@cirrus.com, james.schulman@cirrus.com,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com
In-Reply-To: <20220623105120.1981154-1-ckeepax@opensource.cirrus.com>
References: <20220623105120.1981154-1-ckeepax@opensource.cirrus.com>
Subject: Re: (subset) [PATCH 1/6] ASoC: dapm: Initialise kcontrol data for mux/demux controls
Message-Id: <165599273226.179867.18058864820347037377.b4-ty@kernel.org>
Date:   Thu, 23 Jun 2022 14:58:52 +0100
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

On Thu, 23 Jun 2022 11:51:15 +0100, Charles Keepax wrote:
> DAPM keeps a copy of the current value of mux/demux controls,
> however this value is only initialised in the case of autodisable
> controls. This leads to false notification events when first
> modifying a DAPM kcontrol that has a non-zero default.
> 
> Autodisable controls are left as they are, since they already
> initialise the value, and there would be more work required to
> support autodisable muxes where the first option isn't disabled
> and/or that isn't the default.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[6/6] ASoC: dapm: Move stereo autodisable check
      commit: 4d6c2b46d81765e920007f76185a8d1fb5e41ca3

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
