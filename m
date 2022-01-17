Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9B4F49011C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 06:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbiAQFS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 00:18:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231665AbiAQFS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 00:18:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A574C061574
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 21:18:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB72860DE5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 05:18:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 187B7C36AE3;
        Mon, 17 Jan 2022 05:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642396737;
        bh=KOpdHrP0D4tL/peYfXtHPXJeFSzxKLU+iXuIMPYYyN8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=nKDGJ3qF2Qig7p8cNu70Rykpw1U2tvFAurK1wlT3FgAcrdsB6RR0FEY1pQe2D3wOy
         lDpijOiI1nvzpAxSHON+JyseDO+sn5RBGl5IShHkOg0zjTAl+YVGvIUxAciKsP3eQV
         R/FkWLu2GKRcY4dUHEhLWhYXRXQXHWoFAc/0FccvLgiiSqN+q9rkat7kJItlLsZVhm
         PzKbnsEfrOXIG5CC5nje9N0jgrjB1iYbq2t8nenbNeMTsX8lYkfguJPF4FSHAz/aa5
         /I+hMwv9k2IWI5XSVnmaRUUge4U2pHlEsSzJuZeIAFsrXPPAtMuuLn96gvxQiBZVHg
         2GL9Qk9fppNXg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0767BF60798;
        Mon, 17 Jan 2022 05:18:57 +0000 (UTC)
Subject: Re: [GIT PULL] signal/exit/ptrace changes for v5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <878rvhlvh2.fsf@email.froward.int.ebiederm.org>
References: <878rvhlvh2.fsf@email.froward.int.ebiederm.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <878rvhlvh2.fsf@email.froward.int.ebiederm.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git signal-for-v5.17
X-PR-Tracked-Commit-Id: a403df29789ba38796edb97dad9bfb47836b68c0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 35ce8ae9ae2e471f92759f9d6880eab42cc1c3b6
Message-Id: <164239673702.10913.1885110574836270943.pr-tracker-bot@kernel.org>
Date:   Mon, 17 Jan 2022 05:18:57 +0000
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Alexey Gladkov <legion@kernel.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 14 Jan 2022 17:59:37 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git signal-for-v5.17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/35ce8ae9ae2e471f92759f9d6880eab42cc1c3b6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
