Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B186490228
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 07:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237258AbiAQGzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 01:55:04 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:52558 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237226AbiAQGy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 01:54:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E37EA60F3E;
        Mon, 17 Jan 2022 06:54:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5BC02C36AE3;
        Mon, 17 Jan 2022 06:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642402496;
        bh=BXSc7a9Hgg1FHTe+Jz80+kHLdYQzBI30yKAwwTF52cY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=X3TiqeKYTvHIeXovPPEl9PSJAB/VS3ABFmEtQOmf95OjCLzOsPPZn+Dviu1B6vOyb
         hdzIiFl6AQ5c49w4YIMZey6AiemSFgBTN/cqs2goO2vMmf1067XvkjZVIAgAMWJDnE
         XggGTZ/WoJIUPJiyD61ACb6HdO1GgEBLHoVoJglOa+otm2Iuri2nXgc39qwFpTEnJl
         +9h+X5Y5OnFGrZeXspJjBi7IPm+CJ0Y/TT7V5YXuE4YWAfIFRv+xa7u6s3b7YQKnbf
         2TFB5DAznVYd1YYjrEwNoitiXHOFYvrRYiUmA9X4exNoxVOqaVpJAZ+DPvcMsISQ2X
         OdiiFId44RMfQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4C23CF60799;
        Mon, 17 Jan 2022 06:54:56 +0000 (UTC)
Subject: Re: [git pull] Input updates for v5.17-rc0
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YeSXOaSWDSjMykUO@google.com>
References: <YeSXOaSWDSjMykUO@google.com>
X-PR-Tracked-List-Id: <linux-input.vger.kernel.org>
X-PR-Tracked-Message-Id: <YeSXOaSWDSjMykUO@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus
X-PR-Tracked-Commit-Id: 762f99f4f3cb41a775b5157dd761217beba65873
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b520085ca57982c4beeb9bb64b8f6018425cb61f
Message-Id: <164240249630.26213.2634367834819604424.pr-tracker-bot@kernel.org>
Date:   Mon, 17 Jan 2022 06:54:56 +0000
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 16 Jan 2022 14:07:53 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b520085ca57982c4beeb9bb64b8f6018425cb61f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
