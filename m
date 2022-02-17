Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 235BC4BA890
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 19:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244509AbiBQSmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 13:42:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244500AbiBQSmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 13:42:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A747EDFE1;
        Thu, 17 Feb 2022 10:41:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 88D6E61B83;
        Thu, 17 Feb 2022 18:41:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E4A13C340E8;
        Thu, 17 Feb 2022 18:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645123307;
        bh=zPXGLyQABZXQ8tHOqgxvjFHnUe5zxCmVg5uIV2tzmVM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=HLJpFpQFqC44p+gOkjYhj3CBXxxohepzPgSWp4Dh9fKM5rbV+SKmJHMXWHOsvzyUw
         1lKghm/NYETvdDs6y9EPJmp3FtXK9c89WFlLFjk6BJpEB1J0VDtsD0iQ7zbSxm6FYW
         s2PtyxkNYhXfvbJwjkkjWGI9vpDLUNB0mrSJ4vgohgf+roTbhpu5h3dWPIWczQp66Y
         QjhghOqn3jDgKc3QtBxVryjBxU/VmFVAbKzCJhtaykxkqv5T9vXbZVDhxDQwBvwrac
         uFIH1PXtF2gamA/8O3Qquleo3DQV0bQwS7af+m4s/54neXAYAwUFlU6mC5ILHpSZ+w
         Q47lQt80quklA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D1EB6E6D447;
        Thu, 17 Feb 2022 18:41:47 +0000 (UTC)
Subject: Re: [GIT PULL] perf tools fixes for v5.17: 2nd batch
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220217153627.308659-1-acme@kernel.org>
References: <20220217153627.308659-1-acme@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220217153627.308659-1-acme@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.17-2022-02-17
X-PR-Tracked-Commit-Id: 31ded1535e3182778a1d0e5c32711f55da3bc512
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2dd3a8a139082679b7a73fc32596aa667b0841d1
Message-Id: <164512330784.3768.5230087658793621678.pr-tracker-bot@kernel.org>
Date:   Thu, 17 Feb 2022 18:41:47 +0000
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Changbin Du <changbin.du@gmail.com>,
        German Gomez <german.gomez@arm.com>,
        James Clark <james.clark@arm.com>,
        "Justin M . Forbes" <jforbes@fedoraproject.org>,
        Kees Kook <keescook@chromium.org>,
        Rob Herring <robh@kernel.org>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        =?UTF-8?q?Valdis=20Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 17 Feb 2022 12:36:27 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.17-2022-02-17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2dd3a8a139082679b7a73fc32596aa667b0841d1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
