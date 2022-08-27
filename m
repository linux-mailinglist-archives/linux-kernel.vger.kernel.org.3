Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE1DC5A3A70
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 01:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbiH0XHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 19:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbiH0XH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 19:07:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2FF40546;
        Sat, 27 Aug 2022 16:07:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 33921B80A6C;
        Sat, 27 Aug 2022 23:07:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 00F1EC43470;
        Sat, 27 Aug 2022 23:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661641644;
        bh=GyEAnzn30yias3JGX4jhm5zjPbh67S84/b+odA03iXs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Kkayidd+EYo1ZWj3/OHChTUVgEVUPYdCebYTI+hf6jpgN/b+HilMc9XM1v8OVN4LF
         BTFttAndt/CmNcxbq+nf7QSLHyaevC79DLX9xW7RJWubXsgZw6V9pbSlV83PWVAGbw
         G92GfugyQaHZlzIn5ALWf/rJz87WWt9UDcKNHF+BI3OyKl5HrQ+nQg0yylADbHW4Re
         v7rr6z/6RKybSuX2UO6Nus7MeChSXlWFd/j27MwJnRFkobcRwCdXgf9f42WtqtETXp
         cCpnmnDedQuEOzSiFJcqrXavyxkEQFxZLe1bdvFiYe6662m4iF149MwSqmH4wh6LBe
         ko9IzgRKEvEew==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DDB8BC04E59;
        Sat, 27 Aug 2022 23:07:23 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fix for v6.0-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jN76n5aVoh5C+awG5N0ewzp52HCikW-H=L88EMT=DTZQ@mail.gmail.com>
References: <CAJZ5v0jN76n5aVoh5C+awG5N0ewzp52HCikW-H=L88EMT=DTZQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jN76n5aVoh5C+awG5N0ewzp52HCikW-H=L88EMT=DTZQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.0-rc3
X-PR-Tracked-Commit-Id: 6ca7076fbfaeccce173aeab832d76b9e49e1034b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b98f602df71aa9612af3239a8d2a23b126e4357a
Message-Id: <166164164390.8591.18416002291483209990.pr-tracker-bot@kernel.org>
Date:   Sat, 27 Aug 2022 23:07:23 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 27 Aug 2022 15:40:54 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.0-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b98f602df71aa9612af3239a8d2a23b126e4357a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
