Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B734B4CB001
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 21:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238714AbiCBUhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 15:37:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240618AbiCBUhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 15:37:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F955C1163
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 12:36:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E953DB82220
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 20:36:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 943CBC004E1;
        Wed,  2 Mar 2022 20:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646253413;
        bh=Y7SXpInx+Ge2rajg1YXiA5bSzMb4MaWtiETkwg7FvdM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=XhDVurOnp5JH2hjV04Ub1WiAEKWEr8HDPq17/0LBAQWqrPMJGHOv1OnUMPn+m5um+
         0VnW+KbMlxxaEfur9NSuiALfbAFUNYcB0LxHruE6ydF3PQ16/X0c936TQ6baNftW8F
         XSwJt0q8G5qggzjpg3CTnH7A3lK2kkryyuuY3YBDCwVjOx44m4xlNWj/BL2hd1ZFbO
         D6swPDRO+zFjxb6/t5YKPmvw9SsHgbUB7jg1efQZdZUdA33P92JmSVjhRAG5vWxXw0
         8WfEKOIvbMQVey21qysXzcJhAIOEbgwe9lp4zxLaUGE7aKo9d2J3o0PeLMtLnocPpU
         8l37sUxdRjkTA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7F5C2E7BB08;
        Wed,  2 Mar 2022 20:36:53 +0000 (UTC)
Subject: Re: [GIT PULL] NTB bug fixes for 5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yh6O7wmp8HCjxOn3@athena.kudzu.us>
References: <Yh6O7wmp8HCjxOn3@athena.kudzu.us>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yh6O7wmp8HCjxOn3@athena.kudzu.us>
X-PR-Tracked-Remote: git://github.com/jonmason/ntb tags/ntb-5.17-bugfixes
X-PR-Tracked-Commit-Id: 9b818634f8e7e0bca3386a50b1fada7a49036408
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ae5f531d1766a2cc98857707671223ff1284236d
Message-Id: <164625341351.15521.5087165913521187758.pr-tracker-bot@kernel.org>
Date:   Wed, 02 Mar 2022 20:36:53 +0000
To:     Jon Mason <jdmason@kudzu.us>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-ntb@googlegroups.com
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 1 Mar 2022 16:23:59 -0500:

> git://github.com/jonmason/ntb tags/ntb-5.17-bugfixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ae5f531d1766a2cc98857707671223ff1284236d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
