Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1FA64B2E37
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 21:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353136AbiBKUF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 15:05:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353103AbiBKUFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 15:05:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E79DCE6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 12:05:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A01362000
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 20:05:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9CE16C340EE;
        Fri, 11 Feb 2022 20:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644609920;
        bh=X/+ravp8QiNJfs+JtdXQSoxZcUiZhVaI/TN5+FRJ6FA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=RsNFth+QFR7rxFNptgysTLOEh2jxCr8CJKDGNkTOonoU4q2QekXY31EaWidyoDaky
         mNr07GOzXSgJViRcSXbuW/JL8wFgjCvFoHmmFrCz0XTffA+EbNZUu6qgf76oQ/Nh+1
         UWK1DQ6PeTZkH9IEULOS4CqQFCZMnC6yuO6SpNBSBEbckluURjG6eRRLw+lN5QslUK
         drlnSWVDFSWCdK8AHuL/QkrByzapUZvOjMxupTu0ua7reM+NFm4vUBOPrdOXLyf3If
         jQlpodrQASkcPTCQHA/+HYyMpxaAKoU1XDXWEcA+OxyiSlmk7o99h3gPHJ+eWG0oPS
         MMo277tCjrHWg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8A5E9E5CF96;
        Fri, 11 Feb 2022 20:05:20 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: Updates for v5.17-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220210193154.0bcd3700@rorschach.local.home>
References: <20220210193154.0bcd3700@rorschach.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220210193154.0bcd3700@rorschach.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.17-rc2
X-PR-Tracked-Commit-Id: 3203ce39ac0b2a57a84382ec184c7d4a0bede175
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 32f6c5d037740835043f58f5c59b29841dbe39ff
Message-Id: <164460992056.1412.6755748836991931666.pr-tracker-bot@kernel.org>
Date:   Fri, 11 Feb 2022 20:05:20 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        JaeSang Yoo <js.yoo.5b@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 10 Feb 2022 19:31:54 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.17-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/32f6c5d037740835043f58f5c59b29841dbe39ff

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
