Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9A84EFE1A
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 05:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244440AbiDBDJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 23:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240357AbiDBDJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 23:09:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0C94993A
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 20:07:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0ED63B826A6
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 03:07:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CF0AFC34111;
        Sat,  2 Apr 2022 03:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648868867;
        bh=N6jLYX9TwpD3zz+z9klGFGHzcaegpMCej/lT9eFAzng=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=k+FvZfNLwYHHuOG3rAIgwLzQnCgYzsD6kNrajiNA/D1CspW+t1Gky86vjPDlB4oav
         Uoq7kRyyTggs7u0bHtWYztDPJA95bhMDqkuAbrRLB2y9oUK+nCCr4cQh+2+JEcmHoh
         nakBYOGs2bQpaW6KjJftZgwNIc0Tc9jXKqV0fvMMjQowyAObVTnN9jtcM4bfG6hgQk
         WMlsnP2PytRFWnc+Ti5kOqBG3h4+5JvsDN30YcRiqV5URMrFDS094Ooh7e2tyrQNRW
         myUd7Sznv7LLDD7avjyXcSHUtSoJ/uvzZ1dUVsshDutxkvWentrhlYqFpfftNKZ8RN
         IKJwkMwSTpWsA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BD8B3EAC09C;
        Sat,  2 Apr 2022 03:07:47 +0000 (UTC)
Subject: Re: [git pull] vfs.git misc stuff
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YkesUZwCNJcHxIv4@zeniv-ca.linux.org.uk>
References: <YkesUZwCNJcHxIv4@zeniv-ca.linux.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YkesUZwCNJcHxIv4@zeniv-ca.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.misc
X-PR-Tracked-Commit-Id: 61e02cdb6ac68a84f1bb95026632d63677f26202
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 88e6c0207623874922712e162e25d9dafd39661e
Message-Id: <164886886777.20951.15788748987405964482.pr-tracker-bot@kernel.org>
Date:   Sat, 02 Apr 2022 03:07:47 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 2 Apr 2022 01:52:17 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.misc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/88e6c0207623874922712e162e25d9dafd39661e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
