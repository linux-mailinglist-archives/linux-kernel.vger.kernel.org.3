Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE4851EF4A
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 21:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240822AbiEHTI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 15:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379999AbiEHSoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 14:44:54 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B80B85F
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 11:41:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1C467CE11A1
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 18:41:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 30E45C385B9;
        Sun,  8 May 2022 18:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652035260;
        bh=tI/7YqOwq0YX55A8Vahq+uQYnIz5RkTDhnJtoS3l0DY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=E1FHHU/9O8s4pgNVlYvKdDe0ujbHvEaMBPgFDKtVD4gcsObgpphL5uJnZKOJuENDG
         ET69fZuap+PA9JyiTCg/aMJebzYPU+2tedcAmbM/khmcQnYtItSQrYvjxCsSfpyE/A
         ehCOtORmNptAvXyhLTJmfo5oHbR6yp8BqDbplXLZ4sumpoSLkpRgDcIZoxoyOgz6vR
         L//OC+VbqD8YtVOivOepUXviUIWEu4Pkf0+EW8GNsSiMtYpdiBV0b3ybVH1y4I5zh8
         zAT69NINorfsnMNX2lDkzCrGhtikW24EusVAzlm0NuYl1snajJ0stF/uTw7LB5bd5y
         OFvj9UOz80Mjw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1A330E8DBDA;
        Sun,  8 May 2022 18:41:00 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.18-4 tag
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87fslkte79.fsf@mpe.ellerman.id.au>
References: <87fslkte79.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87fslkte79.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.18-4
X-PR-Tracked-Commit-Id: 348c71344111d7a48892e3e52264ff11956fc196
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e3de3a1cda5fdc3ac42cb0d45321fb254500595f
Message-Id: <165203526009.974.8487583887311129305.pr-tracker-bot@kernel.org>
Date:   Sun, 08 May 2022 18:41:00 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        haren@linux.ibm.com, kjain@linux.ibm.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 08 May 2022 22:13:14 +1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.18-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e3de3a1cda5fdc3ac42cb0d45321fb254500595f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
