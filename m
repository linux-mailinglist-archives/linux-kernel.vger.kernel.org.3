Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4571A496AE5
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 09:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233833AbiAVIGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 03:06:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbiAVIGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 03:06:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2866C06173D;
        Sat, 22 Jan 2022 00:06:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8108460B5F;
        Sat, 22 Jan 2022 08:06:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E83C2C340E2;
        Sat, 22 Jan 2022 08:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642838800;
        bh=Inymk304iL4uagniKsNcpmh82p7wZK5rrLaS4Edg5XY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=dW4P2A04SW9f7l64+9Cf9h0PGp3xB2JCajH26TeO30CPIC+0d1FoVie5dLWA0VPb6
         lglJmRhUPzn/Ons7tO6AcvuJ5GhOf3VDEv+jWAlY060CkP5vskl5dmI15gvDPxz9Kr
         h2PRZHUSEtXtf67DzQUvi/YYpetgkPv1Mq1kuBNEcAVgF90vhhexIj/pfp92jSLHjQ
         /LRgS40S2pijeeB5MqMLo70NO8E4cQsfTOknU9ijZjF92xKvpZb87iI4h9vY4Rjsqk
         0QBsSDk5F3qQREK4oBLZ1D/V7oA4oaJplY01Cmm8/VXY4mI/NFQtYeAT6HrHJlfXlM
         XPyzrV39eoRsQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D5652F60796;
        Sat, 22 Jan 2022 08:06:40 +0000 (UTC)
Subject: Re: [GIT PULL] Devicetree fixes for v5.17, take 1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YesPMjmwx4snvWDQ@robh.at.kernel.org>
References: <YesPMjmwx4snvWDQ@robh.at.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YesPMjmwx4snvWDQ@robh.at.kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.17-1
X-PR-Tracked-Commit-Id: 18a86e5907f7160fb548d0d717e0f842b310708a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0809edbae347a224ca1b59fb8be1c2d54389c2c6
Message-Id: <164283880086.17909.1671339252918276759.pr-tracker-bot@kernel.org>
Date:   Sat, 22 Jan 2022 08:06:40 +0000
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 21 Jan 2022 13:53:22 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.17-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0809edbae347a224ca1b59fb8be1c2d54389c2c6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
