Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CDAE4C4F72
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 21:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236425AbiBYUSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 15:18:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236245AbiBYUSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 15:18:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5260063BC9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 12:17:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 74C9DB8334A
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 20:17:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1F67CC340E8;
        Fri, 25 Feb 2022 20:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645820258;
        bh=vdWegqtTtaOl3U7leHU6jYtdKKHdYoyvBsyvLNe4eVQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=QRQCQGyqyMYuEXNBvfYxw3m0wpmZbNACjnmSYVlc9QHzfM5HPdKayWdzaBhAXJrJK
         YxfbLZWJY6abfdTyB0hKu4EfP6xqJ0Zqcis38taNBy4PN8ZStF3mLag6XsG5OtM4jZ
         hz6J6DHx7ecZ5ROibzXjtqlxHGpTjT9n6srxHrK88aNCbVn1jHPgloiFVLj1yaRo5F
         pIHsAvWm89XOrJwRN76H9vg8JG46JaU+aT9M0JTvwqUXAV2t6EPlDe11ksrsIJU7KL
         HaNZcJ0QuNFAD27W9x20Q8VuoZIL0dQpqkDUImajet9bwCn/2WIs26T80h/3oE2gGe
         0sqzFoUrEyvtQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 03FA7EAC09B;
        Fri, 25 Feb 2022 20:17:38 +0000 (UTC)
Subject: Re: [GIT PULL] Staging driver fix for 5.17-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YhjYPIRvDnV7XAzV@kroah.com>
References: <YhjYPIRvDnV7XAzV@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YhjYPIRvDnV7XAzV@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.17-rc6
X-PR-Tracked-Commit-Id: b6821b0d9b56386d2bf14806f90ec401468c799f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eae9350eb40aa0b07c280ab3a504bdc65c2211f1
Message-Id: <164582025801.12222.16361077026884228274.pr-tracker-bot@kernel.org>
Date:   Fri, 25 Feb 2022 20:17:38 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 25 Feb 2022 14:23:08 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.17-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eae9350eb40aa0b07c280ab3a504bdc65c2211f1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
