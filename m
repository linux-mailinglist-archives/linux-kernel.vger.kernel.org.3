Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38BCB534329
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 20:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343957AbiEYSiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 14:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343982AbiEYShx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 14:37:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BAC9B8BD3
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 11:37:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E5364B81E9A
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 18:37:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 63809C34119;
        Wed, 25 May 2022 18:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653503857;
        bh=nLmCvqzwrCRLhLB0pozEcPV/2/UC6kozAFFDsAyZwDs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Ecf2JjwRgFwoFIuQ4WYGyDUFzZFl11gI5x0HpbQQGkD0Z9UZXA6wudBRmMupjk1jv
         BwSG5++jHsTSfroLDxHpY7OjHvD2wLUW2jMPVBHJEjXIsD2eiD4NfeBkkiYyblqdnS
         p6cKM69scwF4Mu3tpV2ZETgnHKSZxs6x85uiSvZKNDDBAO00BqLrhL+eVi1nU86mdG
         b5DQw67ByiqDX6jotlgReot9wYZcJwCkJ/Paxb822Ry/CGzCV9oaik0GOkBapS46Cp
         qZ2ob1Z8hMEgwx94WszzeeArf2PivClll7eimjKtHExanBlRXQVYDHPYlv6qzjwma1
         aiMQdGiwjHFFw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 51074F03943;
        Wed, 25 May 2022 18:37:37 +0000 (UTC)
Subject: Re: [GIT PULL] printk for 5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YouKQw72H7y9EJQK@alley>
References: <YouKQw72H7y9EJQK@alley>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YouKQw72H7y9EJQK@alley>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-5.19
X-PR-Tracked-Commit-Id: 1c6fd59943a630f087b4b3089aefdcb0bf43cca0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 537e62c865dcb9b91d07ed83f8615b71fa0b51bb
Message-Id: <165350385732.15754.13378378629917550984.pr-tracker-bot@kernel.org>
Date:   Wed, 25 May 2022 18:37:37 +0000
To:     Petr Mladek <pmladek@suse.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jan Kara <jack@suse.cz>, Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 23 May 2022 15:21:07 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-5.19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/537e62c865dcb9b91d07ed83f8615b71fa0b51bb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
