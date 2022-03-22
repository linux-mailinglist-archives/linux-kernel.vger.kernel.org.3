Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE0B4E37BC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 04:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236327AbiCVD6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 23:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236256AbiCVD57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 23:57:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015091F63B;
        Mon, 21 Mar 2022 20:56:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C16961295;
        Tue, 22 Mar 2022 03:56:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 01B63C340EC;
        Tue, 22 Mar 2022 03:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647921392;
        bh=KOpf2xpUGrjxWkL3lDijrUPJH4Qdd2P/xpeLYVwQEaY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=RY2FkVvgezRSIiZefIQRe7ZtplHzOCkOGqLHn8c9AIoUQuHVfLpf9RTd/te3upTt0
         P2ova9hcKXfoQn5nXNKR5hDJVcyxLpknodbq1Jrgdny0BjPAqXSqv3tGGXe44sJ9yD
         1Vmf3Ek318DVj5u4c5AuVp5eK4BQ4AdGBOE6oZ4d9ta9AsOp92RocjodZaXq2q+KpK
         67f7U5ECBbLr+7UG03DRS6hij6uLnM++5oc2OH8AXMqpkjcs1i54H8bgLkaXX0TJli
         7QAWGbvtpkfkhqlDbcu472cwZQGqu1nPSN99+FkdEy+6ElBWhaAvFwii+tMY+u9bKk
         rOvxl79d+1twg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E23D7E6D402;
        Tue, 22 Mar 2022 03:56:31 +0000 (UTC)
Subject: Re: [GIT PULL] Smack patches for v5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <bf678bae-821c-02ab-042a-004c03d9c334@schaufler-ca.com>
References: <bf678bae-821c-02ab-042a-004c03d9c334.ref@schaufler-ca.com> <bf678bae-821c-02ab-042a-004c03d9c334@schaufler-ca.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <bf678bae-821c-02ab-042a-004c03d9c334@schaufler-ca.com>
X-PR-Tracked-Remote: https://github.com/cschaufler/smack-next tags/Smack-for-5.18
X-PR-Tracked-Commit-Id: a5cd1ab7ab679d252a6d2f483eee7d45ebf2040c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2c5a5358feff2c1e035a67a9b352c4358e669e5b
Message-Id: <164792139192.6005.14812990568103025130.pr-tracker-bot@kernel.org>
Date:   Tue, 22 Mar 2022 03:56:31 +0000
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     torvalds@linux-foundation.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, casey@schaufler-ca.com
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 21 Mar 2022 09:34:59 -0700:

> https://github.com/cschaufler/smack-next tags/Smack-for-5.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2c5a5358feff2c1e035a67a9b352c4358e669e5b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
