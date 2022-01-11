Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1A0648B8F4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 21:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244803AbiAKUxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 15:53:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236657AbiAKUxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 15:53:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE4BC034002
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 12:53:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8036261749
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 20:53:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E8334C36AF5;
        Tue, 11 Jan 2022 20:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641934387;
        bh=LR/5iNvQTy2WLNEkrDGrIZJcf4eaBVCF4NOM/hbzNVg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=n9+WRPll5QzJvOidLZPQwV4bBaJvRkLUUM7DlniwdWIZuigEXHEqHngiSm01bWmra
         JXtNpvaNmjDmn4MBEatDadM2UXHnr97DMnLB5kPYdm2IY9HdiZZRjE5wDoQCvbwZyW
         utTMX0s5wbth+qLugRq9gM179dYhfqDY5NptDvMETklm1kDnyAaZBkUwDWibIGYhlk
         pJO8ibXsvuzX5brMeVUfbGeo7YvAiEp4N3NfmCknbR0LuOwuCBZedWzrWyD4cIoMMS
         rAODeexWUtTQJY/t2vOZ1RE7tERqwC0YrZLq8wnNJ9fmRqP2MdRV0XHkSDmBOTPx11
         NanlViCVKzkFQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D484EF6078C;
        Tue, 11 Jan 2022 20:53:07 +0000 (UTC)
Subject: Re: [GIT PULL] removal of trivial.git
From:   pr-tracker-bot@kernel.org
In-Reply-To: <nycvar.YFH.7.76.2201101025190.28059@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2201101025190.28059@cbobk.fhfr.pm>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <nycvar.YFH.7.76.2201101025190.28059@cbobk.fhfr.pm>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jikos/trivial.git for-linus
X-PR-Tracked-Commit-Id: 081c8919b02bc1077279cd03972d7ec6f53a6c6b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7db48b6b4a03c067159a1dbd8f917453ae3154cb
Message-Id: <164193438785.11435.15624796885787518837.pr-tracker-bot@kernel.org>
Date:   Tue, 11 Jan 2022 20:53:07 +0000
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 10 Jan 2022 10:29:42 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/jikos/trivial.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7db48b6b4a03c067159a1dbd8f917453ae3154cb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
