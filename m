Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5965952AED7
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 01:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbiEQXwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 19:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbiEQXwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 19:52:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 791C13EF0A;
        Tue, 17 May 2022 16:52:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 39BB0B81D64;
        Tue, 17 May 2022 23:52:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F1DBAC385B8;
        Tue, 17 May 2022 23:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652831531;
        bh=pidzj9LQpDSlLk184wVZiQFLOuoGvNzKFNDlujLBMYs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Y2i1StfN1Bx4j+HBYYt2CZsSUqeEvhDaWf7IEhUMhCprgqUWW9rDdGHMAfDsGnbH2
         wYWLHe9p/4XNKoUG2z/rsd69CMWt5Cu8Xu8cqNVfPRqzaPRwrxJnO3mSs9qubiZZFW
         40KpbMb9zFjRyp4rnPLcJHPqogJqtVMSXCoQ9iJKLgJd0Yq2IH+HSMrnbBBpQKN/f2
         Ayd7/2c0NDjKbly4DwvFAtsZS0iL3ip85zOXvMZymTzjZpQ0qCMz2z4xYgg+BJ7XLE
         0xe7C8By5O3HXS4lDH22s2Els70jOFHcu9b2qZjh5dVThU67DuF1UzUAs6ikMPmuu+
         F7o5LmexDCgBg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D024FF0383D;
        Tue, 17 May 2022 23:52:10 +0000 (UTC)
Subject: Re: [GIT PULL] Thermal control fix for v5.18-rc8
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0ghkfwSznen8DTiS_O_obYWmOw8R_RyqK4ZYur+Kkus8w@mail.gmail.com>
References: <CAJZ5v0ghkfwSznen8DTiS_O_obYWmOw8R_RyqK4ZYur+Kkus8w@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0ghkfwSznen8DTiS_O_obYWmOw8R_RyqK4ZYur+Kkus8w@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-5.18-rc8
X-PR-Tracked-Commit-Id: 7b145802ba545ecf9446ce6d67d6011b73dac0e0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a1f37cd8171cfcc1e9f79b914add983706b4e7dc
Message-Id: <165283153084.29538.13138272985125674723.pr-tracker-bot@kernel.org>
Date:   Tue, 17 May 2022 23:52:10 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 17 May 2022 18:36:30 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-5.18-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a1f37cd8171cfcc1e9f79b914add983706b4e7dc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
