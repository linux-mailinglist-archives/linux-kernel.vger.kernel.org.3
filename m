Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA31E489F3F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 19:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240292AbiAJS2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 13:28:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241576AbiAJS15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 13:27:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA7FC061748
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 10:27:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E35B561355
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 18:27:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5874EC36AF7;
        Mon, 10 Jan 2022 18:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641839276;
        bh=Fg6//NWM6F1cYwTHpouk0ALa9mQTzvNphTIcIETGM5Q=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=DBGOGkHxTxClXxrtiKaJ+cBB080+0psiupX591CIHpCnE7QbiOLgiOge7Y61gTSVb
         eTARyZ8KM+gn9dAbHG1NXiJCxUwi2g8I7O9xtvszid3Tffhs5QP08L9ZPr7V/JG6t9
         xBeaZHsz8xHHOmh4JE09Uiaw9mttPeNZVyKtijfSrVYt950TMHuHsocfgvtUN0clUb
         qSmWNMii638NuB3nQ3MGpD5SVqOAqwyaQqykLszacXhmWnumb0fEtv3x84uY0fO4Kq
         2/1jfOQXOHSTPgbVF2wJJQUWJSVvulwWU9aNJXNXKR9tdf/wH54gjh5o9CQY7XU4kb
         q+rvDBFcPR7PQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 48A8CF6078C;
        Mon, 10 Jan 2022 18:27:56 +0000 (UTC)
Subject: Re: [GIT PULL] x86/sev for v5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YdwK1rME5ufAJdHG@zn.tnic>
References: <YdwK1rME5ufAJdHG@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YdwK1rME5ufAJdHG@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_sev_for_v5.17_rc1
X-PR-Tracked-Commit-Id: 20f07a044a76aebaaa0603038857229b5c460d69
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 01d5e7872c1c2c04f4fd419c9a4968e148efc5a0
Message-Id: <164183927629.9673.14717390175759908958.pr-tracker-bot@kernel.org>
Date:   Mon, 10 Jan 2022 18:27:56 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 10 Jan 2022 11:30:46 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_sev_for_v5.17_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/01d5e7872c1c2c04f4fd419c9a4968e148efc5a0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
