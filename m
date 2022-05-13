Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55A95526C62
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 23:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384703AbiEMVjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 17:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384692AbiEMVjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 17:39:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2653454BED
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 14:39:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C3782B831E4
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 21:38:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 79519C34100;
        Fri, 13 May 2022 21:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652477938;
        bh=uls0Cs7a/Pq03jujmH7qyme26hYYsttE4InpYcX4XM8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=bCw9L/nHBxvmBN+gCwdn57XC9erRsWoyPAI+934a4w7QPRsPpKyFNzBCi/gIMWd1F
         B/VBeD4H2iHZzL7CIcozQgdDce0Wwv9cULFlLHRCp9xf7HAgirUoMxe0kBqzsfJmtW
         5elWLR4sMDsXkLh4w8nCpc2vSMqKL18fhpqI+5MpfIuL8poFqCsJWz+5Kwvnd7D/KW
         u5o2D44BNtgumu0jwDH+EmOazsRqVDogpemUaYbAXQpZpchD5R46uvxu0h8sr1EqLq
         ao1/2/UJaK6YPwj1cwAoZXzllcMjTgtqZTSbdb1puytGI8dgPDr8eip1a6wpCPb+hV
         KdNuUdegD8mOw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 64A72F0389D;
        Fri, 13 May 2022 21:38:58 +0000 (UTC)
Subject: Re: [GIT PULL] gfs2 fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220513210710.4124506-1-agruenba@redhat.com>
References: <20220513210710.4124506-1-agruenba@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220513210710.4124506-1-agruenba@redhat.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v5.18-rc4-fix3
X-PR-Tracked-Commit-Id: e1fa9ea85ce89207d2ac0316da35a4a7736801f9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d928e8f3af38abc8d2d56d9329a8280f7af5f10e
Message-Id: <165247793840.10019.8065611897082120198.pr-tracker-bot@kernel.org>
Date:   Fri, 13 May 2022 21:38:58 +0000
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 13 May 2022 23:07:10 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v5.18-rc4-fix3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d928e8f3af38abc8d2d56d9329a8280f7af5f10e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
