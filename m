Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E97C489F39
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 19:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241908AbiAJS2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 13:28:15 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:39290 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241536AbiAJS15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 13:27:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 59216610E8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 18:27:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2D8D5C36AFF;
        Mon, 10 Jan 2022 18:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641839277;
        bh=OnPt0sGPuFvdpM6WsNjofwx9CRNaL8fEKRwpvb9qqhk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=l+/+H7Zl4VCTOpsMTqWyc+ENpYobjICCjLduyhNG9s6y5zY/SkBivIY2RlSCiEaBd
         mEr1ZDoFDCupdJbfCaLSsUUziYMWWkLBwIWJxT4mjQCkfCw5P+9r7TLAjQTpPaF4kz
         rIySa934NWoGTg9UdgBZnqI5OgG9teKyR6dmnyFCIMPffOD1qcevctB3WhE5962cFR
         fZzIV6udUNlqUs3zIdFnohOlci7EOm80w1U0Rwx0aOC4T+8I3G3tnA9b1PgSZg5taQ
         bRe6U12AJK7RZcNuE0d8+ymAbR+uG4d3gRY+cObA+IWhNxIReu+EpAAqUZnoPjRRXm
         VAAScfDsiWuEw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1C978F6078C;
        Mon, 10 Jan 2022 18:27:57 +0000 (UTC)
Subject: Re: [GIT PULL] x86/cpu for v5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YdwVl0H54fmUIux0@zn.tnic>
References: <YdwVl0H54fmUIux0@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YdwVl0H54fmUIux0@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cpu_for_v5.17_rc1
X-PR-Tracked-Commit-Id: 244122b4d2e5221e6abd6e21d6a58170104db781
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 25f8c7785e254779fbd2127c4eced81811e8e421
Message-Id: <164183927711.9673.15206748588528750182.pr-tracker-bot@kernel.org>
Date:   Mon, 10 Jan 2022 18:27:57 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 10 Jan 2022 12:16:39 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cpu_for_v5.17_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/25f8c7785e254779fbd2127c4eced81811e8e421

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
