Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7FC5371F6
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 19:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbiE2R7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 13:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbiE2R7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 13:59:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E875160040
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 10:59:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 827D360F81
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 17:59:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E8C70C3411F;
        Sun, 29 May 2022 17:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653847157;
        bh=D+7onteyQslE4BhRFT8+yZLHnOETB58u7cR4I9fgzjo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=TTVnLgH/ZXjD67lCxdp7R+zdYSlkHobR/Oe/KecNitDnqgQM0AAFjX/gZh8f/8T4f
         AMlf3dfi0LVReLUuA4LEljFKBmjW0wU7P2MYHBePYmw7b7Z2FDx7++9kDRpDxcO4gR
         VPi/TnNZRKWpoTfzYFOtOdH2fp9WkHreZzzPvgdD0YAImCx0ggSX4TKCxkiDgAV0De
         2CD06EOKSOcRRqotzKCRej8lKukoOSXQ2kj90sQexqWBJUNWYcPR9gXGFZ4/bVvIod
         Px2d/dZh4hJJfeDdrw7C4vXEuwV3wsnNSqkn89G1FN9JOeKMzkDGZbI+26G8jo03oF
         mAdemmh+Oe+rA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D1C21EAC081;
        Sun, 29 May 2022 17:59:17 +0000 (UTC)
Subject: Re: [GIT PULL] tracing tools: Updates for 5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220529130917.06df783b@rorschach.local.home>
References: <20220529130917.06df783b@rorschach.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220529130917.06df783b@rorschach.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-tools-v5.19
X-PR-Tracked-Commit-Id: dada03db9bb1984826e61cfcf1418ac73848324d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c3a9a3c5f5590e85da15d6201e415ff636fe5670
Message-Id: <165384715785.24035.14757748735438375978.pr-tracker-bot@kernel.org>
Date:   Sun, 29 May 2022 17:59:17 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        John Kacur <jkacur@redhat.com>,
        Wan Jiabing <wanjiabing@vivo.com>
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 29 May 2022 13:09:17 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-tools-v5.19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c3a9a3c5f5590e85da15d6201e415ff636fe5670

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
