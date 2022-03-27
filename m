Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38DAF4E8A7B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 00:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236922AbiC0WYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 18:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbiC0WY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 18:24:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 956ABE0DC;
        Sun, 27 Mar 2022 15:22:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2F4AEB80DD8;
        Sun, 27 Mar 2022 22:22:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DE491C340EC;
        Sun, 27 Mar 2022 22:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648419767;
        bh=fG8+d8sNVPS5l5FLwTfiPdWa1b3S7uWFkrHQv2LLCGk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=TTB6S29NgVFjDHezmNMy8YEgDJvjaV30ZD9D6mW2keCwh5ufIBCsbdcIpZhpCbdRo
         ykF9HjVAE8q+bPU8MgM3UlmGUboRvk6xmB4ua1AoSZLG5747TTWRLR5/w/uaT9tU1p
         JNkoNs02ASBXwHusQ+WUw4Nm9aclB+n7Ftz34Ev1nWtA5fjcFH1HHUu7ejcLAnUizY
         5ALVvUQQDwNaQtB/HpwNVeJ5hhwb5mpMWSRdpgChvxDMAziBcXnycM0yEQrEH2NbT+
         FWxzFy+8gam/YD1iqj+BIVEPyLSErvGjOPKoyFW44h8qlHh6tjrzRi6vhujNApjysa
         NPdkvHNdRDYcA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CA0ACE6D3DD;
        Sun, 27 Mar 2022 22:22:47 +0000 (UTC)
Subject: Re: [GIT PULL] Landlock fixes for v5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220321115913.478505-1-mic@digikod.net>
References: <20220321115913.478505-1-mic@digikod.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220321115913.478505-1-mic@digikod.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-5.18-rc1
X-PR-Tracked-Commit-Id: aea0b9f2486da8497f35c7114b764bf55e17c7ea
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 29cbaa3e60dfe48e341a3a5ce1c2d8f3d9e9667c
Message-Id: <164841976781.22197.3197241870362548158.pr-tracker-bot@kernel.org>
Date:   Sun, 27 Mar 2022 22:22:47 +0000
To:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Christian Brauner <brauner@kernel.org>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 21 Mar 2022 12:59:13 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-5.18-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/29cbaa3e60dfe48e341a3a5ce1c2d8f3d9e9667c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
