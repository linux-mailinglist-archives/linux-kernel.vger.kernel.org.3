Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 771544E1910
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 00:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244404AbiCSXva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 19:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240101AbiCSXv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 19:51:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01BE29819;
        Sat, 19 Mar 2022 16:50:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 465C060EF0;
        Sat, 19 Mar 2022 23:50:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AD556C340EC;
        Sat, 19 Mar 2022 23:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647733803;
        bh=pY7QPJiUo32hPXY0yiQ/tuO6qNxymu13nKdimgECFSs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Ju9qlum+L1yqyZXJrNDq3hEtr4XrU8a756Qvtos+JH3P0RSfT6u84FxGf6vqfom0+
         qf0W231ERkorPSFj28JHi3OYrxVlB7lVjY9ld7/SAb87vyCfVShL+GtLN06aYc8BXB
         k+ttW9x5MqXZ+GDLGSPUzdoAj35AaPc+IhmXCiquiDtDbukLNExLb+PvCNAsqfaFZ8
         BO5bGY3iOWT9cVW5yPemh38AgNRTCnegdR/yYDCyRsZJpAsohuQ1E2QJvPdpbK1ROK
         wdEosH23USCdsCSrJMq6vXWpKt20OUbYekRqfigVt1g3KASWJmDq4T8DZ0qswZEXK2
         GACO3B3+wylqg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 943D7E6D3DD;
        Sat, 19 Mar 2022 23:50:03 +0000 (UTC)
Subject: Re: [GIT PULL] SCSI fixes for 5.17-rc8
From:   pr-tracker-bot@kernel.org
In-Reply-To: <2a71975c2888f30ddebff8aa509933bc87c1a552.camel@HansenPartnership.com>
References: <2a71975c2888f30ddebff8aa509933bc87c1a552.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <2a71975c2888f30ddebff8aa509933bc87c1a552.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: 733ab7e1b5d1041204c4ca7373f6e6f9d08e3283
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f76da4d5ad5168de58f0f5be1a12c1052a614663
Message-Id: <164773380359.1966.8716812458635201424.pr-tracker-bot@kernel.org>
Date:   Sat, 19 Mar 2022 23:50:03 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 19 Mar 2022 15:45:47 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f76da4d5ad5168de58f0f5be1a12c1052a614663

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
