Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19AAC59F178
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 04:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234006AbiHXCqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 22:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiHXCqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 22:46:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74C73C173
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 19:45:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 51EC3B822DB
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 02:45:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F25F7C433D7;
        Wed, 24 Aug 2022 02:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661309157;
        bh=ZNwLjIRgqTnxYF9V0apj16+sGb2PqGLjh6rCxu5OogI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=av6H4vfWKJuI7Cgcc0PCIwM6cv6EY9jJFZ6aMefY4Vm1UPSkF/fTZbITYuZW2KhiV
         32gzKssRE9Q5l9Sp7McLEVQwIKdFMw65rfOirlrqYJrprAud16b1Di6cviRWoFVyqS
         gWGfg1kEbJhL27v3UkYcYwnBFrkc4pKBjPXrjRWWV9FcyE+2Sg3B3Oc7Ln/V+za28G
         7mVZhqedC/GmOt0hLN3TvGHcB4a2ChM5hZmcKc18UDL6QEX3ok1sS9yriGQInMRuNy
         71tVV9dLTq6dq4KHmK6DzxBxYd8jswJVeIVG9SaUQWp0VOfsfOH+4gEPTreWVNodTC
         wKmorq7YGJiPw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D6298E2A03B;
        Wed, 24 Aug 2022 02:45:56 +0000 (UTC)
Subject: Re: [GIT PULL] Audit fixes for v6.0 (#1)
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAHC9VhRVFNy06XjVzd7BbPgMOxGYo4hV7bh5t73qFV_AQTrUPg@mail.gmail.com>
References: <CAHC9VhRVFNy06XjVzd7BbPgMOxGYo4hV7bh5t73qFV_AQTrUPg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAHC9VhRVFNy06XjVzd7BbPgMOxGYo4hV7bh5t73qFV_AQTrUPg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20220823
X-PR-Tracked-Commit-Id: ad982c3be4e60c7d39c03f782733503cbd88fd2a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 072c92b1b1ef69c0e4898a70194ec2df70b15cd8
Message-Id: <166130915687.7543.4697628699998502552.pr-tracker-bot@kernel.org>
Date:   Wed, 24 Aug 2022 02:45:56 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-audit@redhat.com, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 23 Aug 2022 15:19:09 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20220823

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/072c92b1b1ef69c0e4898a70194ec2df70b15cd8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
