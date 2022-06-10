Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9269546C48
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 20:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346205AbiFJS0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 14:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349804AbiFJS0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 14:26:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A962CDEC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 11:26:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3F6BAB836F2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 18:26:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0C1A9C34114;
        Fri, 10 Jun 2022 18:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654885560;
        bh=hnJGEJ6cGM5h+26mHdcmFFEsRgKuweQknb6iEEtMA3E=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=LE4Se7DCHVSvtvi3x7Cx7yZmxbN4gLsxqeZ3lEUZhlffWdVuMXR7GkYvAv3VCSRmq
         M6uZe5QV+TxYmmoN2O9JVLFdSWl7kc4SD/eB+pPC58aqKHTHcL1PQA4rop8H7ErDnT
         3zZUNKeErrRLfxaiaFoSirpJceI3WMlFz0k2s6kkZDm20BrpkA64E6OmCOCEys3IpN
         qNXL9mSl1k5tGf3FSSI+v2Uq07kCYjZOKVT0PFH1gtI7RvOqpl1RdUKFU2deGJdN8n
         klwyEuNEai5z0pTPty7OJxmZow2rmsR30Fg7iaq48nAe1PqAQrCvefgJeQ9A3rDv2j
         8OUqi5DmmOO1A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E8375E737EA;
        Fri, 10 Jun 2022 18:25:59 +0000 (UTC)
Subject: Re: [GIT PULL] xen: branch for v5.19-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220610044858.30822-1-jgross@suse.com>
References: <20220610044858.30822-1-jgross@suse.com>
X-PR-Tracked-List-Id: Xen developer discussion <xen-devel.lists.xenproject.org>
X-PR-Tracked-Message-Id: <20220610044858.30822-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.19a-rc2-tag
X-PR-Tracked-Commit-Id: dbac14a5a05ff8e1ce7c0da0e1f520ce39ec62ea
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f2ecc964b9414a407828f9bef242b77483e95a6d
Message-Id: <165488555994.32117.5799921241915272315.pr-tracker-bot@kernel.org>
Date:   Fri, 10 Jun 2022 18:25:59 +0000
To:     Juergen Gross <jgross@suse.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, sstabellini@kernel.org
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 10 Jun 2022 06:48:58 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.19a-rc2-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f2ecc964b9414a407828f9bef242b77483e95a6d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
