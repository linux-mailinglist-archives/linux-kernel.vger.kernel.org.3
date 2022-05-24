Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF831533205
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 21:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241583AbiEXTyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 15:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241367AbiEXTxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 15:53:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7952A7939A
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 12:53:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C1F6616E8
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 19:53:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6D953C3411B;
        Tue, 24 May 2022 19:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653422006;
        bh=9QHRLZnH67ZRBIAjE4Bj6W9k2UmzugQn55IZ5C02oAk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Rl0ZK6yCaUhciY+rhJ6t2j9WHXSoDEVJkqiHu6E8xk0Kfh8+w1tNM9fCEMidUV8sv
         I+KSclgkWGjFQxYLkQEZN1RB3y5i+HcnAXXlO/N2uPaWZnErCUFVU5vzGz35yTSGkF
         hBVjmGHULMJUY8gVKZVZKTsT3HIr+5sJn/s4DZPXsGgRoDFK7MRkseoqR/Stkar1tc
         TXquBF4JoZd5gtYJ19Dro2Ibf6/VWIpz/B/aWXSCRO5aIgnEhXuE71GB6/LxSgMaT7
         fw09GiMH5eZIg443dJ1R+VFtw5K1Cu/7lF76gfdAOZFwLVRdhMaUnjSngMl6bQLNC4
         h/3qWOtd7kQ9Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5A7F5F03943;
        Tue, 24 May 2022 19:53:26 +0000 (UTC)
Subject: Re: [GIT PULL] objtool changes for v5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <You3JC/BOIyEnmQj@gmail.com>
References: <You3JC/BOIyEnmQj@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <You3JC/BOIyEnmQj@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool-core-2022-05-23
X-PR-Tracked-Commit-Id: 22682a07acc308ef78681572e19502ce8893c4d4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 22922deae13fc8d3769790c2eb388e9afce9771d
Message-Id: <165342200636.18932.7813564120891653486.pr-tracker-bot@kernel.org>
Date:   Tue, 24 May 2022 19:53:26 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 23 May 2022 18:32:36 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool-core-2022-05-23

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/22922deae13fc8d3769790c2eb388e9afce9771d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
