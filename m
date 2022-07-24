Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EDE157F617
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 19:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbiGXRBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 13:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233555AbiGXRBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 13:01:07 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACEF4FD20
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 10:01:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1EABACE0FDC
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 17:01:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5A307C341DE;
        Sun, 24 Jul 2022 17:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658682062;
        bh=EIURqzu53Epz1Ek+04ymRTvZxBOAHWbGaDyrVvcj2RQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=oBpFQn8P8K0eJC+r0p5s0kniPFiKBmPA3W99T4bk1WE6nDnvgU5KOfDQXtym6X5/7
         JKRQU7k6+oVTQxnn42+heLbj+BiWYcVCz0FO6Zlf9i3XOceETPOPAv+QZ9gEfVQEGr
         SnhsmWOpwPIwXEEA5SxPNk9u2z/qJyXtmYBcPPLlbZ9Q5qGxTpr2MLYssByexh7+6E
         rNQ0mkrgr5kYKlOXyXIGKLujTke4auXNpFWNO/rMiFcdDXbrR4Vxdrin3wiQnKR1eD
         x5bx+z7iVPRbnfpnCCgaFMCbWrHZC8+tdZ5HRUjcbk2omJ9vcoYFHZsgO6OHkXoQWg
         HCd8WC+tWAzjQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3202FE451BA;
        Sun, 24 Jul 2022 17:01:02 +0000 (UTC)
Subject: Re: [GIT PULL] perf/urgent for v5.19-rc8
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yt0QkASKgozBD253@zn.tnic>
References: <Yt0QkASKgozBD253@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yt0QkASKgozBD253@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_urgent_for_v5.19_rc8
X-PR-Tracked-Commit-Id: b0380e13502adf7dd8be4c47d622c3522aae6c63
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: af2c9ac24019ece9281e606662e5c78fa67f5930
Message-Id: <165868206220.25283.8010031676742068896.pr-tracker-bot@kernel.org>
Date:   Sun, 24 Jul 2022 17:01:02 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 24 Jul 2022 11:27:44 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_urgent_for_v5.19_rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/af2c9ac24019ece9281e606662e5c78fa67f5930

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
