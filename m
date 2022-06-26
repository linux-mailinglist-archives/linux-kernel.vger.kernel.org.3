Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A35C55B332
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 19:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbiFZRge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 13:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbiFZRgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 13:36:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A38BE0A4;
        Sun, 26 Jun 2022 10:36:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F169CB80DF4;
        Sun, 26 Jun 2022 17:36:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AB3E5C341CB;
        Sun, 26 Jun 2022 17:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656264972;
        bh=S/p+uHopoJlNaQZMjUi/yJtD1lLoTo6HlzPDOlPvvRw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ReF+K77CGVoccto7Bwq5pcOAaJLCZqq6hexcTnENDvT8+PpHuVefv4xSyIgveNdF7
         +S284dwuLv5Sfy7GhetMW4g9oGpuoaHBjtn6xf6k/pXwMsUXzxX4ypft12anJHCuiW
         3va8vRpnZSBLLL4nVpnQmvhyaarS0ualbgf54FkuTZS2afDfEQ5Yae7XtVJ6p632K7
         vcGkrpRtvfzPCcPg+0NlmYnLHOaH/Cv2d+REf5fZilXc1Xmc0rWuQ8IoXRgrStAnsM
         LWu5sElY09Xoere3NhV33Xfx2+I4TCsxYa7Fq1DRX8N9LrRPZJYdzhtFRgNL1C/j62
         GLA0ez8PPRCgQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9A0C4E8DBCB;
        Sun, 26 Jun 2022 17:36:12 +0000 (UTC)
Subject: Re: [GIT PULL] SMB3 client fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5muuxg3iDXMkcasnRoCfi8WeE1i3Y=GTgBB8qMQShFppdQ@mail.gmail.com>
References: <CAH2r5muuxg3iDXMkcasnRoCfi8WeE1i3Y=GTgBB8qMQShFppdQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-cifs.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5muuxg3iDXMkcasnRoCfi8WeE1i3Y=GTgBB8qMQShFppdQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/5.19-rc3-smb3-client-fixes
X-PR-Tracked-Commit-Id: af3a6d1018f02c6dc8388f1f3785a559c7ab5961
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 918c30dffd14cd3f4af1e67cb40db91a008fc4fe
Message-Id: <165626497262.22456.3866543276672314634.pr-tracker-bot@kernel.org>
Date:   Sun, 26 Jun 2022 17:36:12 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 25 Jun 2022 16:38:40 -0500:

> git://git.samba.org/sfrench/cifs-2.6.git tags/5.19-rc3-smb3-client-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/918c30dffd14cd3f4af1e67cb40db91a008fc4fe

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
