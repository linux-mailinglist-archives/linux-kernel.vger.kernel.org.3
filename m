Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06AA1470E34
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 23:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344959AbhLJWui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 17:50:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344860AbhLJWu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 17:50:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21105C0617A1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 14:46:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E081CB82A12
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 22:46:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 99B1AC341CD;
        Fri, 10 Dec 2021 22:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639176411;
        bh=g1Mi3fOZNd41EZPqYx4KoCP7+0kEfwIjBoredO+AIhY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=lvXlN8fo34bD5lW/IfwJxXs9cJFW4DWDQcdO4XQO+wzsU4usJ4fgJupNSo9ZuRLY/
         L5GXpS+2iu3Pmk6sLw99QmoQx5rk8yq8KFg5yvKhFwUCp3WOcsgH3vt2+SAthXAMlp
         Ox78eaaxB9tOtM4q4n3mwJwJa62Sd9DTeNAj0WIuDZstx+3DV4fdCXzBe6h8Z50+Xh
         3NxZmAMv+KtbWJnN5g97S1xaFaZLcGj3kfexH2V2GnsaIHhkYzX+/uEZ14/VUpPsiZ
         oc4BZxm7YEvXRbUSVAA5gZU68axOyaE7T2idsn8s6dQFYq7UU17b+RqJBuF6xiJrs9
         2hnPGmTEmoytA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 8535D60A39;
        Fri, 10 Dec 2021 22:46:51 +0000 (UTC)
Subject: Re: [GIT PULL] tracing/tracefs: Updates for 5.16-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211210134801.56e26614@gandalf.local.home>
References: <20211210134801.56e26614@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211210134801.56e26614@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.16-rc4
X-PR-Tracked-Commit-Id: c24be24aed405d64ebcf04526614c13b2adfb1d2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 257dcf29232becbbd9bab68e3dc1ed7bbe654efb
Message-Id: <163917641153.4787.14964273165900153203.pr-tracker-bot@kernel.org>
Date:   Fri, 10 Dec 2021 22:46:51 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jiri Olsa <jolsa@redhat.com>, Miaoqian Lin <linmq006@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 10 Dec 2021 13:48:01 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.16-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/257dcf29232becbbd9bab68e3dc1ed7bbe654efb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
