Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A56775B2456
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 19:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbiIHRXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 13:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiIHRXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 13:23:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1550F1F05;
        Thu,  8 Sep 2022 10:23:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4595AB821DB;
        Thu,  8 Sep 2022 17:23:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EC4D0C433D6;
        Thu,  8 Sep 2022 17:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662657821;
        bh=vrxq50BkddcMR47TnVqjMcbDd6aKvAswpPltXOa/axY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=GoVzQ//dyDIJxxyAF4aCjyfq2eVukX9EBVoOGylY+iC0to14LTRMG+QuLWasJ0Qi/
         YOy5HWYTgbGr+K0a6QVgDTS2mKm1vB57rar7zyskq/60uXI6vmIVG/wediP2+tGMZJ
         Ej7LxFm4R67VPy6H+YbHAJMW5WW4fVGRaoxnFgGebd3QQClZ1IQvyKsCTeHZByQIF4
         ebArT7g47mIK/kPDqP/v7TPfyEMuulCMgrtJJ6taLAb+kjWppx2sjWyNjNLLxRqP3B
         QtuD5PXG//LCzkaebm/7ezvSSsdh2pB0N3CjYOnZCX6XZG2miEnXZ56JbnuS2Wh1Ug
         jqNob4PE+KW5g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D027FC04E59;
        Thu,  8 Sep 2022 17:23:40 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v6.0-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220908122132.2A0BDC433D6@smtp.kernel.org>
References: <20220908122132.2A0BDC433D6@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-spi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220908122132.2A0BDC433D6@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.0-rc4
X-PR-Tracked-Commit-Id: 9c9c9da7aa108e6bf952c18289527a5234e4fc59
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 506357871c18e06565840d71c2ef9f818e19f460
Message-Id: <166265782084.29466.1806562734065083440.pr-tracker-bot@kernel.org>
Date:   Thu, 08 Sep 2022 17:23:40 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 08 Sep 2022 13:21:23 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.0-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/506357871c18e06565840d71c2ef9f818e19f460

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
