Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 641D34BBE91
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 18:40:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238770AbiBRRkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 12:40:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238759AbiBRRkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 12:40:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 827C76D94F
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 09:39:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 35BCEB826AF
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 17:39:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 04539C340E9;
        Fri, 18 Feb 2022 17:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645205996;
        bh=dnl6SUWMIsoOW/hvEVw5N37t7VlaV0s+GKU9fqT3B/Y=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=N5Kpvf+ZQtDhgww6coAUuomb0pa0hwQ0zgJCR96TRK03MdgaiJlUhys6GMqLBZZtW
         gHxd4I3UQ8ymyoq/SXiOZ6KeyHDKbNkQM6oF7aVpMS2i+Ws0Un3picc0yAF0Z4KfM+
         6Uz5pMGXuTvIv9B9JHxlIL0ivTXHFPCg9p2SReIsSWQOZF1zm8Z+b8+axbdbjCH/7Z
         cVPFq10qnU72+3FLZzIuUjbzEATp7a2H2ql8BzsWETYWWs5zoqS7Bfq9PcU00H60pP
         pHPlEM7kGB+KxwSrrJDFaVjUD+nh+AG0P0YON9O29aNJf1GxGKzCo4f11rgVwXmzfl
         Qas4FXXF/z9ag==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E7A14E5D07D;
        Fri, 18 Feb 2022 17:39:55 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.17-4 tag
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87pmnknauq.fsf@mpe.ellerman.id.au>
References: <87pmnknauq.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <87pmnknauq.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.17-4
X-PR-Tracked-Commit-Id: fe663df7825811358531dc2e8a52d9eaa5e3515e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ea4b3d299fe6b6c9afa4a91dc2cf5479d0089eeb
Message-Id: <164520599594.19024.14896573547051091073.pr-tracker-bot@kernel.org>
Date:   Fri, 18 Feb 2022 17:39:55 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org, anders.roxell@linaro.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 18 Feb 2022 13:54:05 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.17-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ea4b3d299fe6b6c9afa4a91dc2cf5479d0089eeb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
