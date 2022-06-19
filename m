Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3EB550B52
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 17:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236855AbiFSPCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 11:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236193AbiFSPBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 11:01:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC7AB847
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 08:01:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 08AEFB80D2F
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 15:01:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7EEF9C341CE;
        Sun, 19 Jun 2022 15:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655650887;
        bh=bXbp7awKJovcCh0OIf9fctWUl5zIWszFqAfg+KWAKLs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=l8LUIbxJmAArAlfMwWuDWi1ogTlMNJ9gX9IpKmoVOf9WFbt8HfnmVRTpR1sgldElZ
         7paiHthqJn0XQxc7Na2XUJOAN3uwE79wIiAgUrHoPEqNanwo2QG8oOuwVQDW9RTAV3
         IXb3q6IfrtpqFg9TW4QQkWwf/fwMB6DkHJtxfp79/JJBh+IcjZ9lAhZiE2edRusygs
         dV/85Z3vOWuIuW+9Gqbb2EUuxJWr1fccFfWdO5aI8TGD94kkq9J/lcGELdrIaUiOTb
         9v4vUn35uAVcY0NzE4uPKPkI99CaPbUaxPfO0z61x1VV4ER/GK4eSBa0y5BjVrtEq4
         HikrKNtO53/CA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 65359E7B9A4;
        Sun, 19 Jun 2022 15:01:27 +0000 (UTC)
Subject: Re: [GIT pull] sched/urgent for 5.19-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <165564430177.1413209.17080752287209695297.tglx@xen13>
References: <165564429738.1413209.17302088152547038708.tglx@xen13> <165564430177.1413209.17080752287209695297.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <165564430177.1413209.17080752287209695297.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2022-06-19
X-PR-Tracked-Commit-Id: 04193d590b390ec7a0592630f46d559ec6564ba1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 727c3991dfdb3ff104e33307e287692ef01daec9
Message-Id: <165565088741.16911.2515291262656028543.pr-tracker-bot@kernel.org>
Date:   Sun, 19 Jun 2022 15:01:27 +0000
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

The pull request you sent on Sun, 19 Jun 2022 15:12:38 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2022-06-19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/727c3991dfdb3ff104e33307e287692ef01daec9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
