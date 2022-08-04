Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBEFC58A35D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 00:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240178AbiHDWqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 18:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239916AbiHDWqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 18:46:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB800C24
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 15:46:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9BD08B826E4
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 22:46:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 69B14C433D6;
        Thu,  4 Aug 2022 22:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659653163;
        bh=QwWGxEGYpivv/q9IQZQYPUVVnG6Oj48r558KUSTiG/o=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Uolp0NKohRLr+hagc8vZHgfMaagDoG4NiVdLCHfLSi96W+ZFHw+N1w3ly+/dRAFDi
         FvWYUpNKeaFIUDjSb/xBdc6/LztOyTV4YAk4LNIOzZqmb/IXAASZOZXjoa5eY/8nWz
         SjtThDM9MM9Bi3v0g/MUasjbAi2Lk3FzgYJhfmyX84ERFKVG56Ws4cTtQMEzzbQema
         V8JuyFSO5yN2ialzeySZlI0we8BZvlw88uCE5geES4PMOmOMybCe6hUAm4yDziOVZu
         LEDs4suC67+4DW/xJ5he7OOX5IMj0cY+0oMphE6TCh5LA9r3rUgqzRC+pZNamndoVr
         W22GyqJC+HjgQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4F6CCC43142;
        Thu,  4 Aug 2022 22:46:03 +0000 (UTC)
Subject: Re: [GIT PULL] xen: branch for v6.0-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220803075226.2400-1-jgross@suse.com>
References: <20220803075226.2400-1-jgross@suse.com>
X-PR-Tracked-List-Id: Xen developer discussion <xen-devel.lists.xenproject.org>
X-PR-Tracked-Message-Id: <20220803075226.2400-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.0-rc1-tag
X-PR-Tracked-Commit-Id: 251e90e7e346a23742b90e2c4db19d322e071d99
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7447691ef994ffd8072809a11ca9167a2d91564f
Message-Id: <165965316331.20279.7058969435031457273.pr-tracker-bot@kernel.org>
Date:   Thu, 04 Aug 2022 22:46:03 +0000
To:     Juergen Gross <jgross@suse.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, sstabellini@kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed,  3 Aug 2022 09:52:26 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.0-rc1-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7447691ef994ffd8072809a11ca9167a2d91564f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
