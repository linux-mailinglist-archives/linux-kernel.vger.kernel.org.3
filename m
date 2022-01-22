Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A750D496B84
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 10:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234246AbiAVJkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 04:40:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234209AbiAVJkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 04:40:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C65C061401;
        Sat, 22 Jan 2022 01:40:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D549F60C42;
        Sat, 22 Jan 2022 09:40:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A92B3C340EB;
        Sat, 22 Jan 2022 09:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642844415;
        bh=MOXNN6+9zF4Ah4Pruz4Jj3fw/AZzwy+ohbgpgx5w38g=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=iraf5GWhQCR9OIp0s8aYF7tsuCra0btgYeo3QKvnrVUropNiZy44t3GCYAJ36LOc8
         dXOySWigGVkPundGvwA78MlyZjSTZr5rj1l0kYe6gXqfAIJIV5sAaZQytRV67az1Fr
         s+5hGt5midyhRKvi87r4Oy936dWpPteWHvoo+ijb0UvqJ5p1WeLFyXYFDKt+hrBuDM
         zv5h9lxr6sUapFDCcRyScn8/NGx3ROTIX9KjhBTXH+MSNtQRstts0wzpNMO8PhXt5O
         JbAd1I6OYFfzEowHQsehmgFIkJslM60BDho1wOM19M5rgDY+Ya9QJ/2TfM1CWkSlIw
         yeaswEh4DaFpA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 981CAF60798;
        Sat, 22 Jan 2022 09:40:15 +0000 (UTC)
Subject: Re: [GIT PULL] smb3 fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5mvb8d_mo+tEhQ+rXE33zgixiq5YiFyapcMEzEd6bXqf2Q@mail.gmail.com>
References: <CAH2r5mvb8d_mo+tEhQ+rXE33zgixiq5YiFyapcMEzEd6bXqf2Q@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5mvb8d_mo+tEhQ+rXE33zgixiq5YiFyapcMEzEd6bXqf2Q@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/5.17-rc-part2-smb3-fixes
X-PR-Tracked-Commit-Id: 51620150ca2df62f8ea472ab8962be590c957288
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8205ae327e396820fb7a176a94768146ac0b87ea
Message-Id: <164284441561.7666.8847091032449578335.pr-tracker-bot@kernel.org>
Date:   Sat, 22 Jan 2022 09:40:15 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 21 Jan 2022 23:51:11 -0600:

> git://git.samba.org/sfrench/cifs-2.6.git tags/5.17-rc-part2-smb3-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8205ae327e396820fb7a176a94768146ac0b87ea

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
