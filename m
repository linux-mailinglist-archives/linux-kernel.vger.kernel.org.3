Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CACFF5045CB
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 02:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233141AbiDQAOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 20:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233190AbiDQAOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 20:14:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA6F55775;
        Sat, 16 Apr 2022 17:12:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B8F50B80A08;
        Sun, 17 Apr 2022 00:12:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6E47CC385AC;
        Sun, 17 Apr 2022 00:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650154322;
        bh=0fHr7bqbijKghkRRoAuFYYVqr2tK7VyD3vAKWbneVmM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=UaVeKWir+HP00VGF0gmjPTcwqQLc5OMgh+pk/zoffiV/himROF8Et1kLZv2UxabOO
         JeINrRb834R4APY2YGFcl2ZwVpUeG7bNIse6Kd4iLrva1JKV41IODOQJrd7M2/Vfz/
         QHEW/B8WE4A/3oI9U8gEqS3sienhkc+93nYdSYD+L7Mnw+SKtA4rCK4/b1cnqwEPbQ
         NwEHkU6GoSjQnbRTXLcCGR/VfSEFOwfh+V0teY6+XtmBb4GYuW3kx3AHzfsfXx5U5e
         Kei3wyJHB1AoXXhB+KcIaYnSnfYugL235zRE8175bE5UapWd9QN5sGMGnDn45/o3Dt
         YrGcMeeAHJnyw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5B3A0E7399D;
        Sun, 17 Apr 2022 00:12:02 +0000 (UTC)
Subject: Re: [GIT PULL] Devicetree fixes for v5.18, take 2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YltCm/NZ+tnI6dzn@robh.at.kernel.org>
References: <YltCm/NZ+tnI6dzn@robh.at.kernel.org>
X-PR-Tracked-List-Id: <devicetree.vger.kernel.org>
X-PR-Tracked-Message-Id: <YltCm/NZ+tnI6dzn@robh.at.kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.18-2
X-PR-Tracked-Commit-Id: 652980b1541c5a02e6410647c7daf840c06d724a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a2c29ccd9477861b16ddc02c411a6c9665250558
Message-Id: <165015432236.20129.3790348596362231864.pr-tracker-bot@kernel.org>
Date:   Sun, 17 Apr 2022 00:12:02 +0000
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 16 Apr 2022 17:26:35 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.18-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a2c29ccd9477861b16ddc02c411a6c9665250558

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
