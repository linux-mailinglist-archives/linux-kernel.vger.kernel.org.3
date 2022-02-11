Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E34994B2E35
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 21:06:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353194AbiBKUFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 15:05:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353132AbiBKUFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 15:05:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93199CE9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 12:05:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3AB71B82C92
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 20:05:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D59E6C340F2;
        Fri, 11 Feb 2022 20:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644609920;
        bh=nXPMu96sgUwAcghXAV02xdZu2la5a+iaStV7ZZoITJQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=SdZYgVJ0n6p1NWDtZEc+hcomORxrRkg+4Mzw8ZB3ZfO15Y1kRhW8iEK/Ib8vOfUTE
         lPHeNeDtoGt6/e+Qgp1dpx4jf4EPlb5HQKqFywsDXMWKpHs2IwdPCjrSA2hU9qlZea
         ddqPFD/+BF1yxvHHNmgXTP2Wg6R2aGz5rSTQHVvWzOGJKwziV63PIE8gHCaNC3ur3x
         t6803Cqy5YL+uvlOicXrUb9hK/lpGiLZRaO52yLvWsI4gwKwyluW8s1darZtmO8MvA
         WTp8lZAurhqf84vQP1xh6EObN34Lg3kgg2A9MUmUO4dhF8MKTOwBiClZ4Q3aOQ1QBV
         SEZh/wNuasS4A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C390EE5CF96;
        Fri, 11 Feb 2022 20:05:20 +0000 (UTC)
Subject: Re: [GIT PULL] gfs2 fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220211170522.348999-1-agruenba@redhat.com>
References: <20220211170522.348999-1-agruenba@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220211170522.348999-1-agruenba@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v5.16-rc3-fixes2
X-PR-Tracked-Commit-Id: d3add1a9519dcacd6e644ecac741c56cf18b67f5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8ce964b520ad0ad626cb1ee93a444aedceed5425
Message-Id: <164460992079.1412.7862203771120970033.pr-tracker-bot@kernel.org>
Date:   Fri, 11 Feb 2022 20:05:20 +0000
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 11 Feb 2022 18:05:22 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v5.16-rc3-fixes2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8ce964b520ad0ad626cb1ee93a444aedceed5425

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
