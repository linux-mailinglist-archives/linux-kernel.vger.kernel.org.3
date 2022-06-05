Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE9C253DD54
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 19:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351496AbiFERQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 13:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351419AbiFERQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 13:16:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702504EA0C
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 10:16:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 23D04B80DB0
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 17:16:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DF576C3411D;
        Sun,  5 Jun 2022 17:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654449380;
        bh=gtfTjE2G5QCOXUJN0JF2bESA9NEERHvQCR0TgsXRPo8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=KBF3B9RwmP451Q38kpaNMUT2K1X1jmVfMgbWHYCvliLex62UjpQrZoaO2xFmmudBT
         9oTJQnSA47s608ZtAqsSpmIUZcoTiZ9d6PIv3JGLuXmKp4/pFPLHpwfXRQqZumwsNA
         Q1N2CSNjVqqERXBqNCEtq/Lt2lUMUAZNwSadzroC0t4GxLoyS9Rt9ZuX12L0pd+MR8
         4cAf4bYLBWLNKselXX0SzReVG5SJV71lQUFsFwogS9IsM6YQqMtEyxFWomOakGbCYK
         zCHdeL/tdWYt4zl0ygzRLIdZ+7B8HlhHyb6oO/cXcxzP4hAYolNkJ9ajHPLlXFaHA3
         +FWuK4isX4y1g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C00E5F03875;
        Sun,  5 Jun 2022 17:16:20 +0000 (UTC)
Subject: Re: [GIT pull] objtool/urgent for v5.19-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <165442136963.152751.14259048792272164569.tglx@xen13>
References: <165442136963.152751.14259048792272164569.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <165442136963.152751.14259048792272164569.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool-urgent-2022-06-05
X-PR-Tracked-Commit-Id: 2028a255f4df3af9e759f01f958d3237f825f256
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 44688ffd111af31984237f0cba05f2e201eac530
Message-Id: <165444938077.7539.7958098958836789558.pr-tracker-bot@kernel.org>
Date:   Sun, 05 Jun 2022 17:16:20 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun,  5 Jun 2022 11:30:50 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool-urgent-2022-06-05

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/44688ffd111af31984237f0cba05f2e201eac530

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
