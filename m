Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 005874E6C1E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 02:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357575AbiCYBkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 21:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357647AbiCYBiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 21:38:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D23C12E4;
        Thu, 24 Mar 2022 18:35:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A476F60A66;
        Fri, 25 Mar 2022 01:35:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1216EC340EE;
        Fri, 25 Mar 2022 01:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648172146;
        bh=8xxMWqrsHLOpdHkzDXT+Lo+CA0FyLMAV8zlvXf9abjA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=u83EH+Md6ka08w1UdRvLJmnoC2lzqymgDRMV71WyG1un977ut62euohYPXLbZyB17
         iMVJAPQOARH0fIwMK0iDFWuHIJ+eWlbg7wh0SfzqZVufM8KIxFr5gENLXFQjFlYz3Y
         PYWL+aDbN1SkpeZdaVgKjaZTGOP+XvMTiMpX/LTlXvmoKGDVKZF3ok16b/uzS6juSA
         dmja7wn0HHKEh5zwed3TeGo8YDwNOj1MsKOiLN+r19watR6sOwLjoDyRLzZ//mte/g
         7MYZdIKKtdDLmxjDRhOW7U12FsU56WO4hpe7nQkspwvoDzupBmHOmeF5XLSeenDW7y
         jv9uoJZi75w3w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F3921E6D44B;
        Fri, 25 Mar 2022 01:35:45 +0000 (UTC)
Subject: Re: [GIT PULL] Ceph updates for 5.18-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220324172554.12797-1-idryomov@gmail.com>
References: <20220324172554.12797-1-idryomov@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220324172554.12797-1-idryomov@gmail.com>
X-PR-Tracked-Remote: https://github.com/ceph/ceph-client.git tags/ceph-for-5.18-rc1
X-PR-Tracked-Commit-Id: f639d9867eea647005dc824e0e24f39ffc50d4e4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 85c7000fda0029ec16569b1eec8fd3a8d026be73
Message-Id: <164817214599.9489.11282402918350955386.pr-tracker-bot@kernel.org>
Date:   Fri, 25 Mar 2022 01:35:45 +0000
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Howells <dhowells@redhat.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 24 Mar 2022 18:25:54 +0100:

> https://github.com/ceph/ceph-client.git tags/ceph-for-5.18-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/85c7000fda0029ec16569b1eec8fd3a8d026be73

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
