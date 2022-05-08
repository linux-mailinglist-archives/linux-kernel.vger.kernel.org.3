Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4A1C51EF42
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 21:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241193AbiEHTIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 15:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379988AbiEHSox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 14:44:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD8AB85F
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 11:41:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 53B42B80EA3
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 18:41:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F1EAEC385AF;
        Sun,  8 May 2022 18:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652035260;
        bh=To0H3REJDnUxGONC8RvxewdFgEv8lZWnNRseQeban4o=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=UCJe2e68f2gmO50T28F1yl5zRjPM8bSQp9leZggicSrsslRvpkUxW6IcQEMflqHIX
         I+jskciRdQgOvgW3c7p+N66FFDU8aIVF2ttrwi2Mydn7rGLZNnv9ZfTqeldGbVJ5Fq
         iK1cPOBniR4AsE6v2zkoWZPVaNQ0V5jnGvTf0evVAskkhAetSgVGYS0xV0cGcgQiTD
         8Bp5oPOYzlPDterrnamPburhfjgPgFl3QKadYElSzwc6wl/EjQQPpgPMsQkxnSY+n8
         QXlUlUYyF8L6ndWRSK31gkcyAKkn2bB3hF324iYI2ZCiIpZuu1v6wowmC7lK2mlyF+
         5qWPcL6mMKqzA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D0900F03928;
        Sun,  8 May 2022 18:40:59 +0000 (UTC)
Subject: Re: [GIT pull] locking/urgent for v5.18-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <165201148366.536527.18041857851988281678.tglx@xen13>
References: <165201148069.536527.1960632033331546251.tglx@xen13> <165201148366.536527.18041857851988281678.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <165201148366.536527.18041857851988281678.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2022-05-08
X-PR-Tracked-Commit-Id: 60cc5468daaefc18ffc081dc484bdaa1bd270561
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ede4c6d78a32f9b7dfdb12d5edf8c8c4c84c729a
Message-Id: <165203525984.974.8985636765269566104.pr-tracker-bot@kernel.org>
Date:   Sun, 08 May 2022 18:40:59 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun,  8 May 2022 14:05:22 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2022-05-08

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ede4c6d78a32f9b7dfdb12d5edf8c8c4c84c729a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
