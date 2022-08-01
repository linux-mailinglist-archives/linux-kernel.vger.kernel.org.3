Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 104F6586E77
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 18:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234014AbiHAQSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 12:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233855AbiHAQSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 12:18:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4234F3E77D
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 09:18:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E62A6B815A6
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 16:18:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 84F12C43142;
        Mon,  1 Aug 2022 16:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659370683;
        bh=cCZw+mC5AUx8GHUZHP/7slrWF+REQUUg2wxposz99R8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=MsbmzXm+L1oRTZDSaJSbSU7G/13a4WN2r/+JYR7GPy5UWI/aXzFi4eBR93A9/3lNA
         ocKJgyrfR4/i+zdi2Eh5pFI58qM+7BCn1w6cAFNRjyVP6fgwD5jTFgoR7hlbXGnEUe
         xcMfDiyvIy8+VirFjJNNqI6K0Jrbif9d8mSGx8WwBKzWYNbu61sSxCOsQXL6fxIwLR
         UFeRTqYwW7Uk9Qw3yKEVyRlznlbql0qTsu/x3AyC1KLfk75db7Kb2rpsJqm9dtymdX
         mgdxw6EBJL4uQr2tDXysezCIZAJ7IqtfPt3f/gfwVBRaKW+Lg9sQ+Rqaqx705/KM5v
         L7g/quXnr9fWQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 71B32C43140;
        Mon,  1 Aug 2022 16:18:03 +0000 (UTC)
Subject: Re: [GIT PULL] dlm updates for 6.0
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220801144329.GA10643@redhat.com>
References: <20220801144329.GA10643@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220801144329.GA10643@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-6.0
X-PR-Tracked-Commit-Id: 958589892218e43ec83d5562438e0c1cc44a4716
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eb43bbac4c3c97b34b72e1dbd91544ee0d48e8d6
Message-Id: <165937068345.17475.17761614919373675607.pr-tracker-bot@kernel.org>
Date:   Mon, 01 Aug 2022 16:18:03 +0000
To:     David Teigland <teigland@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cluster-devel@redhat.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 1 Aug 2022 09:43:29 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-6.0

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eb43bbac4c3c97b34b72e1dbd91544ee0d48e8d6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
