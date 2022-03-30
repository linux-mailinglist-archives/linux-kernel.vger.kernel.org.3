Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AFA94ECFCA
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 00:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351717AbiC3WtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 18:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351709AbiC3WtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 18:49:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2630C2BB18;
        Wed, 30 Mar 2022 15:47:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D05F0B81E0B;
        Wed, 30 Mar 2022 22:47:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8C247C340EC;
        Wed, 30 Mar 2022 22:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648680433;
        bh=napctfPmUnuPT4JQd2K3wnmJ9MbbAeRpHUscYsH67m4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=TLQul/rXBarYSPXj2G86GQjc1YEZGVzQiswzTfsX/7WtfZVqKg44yg6YuWMvut0Y+
         +lAT5Pr70DbrEv0oz9bDwu6Wx0rSaDrwpVfEHPFJHASeNoI2GBohzPcD2tENrrI+H5
         43BfpRP3RrcwE3zMMrXUAaA05TfxGSpwz3uJxyaqWqmvLJq6YwGMmj85+zifFRjAwj
         xEop4sMqWRpLBFkUmBzBJN5k1QflLnT8j9Zq51d59Dl40MN1j7ddqwPvVyL8GNn8HY
         Ys0DqgsoxO5+0VP5xaJ7R/eYii4JcpPnqQf2/baWNHmVNlGNC3yaGNfydjjzsKXcOm
         trSjykeOE9j5Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 78500EAC081;
        Wed, 30 Mar 2022 22:47:13 +0000 (UTC)
Subject: Re: [GIT PULL] Modules fixes for v5.18-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YkOIOQPY9N66jp1f@bombadil.infradead.org>
References: <YkOIOQPY9N66jp1f@bombadil.infradead.org>
X-PR-Tracked-List-Id: <linux-modules.vger.kernel.org>
X-PR-Tracked-Message-Id: <YkOIOQPY9N66jp1f@bombadil.infradead.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/ tags/modules-5.18-rc1
X-PR-Tracked-Commit-Id: dc0ce6cc4b133f5f2beb8b47dacae13a7d283c2c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 57c06b6e1e74b62eabaacacbe40bdb29c7e990eb
Message-Id: <164868043348.15820.3114847338585386690.pr-tracker-bot@kernel.org>
Date:   Wed, 30 Mar 2022 22:47:13 +0000
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jessica Yu <jeyu@kernel.org>, patches@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-modules@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        Vimal Agrawal <avimalin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michal Suchanek <msuchanek@suse.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 29 Mar 2022 15:29:13 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/ tags/modules-5.18-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/57c06b6e1e74b62eabaacacbe40bdb29c7e990eb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
