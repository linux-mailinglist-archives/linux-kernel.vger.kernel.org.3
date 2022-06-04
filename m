Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9B4E53D88B
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 22:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241334AbiFDU4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 16:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241306AbiFDU4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 16:56:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30BE62CE1C;
        Sat,  4 Jun 2022 13:56:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E3EA2B80AD6;
        Sat,  4 Jun 2022 20:56:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9DBC5C36AE2;
        Sat,  4 Jun 2022 20:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654376162;
        bh=/QV3qT1Ae0fHq0l/aVcHnzde6eUEWGyd3EnIgjLnwpg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=OkXBIBzulf073PiulJorwu+/xKTcICUFWGZdO6mE2zVVC8cXSoC4n+wD7mgOIkqcl
         nncILFa+HNRRVHXQHcL1fR2Q17hvmsX6TWq1T7pKE3YAWy+B9/iElOp9eOokirSAje
         txyK9cxD4ZtddEqYwmLP/Ln/MXxgSSRxq1q7v19Eaz/WgLfmgJFiwGrx7BG9APgtQi
         GKvbygUmADKHwIWmdyuNdi3OtsQPS9KYKtZ6vjVd0BjrraJVKCzPFKWLL3i4Jp90cn
         H7xZaxdXMI+fhruqf0tutwb8cCoickWqAbDAbGC2lQSMbX1UUdQniXcWT89sZfmJmF
         u1J58g724H6mw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 87E2CF5F173;
        Sat,  4 Jun 2022 20:56:02 +0000 (UTC)
Subject: Re: [GIT PULL] more parisc architecture fixes/updates for v5.19-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Ypt1N+GyXEMfAxR6@p100>
References: <Ypt1N+GyXEMfAxR6@p100>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Ypt1N+GyXEMfAxR6@p100>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/for-5.19/parisc-2
X-PR-Tracked-Commit-Id: b046f984814af7985f444150ec28716d42d00d9a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 23df9ba64bb9e26cfee6b34f5c3ece49a8a61ee1
Message-Id: <165437616255.25005.18187271570341058032.pr-tracker-bot@kernel.org>
Date:   Sat, 04 Jun 2022 20:56:02 +0000
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>,
        Mikulas Patocka <mpatocka@redhat.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 4 Jun 2022 17:07:35 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/for-5.19/parisc-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/23df9ba64bb9e26cfee6b34f5c3ece49a8a61ee1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
