Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6809A51C86B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 20:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384477AbiEESwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 14:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384532AbiEESuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 14:50:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E2743AF6;
        Thu,  5 May 2022 11:46:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E1777B82EA9;
        Thu,  5 May 2022 18:46:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7F2B9C385A8;
        Thu,  5 May 2022 18:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651776361;
        bh=XEs/LpCX6b+FrR7PhEB2LhoKwP7Bh3K8TeU4OL4/3FI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=qOts4C0SSnVcoxJ7XkVyrxicOGfloccRWwq92RKUMQ8F9fCXylOx2PZLpOcGXrge3
         PMoIFuP+XjtXXx18ebpgE3lHxYBQspPBNppoWf28F/0AQmTUXZDSDndN4tVy/gRnwd
         6tDbuHBsS+daC+e2YI3K6PsqvLzSvRIwYZWFhYhcWerc7oRmEr+urFhaVo7B4V0aGg
         4B8MHPPjN14PmvLw5md7KJ/M45X8tIWHqMaMlV4cX47P+CKa1p4T7x6T5PIbF5ACIs
         nKAxz325GIAg8CCPUTtsH3fzgJ+xr8Qzn/M8aWo47PjGbKvqMZfKH5jwapKpBaFnqq
         bsnnpt+axgDRQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 64CE0F03848;
        Thu,  5 May 2022 18:46:01 +0000 (UTC)
Subject: Re: [GIT PULL] MIPS fixes for v5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220505115539.GA11181@alpha.franken.de>
References: <20220505115539.GA11181@alpha.franken.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220505115539.GA11181@alpha.franken.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips-fixes_5.18_1
X-PR-Tracked-Commit-Id: f0a6c68f69981214cb7858738dd2bc81475111f7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 905a6537e7640993fdbd18da6f56d86035069e88
Message-Id: <165177636140.18464.657374414125244564.pr-tracker-bot@kernel.org>
Date:   Thu, 05 May 2022 18:46:01 +0000
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     torvalds@linux-foundation.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 5 May 2022 13:55:39 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips-fixes_5.18_1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/905a6537e7640993fdbd18da6f56d86035069e88

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
