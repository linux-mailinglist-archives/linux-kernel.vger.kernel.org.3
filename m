Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCFB591485
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 18:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239632AbiHLQ7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 12:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239504AbiHLQ7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 12:59:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1CAB0B36;
        Fri, 12 Aug 2022 09:59:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1BFF16162D;
        Fri, 12 Aug 2022 16:59:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7DCF3C43141;
        Fri, 12 Aug 2022 16:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660323576;
        bh=dYfDkEXm2FVNmiIZ740z+gR6XQETJgauB7fNRq96f08=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=UdZ9C8/456PCqFFhB8pgG7t4Z4RVA/lfO93OaJLqs9FLe6QKZ2ncBgVC5VmX7EFus
         uqdznUQjwN0ZxyQmiHpK5MDXUndkL4U7A52NDxMgdBqG6wFfdSGPoCu3gKlWnP+UlD
         bdmvMiFqW4q7ZHyXc66M8DNM+bkPcD51DcrZu/mUHrKd6icwZrqSjnBU9Fb9e8EUxd
         PA4bPsihqds5tvSi6n/zx5h8dttnXNfUobwKk3EQBeGw2sQELJjOKXbFctrLejaXkr
         uz9Kl6swh2eBmYEwY1vh/5MtvxtbVu1wZE0d5SRSVIe0vrrGlIewHqDxi1QtDhfezg
         zPF8ijdCZv8Pw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 645A8C43142;
        Fri, 12 Aug 2022 16:59:36 +0000 (UTC)
Subject: Re: [GIT PULL] power-supply changes for 6.0
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220811232827.e4ib5raltkbacmgc@mercury.elektranox.org>
References: <20220811232827.e4ib5raltkbacmgc@mercury.elektranox.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220811232827.e4ib5raltkbacmgc@mercury.elektranox.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v6.0
X-PR-Tracked-Commit-Id: c9d8468158adca6dffd2ff5b1befd35f75568b10
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f7cdaeeab8caf8e42fc176cdb272944e036ad998
Message-Id: <166032357640.14629.17979609174109082646.pr-tracker-bot@kernel.org>
Date:   Fri, 12 Aug 2022 16:59:36 +0000
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 12 Aug 2022 01:28:27 +0200:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v6.0

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f7cdaeeab8caf8e42fc176cdb272944e036ad998

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
