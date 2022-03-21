Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D69A04E332C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 23:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbiCUWzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 18:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbiCUWzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 18:55:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A60F49F0E;
        Mon, 21 Mar 2022 15:37:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 35A1E61577;
        Mon, 21 Mar 2022 21:53:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 98B4FC36AEB;
        Mon, 21 Mar 2022 21:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647899628;
        bh=A0PmxMF9lp0QfR7y4V1JOHrLucoeF/E5K0BXDm302H4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=tmkr2s6HgH2nQnTpABJL7ytOGTnTexLPyUTyqy9rUY1rG1R94bJmI7YQX75OxrCJM
         FysaVQJJQNb8/uWRsC/AplzBZpkGn6WJ4XA2s1xEoOxiPBv1ScFt5sQO4d2o1GrQ+6
         UwqHPwICTWFpfq7I5Bw9BBUqV5w3RREL+/cMeYhfBZyqeTtWWC23vBSUtdxsokg0W0
         TbykkEaeNDKiHgSoq9zW9xkhOt0m/Qid8mOS2hpaKMrs2Njj5nbdzDAnhwlX9V3l8m
         D0nAGTF9Lzuf7SM8pAc5Xw3Sb5PyFlsPwdDYb4SSOHgzlNbrFwYx8hEZL+5qo/bOK2
         9kN37cA0K/XRA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 840A6E7BB0B;
        Mon, 21 Mar 2022 21:53:48 +0000 (UTC)
Subject: Re: [GIT PULL] Thermal control updates for v5.18-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gzkr8k3u6ZdKnsAOgk569Gf-HF5u2AShXdznEE4+UYGw@mail.gmail.com>
References: <CAJZ5v0gzkr8k3u6ZdKnsAOgk569Gf-HF5u2AShXdznEE4+UYGw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gzkr8k3u6ZdKnsAOgk569Gf-HF5u2AShXdznEE4+UYGw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-5.18-rc1
X-PR-Tracked-Commit-Id: 31035f3e20af4ede5f1c8162068327ea0b35a96e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f648372dfe3e8e9dc8583c2b1790388be49bb47f
Message-Id: <164789962853.9856.12832687856258524838.pr-tracker-bot@kernel.org>
Date:   Mon, 21 Mar 2022 21:53:48 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 21 Mar 2022 17:39:44 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-5.18-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f648372dfe3e8e9dc8583c2b1790388be49bb47f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
