Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74AC258B118
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 23:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241516AbiHEVZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 17:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238057AbiHEVZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 17:25:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A551900E
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 14:25:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B50761378
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 21:25:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6B80BC43140;
        Fri,  5 Aug 2022 21:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659734731;
        bh=Z2WWRv1Ztn1rlMDu2F+5abtBA5cozDQA/ypl6T4vWZY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=aDEJla8AuYFMdzkup3RA9LjdS+WcjZX6UWKl6SlXFR31tXchOPBWGEUlOc6KqadZo
         1R8Lr9WLAM/GgxJuhOTiIAZW6fnNK55XaoAZ76vaWNjq2d3Ilm4VZie7ot+u20xyhN
         3+NaGTdTyjS9x5SlK3zI9Qt7z4h8sLEvH6eUzS4sEdw7ndGCjrCaOKRNzrSCVKclRk
         ab7Qqhb5ycFfC6QfkH+48k2MpFJGB5dWTVemlWy6/jl0JDiDvazMZiHc6vVNgreks+
         uFuXORSGhr+APA63skDn4PqD0pyD8uHu5V4zZAgxEHKvGaOVwE7Zt6+FXZaW/A1411
         Lk7NtrohRSAnA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5BDDAC43140;
        Fri,  5 Aug 2022 21:25:31 +0000 (UTC)
Subject: Re: [GIT PULL] UML changes for v5.20-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <922167294.69837.1659732974689.JavaMail.zimbra@nod.at>
References: <922167294.69837.1659732974689.JavaMail.zimbra@nod.at>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <922167294.69837.1659732974689.JavaMail.zimbra@nod.at>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git tags/for-linus-5.20-rc1
X-PR-Tracked-Commit-Id: af3e16101cee95efaa72095fe06c15ec0b8eb195
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 79b7e67bb9747e621ff1b646a125fbea26e08d56
Message-Id: <165973473137.8747.17310204893733280575.pr-tracker-bot@kernel.org>
Date:   Fri, 05 Aug 2022 21:25:31 +0000
To:     Richard Weinberger <richard@nod.at>
Cc:     torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 5 Aug 2022 22:56:14 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git tags/for-linus-5.20-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/79b7e67bb9747e621ff1b646a125fbea26e08d56

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
