Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71B7E53B12C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 03:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233112AbiFBBPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 21:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233098AbiFBBPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 21:15:32 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB5028E719;
        Wed,  1 Jun 2022 18:15:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 98E6FCE1DBA;
        Thu,  2 Jun 2022 01:15:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F29A7C385A5;
        Thu,  2 Jun 2022 01:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654132529;
        bh=dIyI0EHO1+u34y11qkC09d6/0IBp5okee0/nHVtoRaY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=F40VZTmu9X86cKRVpETm98IWDDE8DzvvHQ1gXzI0r8JSMvtl/++Xwhw2izxLq2amV
         i9WSIpVzWHkVOxYj/s4JrYBc826IqnI6CXjClsA4ZaHwIo0UcnwsDupp5utxf1Xkkz
         kPN/n25xc26zgQ8aJ/2Jhxk3H/dVs/uWNadd4oAye764+fBzvwGcafxAEUiubSBfuW
         D5QlkJu26YD9Usfz/ypb97xaKi2G/JgHnTrJL930qqVZstSFbkc+r+J7WtHd6D0P4i
         xoRrNStrzmKyNCXCtHwYofcb0F+AIaG4CqQU0uLye1JU3iDGB6KxI5EpjGQ4uOzl4q
         ZKhcbzNoDa2Dg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DEDE0EAC081;
        Thu,  2 Jun 2022 01:15:28 +0000 (UTC)
Subject: Re: [GIT PULL] xfs: changes for 5.19-rc1 [2nd set]
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220601221431.GG227878@dread.disaster.area>
References: <20220601221431.GG227878@dread.disaster.area>
X-PR-Tracked-List-Id: <linux-xfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220601221431.GG227878@dread.disaster.area>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.19-for-linus-2
X-PR-Tracked-Commit-Id: 7146bda743e6f543af60584fad2cfbb6ce83d8ac
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0e5ab8dd87c29640a46aee9e38bc3ba7645b1db0
Message-Id: <165413252890.5973.590261192738155869.pr-tracker-bot@kernel.org>
Date:   Thu, 02 Jun 2022 01:15:28 +0000
To:     Dave Chinner <david@fromorbit.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, djwong@kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 2 Jun 2022 08:14:31 +1000:

> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.19-for-linus-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0e5ab8dd87c29640a46aee9e38bc3ba7645b1db0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
