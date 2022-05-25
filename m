Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A197B53353A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 04:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243483AbiEYCQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 22:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243770AbiEYCQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 22:16:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83BF51D314
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 19:16:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C4626153B
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 02:16:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6B500C3411D;
        Wed, 25 May 2022 02:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653444993;
        bh=ps3onEs9tU4RQ6uIHduRmySzcnGpiXAe7aevNH/U+EA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=e+ngpJ/m03TtARLBAa8FikoHobuttetbo/8A/ZTakoOssk/v611X5B2Br/nQYHj+G
         XMBJFCizyD8eQXxLNqj+asN4oYv29kQ2fcnq33h9CmZQe+LjEfnGquBALAQaE+Q9p3
         EK4ymKWAw7F8sAnMFfrCZLoNX5wCPWNRCdGIAYHnF1DVA6OgU530LV63Fhgq0WPaRP
         vD8dy6u3cM8BWqseSuwwcVl4bOj2Tvnlv+aV3iPzSvpDlZCJaJHDQH02O2inn1uicJ
         XfLuSODd5tzlqwpdQ/vOxzZsdLQPXGYyF3shKhTfSJsdN0ObH8m8TsTzYUOC910+Ev
         ki+r/zY7O1rIQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5AFCAF03938;
        Wed, 25 May 2022 02:16:33 +0000 (UTC)
Subject: Re: [GIT PULL] gfs2 fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220524194145.884805-1-agruenba@redhat.com>
References: <20220524194145.884805-1-agruenba@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220524194145.884805-1-agruenba@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v5.18-rc6-fixes
X-PR-Tracked-Commit-Id: c360abbb9db298d0548b31e1a86a48ebb157d7cd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7208c9842c50f97327aac20be62edc8ad230f05c
Message-Id: <165344499336.22339.4867902251802449445.pr-tracker-bot@kernel.org>
Date:   Wed, 25 May 2022 02:16:33 +0000
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 24 May 2022 21:41:45 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v5.18-rc6-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7208c9842c50f97327aac20be62edc8ad230f05c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
