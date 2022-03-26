Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4E14E8423
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 21:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235123AbiCZUTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 16:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235107AbiCZUTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 16:19:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9401EEDA;
        Sat, 26 Mar 2022 13:18:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF26A60DE1;
        Sat, 26 Mar 2022 20:17:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3A4F7C340ED;
        Sat, 26 Mar 2022 20:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648325879;
        bh=BVqk7238peYt4cidbb7ajSxzxB9Dqb5cSuWdvZkpUCc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Ak4xalgGDaxOoH/7Bu1RePGILZ4YY8kDsma86S0SnnLesuMHiNYg94ZOPbIooA9JB
         4a54K3SEXDyBTlUdtvrGEnv6tab963vdP7lbIJFJwrhTg2yKKRS4Vcf/edXNyC/5Bp
         ygiUyYMOz2uVikvXYGNt2XU9Bk/VDJ0Fm+DJl1Rc4bZc1yWHndpgzx6AwcXk5mFxm3
         O1RLSRU467EvDj1wdQrWxcVmy4XgPRL3FTZPMSwL7gK+rHPJgrmHoTtW/BgB4RllXs
         fd9AOaPsc9JXO1S5NoN1QGPqN22sbAaueSK4p8PDswUn3kZdCCvq+u7EHJLuDu+TIk
         lNA84PXn2+Hfw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2823DE6D44B;
        Sat, 26 Mar 2022 20:17:59 +0000 (UTC)
Subject: Re: [GIT PULL] Devicetree updates for v5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yjy1narVcf4pTiDG@robh.at.kernel.org>
References: <Yjy1narVcf4pTiDG@robh.at.kernel.org>
X-PR-Tracked-List-Id: <devicetree.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yjy1narVcf4pTiDG@robh.at.kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-5.18
X-PR-Tracked-Commit-Id: 6b49f3409a090c8e9d1f46ff2705c479b45a54d4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9bf3fc5007856d5ca76d6e7a4652e3b67b683241
Message-Id: <164832587916.7233.7920610075225337690.pr-tracker-bot@kernel.org>
Date:   Sat, 26 Mar 2022 20:17:59 +0000
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 24 Mar 2022 13:17:01 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-5.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9bf3fc5007856d5ca76d6e7a4652e3b67b683241

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
