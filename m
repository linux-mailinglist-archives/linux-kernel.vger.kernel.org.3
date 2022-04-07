Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 734374F7BDF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 11:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243938AbiDGJlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 05:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243881AbiDGJke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 05:40:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 001381B7567
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 02:38:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8B16BB826EC
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 09:38:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 225A9C385A4;
        Thu,  7 Apr 2022 09:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649324312;
        bh=5s9OskJhRbRG2UiHya741d2AQEc7gXNCfqv7+61bHTo=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=oSgF3ttao0gVuOlFBOMt9yHpO0kCnAqrr5505QzbDPd51pMmOkIeBjYcQRtVRyGyP
         Ait3GuJuxl0/lyEPOO4Yf1AciPnd5o3Rd6UmadIK6jXimksRI2/q/QI7GfhL1og0f8
         F6sKXWjfmQQ4Flol+icFsLEmIGMmrSm6bN00haeFXqCqdpm6W5o2m0QaQt4+lM9sbs
         fwtOS8sWrSWcg5SE2Pyoq7Gn2rcmpwi4TnsOLybt/P1gf7xJVUPwLiBLS3aa9V9W1A
         2lCl6vYS7ej/9+1Rn4IHNx95h1v9aaKr5YDa+hHBXezAn6TPRcVsue0kemWQfKEp+7
         Xj0dRH+U6rSmg==
From:   Mark Brown <broonie@kernel.org>
To:     rf@opensource.cirrus.com
Cc:     patches@opensource.cirrus.com, dan.carpenter@oracle.com,
        lkp@intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220404113252.1152659-1-rf@opensource.cirrus.com>
References: <20220404113252.1152659-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: simple-card-utils: Avoid NULL deref in asoc_simple_set_tdm()
Message-Id: <164932431085.3844153.445127549627667818.b4-ty@kernel.org>
Date:   Thu, 07 Apr 2022 10:38:30 +0100
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

On Mon, 4 Apr 2022 12:32:52 +0100, Richard Fitzgerald wrote:
> Don't dereference simple_dai before it has been checked for NULL.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: simple-card-utils: Avoid NULL deref in asoc_simple_set_tdm()
      commit: 51a630a7051f7f4f1cfdd64c20c7110f9907c230

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
