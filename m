Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6594054EDB2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 00:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379246AbiFPW5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 18:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378348AbiFPW5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 18:57:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1709D6212F
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 15:57:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CA610B82667
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 22:57:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7D969C34114;
        Thu, 16 Jun 2022 22:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655420227;
        bh=R4OblaFZ+Xgd+5ufYtHoYOpaTW7+lk9x/SlbAwQwLwY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=dYmGy+YeTJGOHqqEr1jX1SV1QYitXbIjrhK4dEm60XiwPz0CYwNMMSndlUkXpWf4H
         oqvDE2FQXKAPkVEYJB0VkEa/fOxeUWkMYRv75bjKRtgL4LwWnL3IKLiZgzj479RB/R
         kdCKBsgIXWuUPiKhG+9H5Cn2bKUwxqLtDjmDmyuqUgBmY3bwgQinQqQMRRK7/eEiH4
         mN2v6G4Kz5OIv6M9t8f0mdv8WY6WkbaWamUR2t82Qco4v0KwsPdD0ox/51uo+7psRQ
         QYekglmiE9txD4zyXmSX4ltBVflPxUA3F+7ju8bz9rC6/A+iItv1IVT4Kviix9BzWX
         qygg7OtidLzOg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 66EB2FD99FF;
        Thu, 16 Jun 2022 22:57:07 +0000 (UTC)
Subject: Re: [GIT PULL] Audit fixes for v5.19 (#1)
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAHC9VhSjdCsyVz+Y7Xttvr2X389aDYiCvJYR-DEGa53AvmHs-w@mail.gmail.com>
References: <CAHC9VhSjdCsyVz+Y7Xttvr2X389aDYiCvJYR-DEGa53AvmHs-w@mail.gmail.com>
X-PR-Tracked-List-Id: Linux Audit Discussion <linux-audit.redhat.com>
X-PR-Tracked-Message-Id: <CAHC9VhSjdCsyVz+Y7Xttvr2X389aDYiCvJYR-DEGa53AvmHs-w@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20220616
X-PR-Tracked-Commit-Id: ef79c396c664be99d0c5660dc75fe863c1e20315
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0639b599f6f3cc871a9e024481a25a7d85946eb8
Message-Id: <165542022740.4629.11488121380306988445.pr-tracker-bot@kernel.org>
Date:   Thu, 16 Jun 2022 22:57:07 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-audit@redhat.com, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 16 Jun 2022 17:50:26 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20220616

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0639b599f6f3cc871a9e024481a25a7d85946eb8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
