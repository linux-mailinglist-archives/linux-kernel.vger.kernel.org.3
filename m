Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC28E49FFAA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 18:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343763AbiA1Rgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 12:36:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350431AbiA1RgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 12:36:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989CCC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 09:36:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C29661AFB
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 17:36:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 943EDC340EB;
        Fri, 28 Jan 2022 17:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643391360;
        bh=dGdW+0uRYWOFFG1y09wydPXd2QObbOOam+FFFWIeB4c=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=X6YCv2PL3+iwevH4PkBPACHPR1AFCyy1oLcGgAC/j53ne4uKybGzIeEDC0tZ/dNn+
         +2aLAQLeBxVTnskRYs0sOwiVk/dGmKLN8Zo0jbbTQo6FKz8ZsfPeCRdmQ7m4Qtcox6
         blPzDzT0iCUy+U+4NReweAIteTMljKDQy2rUwIAzzkdWPnqEiHBkM04XzSzEuBWy4e
         OgGACcSj8l2rw1rkj4AdoxjTMuA8tGLbyMjQFrihQxs3Ew+NrfngCuD2TIYm5delMF
         DsktEWNJVGN2iXzA4kFy0E0xAf7O0TGe/U6iUzXCoVh/GWYnMilp8PkfTZr/OkgCq7
         Pi+S0vEY1spzQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 80C38F60799;
        Fri, 28 Jan 2022 17:36:00 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: Fixes for 5.17-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220128122020.7d938e68@gandalf.local.home>
References: <20220128122020.7d938e68@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220128122020.7d938e68@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.17-rc1
X-PR-Tracked-Commit-Id: 67ab5eb71b37b55f7c5522d080a1b42823351776
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: df0001545b2769e6aa33a45e26c00a4cdac48c29
Message-Id: <164339136052.16649.10734271683695142745.pr-tracker-bot@kernel.org>
Date:   Fri, 28 Jan 2022 17:36:00 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 28 Jan 2022 12:20:20 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.17-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/df0001545b2769e6aa33a45e26c00a4cdac48c29

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
