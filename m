Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67DA7533273
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 22:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241652AbiEXU1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 16:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241618AbiEXU07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 16:26:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547294757F;
        Tue, 24 May 2022 13:26:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E5EB761716;
        Tue, 24 May 2022 20:26:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 55B84C34100;
        Tue, 24 May 2022 20:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653424017;
        bh=VzSnHv2jht3fJXnclXKcF+5E7OE2pi4GuoRnLFaDJsM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=OrGZsLGAx2UCo/PT6aYeLxhQ5P9zTRoJT3RlP5N/K0aH31Jo1rCjSSvmp/u9ltBvK
         x0BQu7ZoKpDqjiSNsEiqWK0CWQ9OPlZpmyUGGQZJ83S0DkumPBh/oEnRCSB3fewB+P
         wI/s/89tn7qnIOnNuiWCXklLdhKMr6hUffRDoKlKdYIBlze0crovaPMGVbvycGQIwR
         M8QEg2omRG9glz52vfb7i58Yr9jiJ27JXZW+xalbPdKnwzLZ9WYBdg3M1rJb0Jc6YM
         AdTjmjtjQCej5Uy96+GtDl+J2IwDGWyGuPXqGt1z3J/7EJEVTfhHFiJhO4SJBsWDk0
         HikgxAcaBW8bw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3F339F03938;
        Tue, 24 May 2022 20:26:57 +0000 (UTC)
Subject: Re: [GIT PULL] SELinux patches for v5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAHC9VhTFMrc3yRiQ=fnw0-qWCTuUcH3iD1txSvLUh71WFsLrFw@mail.gmail.com>
References: <CAHC9VhTFMrc3yRiQ=fnw0-qWCTuUcH3iD1txSvLUh71WFsLrFw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAHC9VhTFMrc3yRiQ=fnw0-qWCTuUcH3iD1txSvLUh71WFsLrFw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20220523
X-PR-Tracked-Commit-Id: 1af0e4a0233fea7e8226cb977d379dc20f9bbe11
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: efd1df1982e9203b4f56cb0d5946a24885260ce5
Message-Id: <165342401724.5255.4328014186208791233.pr-tracker-bot@kernel.org>
Date:   Tue, 24 May 2022 20:26:57 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 23 May 2022 10:13:04 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20220523

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/efd1df1982e9203b4f56cb0d5946a24885260ce5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
