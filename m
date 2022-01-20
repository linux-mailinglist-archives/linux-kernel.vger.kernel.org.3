Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A06A4494D88
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 13:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232630AbiATL7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 06:59:35 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:38574 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232515AbiATL7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 06:59:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A07461696;
        Thu, 20 Jan 2022 11:59:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ABC78C340E5;
        Thu, 20 Jan 2022 11:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642679958;
        bh=2qU9RnOeg36g3oy9rAFadkNikwYk/1c//W1ZGYgXpcM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=c8BJB2k2PZ5IF4DJB07oKxTDqsVfP5OkM9l+vinb4G9CILSwxICHZPofR4yuJ+Nbb
         1ccKTHqBmSI1IbIqUfbyGzPE5zuyY2GkIvpsd0jq969M7K8gg/AoV0OnDOOb4g9YMA
         6dUSMiKSiC30oKboa9/IdxoCST+BCRf0ObQtW4n2Pabkv7kXvxZuLFlIXfBmKNizOx
         /nRvtXHuYEpy7v2J0CrBzOkLrdZOhqoovoF3h+5GOgX/U0goDioP/H+vTuB0lFuL9R
         ltywQu55BM41KJwt+EGF3rkycx4MbFBGUapwm5wuzd+vx+kF0ot2CS//2WywUA6GKV
         Caat5+FZpiLqg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 988BDF6079B;
        Thu, 20 Jan 2022 11:59:18 +0000 (UTC)
Subject: Re: [GIT PULL] ksmbd fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5mthCbxAM-OOjwK01YGiqU7SMexco1vgTFp6tcC-XHAbVw@mail.gmail.com>
References: <CAH2r5mthCbxAM-OOjwK01YGiqU7SMexco1vgTFp6tcC-XHAbVw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5mthCbxAM-OOjwK01YGiqU7SMexco1vgTFp6tcC-XHAbVw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/ksmbd.git tags/5.17-rc-ksmbd-server-fixes
X-PR-Tracked-Commit-Id: ac090d9c90b087d6fb714e54b2a6dd1e6c373ed6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 67ed868d23711e9cec9e8adb7ae5596ae76f7cbb
Message-Id: <164267995862.31408.1445718537502228207.pr-tracker-bot@kernel.org>
Date:   Thu, 20 Jan 2022 11:59:18 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 20 Jan 2022 00:14:38 -0600:

> git://git.samba.org/ksmbd.git tags/5.17-rc-ksmbd-server-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/67ed868d23711e9cec9e8adb7ae5596ae76f7cbb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
