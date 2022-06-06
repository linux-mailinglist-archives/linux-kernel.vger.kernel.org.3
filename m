Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3DE653DF15
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 02:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351849AbiFFAXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 20:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351838AbiFFAXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 20:23:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3466398;
        Sun,  5 Jun 2022 17:23:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E63CDB80E19;
        Mon,  6 Jun 2022 00:23:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 86D76C3411D;
        Mon,  6 Jun 2022 00:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654474984;
        bh=PuP54w3s5xWgLzCRYuD9RGXTUDsTsq4kBrSDZ/vVbLI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=hHe/71wzb/RuxjKxvzxPzjHEbbXGygYtD7B/xoJBOR3sl2g9L7wp4htQ2V0iCxdQX
         YZx0EcMgTXG4iiTzfoGZsy9rEXR0/tTXKmhRHasvl+VnaN/GyrpkNMAT/PHV3JFnG2
         yy3TGZsiuPOzE1FP47dgc0C4wCjrUgzfh/eaHNPAIJk3qXoyIEWQch8pYz2AD0wfTo
         djjxjvzH+QJnkHiEtPrrZTIRxi80oR38Mj2Nh4uv+SeFfeu5K11yc6qXtl5BdAJlB7
         15jmOrsENTPRVNolAKIfqYDgTG0muo2erNJsl6DOg5IQVCQJQpxOY8pQNJ5ptubbYZ
         qZpshoS87Uxmg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6F4BDF5F173;
        Mon,  6 Jun 2022 00:23:04 +0000 (UTC)
Subject: Re: [GIT PULL] hotfixes for 5.19-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220605113808.2cf854614e3aff3790b7c49e@linux-foundation.org>
References: <20220605113808.2cf854614e3aff3790b7c49e@linux-foundation.org>
X-PR-Tracked-List-Id: <mm-commits.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220605113808.2cf854614e3aff3790b7c49e@linux-foundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2022-06-05
X-PR-Tracked-Commit-Id: a19cad0691597eb79c123b8a19a9faba5ab7d90e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 815b196c7057356e7ffa9ce97892cb5fd5de17e0
Message-Id: <165447498445.29908.6343180351407871895.pr-tracker-bot@kernel.org>
Date:   Mon, 06 Jun 2022 00:23:04 +0000
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        mm-commits@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 5 Jun 2022 11:38:08 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2022-06-05

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/815b196c7057356e7ffa9ce97892cb5fd5de17e0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
