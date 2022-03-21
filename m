Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14AD04E30B6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 20:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352761AbiCUTUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 15:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352700AbiCUTUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 15:20:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59FFF326E6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 12:18:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AFE11B81167
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 19:18:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 60DDBC36AEC;
        Mon, 21 Mar 2022 19:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647890314;
        bh=d0s3jOGiJGutpaLdnsrPeVEnHyGock5XYTy0pQHsH3w=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ZoLbYLVURdu/2GJVSKJRvdMMudEJfXiPlnRO2g4oIpQBCaDnsgFrCXKWwmdB31Cw4
         5OEO2g8aqVWzjPYfPCOUxpXFe6EvfEFUWpRd56/ggRKdB7vkgnbE9tMFnRnYa+ifAp
         zEJfl3bRrYVqu1KkL5wTESkTZYSpDiBX2wn0PyvG0N7Ton9mblb8JFNoYVUaoaMVfN
         uJnOBFVQHApiXGxMJh0RGcok4x29MRrkEZk95RSV/KjPFCXqRwTCBhKR6D7ZKzAq1e
         m8shxFIJIMTDmNkomyTro8TqaIc3lnI4vkRGU6WDW08QA7MlWMFEk21oCCa+sXifw7
         Bf5oUcmwX3SyQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4A727E7BB0B;
        Mon, 21 Mar 2022 19:18:34 +0000 (UTC)
Subject: Re: [GIT PULL] x86/paravirt for 5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YjhVA/LtQ4qFZuKd@zn.tnic>
References: <YjhVA/LtQ4qFZuKd@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YjhVA/LtQ4qFZuKd@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_paravirt_for_v5.18_rc1
X-PR-Tracked-Commit-Id: 2e1f8e55f9e054b4a49ffc06c7e33b5d4725f05e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 35cbdaf75394e1061a9bd64b4698915c6db58512
Message-Id: <164789031430.24158.2098302172442601304.pr-tracker-bot@kernel.org>
Date:   Mon, 21 Mar 2022 19:18:34 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 21 Mar 2022 11:35:47 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_paravirt_for_v5.18_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/35cbdaf75394e1061a9bd64b4698915c6db58512

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
