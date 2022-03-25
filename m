Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD664E7BDB
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233126AbiCYVIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 17:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232900AbiCYVIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 17:08:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9629E1EDA12
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 14:07:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1CCFE61D41
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 21:07:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 80A96C004DD;
        Fri, 25 Mar 2022 21:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648242425;
        bh=bC9Ftyp9RHD2jrv8YnVFShS/c5vA288ID0S4/5MZ4XI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=gnqZxZODoqgSXnuTheTZ8FsaUDxBMNmQJ8s9uK3NRPUNsdVgbu+H7IfFx0CPLgpoO
         +qXWN1YSLEjJWWnmghS4aAqEFiYcuQ/ElCzLTd/g1tUnmUyRTP8rZEjjwZRz/bgauG
         7/TUgFgTqdT9L64A3bCsjpZkFmRztmUDIozasbRQ6Ou9Bz7RJypC5Fhk8ER4IjligC
         +xb/di6bp5cJy7qSSJR9jjscFYM1riUKi/T7ndNIpRt2NFxCWWOsw6vcJ4i9+wNYCQ
         ANy79ePhnJv0lSMiUwB4M+ezT90ybZm0k04nUqMBWJ/8yOXCsYBI/UXXKyRsdZcRt8
         C0Q8/k7v0wlMg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 67ABBE6BBCA;
        Fri, 25 Mar 2022 21:07:05 +0000 (UTC)
Subject: Re: [GIT PULL] HID for 5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <nycvar.YFH.7.76.2203231015060.24795@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2203231015060.24795@cbobk.fhfr.pm>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <nycvar.YFH.7.76.2203231015060.24795@cbobk.fhfr.pm>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus
X-PR-Tracked-Commit-Id: b146dbbd3bc61678165f3de7904ab613865385ba
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5e206459f670b579da9b7861a0f3ce3b989a68b6
Message-Id: <164824242542.8431.17371449925077373260.pr-tracker-bot@kernel.org>
Date:   Fri, 25 Mar 2022 21:07:05 +0000
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 23 Mar 2022 10:18:39 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5e206459f670b579da9b7861a0f3ce3b989a68b6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
