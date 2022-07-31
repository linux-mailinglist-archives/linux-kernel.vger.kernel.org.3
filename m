Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7D9D586004
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 18:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236999AbiGaQ4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 12:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236937AbiGaQzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 12:55:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F336472
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 09:55:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D96EEB80DB4
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 16:55:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 857EEC433D6;
        Sun, 31 Jul 2022 16:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659286548;
        bh=vk/5v/etr2AWVlX0WBCMwY/MMz3J/OQvlQSOKHnZQcI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ni0SGpYtr2Jwzz5z9shQS56CqdI5UmocNqwP0zWc0lkW9KpaAlLYoVMjB5p+9SaLj
         N3KTxPHclIw2/drWB2tSKtvVu+3ADvPCAxc3GwOemCCr70I5SLuXW0TNMGgpm369s6
         JsMraXY8NfoOw8X6lQurOJ8eL1qiMDEET90qRD2vU9xd7g2Yxc+3GJAjbgIRuwXktC
         +EwpSo5g718Y2pbvaMtdWkZD3u5nznxWiWEk+RHvYbm+WwUT2e0x4fjFy+NfAQJ7iD
         TVj/yV5LPtTBhai3vpc69IljDHzxqQigr6joZWZslal0g2HgWemIV3Pp42AQtEobtL
         qysA/VfgrZvuw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 671B2C43143;
        Sun, 31 Jul 2022 16:55:48 +0000 (UTC)
Subject: Re: [GIT PULL] x86/urgent for 5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YuZYELRWE77M09c2@zn.tnic>
References: <YuZYELRWE77M09c2@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YuZYELRWE77M09c2@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.19
X-PR-Tracked-Commit-Id: ea304a8b89fd0d6cf94ee30cb139dc23d9f1a62f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 89caf575400a9296e45b7de97b07d2fbf249c1f5
Message-Id: <165928654841.8632.1633335365341452244.pr-tracker-bot@kernel.org>
Date:   Sun, 31 Jul 2022 16:55:48 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 31 Jul 2022 12:23:12 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/89caf575400a9296e45b7de97b07d2fbf249c1f5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
