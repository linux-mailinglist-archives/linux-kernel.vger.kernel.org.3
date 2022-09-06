Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 149605AF458
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 21:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbiIFTWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 15:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiIFTW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 15:22:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88508A925D
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 12:22:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 443F0B81A0A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 19:22:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F33D2C433D6;
        Tue,  6 Sep 2022 19:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662492146;
        bh=jqh6xuQgKJlV7O/dZmQDjPjv7R2ccUKSljtIZ02JbkQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=QGi+dzdr0xJVGyCvAssL9qc7xQohCA98+jehmM9F0wxfI6zWA4YMoG1lIiAVqhmFO
         hBXPHXZBHHoS+iTrooOhDgWKZ65ZdpIvX7lUNKU+oyRVuTtGBut7pG7A/A7rbjxlfr
         OnLQs70Mg3PItwAtYN2K2bS/I3dv4D3L7vE9Qz5CAQwpFWtFQEpIaozIZJlpsWv4F9
         a/me+vtg+IHT4sE2uEmv53ZfB6rjOn0l+Qoe25rlVi7nyxkPhhYAQu3BMpyKlWusN+
         C/zPuItje/71oHQ3qcOCgr9K5hULkKr3qhwqqf2QHioOiEK1BDmWDP67RvEBj4k3GG
         HobKUJ5G0iApw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E2E08C4166E;
        Tue,  6 Sep 2022 19:22:25 +0000 (UTC)
Subject: Re: [GIT PULL] erofs fixes for 6.0-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YxdyU26Us1vmDxVJ@debian>
References: <YxdyU26Us1vmDxVJ@debian>
X-PR-Tracked-List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <YxdyU26Us1vmDxVJ@debian>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.0-rc5-fixes
X-PR-Tracked-Commit-Id: 2f44013e39984c127c6efedf70e6b5f4e9dcf315
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d2ec799d1c1be847d6a70704fe586ac4d14265c8
Message-Id: <166249214590.30445.1453272856392064922.pr-tracker-bot@kernel.org>
Date:   Tue, 06 Sep 2022 19:22:25 +0000
To:     Gao Xiang <xiang@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, Yue Hu <huyue2@coolpad.com>,
        Sun Ke <sunke32@huawei.com>, linux-erofs@lists.ozlabs.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 7 Sep 2022 00:16:19 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.0-rc5-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d2ec799d1c1be847d6a70704fe586ac4d14265c8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
