Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B246155A34D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 23:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbiFXVI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 17:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbiFXVIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 17:08:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F33710FCF
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 14:08:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0D780B82A88
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 21:08:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BA5A5C3411C;
        Fri, 24 Jun 2022 21:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656104886;
        bh=nuvVSUEBYobWv9qV9oSBqu85Hf4yIc0DW/0aq33yppM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=uNncqsfB/L96482AfKX4bNCkXM3XQBRFbm9GwHphOxgtfkfaudYeNxSSVv2UfKLze
         qbp9wjj+dcwqlIFxq/lIjXndsIJNavMMwPkqaPCkkG+ZEy2VQuLi7CJpp+QxOKj1fh
         uEPstMgToFIyZC1YO3xhhkBgY9T0rMSfYb+YvLM0WoqJTy+46zfyNwJF2PnYw7Qjux
         Buc+bIiUMQ9/qcchVEZddfwMrDqQE9i8tvyXW/mAc3spSIiR7xvoUfRf9mRWBvNv4o
         zblDESVfK3GH487q2wnbosKOfjZ21i7f1pmgCenNzUiwA1PD64vUA6c1Yq/L4E1C4Y
         OUiloFpYkZ1Ww==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A3D45E574DA;
        Fri, 24 Jun 2022 21:08:06 +0000 (UTC)
Subject: Re: [GIT PULL] regulator fixes for v5.19-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220624165400.B90CAC34114@smtp.kernel.org>
References: <20220624165400.B90CAC34114@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220624165400.B90CAC34114@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v5.19-rc3
X-PR-Tracked-Commit-Id: 122e951eb8045338089b086c8bd9b0b9afb04a92
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bed051817cb38eda5f80201956a2500b4e88cd14
Message-Id: <165610488666.13803.1970765403167135650.pr-tracker-bot@kernel.org>
Date:   Fri, 24 Jun 2022 21:08:06 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 24 Jun 2022 17:53:44 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v5.19-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bed051817cb38eda5f80201956a2500b4e88cd14

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
