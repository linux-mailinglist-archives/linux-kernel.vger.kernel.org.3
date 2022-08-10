Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFF4058F265
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 20:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233530AbiHJSeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 14:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233203AbiHJSdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 14:33:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F289B8C00D;
        Wed, 10 Aug 2022 11:33:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 56B846145D;
        Wed, 10 Aug 2022 18:33:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B64D4C433D6;
        Wed, 10 Aug 2022 18:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660156418;
        bh=7qK90/kn/gxyJyTJJTPr6rA6+HNihlzJiRT7wGzKqd4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=CSqp5kjNqsG+0brEj4OJIDUKO5z6KvXsfZMM44x69LT8Fxj14Q5yWbEe24BQI2+/5
         pUs8c4wFUP++ws6W4tgG8osZacNOJely/vDK7fICCQfAcKlOIRTEQkqqgqIeaUeXse
         1hK2rDYhrFvI2qBeb/9VGZ7DJbEb51oROcinU0xjBEYKSr5d6LDtFJIC2pt6PP+tT5
         ffz1zALeaO+t9T9QTM6rAGjSKScapuAO9bqPzvxHL+PGyJcLcTFNmq8Z+T5zTzQmu8
         4fVtLOM2IIKEoUIQODUMNVWFrLkVgwMNUl7bshfu+ZjEm+wkZQCBtjtP+QJohg4wAL
         ZSPRFjUML9bzg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A4497C43142;
        Wed, 10 Aug 2022 18:33:38 +0000 (UTC)
Subject: Re: [GIT PULL] remaining MM updates for 5.20-r1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220809181742.30eb3ee4071d2b8bb81bc959@linux-foundation.org>
References: <20220809181742.30eb3ee4071d2b8bb81bc959@linux-foundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220809181742.30eb3ee4071d2b8bb81bc959@linux-foundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-stable-2022-08-09
X-PR-Tracked-Commit-Id: a9e9c93966afdaae74a6a7533552391646b93f2c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b1701d5e29eb0a102aa3393319b3e4eb1a19c6ea
Message-Id: <166015641866.32353.16807249015696861.pr-tracker-bot@kernel.org>
Date:   Wed, 10 Aug 2022 18:33:38 +0000
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
        mm-commits@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 9 Aug 2022 18:17:42 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-stable-2022-08-09

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b1701d5e29eb0a102aa3393319b3e4eb1a19c6ea

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
