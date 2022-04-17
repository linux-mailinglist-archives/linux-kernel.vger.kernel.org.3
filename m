Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C644E5048C5
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 20:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234700AbiDQSJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 14:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbiDQSJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 14:09:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211681BEB3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 11:06:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A76E960C02
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 18:06:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 17E76C385A9;
        Sun, 17 Apr 2022 18:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650218818;
        bh=S/fuXmDS1XoI+nET+aUSs99FrSJzwjzC004PXgrz5xY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=A/TL+RpGdVTybhqLT1+2d/jfJtDuWvJST1gKopqnlLyNpq54UL7wVYwStZWsOEupG
         rP/Xmj9uOMWB9vQ57HxQp2jQrB7wgmZzzCXaU80OXfpjDI2Wv+rN05cTnqv/BAyWIV
         TvWW2uh3mFlltkWKaWmKkLGSsumFkjPfHaDsZKMqkm2kYJZbqJsd2I6tkFu6y2tLGQ
         cmDLI/uzIq2McK7iJnhyoz8wUu9vYpwuAUELjU6KXJmnIeu064VXAiQAGOkYiTax+q
         8ZeegY/A4prTkubPkSq+1wlx7I6SFSjmHadrw9kW1sWzRbS5sjSKhF2zczZXBrG/GZ
         HEyQdHpSflY9Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 01666E7399D;
        Sun, 17 Apr 2022 18:06:58 +0000 (UTC)
Subject: Re: [GIT PULL] xen: branch for v5.18-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220417081632.11230-1-jgross@suse.com>
References: <20220417081632.11230-1-jgross@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220417081632.11230-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.18-rc3-tag
X-PR-Tracked-Commit-Id: 262fc47ac17461c8cdc71c70aff6c3ea45acb0b9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a1901b464e7e3e28956ae7423db2847dbbfb5be8
Message-Id: <165021881799.30246.5843841963508898915.pr-tracker-bot@kernel.org>
Date:   Sun, 17 Apr 2022 18:06:57 +0000
To:     Juergen Gross <jgross@suse.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 17 Apr 2022 10:16:32 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.18-rc3-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a1901b464e7e3e28956ae7423db2847dbbfb5be8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
