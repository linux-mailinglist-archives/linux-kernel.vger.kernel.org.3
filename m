Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABBC15641E4
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 19:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232395AbiGBRiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 13:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232493AbiGBRiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 13:38:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26049E037
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 10:38:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BDC98B8068A
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 17:38:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7A8CCC34114;
        Sat,  2 Jul 2022 17:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656783529;
        bh=iNbDC+O4df97kCA0R2yVWyePRF78hqPgYZFS+GXLCZE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=bSVrLBmQLd/PiM75ZCKeAaP5AE4K5j7IFC5XeqC3SCI63FBO4ToE2e7LQmNPUoOc2
         6w9QkgwlL7MbzZCepTQDLqKdl4poRocySXkBwzXujnx6pUn1jREDZe6sUdjXomNycf
         9Qz9gXGkTGtvF1WiZ4r9gZ7r3Vlww9MtAZVOVcmfL92FeWsFDT3vvLOgcbfLLc0iiS
         3XaBi4nUDmJx8hZrLZRDGRjyRx+V+osB1dscFgymeluaLWUj5LPP7g4V0OqjZ6EieB
         ljVSiBJcW01XEf4DUiLhqj42k6fZAKwWq06Uo/wUup9bHA8+DoMTyxGoifJjqblgRM
         DvfZLi134gmDg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 68FBDE49BBC;
        Sat,  2 Jul 2022 17:38:49 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.19-4 tag
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87edz3aj9f.fsf@mpe.ellerman.id.au>
References: <87edz3aj9f.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <87edz3aj9f.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.19-4
X-PR-Tracked-Commit-Id: ac790d09885d36143076e7e02825c541e8eee899
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5411de073362300d99bb35d46d77d656760e4606
Message-Id: <165678352942.3400.15836912019951685406.pr-tracker-bot@kernel.org>
Date:   Sat, 02 Jul 2022 17:38:49 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        nathanl@linux.ibm.com, aneesh.kumar@linux.ibm.com,
        linux-kernel@vger.kernel.org, liam.howlett@oracle.com,
        rppt@linux.ibm.com, naveen.n.rao@linux.vnet.ibm.com,
        linuxppc-dev@lists.ozlabs.org
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 02 Jul 2022 20:42:04 +1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.19-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5411de073362300d99bb35d46d77d656760e4606

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
