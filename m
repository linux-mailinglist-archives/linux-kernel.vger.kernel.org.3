Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3482D4EE178
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 21:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240559AbiCaTOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 15:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240350AbiCaTOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 15:14:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD6AD239324
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 12:12:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 82C1EB821C0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 19:12:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 215E6C340EE;
        Thu, 31 Mar 2022 19:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648753964;
        bh=Q+rR/0hP2RoJVEQBcWMctDTZ15UahEMPjDz0YVbKDh4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=DPFWt/4WRfmT9kbiLqM5HUbnzfreuQkV6p9FSABe/dUQYYw2Xno13hU2ZYTDDc/i0
         Ht4ZK9aYeWDHLnXFKcFZrmqivnlZtmurHyQ22Xr/IYDbOgjezkp54pP2RxBo7LpF81
         z+nlL8jdZr0MY3HGQut2c2oRTWfcJaXAyvxuR1M7GhO7jSKGugsZFlk3S7R+or+cDZ
         0EgIZgb7mEE/46e6HqECNzVXF3Fw/ZSt5J+JfhG8b+VQhE7V4YP53DdiIXudoWpIGQ
         zgZmFvg8oM0x4JuS7ncu9o6sAnDZ+O9Sc9qQN4ldru18mXZ61jpXOZXYaX5x4oSzQL
         qcL8B5jspgB3g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0E300EAC09B;
        Thu, 31 Mar 2022 19:12:44 +0000 (UTC)
Subject: Re: [GIT PULL] hardening fixes for v5.18-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202203311127.503A3110@keescook>
References: <202203311127.503A3110@keescook>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <202203311127.503A3110@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v5.18-rc1-fix1
X-PR-Tracked-Commit-Id: 229a08a4f4e4f9949801cc39b6480ddc9c487183
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f87cbd0565eb7e2fa15296c74210658db1346431
Message-Id: <164875396405.22373.4543629917803159331.pr-tracker-bot@kernel.org>
Date:   Thu, 31 Mar 2022 19:12:44 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        David Hildenbrand <david@redhat.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        Logan Gunthorpe <logang@deltatee.com>,
        Martin Oliveira <martin.oliveira@eideticom.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Minchan Kim <minchan@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Zi Yan <ziy@nvidia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 31 Mar 2022 11:35:40 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v5.18-rc1-fix1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f87cbd0565eb7e2fa15296c74210658db1346431

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
