Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F40684BD1BC
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 21:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245041AbiBTU6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 15:58:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244197AbiBTU6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 15:58:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E54C14086
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 12:58:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 371E360F6B
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 20:58:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9E072C340F4;
        Sun, 20 Feb 2022 20:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645390690;
        bh=Rnm58iaoTu3Etn/Or+QTIb5Av3XyDGGHDRLgL4DQ1kw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=FR+fHbkxi4iuDruz92cmUeIBHzTVxW5p9nPJs6vz5NJdqwaQ8VK3srVWs5/xyu2S/
         JKY0YuIHg6TYDTKW3/dAnMWSBtGlWHhTw4ssvt7AhoxAXxWBM87Gmqcstfc9oz+3vp
         FxCc1qdEdWw1NxYHt2c0s0gaeJv/Z6qluzIJqaZGpItUjFLFzeB8C95oKpNE5rCeFG
         3KijQrPQaRHrukfQLQvOu0KrqLi3zixPb0IafQMB8oTlJQzFJKkte49Moj1SXArwfJ
         LDkuVGNzuhfRaGzS6D+XEyLX52qQgnq0QpXXDHdUMe7+7l4H/vNluldjRbLHzY4GoZ
         H9QZs4JDQRsjA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8A2F4E7BB19;
        Sun, 20 Feb 2022 20:58:10 +0000 (UTC)
Subject: Re: [GIT PULL] locking/urgent for 5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YhIzpZZCJ07o/vND@zn.tnic>
References: <YhIzpZZCJ07o/vND@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YhIzpZZCJ07o/vND@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/locking_urgent_for_v5.17_rc5
X-PR-Tracked-Commit-Id: 28df029d53a2fd80c1b8674d47895648ad26dcfb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3324e6e803156b4296975555f566892e4e3f4fcf
Message-Id: <164539069056.9723.13114502509401491847.pr-tracker-bot@kernel.org>
Date:   Sun, 20 Feb 2022 20:58:10 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 20 Feb 2022 13:27:17 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/locking_urgent_for_v5.17_rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3324e6e803156b4296975555f566892e4e3f4fcf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
