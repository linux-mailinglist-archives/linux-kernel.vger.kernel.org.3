Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9500513BF2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 21:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351342AbiD1TGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 15:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346460AbiD1TGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 15:06:47 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A5665DA7A;
        Thu, 28 Apr 2022 12:03:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 86468CE2C22;
        Thu, 28 Apr 2022 19:03:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9776CC385B0;
        Thu, 28 Apr 2022 19:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651172608;
        bh=EqzvgrXitlc/gUxcBmlr2KBOeceP/Bxg+K4LKbcKrv4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Rpxgaq1DGU6kuE2yRUOK+xoBO8VFg3AEv9g742tsx/F79YiMUHoCa0/ARmPcsFTju
         1SsKWbduQn3Lj/ME48EQHyOpKnW+iOjjTvSYsY7k8N5BGAYaGNR8tsyf7FQ2gYAVNk
         I7D74+P6lILbIn/JOQyQJp1JanGTvtwYP7o7WA9A0WpNPgiQOI91WpyezS6rLZ3q1E
         fAw4vH0k+R41KoBzKmtfpmxaT7iqc/HXMZr3DpjEJZCDYKrl+MSi8uxheCSrJlmhSn
         lqYXDkTTdlmsBK0Eol7paFqQrH9As5bgpN3ahylPzHZShSIxsIpQAZL+VCI/aR+Owt
         R9SgHp2D2b6bA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7E1FBE8DD67;
        Thu, 28 Apr 2022 19:03:28 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fixes for v5.18-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jaMoSXJ-Q7w8Pduk9=3NyaWakdvQU2mBOPMM2vE9dTjQ@mail.gmail.com>
References: <CAJZ5v0jaMoSXJ-Q7w8Pduk9=3NyaWakdvQU2mBOPMM2vE9dTjQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jaMoSXJ-Q7w8Pduk9=3NyaWakdvQU2mBOPMM2vE9dTjQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.18-rc5
X-PR-Tracked-Commit-Id: edbd9772cc9d8af6c136d01d8b9402f6ab767e9b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 659ed6e2850c7df4eba838863325f6d71f437844
Message-Id: <165117260851.15527.8575331170857985877.pr-tracker-bot@kernel.org>
Date:   Thu, 28 Apr 2022 19:03:28 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 28 Apr 2022 17:32:36 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.18-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/659ed6e2850c7df4eba838863325f6d71f437844

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
