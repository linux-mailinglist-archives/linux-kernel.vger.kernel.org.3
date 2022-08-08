Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52C1258CCD3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 19:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244076AbiHHRkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 13:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243936AbiHHRkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 13:40:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F1C1707C;
        Mon,  8 Aug 2022 10:40:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DD5F5B80E80;
        Mon,  8 Aug 2022 17:40:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8CE5BC433C1;
        Mon,  8 Aug 2022 17:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659980407;
        bh=SLglWr7ykm2Wwdt9J81+AHUiyVGolOntUWEC8TdYpSI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=GXA8GS5KW4KXnQbhv7w+Ws54bKxNGs+/82WlNVEjyGfwIENwZLFcF1xKRpFzJoj8f
         VyKaPMoYmQOrje/rJ7cG3JXu0fhsFShocVnbCQj9RQCfskQJpCiSepO5R8Gs1yCFlI
         NqtAIWfFmPynrozC/0kUsX73mtuJZRsuYs7XhPoM3sedDzkWPIapAjCiefwqT8Upuw
         q2H5WGQNCXjhErrN773chrm5tQvAPDOGFrVM4lXxidm04yKbCjl0+UjUEdueQ/3Ycu
         FOVfPSGJk9PqkEH1uW8YKjWwr+QpulDxrG4hab7Lu0q1gGgaLpGZIzf/K8ECL3bh5E
         cEVNjHe9wXzxw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 732A5C43143;
        Mon,  8 Aug 2022 17:40:07 +0000 (UTC)
Subject: Re: [GIT PULL] hwspinlock updates for v5.20
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220808160316.2096259-1-bjorn.andersson@linaro.org>
References: <20220808160316.2096259-1-bjorn.andersson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220808160316.2096259-1-bjorn.andersson@linaro.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git tags/hwlock-v5.20
X-PR-Tracked-Commit-Id: cdab30b44518513003607ecfc8a22de3dbbb78ed
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3466f49dd0dd9d30fe1e916b49fca1f4f99a3b66
Message-Id: <165998040746.21911.5233185589954379354.pr-tracker-bot@kernel.org>
Date:   Mon, 08 Aug 2022 17:40:07 +0000
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christian Marangi <ansuelsmth@gmail.com>,
        Minghao Chi <chi.minghao@zte.com.cn>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon,  8 Aug 2022 11:03:16 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git tags/hwlock-v5.20

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3466f49dd0dd9d30fe1e916b49fca1f4f99a3b66

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
