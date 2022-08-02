Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B28D5881ED
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 20:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237976AbiHBSeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 14:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237518AbiHBSeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 14:34:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19135474F9;
        Tue,  2 Aug 2022 11:34:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB3B861245;
        Tue,  2 Aug 2022 18:34:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1E6ECC43470;
        Tue,  2 Aug 2022 18:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659465250;
        bh=zWEQSiuRY2c+v7MzktmbwOtb8tZAB/mFbrukyNj4qWU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=WHtLxiDvQDk6aeSWc1Su9645QpcYp3EH9ADoNfGkXm2fzl1E6y3oDBNYHlBSuiMYx
         D8MYKR9MHg/TaLeGeoHni7zM4rnQe8MNDccqNuoHwwDj5LEyTIImFXXcNoA1Il+6U+
         rJiO4Ysa9E8PLi8Ipfij5zRSx/wGDgFQgumiZgsZp2HvYq3kgz/NmFbCaLP757JTN7
         rdjxMM14TRWA2lpCMt5uTXmum2UT2lAUypGuo368jnBaJbheZNP4Ju3z4HJl8ysgiG
         dokeGJTVDGFdDoVIf4KQ0BMAPXPXfk0ZJ0gnHRRVN7LrF5H7vBOEGJ/4CBbqnKsdkT
         fQeTClA1YSoBQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ED98DC43142;
        Tue,  2 Aug 2022 18:34:09 +0000 (UTC)
Subject: Re: [GIT PULL] Thermal control updates for v5.20-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hX=o5nCmYgLekz_XMRfQcdPyFjC+=+BqEAvetNGD3ASw@mail.gmail.com>
References: <CAJZ5v0hX=o5nCmYgLekz_XMRfQcdPyFjC+=+BqEAvetNGD3ASw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hX=o5nCmYgLekz_XMRfQcdPyFjC+=+BqEAvetNGD3ASw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-5.20-rc1
X-PR-Tracked-Commit-Id: da9d01794e31714a90a38e395c14723fb46f90b0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c1dbe9a1c86da098a29dcdca1a67b65e2de7ec3a
Message-Id: <165946524996.2519.11074669177620457949.pr-tracker-bot@kernel.org>
Date:   Tue, 02 Aug 2022 18:34:09 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 1 Aug 2022 21:53:19 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-5.20-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c1dbe9a1c86da098a29dcdca1a67b65e2de7ec3a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
