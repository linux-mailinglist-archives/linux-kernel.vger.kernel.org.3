Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9993F533380
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 00:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242618AbiEXW14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 18:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242578AbiEXW1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 18:27:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 879FD35DDD;
        Tue, 24 May 2022 15:27:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 456B5B81BF5;
        Tue, 24 May 2022 22:27:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0B285C34100;
        Tue, 24 May 2022 22:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653431259;
        bh=Z0mZsMrmgkZREJ8yonBcBl70AWf4e9ev/eZWbW8Dn+Y=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=QX+ceN6WkSOSWTHPsmc05XNstSZ0+0bjDOzaNPC8f78UIWl2nqCVOqWTm+qLF5TD6
         U6kFiv3K7RPJ4WXkUlX11phT66Pwn/4fub0FTiq02ppRVZmZ27A84ilI+bGJ1EbfTI
         EVzI2zyhfbNUJChwAkZsRXaVx3g3eYHck3Xbf6wrGF9Nq80doWHgN/DA6u21xEu5m7
         fRDjC1NStyo4LeiXFgb0Hzw/T8eR3Pb5ZEYmLqom2omj+T8nqkBVKVR8VIjmdNqqlc
         Q4NvVa7Np3+sg+zLOPJbpPVbRc8ppcy5DsLB7/ylRC1Ch4tCxB1x8rA2PuT8nkM3+y
         IL2hg6usRxQ2w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EE702E8DD61;
        Tue, 24 May 2022 22:27:38 +0000 (UTC)
Subject: Re: [GIT PULL] MMC updates for v5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220523121836.27442-1-ulf.hansson@linaro.org>
References: <20220523121836.27442-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-mmc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220523121836.27442-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.19
X-PR-Tracked-Commit-Id: ded2c4c345001a129293db4bc1fa9ae236ceb0d9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 638971b77f1c4fb9997c674ad66d1b96f7931c2b
Message-Id: <165343125897.3997.12175592671238433164.pr-tracker-bot@kernel.org>
Date:   Tue, 24 May 2022 22:27:38 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 23 May 2022 14:18:36 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/638971b77f1c4fb9997c674ad66d1b96f7931c2b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
