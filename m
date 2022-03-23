Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60C804E5BF2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 00:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233077AbiCWXjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 19:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241532AbiCWXhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 19:37:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C165070047;
        Wed, 23 Mar 2022 16:36:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 78485B8217F;
        Wed, 23 Mar 2022 23:36:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 42206C36AE2;
        Wed, 23 Mar 2022 23:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648078580;
        bh=r0t/LWSTRy50EZPGEgy6dJ6vuSnBZ2yGfwlmCVG7TBo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=VwqWK7uQgNX2u+t8F9/DB1V8UCIaMjgaxw+IX0qwohv2jUUhXdDcEVxaQaKffp2NQ
         BHCDoL2UILVQn4janvojeaIJef4G7e/ortwczdFRpjNSXBSM2LLqRTCRMw1DLXCUSX
         utSZCvhnxUXkajaMF+mIxjm6F/trSHFc1YmSQidop8FvNZ8krxTSMrGIFoXU66LWs2
         B6PQuPojAjiP6/E7DyIsPpwBQ/ICrxDkDFo44aN/20K1K9RaMrEkl5xyflLhKVm6br
         iO/8o84XDs8+kOBKyaDKngtTj1msGu3RCRE7tdAFDDoeUWuUkYuPK9EHy436ItbHwQ
         RsfJAp6xMOVsg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2E6CBE6D402;
        Wed, 23 Mar 2022 23:36:20 +0000 (UTC)
Subject: Re: [GIT PULL] MMC updates for v5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220322114159.358997-1-ulf.hansson@linaro.org>
References: <20220322114159.358997-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220322114159.358997-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.18
X-PR-Tracked-Commit-Id: dc3d879c6ffa25e90875237265898e49b2cabb7e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5bebe2c9ae0e0d3c6b25b8e1048bf66b1a3df621
Message-Id: <164807858018.14397.12936198691051486429.pr-tracker-bot@kernel.org>
Date:   Wed, 23 Mar 2022 23:36:20 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 22 Mar 2022 12:41:59 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5bebe2c9ae0e0d3c6b25b8e1048bf66b1a3df621

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
