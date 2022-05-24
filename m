Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60E4A531FCE
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 02:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbiEXAXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 20:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232311AbiEXAWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 20:22:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E9A433B0
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 17:22:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EA9F0B8170A
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 00:22:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8CE82C3411C;
        Tue, 24 May 2022 00:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653351770;
        bh=PRD2FZr37L8i3VgQXnnXLaCdI7OFmkH9eP0wJnOHZXo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=VyWYdChkmYUx5XtrpATcMtIQdifAXtNZt1KKsYYywrrb3C8ttuHq1KqV/3uL5H7Ch
         Hr2TUqItjGkFNfE6sWuPDMj9jF+Yr/tpFNu9Fsy51+jNlzkNcbpi6T7+qtewv9tqfW
         cGpnzKPsUH1/6m/4LN1VqRPEXWlrXKFMQ9hLaOjI8PBzxPRSoT7cGQ3Pq32n+HcuZF
         Uk+lmIHo+sU7+X4D47uSJU5CGB0JXd3n8dx1ghd+fstbXRr/16o0lDYf1z2PXS3eKc
         Np/DsYeJezPhLFchmgSHuhCQLQFgsVHGa/PHI/UxiqSVwIaAkl9M9vwzwamYJ+Hdvv
         8CByu76SxsQ8w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 75792F03949;
        Tue, 24 May 2022 00:22:50 +0000 (UTC)
Subject: Re: [GIT pull] timers/core for 5.19-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <165329268338.3801280.15015388773053623832.tglx@xen13>
References: <165329267741.3801280.534077656528571075.tglx@xen13> <165329268338.3801280.15015388773053623832.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <165329268338.3801280.15015388773053623832.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-2022-05-23
X-PR-Tracked-Commit-Id: 317f29c14d0cca09952f1022491454b23455ebcb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6e01f86fb2025111c77101254f1442ac137089cd
Message-Id: <165335177047.4476.17071716908363684129.pr-tracker-bot@kernel.org>
Date:   Tue, 24 May 2022 00:22:50 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 23 May 2022 10:02:09 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-2022-05-23

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6e01f86fb2025111c77101254f1442ac137089cd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
