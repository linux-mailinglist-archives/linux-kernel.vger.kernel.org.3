Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C76E4EE17C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 21:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240583AbiCaTPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 15:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240607AbiCaTOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 15:14:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F9223C0C8;
        Thu, 31 Mar 2022 12:13:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E2307619A6;
        Thu, 31 Mar 2022 19:12:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 506CFC340F2;
        Thu, 31 Mar 2022 19:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648753979;
        bh=oHt2Bi4UNwgZ34wXp+/zVqZ2sH9aXbNzf6jU81i592I=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=o4vPWoIj4Kq204P2ZmcQF8O9uVIcS5DVotFzkFlzYNdocZDGKRpIab8hY3Oc1uNQo
         R8LfG8+7nAwrlsuElsBeCGUi/fA2z8r6BdUFeJq+U1gRSb0JTLVs7B6XTDRW53lWls
         yg1iduTUvLr8aTcX+/WbJML3pCFFM/pSaPPU8ENM9oBBmIltIyYUd0GVZ12I19fR0b
         Gxz48pr/jLvnYh9U9mw0ro+QaUAIR/5IAlX8jMwdQiGkvoW/cXUN/1RHcKyrM3/w1w
         CTj3hMIuY7B2DHhc0/eCMm0K65UyIkgLKLIZHv/kwG6XPpm2UN9A9bU8M5lAU52RvY
         q47Gq4Q3HMIWQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3E1E7EAC09B;
        Thu, 31 Mar 2022 19:12:59 +0000 (UTC)
Subject: Re: [GIT PULL] More docs for 5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87fsmy15qm.fsf@meer.lwn.net>
References: <87fsmy15qm.fsf@meer.lwn.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87fsmy15qm.fsf@meer.lwn.net>
X-PR-Tracked-Remote: git://git.lwn.net/linux.git tags/docs-5.18-2
X-PR-Tracked-Commit-Id: 022bb490c79799229ef467d9ccc3e5966001b0ae
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b4a5ea09b29371c2e6a10783faa3593428404343
Message-Id: <164875397925.22373.6462977148329962680.pr-tracker-bot@kernel.org>
Date:   Thu, 31 Mar 2022 19:12:59 +0000
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linus Torvalds <torvalds@linuxfoundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 31 Mar 2022 09:50:09 -0600:

> git://git.lwn.net/linux.git tags/docs-5.18-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b4a5ea09b29371c2e6a10783faa3593428404343

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
