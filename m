Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7508F4EF918
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 19:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346473AbiDARmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 13:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350535AbiDARmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 13:42:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 821DD14B843;
        Fri,  1 Apr 2022 10:40:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1C010B82596;
        Fri,  1 Apr 2022 17:40:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D6B00C34111;
        Fri,  1 Apr 2022 17:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648834808;
        bh=LELeOPMIv3Y9rm+P2mk1AfoUiVYONStwe1gfrdazd6g=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=TSPpFXTar+G+MRzGkE42Tc3aUHxT+Z8kxMtT2iTSiLmrYRByPNpx42i5Zz9u0tvIu
         4wPFv1X2DdhtzLeVLBLGzGds/zkV7KucWqd6KoEy9y4zIt+yHaon/VhnnLGCMN2n4L
         tQwaj82cmBFbrM5yesKLICCs/ErG41N/Vi9/4mGqqTjpAVEL39HbI74Nj8siHxSpiu
         bKBvvyEReXZUJ0I8Pe6Qzp2GQhuSkx1N/y6dPNrC51nOVm4MfLFU2/QY4jt9Q1P+G+
         D2Ac37JeATsC9Bft7mTAqf1kCWViYtZQdOaMcHVuyiTHhp1ChaJTwZn/VUHlPa6uxb
         5zfW+nax6aSJQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C46B2E6BBCA;
        Fri,  1 Apr 2022 17:40:08 +0000 (UTC)
Subject: Re: [git pull] Input updates for v5.18-rc0
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YkZ+K2Gtt75y1/O+@google.com>
References: <YkZ+K2Gtt75y1/O+@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YkZ+K2Gtt75y1/O+@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus
X-PR-Tracked-Commit-Id: 8b188fba75195745026e11d408e4a7e94e01d701
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: aa240ee7883487201d0c6cc537ec1c4cd6cb2a9e
Message-Id: <164883480879.11835.8693561316842820598.pr-tracker-bot@kernel.org>
Date:   Fri, 01 Apr 2022 17:40:08 +0000
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 31 Mar 2022 21:23:07 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/aa240ee7883487201d0c6cc537ec1c4cd6cb2a9e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
