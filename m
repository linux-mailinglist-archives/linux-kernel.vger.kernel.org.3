Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0044EB11E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 17:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239087AbiC2P66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 11:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239067AbiC2P6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 11:58:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502094D261;
        Tue, 29 Mar 2022 08:57:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DEC3461345;
        Tue, 29 Mar 2022 15:57:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 46F48C340ED;
        Tue, 29 Mar 2022 15:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648569430;
        bh=GhEABGbbcF6fJDPfQzlhpd2zhIdKrHcjExkzMoYoXxQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Jum01t2VqhETFU/RcdbL1K1qfh+6WBLm5fFFvAyrxArlXZ66Iigw12L+88zuHLVqC
         ysWsF06ItUd3+GXSZCI0fRj9rXCKc8QElwVEx1IuM/OAjlIubRcSRjjttxANlEYw+K
         9mGCTQVhjl7v5FTNG0mBPH6KquCuMhoZ9bmmzdYqvZcg9lURvvaW5imx+q0ZFxEih9
         l3WaPEO9zqasV+aSs0Y5XuoEM9JfdEHIByiofYcVULbqof9759F3Upeigmd/XuVhIR
         TX775b2esf6xjWNgxB750U0cv7FbQECKVZhtRPxf/PZloFThcpx4mdKFQNGUnMrKZM
         EE5LGemGZ0OmQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 32DEFEAC081;
        Tue, 29 Mar 2022 15:57:10 +0000 (UTC)
Subject: Re: [GIT PULL] Devicetree fixes for v5.18, take 1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YkJhd/QX64LDANXN@robh.at.kernel.org>
References: <YkJhd/QX64LDANXN@robh.at.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YkJhd/QX64LDANXN@robh.at.kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.18-1
X-PR-Tracked-Commit-Id: 22a41e9a5044bf3519f05b4a00e99af34bfeb40c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5efabdadcf4a5b9a37847ecc85ba71cf2eff0fcf
Message-Id: <164856943020.29048.17765502026263151480.pr-tracker-bot@kernel.org>
Date:   Tue, 29 Mar 2022 15:57:10 +0000
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Dave Airlie <airlied@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 28 Mar 2022 20:31:35 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.18-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5efabdadcf4a5b9a37847ecc85ba71cf2eff0fcf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
