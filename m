Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7044BD11D
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 20:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244740AbiBTTug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 14:50:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244705AbiBTTuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 14:50:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D99A30F74;
        Sun, 20 Feb 2022 11:50:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3EBE660EF5;
        Sun, 20 Feb 2022 19:50:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A206BC340F3;
        Sun, 20 Feb 2022 19:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645386601;
        bh=ijCBOgMyfQavgxxWgULZqJ8TvKpR3ECAnBLirSQBA0c=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=C4uc6/kAIN/2KxCk/U6CD6e2+RrvjQdwm0udLVMfzoEJRyo2MTvnvvFIceK6EccR+
         XMeM0m+lkAYL5AjJFm0OCZ4uGxyOVteZ+oT7vjlQ42haEZEJA/OJoumQAWwVL86xRe
         NgaBn0O6f9mFzA6cg7nBnAeqESA4vcWpmTjIrSvm/jaLy3xEz/cw/OR9xCs4ChzBpq
         qEKBUVDjdb6eClRcPsrXrx65heXb/YEtYEjGshihCT2RL86fAvSpqeZ2CyxP1rW9X1
         DITzUPzdZ6Rx00jriNrg4/AaIyltT3dzJZ28h8UDbCM5SDWvpNK7AJJAIJEwlJFswo
         bMPY4JYrCQvoQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8D246E6D447;
        Sun, 20 Feb 2022 19:50:01 +0000 (UTC)
Subject: Re: [git pull] Input updates for v5.17-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YhFw3yaB6CCihNEN@google.com>
References: <YhFw3yaB6CCihNEN@google.com>
X-PR-Tracked-List-Id: <linux-input.vger.kernel.org>
X-PR-Tracked-Message-Id: <YhFw3yaB6CCihNEN@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus
X-PR-Tracked-Commit-Id: 7b1f781f2d2460693f43d5f764198df558e3494b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 961af9dbe5d0d0f58aac989bac17279c17a43663
Message-Id: <164538660157.12071.324986509729735497.pr-tracker-bot@kernel.org>
Date:   Sun, 20 Feb 2022 19:50:01 +0000
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 19 Feb 2022 14:36:15 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/961af9dbe5d0d0f58aac989bac17279c17a43663

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
