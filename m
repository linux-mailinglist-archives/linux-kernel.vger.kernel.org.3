Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C42525881EE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 20:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237567AbiHBSe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 14:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237961AbiHBSeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 14:34:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE8A647BAA;
        Tue,  2 Aug 2022 11:34:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 44F0E6134A;
        Tue,  2 Aug 2022 18:34:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A9371C433C1;
        Tue,  2 Aug 2022 18:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659465253;
        bh=ENm5yflqUj6etoQfsnChoUAPyTebYuwIL28qY8/XELY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ZTBS9CQDeYCbaDV0ewQFwZt3Df0K+2lRwLU1A5zhWYROPdJ6FayhxBLs7cO0NAk6j
         E5UTP6PypUtj14NNvhgh8Y0Gpjo6i6s+e6eNgdsa0UodMWTJ6v6y3COOyVlWgyc6o/
         44gS7heKUWIIDEd5s8F2imA+/4Qdio1FSElx8FIcrckrYaIGrY2GiyPs8/a25ehcqG
         Uhlqxq6/I0ph6xR9rsLH8bv0ntVmoiJL9F2YOUx4cFi3SwleYi/wzL4eTFexm9bXgY
         HCaoOsqJg1yPwBFVLB1r6x5Yr+pzGz8+iEyHI6TeVea/U1nYYtwgGMK2VXlUmrh1m8
         94uJH9yZrpjow==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 90E48C43142;
        Tue,  2 Aug 2022 18:34:13 +0000 (UTC)
Subject: Re: [GIT PULL] Power management updates for v5.20-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hLRoevo3sOqLjDoAU82CVbvE7-dica+8_+_LfHAPb=YQ@mail.gmail.com>
References: <CAJZ5v0hLRoevo3sOqLjDoAU82CVbvE7-dica+8_+_LfHAPb=YQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hLRoevo3sOqLjDoAU82CVbvE7-dica+8_+_LfHAPb=YQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.20-rc1
X-PR-Tracked-Commit-Id: aa727b7b4b67dba2a6cfebdd98767c455c2b3d69
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a771ea6413c00cf4af0570745f2e27084d7e2376
Message-Id: <165946525358.2519.14605775863848930879.pr-tracker-bot@kernel.org>
Date:   Tue, 02 Aug 2022 18:34:13 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 1 Aug 2022 21:51:23 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.20-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a771ea6413c00cf4af0570745f2e27084d7e2376

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
