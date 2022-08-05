Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BEC858B11A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 23:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241757AbiHEVZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 17:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241598AbiHEVZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 17:25:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 421FA1275F
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 14:25:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE0776141B
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 21:25:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 39FE0C433D6;
        Fri,  5 Aug 2022 21:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659734731;
        bh=7GfYWcT6+l89XVda1+TcRuG0YqV1wtvlmyc1VeLGRmw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=fYX4wpaSjGV8hXlnrjzjU4SJSHdmJa3OEbHVXkQ5S6RvsNFyU5VRCLZdwgG73HYrh
         VXosQi0TmgWUGHIcv8lzUNubPMX4Zff6rkQReNtNrTylWOCpj3X3KgL1kkUy+ejBNK
         yxr7eDfM7f1c7itMzw7Eu1xAL0aZ9ERgXU9IM2I1r+P+Ggb/kyy/LYfjKhuxRoCWb5
         BNiG4XOc4XSO2x1zHFxbQrn8m/NyhBdkoGnruStqZvtz8FU7mkVFtH++wGQKg7JQnJ
         Mu1zpQ9rYqcpJlkbQfLU2OvY/TKk4j+WiBK96QjqeakUpQJE2H7s/Ti6/T4c0M6hWw
         vIJfrcMtAEZkA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 29FC0C43142;
        Fri,  5 Aug 2022 21:25:31 +0000 (UTC)
Subject: Re: [GIT PULL] OpenRISC fixes/updates for v6.0-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yu19zEVnjSkH8nO2@antec>
References: <Yu19zEVnjSkH8nO2@antec>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yu19zEVnjSkH8nO2@antec>
X-PR-Tracked-Remote: git@github.com:openrisc/linux.git tags/for-linus
X-PR-Tracked-Commit-Id: 52e0ea900202d23843daee8f7089817e81dd3dd7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4d5398a3ec060c1e3094097e52a19a4d0013c0e0
Message-Id: <165973473116.8747.13652673284909489427.pr-tracker-bot@kernel.org>
Date:   Fri, 05 Aug 2022 21:25:31 +0000
To:     Stafford Horne <shorne@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Openrisc <openrisc@lists.librecores.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 6 Aug 2022 05:30:04 +0900:

> git@github.com:openrisc/linux.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4d5398a3ec060c1e3094097e52a19a4d0013c0e0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
