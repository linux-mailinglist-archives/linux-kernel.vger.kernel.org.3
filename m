Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03D5A5A3A68
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 01:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbiH0XHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 19:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiH0XHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 19:07:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB1429817
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 16:07:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C40560EE1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 23:07:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EE5D9C433D6;
        Sat, 27 Aug 2022 23:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661641642;
        bh=HuqGzKxcQA1Ixo+p4Rc0jwsx0rm9s4fod0Oc3zAx2DY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=rrMwyhrkzJBAtVmM7gDqFbzUclawMMGio3ZVr5UY3ssv10MgnhmEI56OMxbPEtR4R
         7dZC3+GecbTJu9av8QdzeNMtWcRbsbmo76BvVqplJGFL/TpXroJTJNJor6SwiY6b8d
         tw6m4gJFhATyOvGJ1MxIbH9zlb8HwjyYTV0SjiXeLWCIPC7jOrHRJY5SqwaLpvy0/n
         9knGb5668znYg68UdAGr/4vHK8/LuxVdQAHWuLYrnZ3aYo8wkUymeYNkdtLZ2Zg2l9
         EpNR4N8xv8CQ3ixoXyj8/OjKwtnG/V4crYD+wDklZu0n7fP1fuOcw2QnAMiuSXF7XK
         LQL1+ZdWjSwjg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DC69BC04E59;
        Sat, 27 Aug 2022 23:07:21 +0000 (UTC)
Subject: Re: [GIT PULL] Audit fixes for v6.0 (#2)
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAHC9VhTj1qHQ9gkrkay12AFv8rk8ttvaecP_NEBaSeN9xh2zEA@mail.gmail.com>
References: <CAHC9VhTj1qHQ9gkrkay12AFv8rk8ttvaecP_NEBaSeN9xh2zEA@mail.gmail.com>
X-PR-Tracked-List-Id: Linux Audit Discussion <linux-audit.redhat.com>
X-PR-Tracked-Message-Id: <CAHC9VhTj1qHQ9gkrkay12AFv8rk8ttvaecP_NEBaSeN9xh2zEA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20220826
X-PR-Tracked-Commit-Id: d4fefa4801a1c2f9c0c7a48fbb0fdf384e89a4ab
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 17b28d4267d9d9dd11d42eea1d41cd3f5f5a4273
Message-Id: <166164164189.8591.13179493970218141070.pr-tracker-bot@kernel.org>
Date:   Sat, 27 Aug 2022 23:07:21 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-audit@redhat.com, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 26 Aug 2022 15:43:17 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20220826

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/17b28d4267d9d9dd11d42eea1d41cd3f5f5a4273

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
