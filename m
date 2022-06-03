Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 521A253D350
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 23:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347370AbiFCVtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 17:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349445AbiFCVtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 17:49:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B663257B31
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 14:49:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6B13DB824BE
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 21:49:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 23F95C3411D;
        Fri,  3 Jun 2022 21:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654292953;
        bh=ZeyhBQ31QZRSci05XFyBhW+xT730DNmSlDu7BE/0PA4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=g7ZCvK3hzEg20ambGum+TdJr/4joIc3FfQQgiQuVsiRUHYYqT2eJjb2zBtoEDZlKq
         4P+LfNJFZ5qtdHtqQux23OSyRtj7h6rfuVKT+gIsio/9aHJjJwBMK0D+26Wb2Uq9rs
         g3FCTL9nxs7QfNo9EbG5c3/uW8vxReF4wcdTCzFh+ti4Mc0KDZQnd034NfhUXW2v19
         XuNHq06hsO501KdLYbPlS7GgvrLCLhWAfFX5fys2IY93otwAqz2eYzSmHyrC7YKvUb
         Fg4Jv/TVl+tM3c9vShCVUXvD2UZmUlhHO5VQVZQf8gmOCH6/vX+GQu4kq6KlmaJv/n
         rptVfKQ+kze3A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 097C5F0394E;
        Fri,  3 Jun 2022 21:49:13 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Patches for the 5.19 Merge Window, Part 2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-98b420ef-9b28-4e40-971e-7275b8f7c6e8@palmer-ri-x1c9>
References: <mhng-98b420ef-9b28-4e40-971e-7275b8f7c6e8@palmer-ri-x1c9>
X-PR-Tracked-List-Id: <linux-riscv.lists.infradead.org>
X-PR-Tracked-Message-Id: <mhng-98b420ef-9b28-4e40-971e-7275b8f7c6e8@palmer-ri-x1c9>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.19-mw2
X-PR-Tracked-Commit-Id: 61114e734ccb804bc12561ab4020745e02c468c2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f66e797b407bc03a438d1f05057dc7918bab473f
Message-Id: <165429295300.7657.14563990376660686418.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Jun 2022 21:49:13 +0000
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 03 Jun 2022 09:33:46 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.19-mw2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f66e797b407bc03a438d1f05057dc7918bab473f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
