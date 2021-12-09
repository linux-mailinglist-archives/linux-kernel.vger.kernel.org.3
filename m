Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3140446F40C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 20:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbhLITj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 14:39:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbhLITjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 14:39:23 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F67C061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 11:35:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id AF0CFCE27F1
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 19:35:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0327DC341C7;
        Thu,  9 Dec 2021 19:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639078546;
        bh=qebjONMd/KUHzK5Bv2Jd7poplt+ehTXbiDU93qGM2hk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ktKedkfzOEMWXIgpsd8G1eFfPq7z2xKiq2GuKI9XM0C4cTjdqd0THgOBMO15dFrdO
         CdTAvsVPAyLB7yyfc01JnU216bLXtf+ECoQxzYsNITiiYGXHb5Qq7pWX7rrq0qfuIf
         OqaJLC1lKtTv1N/9jWP/XHWDrFYfSj65uGo9u5Vc33e/Xd5bElXkmrvPDVYDdJ7JES
         Et3iKbN9UQDU8kJSLGn7HC7n9McednFxZqItj33u3bkMLaGbSfFRB7PtM4oHHYKuZt
         NGVUmmseiw5XGaH42YkIRzUHrdSYQfvZw6uv/5UF7phJcIIBRYH74z525rpY688b5G
         husGcFzvXpYBg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id DD38B609B3;
        Thu,  9 Dec 2021 19:35:45 +0000 (UTC)
Subject: Re: [GIT PULL] HID fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <nycvar.YFH.7.76.2112091110510.16505@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2112091110510.16505@cbobk.fhfr.pm>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <nycvar.YFH.7.76.2112091110510.16505@cbobk.fhfr.pm>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus
X-PR-Tracked-Commit-Id: 14902f8961dca9c66bf190f7b1583767c97a4197
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 03090cc76ee3298cc70bce26bbe93a0cb50e42a2
Message-Id: <163907854590.11961.8867726111311795141.pr-tracker-bot@kernel.org>
Date:   Thu, 09 Dec 2021 19:35:45 +0000
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 9 Dec 2021 11:15:17 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/03090cc76ee3298cc70bce26bbe93a0cb50e42a2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
