Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 477724960B7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 15:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381054AbiAUO1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 09:27:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381051AbiAUO1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 09:27:24 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F8FC061744
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 06:27:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D326FCE23A3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 14:27:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2D6C0C340E1;
        Fri, 21 Jan 2022 14:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642775241;
        bh=xcxaETSFDuTs0Gf8xaRDyF3tmWP/+IIRFd0KLhuIy5w=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=hapuRhNgd5bUF5ylzslT3q57lItNgKkBVlNnpWP98PgQWu10oOuIVfctqdeOtzxwq
         83ul2jpppJFoZP3tBEwMc1K5kkWtPeTFM8Ghmhl2+dtIL6/pZg8iW7DMC+yVgSvJIH
         slHuhrkZDq7PAWQcdFFjXhA/sh+0TJOUIktYi6FcW2KULmpo+c3Vt+bxMMxAQwzVo4
         NRyZTRMEm7DkhXQrt4vsCiNZ9C/IanoHYecHYkh+FZ1ZuM6EZpvYtcDdbCrAwOz52E
         Hah90mgfFU/JeMdxXxsAcIYrjjh6jVGchyJpNvMvo56Wx2QMN7SQl/IXwQporjarNZ
         COUmPVK2CX9ig==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 14691F60798;
        Fri, 21 Jan 2022 14:27:21 +0000 (UTC)
Subject: Re: [GIT PULL] HID fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <nycvar.YFH.7.76.2201211513260.28059@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2201211513260.28059@cbobk.fhfr.pm>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <nycvar.YFH.7.76.2201211513260.28059@cbobk.fhfr.pm>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus
X-PR-Tracked-Commit-Id: 20f3cf5f860f9f267a6a6e5642d3d0525edb1814
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9b57f458985742bd1c585f4c7f36d04634ce1143
Message-Id: <164277524107.13796.997183501352295347.pr-tracker-bot@kernel.org>
Date:   Fri, 21 Jan 2022 14:27:21 +0000
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 21 Jan 2022 15:17:30 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9b57f458985742bd1c585f4c7f36d04634ce1143

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
