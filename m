Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3544F4E7D6F
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:22:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233142AbiCYVI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 17:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233106AbiCYVIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 17:08:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232E21EA2A1;
        Fri, 25 Mar 2022 14:06:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B398761D41;
        Fri, 25 Mar 2022 21:06:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 25652C004DD;
        Fri, 25 Mar 2022 21:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648242408;
        bh=EfF4jiYlAK+1A5jDv0biMDlGQ2YOqxDmdKoxitYrhvk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Nh6Ft6nvveXrqSJWEb2RdCfiP+P7HOn2+eMmsoKph0V21u9K0KwJnpEa/rpidZqlB
         a28myp5RU6QrfJ4JWMVCyp+UqMK+UG+kQb1Qn1IRu3A9etwz9clPGCnFLHXfNwWTdx
         gSXvVqEc9h7vigFN7ZBLmJEpm9ayRNer1ABah5RLtWbfYuqBS5NLCMHi3103R2iEEq
         bK4/XQplQYnkB20jp4G3ZvWg3mot9LOUU+fmslbg4jScy7+9oCSHEAuXcs8n/fzvBl
         24JRL1yiR7XQ/i6WzUfWlhfwSGnwfzcR8+LfiNl8a0voZvUEFnWnx+e6Xq6Y41nJy6
         QTxMAW+BDmsxA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 06685E6BBCA;
        Fri, 25 Mar 2022 21:06:48 +0000 (UTC)
Subject: Re: [GIT PULL] power-supply changes for 5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220321180324.aruy3fhiopzjkr32@earth.universe>
References: <20220321180324.aruy3fhiopzjkr32@earth.universe>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220321180324.aruy3fhiopzjkr32@earth.universe>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v5.18
X-PR-Tracked-Commit-Id: c22fca40522e2be8af168f3087d87d85e404ea72
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8eb48fc7c54ed627a693a205570f0eceea64274c
Message-Id: <164824240801.8431.17253316786520963063.pr-tracker-bot@kernel.org>
Date:   Fri, 25 Mar 2022 21:06:48 +0000
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 21 Mar 2022 19:03:24 +0100:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v5.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8eb48fc7c54ed627a693a205570f0eceea64274c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
