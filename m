Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9346847176D
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 01:35:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232322AbhLLAey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 19:34:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbhLLAet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 19:34:49 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DBEEC061751
        for <linux-kernel@vger.kernel.org>; Sat, 11 Dec 2021 16:34:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4AB8DCE0A1C
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 00:34:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8D894C341C7;
        Sun, 12 Dec 2021 00:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639269285;
        bh=/iNdbKtaVSMXH8MdYTNdn9KJ0x9lZYbny7VELTMfjrw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Shr1VKLmTpq4QEXq3MFKB4+OYK09YSRQ3Sh4TG6Hmlueo5nDM8LqXgU6HivRkqwOT
         SuRwAjTb43euuLrGxTMaWS+UcVBOCPa7qCOfW3nI+9UmMvGn+51mmtFqgYMW3QizuB
         GmwZqiLv5zDewjWaqy1yiJnko5fGdwTFk5qFDmJ6mb8Lddkrd2Fdy/YT585acqVS+J
         Qoskklco+YT6rbFijrc9XtldCI7p6jttahex0AbRZ7B9hddCI2sdOM3QFBxWr0VRwe
         2yQhI9OBsrpMU1bEcoHLHvo319K4N4fH2yE+lrmuOi2k78znUZ5+vroz72RWjDcbpG
         nHHh4yYIrzjsA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 6197960A36;
        Sun, 12 Dec 2021 00:34:45 +0000 (UTC)
Subject: Re: [GIT PULL] percpu fixes for v5.16-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YbTSgYx7qZ5XO6Yo@fedora>
References: <YbTSgYx7qZ5XO6Yo@fedora>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YbTSgYx7qZ5XO6Yo@fedora>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dennis/percpu.git for-5.16-fixes
X-PR-Tracked-Commit-Id: a4f1192cb53758a7210ed5a9ee695aeba22f75fb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8f97a35a53e2afc0a2485b2d976e12492563a318
Message-Id: <163926928534.10000.4486816236484884462.pr-tracker-bot@kernel.org>
Date:   Sun, 12 Dec 2021 00:34:45 +0000
To:     Dennis Zhou <dennis@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 11 Dec 2021 11:32:01 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/dennis/percpu.git for-5.16-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8f97a35a53e2afc0a2485b2d976e12492563a318

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
