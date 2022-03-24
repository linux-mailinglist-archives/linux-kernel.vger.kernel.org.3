Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 612894E6972
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 20:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353324AbiCXTqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 15:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353251AbiCXTpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 15:45:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 231913A5D3;
        Thu, 24 Mar 2022 12:44:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B7B9561B91;
        Thu, 24 Mar 2022 19:44:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2062DC340EE;
        Thu, 24 Mar 2022 19:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648151060;
        bh=z0JTsFS9m24LFTrajg4AQtkisBFSE+BBsPLbu02WWuA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=pC2rsZfWIpNiJqstcSiZxVFXgbiJ0wxTIGgx3uedSJIvTwfYal7hX7C9evfR8/eQo
         LXFVQ9vBt9iRMUyBgDkB8c1P6pN8K9ar9fzjMKrOUvx/rXzs6oI2yBRCwCoSxgI0pV
         Cqsp+RlVnRaH4IaHqwF8XlYhR0kghxMwfDimETeW416UlrvnwjrB9AKAiHPf3otIRH
         5gak7XqzTdQBI/MLu+/+XM3SLb9deLlOzAqTjN9oqucw0Bxd93bDwISi1/pETR+Uci
         kBi/JKfFAokam7u8yqlOOHoYk14SFF5dBQtrmY7Qs0J1YDSUs0bgo36sjjF0zyjeUi
         FEXVTVGFtNTCg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0E5C5E6D44B;
        Thu, 24 Mar 2022 19:44:20 +0000 (UTC)
Subject: Re: [GIT PULL] flexible-array transformations for 5.18-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220322184802.GA2533969@embeddedor>
References: <20220322184802.GA2533969@embeddedor>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220322184802.GA2533969@embeddedor>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/flexible-array-transformations-5.18-rc1
X-PR-Tracked-Commit-Id: 5224f79096170bf7b92cc8fe42a12f44b91e5f62
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3ce62cf4dc3b01d1cbee1293049ca5d4c7d6d749
Message-Id: <164815106005.31218.5324046159724857868.pr-tracker-bot@kernel.org>
Date:   Thu, 24 Mar 2022 19:44:20 +0000
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 22 Mar 2022 13:48:02 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/flexible-array-transformations-5.18-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3ce62cf4dc3b01d1cbee1293049ca5d4c7d6d749

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
