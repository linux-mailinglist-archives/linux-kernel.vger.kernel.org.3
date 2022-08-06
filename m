Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A56158B79F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 20:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241940AbiHFSUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 14:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241901AbiHFSTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 14:19:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18210E0DD
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 11:19:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C37E8B80834
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 18:19:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 82743C43145;
        Sat,  6 Aug 2022 18:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659809978;
        bh=8BpY/QQLQbdPv0gkRb0Z+RxdTvnAGx2By5cH68aKaXo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=O9orUsnD8+fOE6AaKvpIDjecexC/bLaU6qgILDeJWRFqgOQwAvFyXmEM7OpxYFBpF
         rNYqevZMyqs9c257yn2MYZVrGDRHsJHO7P4gp7CiUXLlA6EZlnCJABMW+GDPmC/Up4
         buaFfQbIaJySk973GodX+u5EOZHxn+ykjKvSg72CD+5YjEyauFNluyq8TxqT+DQy9w
         y1JGnbSWYRQcd/3Cep2jM1dZQf1TcbTyTU41aHzrEGExWcGZM1cD2p4dpeLFWc7Khi
         CJx7JVydUjcuKk4T3oce7ZidDXY2cnLm4uamuud+I7O0H8yiaPy7CSPPCf2P6ETULT
         b1WrE9EbAl4Rw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 719CEC43143;
        Sat,  6 Aug 2022 18:19:38 +0000 (UTC)
Subject: Re: [git pull] IOMMU Updates for Linux v5.20
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YuzlAT7RW1U36+ap@8bytes.org>
References: <YuzlAT7RW1U36+ap@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YuzlAT7RW1U36+ap@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v5.20-or-v6.0
X-PR-Tracked-Commit-Id: c10100a416c16b598bf5155e759307b34dac0d7d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1d239c1eb873c7d6c6cbc80d68330c939fd86136
Message-Id: <165980997846.27284.3824257141690673878.pr-tracker-bot@kernel.org>
Date:   Sat, 06 Aug 2022 18:19:38 +0000
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 5 Aug 2022 11:38:09 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v5.20-or-v6.0

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1d239c1eb873c7d6c6cbc80d68330c939fd86136

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
