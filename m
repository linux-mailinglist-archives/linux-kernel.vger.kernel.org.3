Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDED53D88A
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 22:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241410AbiFDU4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 16:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241300AbiFDU4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 16:56:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315D12CDD3
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 13:56:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DA3FEB80AD1
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 20:55:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 93E55C385B8;
        Sat,  4 Jun 2022 20:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654376158;
        bh=ZlwVPaT7l/IdNQNwYIHS1lieP4Aisx5mKwnqL0f1nXE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=esF5ImWVpzAlPFEH0Tw+L9gHkm+zOiW+H+3JO9Gb4kcwKZNzRsa7E0RIKro6UsdNs
         h144wUIHI7huwMbk6uTHSxO69PD7QI0AITNeuo3/xcwEXwoSiGVExLxxIKeao5ywFJ
         Kx7N6rdtYJ3ofV+IgLSsqmYF9aDbLGPC6IwhgSQbeeAHQLZTRVn1M4RACfAZxQ/4xc
         fDVko6YjZ5Cfwc8RdXDtgH8UzYgpOKtvCMAN+0fia4GtxEmswX9ERjYZ/niKVqTI5b
         zRJLb+ENwLkNzOFkueKvcCPMt67YZlUQm9Oewl5hJbB5TCSK5Bd8Hx+fkpYNwhXUQ9
         JzwX/TSy2EErQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 77C0BEAC081;
        Sat,  4 Jun 2022 20:55:58 +0000 (UTC)
Subject: Re: [GIT PULL] xen: branch for v5.19-rc1b
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220604055608.9037-1-jgross@suse.com>
References: <20220604055608.9037-1-jgross@suse.com>
X-PR-Tracked-List-Id: Xen developer discussion <xen-devel.lists.xenproject.org>
X-PR-Tracked-Message-Id: <20220604055608.9037-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.19-rc1b-tag
X-PR-Tracked-Commit-Id: 41925b105e345ebc84cedb64f59d20cb14a62613
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4ccbe91de91a8f9559052179d15c0229a8ac9f8a
Message-Id: <165437615848.25005.15611342522221631046.pr-tracker-bot@kernel.org>
Date:   Sat, 04 Jun 2022 20:55:58 +0000
To:     Juergen Gross <jgross@suse.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, sstabellini@kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat,  4 Jun 2022 07:56:08 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.19-rc1b-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4ccbe91de91a8f9559052179d15c0229a8ac9f8a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
