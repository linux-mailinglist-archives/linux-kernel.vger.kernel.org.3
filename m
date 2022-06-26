Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1261855B331
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 19:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbiFZRg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 13:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232019AbiFZRgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 13:36:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D26CE0B7
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 10:36:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1CC90B80DFA
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 17:36:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D257CC341CE;
        Sun, 26 Jun 2022 17:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656264973;
        bh=fhBOhWpiQpH///1EZe/AwoeDP2EewiZn8Y5K3QPvkes=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=LgLBa14cR4HYXqZEQl0j1b5mSHrhEQlh8jqEuc+ZuXl6m0ppO99/29S+DFcNRMDTq
         xeOHyoL+Fb3COxwkGmQajKZsvyCgutUr36lo/T5UswWVk4KbQT6/7NosliFpW7+6K2
         e3ULdB+bSSTpPRbPmy6t0NYfbfjjz0koPJK9CL65hMY/QwvhIHagvlbd1I2PnwJSCp
         LP/TFCaXdkNdYIYcUaEJ7CkqJt5u2EIJhoApbzh40G08DET3DoevCMdXTs30GadE7S
         1d/2zEDpCOu291KA0Kb/W5J1NQ4oOIX9LqHahzUp3PCfhH9AHu57tyzQUIn2kKSyJz
         GZCn3vKOhTeuA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BBED1E73875;
        Sun, 26 Jun 2022 17:36:13 +0000 (UTC)
Subject: Re: [GIT PULL] exfat fixes for 5.19-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAKYAXd9C+9RAF=M2h-gVXpnUDq-JQSF857agrE5c=eZQjEZaVg@mail.gmail.com>
References: <CAKYAXd9C+9RAF=M2h-gVXpnUDq-JQSF857agrE5c=eZQjEZaVg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAKYAXd9C+9RAF=M2h-gVXpnUDq-JQSF857agrE5c=eZQjEZaVg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git tags/exfat-for-5.19-rc4
X-PR-Tracked-Commit-Id: 204e6ceaa1035cb7b92b156517e88842ebb4c7ff
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 97d4d0269706c468ec57cbb95a79f1a5c8fd1892
Message-Id: <165626497376.22456.3775805673952551561.pr-tracker-bot@kernel.org>
Date:   Sun, 26 Jun 2022 17:36:13 +0000
To:     Namjae Jeon <linkinjeon@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 26 Jun 2022 14:04:41 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git tags/exfat-for-5.19-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/97d4d0269706c468ec57cbb95a79f1a5c8fd1892

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
