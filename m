Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B938E58A474
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 03:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240485AbiHEB2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 21:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236103AbiHEB2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 21:28:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35EA51BEB6
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 18:28:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C50F161987
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 01:28:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2AFDFC4347C;
        Fri,  5 Aug 2022 01:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659662902;
        bh=+ePxqiBAxJ/ZhuLgdzB/u2Ozgqjq9icjVGgPvaCsGWk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=WBfUCyrGWrmF39kclPrTUvvPBv3j5J72YEYbs7ezXNalxFZtz5CwjiduIIdrc3HpP
         otS9Eq8bdwfE2NZchMaCWVPuJKan5HNjZzw4Ixsnw5F/9fUFuMxjCD7490IAbI1qrh
         pD3eghhvvv2sAQ5dSO981f3NQCGWxAgbBBP6WIDfl1MUcQUE1Vz/rZwYq8/5pbjEf0
         YYZ3iLg9lsVJxBbtSMmGd696ru6pkqRn4mLuqvK83JvLyCgETM6HZFC7DIlVSVG6RL
         hOhA+y4G+D8i3f4j1NsVNWsXki9JMOfCV4N0J1NUWrtj4b4TkXQqlQxuSGSld6UTsX
         r5ODZjr7P8D6Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 19CB4C43142;
        Fri,  5 Aug 2022 01:28:22 +0000 (UTC)
Subject: Re: [GIT PULL] chrome-platform changes for v5.20
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yun1yFEsqpF59Tdy@google.com>
References: <Yun1yFEsqpF59Tdy@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yun1yFEsqpF59Tdy@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git/ tags/tag-chrome-platform-for-v5.20
X-PR-Tracked-Commit-Id: afef1e1a0223623d063a6df51dbc342c9517b948
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5bb3bf24b0aaa76253c77e437b88927a32a10c4e
Message-Id: <165966290210.8823.10771123517822780293.pr-tracker-bot@kernel.org>
Date:   Fri, 05 Aug 2022 01:28:22 +0000
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     torvalds@linux-foundation.org, pmalani@chromium.org,
        bleung@chromium.org, groeck@chromium.org, tzungbi@kernel.org,
        linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 3 Aug 2022 04:12:56 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git/ tags/tag-chrome-platform-for-v5.20

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5bb3bf24b0aaa76253c77e437b88927a32a10c4e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
