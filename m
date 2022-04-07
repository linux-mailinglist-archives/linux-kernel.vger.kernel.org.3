Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4D5D4F7BCD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 11:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234707AbiDGJkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 05:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbiDGJkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 05:40:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E5F2FFFC
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 02:38:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AEEA4B826EA
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 09:38:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4309DC385A4;
        Thu,  7 Apr 2022 09:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649324285;
        bh=/dCkPlJLBZQ2bJhRu9H8DFOpJavGfycnD5w6joNwYYE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=f3014xqRgZZbzcVdYMZBBW9pshaLvsAofctCkKqJKMWm2vCkZeLtXm7KsXJz+u1dE
         3/SseyiA5SfAQK2zO6P1BHbvgdWMsUTuCy1SWRImVMHd9mxIoCycQrkRpx3RcrOOGu
         Rrj5WJdCwEpLYpnKPCk+lA0v8Gd+TikKElm8nbHvLFKqmjYo94Ut/yXpUGjysXDIEd
         g6wQ4gChrvGtVaFxAuYbNnK0YiKWfM5/3kDnAvl8IC8ZHvo6rmjec/ZYesv2kQETUJ
         0opOxnqoNB4WbfoTizgeBf8jMv+iBPQCiLYk2vfXJHGxMRbqdUTeQE55SOmZKtXlo5
         hdYH1O+4gaW9A==
From:   Mark Brown <broonie@kernel.org>
To:     steve@sk2.org, lgirdwood@gmail.com
Cc:     patches@opensource.cirrus.com, wsa@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220405123236.2099063-1-steve@sk2.org>
References: <20220405123236.2099063-1-steve@sk2.org>
Subject: Re: [PATCH] ASoC: wm8731: use simple i2c probe function
Message-Id: <164932428399.3844153.17360257214289561952.b4-ty@kernel.org>
Date:   Thu, 07 Apr 2022 10:38:03 +0100
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

On Tue, 5 Apr 2022 14:32:36 +0200, Stephen Kitt wrote:
> The i2c probe functions here don't use the id information provided in
> their second argument, so the single-parameter i2c probe function
> ("probe_new") can be used instead.
> 
> This avoids scanning the identifier tables during probes.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: wm8731: use simple i2c probe function
      commit: 40658542d7713b6f1b51556ef91822f9ca8942d0

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
