Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD074C5F06
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 22:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbiB0VXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 16:23:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbiB0VXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 16:23:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66FC941309
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 13:22:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 17445B80884
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 21:22:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BDD51C340F0;
        Sun, 27 Feb 2022 21:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645996953;
        bh=2E+sBOtdvNOvpDWBJDXpBwWhZyhXXZwwehXN78UGm+o=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=KAWF0jIJ4uD9pW0gJMIMmzK8/gpMvxxpGfjdMoq9vAvzH3/T10mpLI8KmfkntW0o8
         xBNK0SR5PGGgUAqnBLxvBGQuiF4IF154j5vTU+f308aAYzUbQP0RDH/0n7PJ7pkHbI
         T4uPdBIhMUCI913cMU3ZScrbZmI9z97YRhq8G22we5WHpQFOvafdg+gk8cOkY8VaHO
         10OKXzBbJx/odVeacS5yuwLJpXWUw1TbNlwhBClAUPZ1lORv1ujmjpCUpFfQrClki7
         7xyyPwfMWWuGJMTj20GaFGhZ4LzblkKHurCREM7Eb67G172eNdeavKl7wnJa/AUkm9
         fABSlF1PVGGwg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A347CEAC081;
        Sun, 27 Feb 2022 21:22:33 +0000 (UTC)
Subject: Re: [GIT pull] irq/urgent for 5.17-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <164595358628.38081.10035138977548213816.tglx@xen13>
References: <164595358628.38081.10035138977548213816.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <164595358628.38081.10035138977548213816.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2022-02-27
X-PR-Tracked-Commit-Id: ba1366f3d039e7c3ca1fc29ed00ce3ed2b8fd32f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 52a02554673122486ecb36c36387d91cf9544986
Message-Id: <164599695366.31011.9520850127949842475.pr-tracker-bot@kernel.org>
Date:   Sun, 27 Feb 2022 21:22:33 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 27 Feb 2022 10:20:07 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2022-02-27

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/52a02554673122486ecb36c36387d91cf9544986

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
