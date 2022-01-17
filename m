Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB9A49034D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 08:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237828AbiAQH7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 02:59:44 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:37588 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237817AbiAQH7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 02:59:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0FD61B80D94;
        Mon, 17 Jan 2022 07:59:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D9EDDC36AE7;
        Mon, 17 Jan 2022 07:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642406372;
        bh=mmzj9dpVCg2C3KTbHwA7845dduLVBNsb4+pJqQ6d+1Y=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=vQby8qQy3ccPt9P70D9NanCE4J11RhkS+PGJ98hOn8OLRF1A4k57lk7WPbWy2N/Tk
         8dNYmo1bDpe0+/TcjX1JcraJGR85gMjc5XD23+rNFWNYpbz8O86dNsvX+R6w3dT+Md
         GRv0pMm4XOwX+suargySs36V6b8T16ZW++lvmEh9tehO/Luo9ry4ZogCjf1gAw2sX5
         pd8Twk19pkpfEb+LiPT9h9U3hEI/NbDbGWtF3a4LeOSPx3XldN+RRPJkoGQKLhVJO1
         doVDaSvmsNKbIlz0xpKWv538tDV7htVtvx4an4nZTJP+GAX35gljPcz9ntUiEt641/
         +RntosnIfxqrw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CA1E1F60795;
        Mon, 17 Jan 2022 07:59:32 +0000 (UTC)
Subject: Re: [GIT PULL] cifs/smb3 fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5mu=D=hnvdUTnZg8fYYRUbnGkOLzzo667XxmbYw8ZOBTxA@mail.gmail.com>
References: <CAH2r5mu=D=hnvdUTnZg8fYYRUbnGkOLzzo667XxmbYw8ZOBTxA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-cifs.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5mu=D=hnvdUTnZg8fYYRUbnGkOLzzo667XxmbYw8ZOBTxA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/5.17-rc-part1-smb3-fixes
X-PR-Tracked-Commit-Id: 9bbf8662a27b56358366027d1a77c0676f85b222
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0c947b893d69231a9add855939da7c66237ab44f
Message-Id: <164240637281.28461.4512193926966376366.pr-tracker-bot@kernel.org>
Date:   Mon, 17 Jan 2022 07:59:32 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 16 Jan 2022 21:04:17 -0600:

> git://git.samba.org/sfrench/cifs-2.6.git tags/5.17-rc-part1-smb3-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0c947b893d69231a9add855939da7c66237ab44f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
