Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B30AF4F404B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 23:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384567AbiDEPO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 11:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346650AbiDEJpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 05:45:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84686DAFEC
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 02:31:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11854616D0
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 09:31:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F4B2C385A3;
        Tue,  5 Apr 2022 09:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649151072;
        bh=FZqszyvA+yXRm0uxyPuw51TFFxhoO2xqk3VDZrjdL+A=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=eFyI8GIS9Zft4Os2Zgj6HzrM1/zn8GAwRx2/EdJgVYoOoth63EfVcZx0iMz7oIKH9
         sQ7q/8LORxjajshk3ROOilt5GvqXMGfGl//lOIusbFL9I+2sa34rzmZ6Njbm2gJeF3
         dZAUNDsGYJXe4cszUQueFx3zJktxzIvXFAwRbSd+8mPYIkCauG+zysU8pmCAUoCfYw
         jDeHlDLiyiFXtxAu+uVvE8DsPpuTNyLP4h2sHFPGdncQigbjg0fItNcdwoO/ndZzOJ
         dK3yv4Efuf0/QGHE2H+GFAPxt8jmNC1beFj+1igHA/jZ3qesKaYHHrMVgRJiMsUNNI
         w50CGCZfKcH1Q==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>, steve@sk2.org
Cc:     patches@opensource.cirrus.com, wsa@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220325162515.1204107-1-steve@sk2.org>
References: <20220325162515.1204107-1-steve@sk2.org>
Subject: Re: [PATCH] ASoC: wm*: use i2c_match_id and simple i2c probe
Message-Id: <164915107117.276574.5090942457362043907.b4-ty@kernel.org>
Date:   Tue, 05 Apr 2022 10:31:11 +0100
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

On Fri, 25 Mar 2022 17:25:15 +0100, Stephen Kitt wrote:
> As part of the ongoing i2c transition to the simple probe
> ("probe_new"), this patch uses i2c_match_id to retrieve the
> driver_data for the probed device. The id parameter is thus no longer
> necessary and the simple probe can be used instead.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: wm*: use i2c_match_id and simple i2c probe
      commit: 6d8f318b949aaa43a415947ee834890546e4e81b

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
