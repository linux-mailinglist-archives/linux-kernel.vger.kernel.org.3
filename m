Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0762E539A46
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 02:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348779AbiFAAG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 20:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348803AbiFAAGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 20:06:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BB3BC2A
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 17:06:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 27F11B80FAF
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 00:06:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E3AB4C385A9;
        Wed,  1 Jun 2022 00:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654042006;
        bh=RiVUJJLunPlLqWnhgLpalKLVOijp1W5uMB+tbZrPNac=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=d9bJ+xV/inPblrTPSCKtRFUUzEJ1Aq8uavUzaBWZaGpbel7YNL8nhTvIVDl9jDp0o
         UttHbQpoqMDnkiJV3NJqaCSYRjMOsYKnq+GjXSNu9hN4oWyzaBYa7m0tDabnt5N/M8
         1p/cMdG9x4Qcb13qmPfp/vEYgtXYBFogMhrGdRs21yZPC8Pzoi71ISAVxhhQXH/vNp
         4FO3Jw9angXYp7zLLxYRhWgXiImst0dWvjN1qm5OOm5Fi/y9b1vPgqarr+DWP0YYFu
         KlrcmG7e3ACNcNHd0BqvD1TTbs0QYjrWoipCSJ5RA3nzSf8FE7E2AOHNsBTI6U1jYP
         3e+k0Gl3TlhLg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CF3E8F0383D;
        Wed,  1 Jun 2022 00:06:46 +0000 (UTC)
Subject: Re: [f2fs-dev] [GIT PULL] f2fs for 5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YpaCSoxxcWCqo8FQ@google.com>
References: <YpaCSoxxcWCqo8FQ@google.com>
X-PR-Tracked-List-Id: <linux-f2fs-devel.lists.sourceforge.net>
X-PR-Tracked-Message-Id: <YpaCSoxxcWCqo8FQ@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-5.19-rc1
X-PR-Tracked-Commit-Id: 2d1fe8a86bf5e0663866fd0da83c2af1e1b0e362
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1501f707d2b24316b41d45bdc95a73bc8cc8dd49
Message-Id: <165404200684.13836.6267424984494989209.pr-tracker-bot@kernel.org>
Date:   Wed, 01 Jun 2022 00:06:46 +0000
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 31 May 2022 14:02:02 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-5.19-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1501f707d2b24316b41d45bdc95a73bc8cc8dd49

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
