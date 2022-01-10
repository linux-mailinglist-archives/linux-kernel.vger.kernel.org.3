Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D36F489F32
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 19:28:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240158AbiAJS14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 13:27:56 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:43638 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240141AbiAJS1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 13:27:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 789B7B80CA5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 18:27:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 24160C36AE9;
        Mon, 10 Jan 2022 18:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641839273;
        bh=sreBQKD5pUMhM2K3c/C/oNdpS1h8qXHVoF0eERG0ODQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=BXlkjCXNh9bN+ZlB3vgK5XOTILR4czjU/l43XDbaEMPI2u5GzCFILSa6wkq9BTLuz
         mhbSdQdBpv3oh+u/C4G16WKO0I1o4/TD1x94XA283x8Jb+VVNUt9ouJGy/N3nCxzp1
         DnCsV7P5bvKSr7Vn2+nLvZivwqVoHvR9ByjYjqw5DaISg4wWvZ4Hg6YXgQpclfP61L
         Ihzw4gONfZHrdegPJb2Iwf8AypH3gp+rgxXyMCxe5l4/mCFhdNhlvHM/SsBb5ywt1W
         QJk16ALgjdNKPksbPk12GnYEYinipVOET8f4nnSJdqvoZ9oSiVyLKZw+d39wNwj9JW
         1yWvnSjW60YuQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0F827F6078C;
        Mon, 10 Jan 2022 18:27:53 +0000 (UTC)
Subject: Re: [GIT PULL] m68k updates for v5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220110092303.1921532-1-geert@linux-m68k.org>
References: <20220110092303.1921532-1-geert@linux-m68k.org>
X-PR-Tracked-List-Id: <linux-m68k.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220110092303.1921532-1-geert@linux-m68k.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git tags/m68k-for-v5.17-tag1
X-PR-Tracked-Commit-Id: 1a0ae068bf6b6f4233b1f31bf48bcbc47b111ef2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8cc1e20765f03a29442484a9acbc97e31578af92
Message-Id: <164183927305.9673.627079502563652905.pr-tracker-bot@kernel.org>
Date:   Mon, 10 Jan 2022 18:27:53 +0000
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 10 Jan 2022 10:23:03 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git tags/m68k-for-v5.17-tag1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8cc1e20765f03a29442484a9acbc97e31578af92

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
