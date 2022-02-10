Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90C764B0F96
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 15:03:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242578AbiBJODK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 09:03:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242580AbiBJODE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 09:03:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D519A
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 06:03:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D60E861812
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 14:03:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 46386C340E5;
        Thu, 10 Feb 2022 14:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644501784;
        bh=kKobx81JM9qWQ61Bn0oUUoVkVGcYutTJEWIw6A6X594=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ulJXzZu43tazrHmrEvMiHD4oS+9DPNxsgUhiGW0GuElIYdmtJBD/NawmCQgFWWqGu
         M3xSVSHlOEEuqqOkjIlqcATX8OcrCENwezOx23ZFLoy2MTshl5THu8r0UlxUXhYElq
         /1MzaO7aWlXOAISg9NVCK3Xp4AfkUm/e7kRcBTwhERj3pgDgcxtXrNkhcJ96iMOZcY
         /FIuP/c7ywMzDlZSU2qscJtHdOuwQAYesSbtsD9H+nK9sEPF0/xrIwQ7V0veuKkBo9
         yBkFdN5giY4VXRgJXK/xe5mMLatK4VIQs1g2altMokyZX9MJYFrCZJOf1z61dDxqIq
         d5tjM91PYRXrw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 35A07E5D084;
        Thu, 10 Feb 2022 14:03:04 +0000 (UTC)
Subject: Re: [GIT PULL] Audit fixes for v5.17 (#2)
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAHC9VhTJR7vwuSBRa1nmP4-EY-GMrJmeQ3F_tuihjqLxT23GQg@mail.gmail.com>
References: <CAHC9VhTJR7vwuSBRa1nmP4-EY-GMrJmeQ3F_tuihjqLxT23GQg@mail.gmail.com>
X-PR-Tracked-List-Id: Linux Audit Discussion <linux-audit.redhat.com>
X-PR-Tracked-Message-Id: <CAHC9VhTJR7vwuSBRa1nmP4-EY-GMrJmeQ3F_tuihjqLxT23GQg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20220209
X-PR-Tracked-Commit-Id: 7a82f89de92aac5a244d3735b2bd162c1147620c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 252787201edfdf563ddf6b6006aa534ddc504031
Message-Id: <164450178421.30240.1907810739176095127.pr-tracker-bot@kernel.org>
Date:   Thu, 10 Feb 2022 14:03:04 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-audit@redhat.com, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 9 Feb 2022 22:42:31 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20220209

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/252787201edfdf563ddf6b6006aa534ddc504031

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
