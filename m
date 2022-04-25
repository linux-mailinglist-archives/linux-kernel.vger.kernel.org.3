Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7A0D50E7AC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 20:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244184AbiDYSC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 14:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244167AbiDYSC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 14:02:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B7610772E
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 10:59:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E78261628
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 17:59:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D3042C385A4;
        Mon, 25 Apr 2022 17:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650909589;
        bh=CMsi/XNPu5s69QtgKwOQHpzQ+ml8kfcgdzDF2vVjX+k=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=GNX11SRn9NE+uGSn6prin2vKZlR7tNap1d7PfxBFhXzubyJs9z8CMvqg9MYbnt/Y3
         /lOefT0rQPFo2NMMGGXoKemLBemsLIuVwYqyGtmEPcKyX/O1W/Oox/YYkabP5jMQyD
         E9+FF2p3OYkq0RSKnLPMHZP/PTxoDG7PbRQFFSgkL7pbLatHpfuoJ0YazPyB63yaBA
         CJbhFZpq3ua0Eyj/kS/vOro9jV8JT5zEGJr/QqyFEi+AMUFumr7Ja/5um3103/etLk
         sBepqhU0wtUJIFG5GJkFkzTs6+BYgGY61rTDPYBuG2oZz7AYfJlqgQW/N9jBE6iuJZ
         remoG4mnfGihQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B98BCE6D402;
        Mon, 25 Apr 2022 17:59:49 +0000 (UTC)
Subject: Re: [GIT PULL] f2fs fix for 5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YmbSOkjjP5ekfcGk@google.com>
References: <YmbSOkjjP5ekfcGk@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YmbSOkjjP5ekfcGk@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-fix-5.18
X-PR-Tracked-Commit-Id: 4d8ec91208196e0e19195f1e7d6be9de5873f242
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d615b5416f8a1afeb82d13b238f8152c572d59c0
Message-Id: <165090958975.5171.9135856472795292094.pr-tracker-bot@kernel.org>
Date:   Mon, 25 Apr 2022 17:59:49 +0000
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 25 Apr 2022 09:54:18 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-fix-5.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d615b5416f8a1afeb82d13b238f8152c572d59c0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
