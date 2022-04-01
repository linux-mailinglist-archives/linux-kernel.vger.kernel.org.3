Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC5B4EFC57
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 23:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353123AbiDAVra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 17:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353072AbiDAVrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 17:47:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 241FD10F6D3;
        Fri,  1 Apr 2022 14:45:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BE10CB8267F;
        Fri,  1 Apr 2022 21:45:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6CE68C34111;
        Fri,  1 Apr 2022 21:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648849515;
        bh=IPYYKYLylRZtBz2LyI1nGJyhfLZOmj7SEKU6Hy+JgmQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=AFqzKbr4qwdV1DzMBVGFn5XQoFpLcyGeXqyFQ66+zptWLB1uTv/UUp2o44mtV0wds
         BjK1pi6bcbCc+3vx36l6riOXmXou5poUTnZGSmb5Mg92WAMUdndPq+XNG99Ea6OxA3
         mOsInBV/OAid+6c7FSocyrvuf7yovcVML+vpIUYH0+ThokpRBKrOZTKkboAT/xdaaf
         HZajxRa/epeYNWCEFN6pL5C8xuZVh/N8S09SciwNlDOpCFikhTBB5Ol+hKy5kaCIJr
         6tkjP8tvyv/sUO7PBaRBz3h/2Ck0IfrDLOswkrjQ1RMWvUEWqDz0ylyd9Cdhv1baSN
         QEGbtb/TjGWtQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 59256EAC09C;
        Fri,  1 Apr 2022 21:45:15 +0000 (UTC)
Subject: Re: [GIT PULL] cifs/smb3 fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5msKJPqE9sMpB2=_w9ZJQ8PAPhfD3CqpR5SKJkEFtTyaFg@mail.gmail.com>
References: <CAH2r5msKJPqE9sMpB2=_w9ZJQ8PAPhfD3CqpR5SKJkEFtTyaFg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5msKJPqE9sMpB2=_w9ZJQ8PAPhfD3CqpR5SKJkEFtTyaFg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/5.18-smb3-fixes-part2
X-PR-Tracked-Commit-Id: d6f5e358452479fa8a773b5c6ccc9e4ec5a20880
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9a005bea4f59b603c413ac1df19cda37aa3aa486
Message-Id: <164884951536.9554.14982273407524795396.pr-tracker-bot@kernel.org>
Date:   Fri, 01 Apr 2022 21:45:15 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 1 Apr 2022 11:15:30 -0500:

> git://git.samba.org/sfrench/cifs-2.6.git tags/5.18-smb3-fixes-part2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9a005bea4f59b603c413ac1df19cda37aa3aa486

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
