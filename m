Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0078A4E37C5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 04:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236244AbiCVD6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 23:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236317AbiCVD6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 23:58:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D341F62D;
        Mon, 21 Mar 2022 20:56:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A9FDDB81B6E;
        Tue, 22 Mar 2022 03:56:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6F06DC340F2;
        Tue, 22 Mar 2022 03:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647921392;
        bh=wYq4KHls0ARPH7MwZtBRS6RLp/3gUxPYnQSK7XbHOBg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=rtVVCBk3k/6OpCtHHspzpYsf7d60SylhPfeQ/GWSseREJgDzo0kVdXjoZt+Cy+5Vc
         /H4URhkXxeBNUCS23nSMYifczfToPlT0eL2fchxFVgttYNYkU0YbyfRDMC+s/Sy3KR
         GuTEyeqSUvZF2T/5oBdFbpaEWYAHd0HQbIHZ30QS7MY1o4g5ZXjllmuHTRcLjYknCx
         AKDlF8Eo9DgAJ/99upRNZcq1tB1+brMaXyBv/e0/rd9t1zovuWlPucPRObf3QbsGSD
         dUZ95HK4F3pWq8p8Hedwy+562/XsLAbbJZ98frYwEq3nLE/sbCA4nx4Gpm9Ot0ZecV
         0Tq+UW/lI3kTg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5DF65E6D402;
        Tue, 22 Mar 2022 03:56:32 +0000 (UTC)
Subject: Re: [GIT PULL] SELinux patches for v5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAHC9VhTA1O4J_dS9T_U-Vrmi-7JeHTM6fEOfS8JJBfvoNgDrfg@mail.gmail.com>
References: <CAHC9VhTA1O4J_dS9T_U-Vrmi-7JeHTM6fEOfS8JJBfvoNgDrfg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAHC9VhTA1O4J_dS9T_U-Vrmi-7JeHTM6fEOfS8JJBfvoNgDrfg@mail.gmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20220321
X-PR-Tracked-Commit-Id: cdbec3ede0b8cb318c36f5cc945b9360329cbd25
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c269497d248e43558aafc6b3f87b49d4dd3c2713
Message-Id: <164792139238.6005.9149948654096517063.pr-tracker-bot@kernel.org>
Date:   Tue, 22 Mar 2022 03:56:32 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
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

The pull request you sent on Mon, 21 Mar 2022 18:13:51 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20220321

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c269497d248e43558aafc6b3f87b49d4dd3c2713

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
