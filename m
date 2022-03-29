Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31A634EA437
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 02:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbiC2AhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 20:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbiC2Ag5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 20:36:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B46E1F42E0;
        Mon, 28 Mar 2022 17:35:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 380BA611B1;
        Tue, 29 Mar 2022 00:35:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8F46BC34110;
        Tue, 29 Mar 2022 00:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648514115;
        bh=L60BIW79LVLUEEwsaGZ5Is9uALy/nU0X+1gmyyV1z5A=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=XfO7PGnhPlAzcaa7oSPeZL45o5FDlvufsxtvteo+so0CEWWoyy+fyDWhXrpKvbBRL
         qxY+60IBq7UWM9votofVCJlHi1smWmuqAnxbaLczM45Uz9ZR5xi6YVyUuAqN0HVnGS
         Eih5jpJc1Ldimnwr+qJUD+dTZsNncxThBYCmY5On3LYB/FsZriKVBF2SO7rlq8WTSY
         aj4b0k0BaMSvGZuguxik4fnmqkenhKlWggfQp9F32tryZQ6S30hzq1XSQpcvq1cSAY
         y5InkgjKSHtz8Qs9tgO2+ZCCjxSBbR8LF2mR3M1/Dyly90AsKa+5KwJQfmuJmsU6gB
         845MEAwRNTy4A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7B22EE7BB0B;
        Tue, 29 Mar 2022 00:35:15 +0000 (UTC)
Subject: Re: [GIT PULL] ptrace: Cleanups for v5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87a6d9pr5t.fsf_-_@email.froward.int.ebiederm.org>
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
        <87bl1kunjj.fsf@email.froward.int.ebiederm.org>
        <87r19opkx1.fsf_-_@email.froward.int.ebiederm.org>
        <87o82gdlu9.fsf_-_@email.froward.int.ebiederm.org>
        <87tubyx0rg.fsf_-_@email.froward.int.ebiederm.org> <87a6d9pr5t.fsf_-_@email.froward.int.ebiederm.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87a6d9pr5t.fsf_-_@email.froward.int.ebiederm.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git ptrace-cleanups-for-v5.18
X-PR-Tracked-Commit-Id: dcbc65aac28360df5f5a3b613043ccc0e81da3cf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1930a6e739c4b4a654a69164dbe39e554d228915
Message-Id: <164851411550.5550.16805422072602586537.pr-tracker-bot@kernel.org>
Date:   Tue, 29 Mar 2022 00:35:15 +0000
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Al Viro <viro@ZenIV.linux.org.uk>, linux-api@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 28 Mar 2022 18:56:46 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git ptrace-cleanups-for-v5.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1930a6e739c4b4a654a69164dbe39e554d228915

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
