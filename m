Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2BC256CAF5
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 19:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbiGIRge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 13:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiGIRgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 13:36:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F459248DC
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 10:36:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C172D60F9C
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 17:36:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 296DAC341CA;
        Sat,  9 Jul 2022 17:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657388192;
        bh=t7RM+hJQ6Ow75XYYUUnmeFh1HF82X7msdQCZLLzLEGk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=GBSH83JeYAImn1MC0qEYh+aE/hSBW9dWGkPfghdOBdOZ85+MALbWqgGCS79QvaTZA
         EMf8ij+hvbOADfjtK0B+nfX6L3KAtsF5Ul68iLf3/x+f19GOYtFvCuhqvDg2uzDJ81
         Dj1j3dLJ2TItYYDGUM5o0U0rErGH9wQUQhszS1PxFEcAeyUb1qhS3p3OZAUZgA1Oto
         it6HSdwAKO4dvGR6QXtNzjeJvcDYJc8Vvw34L/t5t8RbRj7px/Kkvi2117ieJZ24Sf
         2ohv0pulPSLP7h43TorxnGZvIBP3gG7wjyveGz69aGZzcB0dZ8F/83w09lhHbFXBR1
         LtO8xNDUI4hHA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1477FE45BD8;
        Sat,  9 Jul 2022 17:36:32 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.19-5 tag
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87ilo6a8do.fsf@mpe.ellerman.id.au>
References: <87ilo6a8do.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <87ilo6a8do.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.19-5
X-PR-Tracked-Commit-Id: 887502826549caa7e4215fd9e628f48f14c0825a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d9cdc3b12525c85b4a2a8b6f3f8f61d9f467ab9a
Message-Id: <165738819206.13845.2520787400071273485.pr-tracker-bot@kernel.org>
Date:   Sat, 09 Jul 2022 17:36:32 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, Jason@zx2c4.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 09 Jul 2022 20:27:31 +1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.19-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d9cdc3b12525c85b4a2a8b6f3f8f61d9f467ab9a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
