Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93BF658D035
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 00:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244580AbiHHWhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 18:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244562AbiHHWhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 18:37:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE6AF70;
        Mon,  8 Aug 2022 15:37:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C06C60FB6;
        Mon,  8 Aug 2022 22:37:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 901E9C433D6;
        Mon,  8 Aug 2022 22:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659998229;
        bh=DzGGQGZW/kLxy+WTWci9KBQcrRgZgES2QKi4Du3Cxo4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=uDgIePwrTWfM2rWWmiMDCi5nSBRZQwbhnpUugvU2i5OEg8N1nopOvK8HuO/kri8Jj
         LJkOpprl951RE07lHNPZ1XOurGroG4vn3GtJObwxXXbCfFs8GkLEhuIfOC6tA+w6mC
         3ukvl/ZkiPSpZ+ykLYIfIWHm3ok5sHrEnBJ8Y6dvf7BLRctKQnFFZ8SYny4cqQDWWR
         BpL1KGV64EtNNyPXenJMaG/d0HGUFmTOhQE9EGcIma9RCJ92hIBeDN9vlNVg9bKiAy
         aTQpm5EETuVKq8Xh/lirgpf8/lTuRvO+4EOWMNoy1pyuPjLE8fXxwJQVhvZB2Q4ecJ
         rcshoNLn8WFhQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7E162C43140;
        Mon,  8 Aug 2022 22:37:09 +0000 (UTC)
Subject: Re: [GIT PULL] rpmsg updates for v5.20
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220808182325.2104359-1-bjorn.andersson@linaro.org>
References: <20220808182325.2104359-1-bjorn.andersson@linaro.org>
X-PR-Tracked-List-Id: <linux-remoteproc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220808182325.2104359-1-bjorn.andersson@linaro.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git tags/rpmsg-v5.20
X-PR-Tracked-Commit-Id: 7113ac825371c17c15e2d0be79d850e5e16d3328
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c72687614b3627b3ea55d8d169e31cac70f56f3e
Message-Id: <165999822951.1400.6022886464783317425.pr-tracker-bot@kernel.org>
Date:   Mon, 08 Aug 2022 22:37:09 +0000
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Hangyu Hua <hbh25y@gmail.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Saud Farooqui <farooqui_saud@hotmail.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Xuezhi Zhang <zhangxuezhi1@coolpad.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon,  8 Aug 2022 13:23:25 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git tags/rpmsg-v5.20

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c72687614b3627b3ea55d8d169e31cac70f56f3e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
