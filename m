Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3949B4CDDF9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 21:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbiCDUXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 15:23:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbiCDUWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 15:22:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5571B151692;
        Fri,  4 Mar 2022 12:22:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1038AB82B8D;
        Fri,  4 Mar 2022 20:22:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C45CDC340F8;
        Fri,  4 Mar 2022 20:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646425321;
        bh=+FlN9O0/6fWFEYP3tQ31BMGachEBs2NKJyAd7igFvlg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=mfDwhMRqF2Hj/TC9eG7GWEP8G0qpvMx5B5hviHR7zacaT95XwOawYwrcjliRz5Jvo
         W2wiQlCd+WNEpe4fEVtgzGL5irAK2NV8f9tvwgzGPfG5/4h29Y3djh29F/ej/Dv8k+
         k0KOQi88T0rWEWlMxAU4bv7eu9ZPVQqvAsr5eAtJSbQ6eiSqmP3U7QPMlQkJauhyGY
         Z81iaPeJusIMF2IHJePYNdyUalXmIWO7cxxHvtoufB6MB6P8+rXYbla1fDOQfojR0L
         vXNDgWlNtPoNWHk8eeqnhxOvcAi/OBOwTxt41vKR1rZw04aixV/brYgVPDN934wEIL
         xpkiJCZ5LyLUQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AABD7EAC099;
        Fri,  4 Mar 2022 20:22:01 +0000 (UTC)
Subject: Re: [GIT PULL] Thermal control fix for v5.17-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0i=5YYvBQcMDb7-gRpC0f_R6KMegyQonN6=ca1ndYauxw@mail.gmail.com>
References: <CAJZ5v0i=5YYvBQcMDb7-gRpC0f_R6KMegyQonN6=ca1ndYauxw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0i=5YYvBQcMDb7-gRpC0f_R6KMegyQonN6=ca1ndYauxw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-5.17-rc7
X-PR-Tracked-Commit-Id: 5838a14832d447990827d85e90afe17e6fb9c175
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a4ffdb61035da6e1550c3cb141a6b25acd7ae3da
Message-Id: <164642532169.24805.1777895778086708909.pr-tracker-bot@kernel.org>
Date:   Fri, 04 Mar 2022 20:22:01 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 4 Mar 2022 19:37:11 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-5.17-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a4ffdb61035da6e1550c3cb141a6b25acd7ae3da

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
