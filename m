Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 683075A4D04
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 15:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiH2NH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 09:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiH2NG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 09:06:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1866C8C47B
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 06:01:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E10AE611F8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 13:01:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19D5FC433D6;
        Mon, 29 Aug 2022 13:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661778086;
        bh=jTDytCuHvzFQa93P6bPX3Q1qKXGCU1D2dILZvqZbiYA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=hF4S/b9yV+2YFmd1VdFm2VKTCgXSTsCO3/CViG3vS0K1IofLZUXoodZBlGLfJF0+B
         T2kJe8qlw3gcVcXBAh67Uuu4Up9tfRuehW5XaOoh8uty+xxGHxOhOSmkjwqHvhAQfB
         Oo4YdqLa7+zIjUKqGXvTfVNzkvyAiu7R18EuFsMcvncfUTWnq+K28fHlnsA0CI/kQ1
         9AimWhk/rLQrO5CZCfnZPTATMm1E5cK7yrCLJWxbMy8QE1+hfqBjBkhjlVKiPyXf5i
         agE5llaz2Y3YTBue3OqGTJ1zNcrlhcImu3T5T1kafySLiZmyQzFG9KesWvZYDOrxGb
         NYV4SmxhsfmPg==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org, venkataprasad.potturu@amd.com
Cc:     ssabakar@amd.com, Basavaraj.Hiregoudar@amd.com,
        linux-kernel@vger.kernel.org, perex@perex.cz, tiwai@suse.com,
        Vijendar.Mukunda@amd.com, lgirdwood@gmail.com,
        vsujithkumar.reddy@amd.com, AjitKumar.Pandey@amd.com,
        Sunil-kumar.Dommati@amd.com, Vsujithkumar.Reddy@amd.com
In-Reply-To: <20220826064250.3302260-1-venkataprasad.potturu@amd.com>
References: <20220826064250.3302260-1-venkataprasad.potturu@amd.com>
Subject: Re: [RESEND v2] ASoC: amd: acp: Modify dai_id macros to be more generic
Message-Id: <166177808385.741330.2587705836145362860.b4-ty@kernel.org>
Date:   Mon, 29 Aug 2022 14:01:23 +0100
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

On Fri, 26 Aug 2022 12:12:45 +0530, Venkata Prasad Potturu wrote:
> Change dai_id macros to make I2S instances in order.
> 
> 

Applied to

   broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: acp: Modify dai_id macros to be more generic
      commit: 99a387c7818fe422fa96458f56bc74f05f263013

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
