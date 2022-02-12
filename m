Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2E2D4B36CA
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 18:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237731AbiBLRRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 12:17:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237673AbiBLRRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 12:17:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C8AF240A6;
        Sat, 12 Feb 2022 09:17:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EBA28B807EE;
        Sat, 12 Feb 2022 17:17:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B386FC340F0;
        Sat, 12 Feb 2022 17:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644686232;
        bh=J5/JpM/NQb9KMRfHLQ9g4TAPQaNxjNzihCsBurKxGLM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Ws0SWi/0zoP8yuBSKgkm976NX9qX4UdWxJpaw5z9AMX7Vit+kqQnIRVLjDPdfAqDl
         EIsKZKKkG6bFJ76JuWcvIPxwMf6In36obJmVjOvhs1jEXcOwJgbvtYIYXSUKFWkh3N
         6UG7XrpFqluWoFp6T1Py9sFNqKZCw77gjGaj0hojwKsQ3RT1FzB16oo66S4p4teB1e
         pgTS7QAxvgf1+QqEh+1uf69XKXMrCbA1q8B/EwNS0R1i827JGz75qB4pq2XQgkewV1
         MmLvy/Yrtv+NOc5bTeD5swAu/lb6ePjg3rk3qK+lTE1uMaOUnOQzcwpwQDh9DrCVSJ
         I6v3hPW0BZpSA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A2F55E5CF96;
        Sat, 12 Feb 2022 17:17:12 +0000 (UTC)
Subject: Re: [GIT PULL] s390 updates for 5.17-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <your-ad-here.call-01644666270-ext-6500@work.hours>
References: <your-ad-here.call-01644666270-ext-6500@work.hours>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <your-ad-here.call-01644666270-ext-6500@work.hours>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.17-4
X-PR-Tracked-Commit-Id: dd9cb842fa9d90653a9b48aba52f89c069f3bc50
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a4fd49cdb5495f36a35bd27b69b3806e383c719b
Message-Id: <164468623266.20961.16254516549608570348.pr-tracker-bot@kernel.org>
Date:   Sat, 12 Feb 2022 17:17:12 +0000
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 12 Feb 2022 12:44:30 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.17-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a4fd49cdb5495f36a35bd27b69b3806e383c719b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
