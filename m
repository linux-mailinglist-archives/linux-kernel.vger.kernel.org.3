Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99D5048A6EA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 05:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348112AbiAKEy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 23:54:56 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:35330 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347985AbiAKEyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 23:54:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A58CF61499;
        Tue, 11 Jan 2022 04:54:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 14899C36AEB;
        Tue, 11 Jan 2022 04:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641876894;
        bh=4lmvbxlGVnJ4vi/qH5S2V4vENzmMOOC0Y23Z2O8dJHs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=GEWMBn2bnJzIS+tzZuNV7QgXTc1+bwucz0MDRzlXYymeZfDxeRVVi5e2AYlzz6hp5
         KC/CJhm8F1aNpCL5BKBHpCOAgxwFEhOs8Onb+M+OsKrRuVVMaQRCl2UHJqSPlcvlDF
         Sek6DZOaOOh3cDbaPsIWU9xySAh4XMEEkrl3S6pu3rI50o2w4JuCjwtnnH5EYnPqIb
         LiCgA+lk9ecQ3SWppMsQ5jhQf8ntYcBgsAhs/tXMY7cxcPkJqQpiv0tn4HS3LhtIGK
         8vzBA3Ejn75aTNgzstNDzfhBY0qtzE0jlzKThpe5pu9j5EsUqMCrB0XtWTjrv7VOHB
         ZsUhWDSCfr15g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EABB0F6078D;
        Tue, 11 Jan 2022 04:54:53 +0000 (UTC)
Subject: Re: [GIT PULL] Power management updates for v5.17-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jHk1fP=V_iDGKVOeYg4xt-EEdgi5UUtQA4_qrQvUibNA@mail.gmail.com>
References: <CAJZ5v0jHk1fP=V_iDGKVOeYg4xt-EEdgi5UUtQA4_qrQvUibNA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jHk1fP=V_iDGKVOeYg4xt-EEdgi5UUtQA4_qrQvUibNA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.17-rc1
X-PR-Tracked-Commit-Id: 78e6e4dfd8f0cbb477a6f9571123edcbd5873c28
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b35b6d4d71365fbfb6f2cc8edc331b3882ca817e
Message-Id: <164187689395.26750.16214054039501570191.pr-tracker-bot@kernel.org>
Date:   Tue, 11 Jan 2022 04:54:53 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 10 Jan 2022 20:16:29 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.17-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b35b6d4d71365fbfb6f2cc8edc331b3882ca817e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
