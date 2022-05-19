Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3530D52C8B1
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 02:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbiESAfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 20:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232100AbiESAfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 20:35:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3645B0423;
        Wed, 18 May 2022 17:35:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2A9ABB8227F;
        Thu, 19 May 2022 00:35:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C9579C385AA;
        Thu, 19 May 2022 00:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652920517;
        bh=GZXlC8RXj+9gJ2vO1wBQSODOhCnAgbIF5Ag6MR/5zG8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=r3zXQHdbTlvx7Z+hnMzHYpBVAsyl9FJVh7rcgCLAPzNDHkICVcM1XvjFnwGrztket
         0n5/5h/2rDvqHKmoxBCk0Gq4iFzZ+89iEJDlSRpHAbS5jYCxaY4WDzpQ+q05iHSSVW
         /mgF16Li53lvvlEXv7eh3eA7v71ZLqqt/KRjU4cuMRsD0DHcf/Vi7u3UukPw8K79XH
         X/u/9/jYune7y8eiiK6GUKlnnoffq+YyXf5BmkoLLxzU5rCNuAx/25JkHNn8hanYcj
         4vOSiR2K2rS40xhThuhIfArVI162iU/qARy8a4JFfc8hLpAqnQxVUF76NWtkEpeR72
         2D8LAt3O1BFpg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B57C6F0383D;
        Thu, 19 May 2022 00:35:17 +0000 (UTC)
Subject: Re: [GIT PULL] SELinux fixes for v5.18 (#1)
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAHC9VhRzZwD5X6AVojX8eFyN8i4fHfw1T5ugDd8brb=qRi1Cug@mail.gmail.com>
References: <CAHC9VhRzZwD5X6AVojX8eFyN8i4fHfw1T5ugDd8brb=qRi1Cug@mail.gmail.com>
X-PR-Tracked-List-Id: <selinux.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAHC9VhRzZwD5X6AVojX8eFyN8i4fHfw1T5ugDd8brb=qRi1Cug@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20220518
X-PR-Tracked-Commit-Id: 6254bd3db316c9ccb3b05caa8b438be63245466f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6899c161313671ca37a7a56429a3a80dad56ee8a
Message-Id: <165292051773.29647.13553381295845820106.pr-tracker-bot@kernel.org>
Date:   Thu, 19 May 2022 00:35:17 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 18 May 2022 14:16:39 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20220518

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6899c161313671ca37a7a56429a3a80dad56ee8a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
