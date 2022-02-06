Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 072ED4AB14F
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 19:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346430AbiBFSiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 13:38:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242046AbiBFSii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 13:38:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B209C06173B
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 10:38:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF0506120F
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 18:38:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 32BE1C340E9;
        Sun,  6 Feb 2022 18:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644172717;
        bh=giQ52Q4eP1jqPJEcUB2WBN9wF7wGeh2JkrVdRLDJGR4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=knO84KDZFYrp1+6XGQpUC3G7XzNRHmrvQBAgETaPir8QlU+Y5LlnNF9aYntmp2uT8
         PhJuqHqcXbclqXOHKvv64A5F/wOuxBxMFoaUW1k1GRIqeQcZbndeoPlzWpJF6On+L+
         pseAs4MxZa0KIl0+uP3qQJyEzEyvPikBcVFFBLj+/PDCFIt71vi3YM+fxc13hcTjfW
         cPjyfPPitFPRAjeO3mU6A+qqZTSL7Phd0pNxz0ZPbsXob4RLueLAE7R71To4hfAhca
         MOES2X1D1nsuPDZ1RzP2U3cr1ZGRGaxVuQEyoKU1CD+4VBK34nApuWgzvzhNXyBlC6
         u/cm05eaJAW8A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2022BE6BBD2;
        Sun,  6 Feb 2022 18:38:37 +0000 (UTC)
Subject: Re: [GIT PULL] irq/urgent for v5.17-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yf+3sIvPPnPkv5Jg@zn.tnic>
References: <Yf+3sIvPPnPkv5Jg@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yf+3sIvPPnPkv5Jg@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/irq_urgent_for_v5.17_rc3
X-PR-Tracked-Commit-Id: dd7f5a11ac5a6f733f422dc22b4d145d3260304e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b72e40b192f21f172a152ecb5905d22928bea2a3
Message-Id: <164417271712.9246.7713497035608175538.pr-tracker-bot@kernel.org>
Date:   Sun, 06 Feb 2022 18:38:37 +0000
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

The pull request you sent on Sun, 6 Feb 2022 12:57:36 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/irq_urgent_for_v5.17_rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b72e40b192f21f172a152ecb5905d22928bea2a3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
