Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E80385A1868
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 20:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243170AbiHYSKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 14:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243145AbiHYSKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 14:10:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB1393DBFE
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 11:10:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3638261CFD
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 18:10:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 94D24C433D7;
        Thu, 25 Aug 2022 18:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661451003;
        bh=3YxFUVo4GWvXT5Nf/enbbgFCB8bQ2703z8YArEPyGdA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=PotAbxxixX3onRSYa5EE4AHp7NnhymsNR25vBFq4pvLqJK6T/7ypqjF1+rIzQFMJw
         IFcbKQFij5IlZz5CNNbmNGGWBOuK/srY5V9foc9bgwV4EmyFKyEZfnQ63qxkJqN9bW
         o+R/MviatWROQ3pS/HxTUdQoInrf1hpNgmbhjDoQmZUhZD3mAT1z4t6rvN5Em4hDRo
         xqVlawQd+kdoaivlgT/l+D/sooJmomnjVVAFm7xYvQc1X9lqVT4pE8fPP73+ivhVKw
         xQNEglCs+6tDZF2oHWqnJV4CNQY0LlL+NWmwRWGbWYDKyAhXMZM7b9P7bBswRGPGgH
         oEdu9Vz/dE0Gw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7A0DCE2A03C;
        Thu, 25 Aug 2022 18:10:03 +0000 (UTC)
Subject: Re: [GIT PULL] ftrace: Fix build warning for ops_references_rec() not
 used
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220823103512.603d3b44@gandalf.local.home>
References: <20220823103512.603d3b44@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220823103512.603d3b44@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v6.0-rc2
X-PR-Tracked-Commit-Id: 123d6455771ec577ce65f8d1bda548fb0eb7ef21
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a86766c49e808bbb74b97d15cea4707a13d2ab52
Message-Id: <166145100349.12987.3605442378250859666.pr-tracker-bot@kernel.org>
Date:   Thu, 25 Aug 2022 18:10:03 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wang Jingjin <wangjingjin1@huawei.com>,
        Song Liu <songliubraving@fb.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 23 Aug 2022 10:35:12 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v6.0-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a86766c49e808bbb74b97d15cea4707a13d2ab52

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
