Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF5053D3D9
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 01:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349679AbiFCXZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 19:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349739AbiFCXZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 19:25:05 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BBC1F620
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 16:25:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2D167CE253B
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 23:25:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 56A38C385A9;
        Fri,  3 Jun 2022 23:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654298701;
        bh=6UHUqQdzkTj73A96QlRsG/2L/VVa49Rs5IzIFnm9O/4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=T2jYltGAgHZP1k0F85gmYoQRb6jOppkwBft4PeesB0wbCR6Lx/Pr+r8bsT7dOvcVo
         11mFtZ5QYV+G2yNnys6wYroJ8ve0GlF66cRErmNRhVr4enu9sYEP88nbPxwYoPoVdB
         nWjDhbedschgo3Fkb/ayazkMLoP36ZsQbffjpkGN/tobFYUxHkbGB1QDBd+GVNuLfy
         MfELpLL/heTTNIUpnwOL9dorWFyH2/utl7+jj+YU+B2V89VEJOTKTt4lJQ5nWVsbgL
         Qm6srEfBmpaNiz8p9ioPOFJpzbbHPyPZBjnvXEvlz9EBFynRuZyKXvMmxOG3ZaaKr1
         sT0lHAhN2I2Kg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 39323F5F176;
        Fri,  3 Jun 2022 23:25:01 +0000 (UTC)
Subject: Re: [GIT PULL] ipc: per namespace ipc sysctl changes for v5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <875ylh8xxx.fsf@email.froward.int.ebiederm.org>
References: <875ylh8xxx.fsf@email.froward.int.ebiederm.org>
X-PR-Tracked-List-Id: <containers.lists.linux.dev>
X-PR-Tracked-Message-Id: <875ylh8xxx.fsf@email.froward.int.ebiederm.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git per-namespace-ipc-sysctls-for-v5.19
X-PR-Tracked-Commit-Id: 38cd5b12b7854941ede1954cf5a2393eb94b5d37
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1888e9b4bb78c88514b24ecafa9e4e4faf761747
Message-Id: <165429870122.22913.6194143729922958016.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Jun 2022 23:25:01 +0000
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Alexey Gladkov <legion@kernel.org>,
        Linux Containers <containers@lists.linux.dev>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 03 Jun 2022 12:21:46 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git per-namespace-ipc-sysctls-for-v5.19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1888e9b4bb78c88514b24ecafa9e4e4faf761747

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
