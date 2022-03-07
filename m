Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94DAD4D07E2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 20:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245148AbiCGTsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 14:48:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245135AbiCGTsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 14:48:03 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F405C861
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 11:47:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 0579FCE128B
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 19:47:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 300F5C340F4;
        Mon,  7 Mar 2022 19:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646682425;
        bh=nAzHLP3Kt9+PtVqYMw+7sHlfuSUTAzvrpaLaZjtK6UU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Xb+Dp+pvqWMKM/Mwl79NCBifSgSdlJmm25HSNTSEjdbD3ot0Zr8morP+3jrrkwcuh
         lA5AiYqTSJnlZefT88b7kCiUR1gL4YG6s2nnOQjD2pGizWDFY2mNbQNw8YOR5wcEH5
         SH3mj2eccqueW7I9tJHUFskdwSTnhYyQz0OFU+RTPrMW9IFxzlNgqreJxgUu/lf+PJ
         mzyjJKH1QEuhU/eCX5685/oliE3PewRzcU5gTZMVjoRe07Rg0I57d0xlzrKCgeWxCp
         EZCqD1FnLgOtRxbfGc1LLHm+oMF43Mmv804QFTICfK46c9JwCbYBSXr/+F/LMjpTc/
         0rM/vq9h4cCbQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 16AA3EAC081;
        Mon,  7 Mar 2022 19:47:05 +0000 (UTC)
Subject: Re: [GIT PULL] mtd: Fixes for the next -rc/v5.17 final
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220307181734.750b4661@xps13>
References: <20220307181734.750b4661@xps13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220307181734.750b4661@xps13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/fixes-for-5.17-rc8
X-PR-Tracked-Commit-Id: 42da5a4ba17070e9d99abf375a5bd70e85d2a6b8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ea4424be16887a37735d6550cfd0611528dbe5d9
Message-Id: <164668242508.29310.5914882137409603918.pr-tracker-bot@kernel.org>
Date:   Mon, 07 Mar 2022 19:47:05 +0000
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <p.yadav@ti.com>, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 7 Mar 2022 18:17:34 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/fixes-for-5.17-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ea4424be16887a37735d6550cfd0611528dbe5d9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
