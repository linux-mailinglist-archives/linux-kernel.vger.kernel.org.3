Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F13A14E4610
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 19:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240645AbiCVSdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 14:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240468AbiCVSdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 14:33:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2FC8CDBB;
        Tue, 22 Mar 2022 11:32:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A991615ED;
        Tue, 22 Mar 2022 18:32:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D005CC36AE2;
        Tue, 22 Mar 2022 18:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647973923;
        bh=qDA5MtSWF57Yx6cT2I6DLrisTM4JwZwjzzsTnuNddsw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=R7uIhNAiOC8kHBjZnrjQVaW/LKASP9z3QGN76DcvpyiDeRTowGAJcWTH43zI1+O02
         3Tu1gZQSM01uv/uJ45vUdVUVEZAphmygiVSeASsblhHWVyT6JAqQAH9DMiRIs04Mlf
         MAVtjrcxce+ryOOzeh9LHPTnuMc71nZ3z1qGAGDVx+CeUxzBY5hONY2QaDtL9z7pR9
         Fy3ILNNzu+NVte/qQO8fLRppLJcHwFJoV2iLmcXFvzjLxemV/1K3jG2jHcnZ/+w7nP
         8lJpfQ1+FuC6yFtW53sw1Xju1xKIOz5tkQuCJPG04qRCMN/Wlhd5ygPxxZT8I62eal
         2SamoLkI4iHYg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B96E3E6D402;
        Tue, 22 Mar 2022 18:32:03 +0000 (UTC)
Subject: Re: [GIT PULL] cifs/smb3 fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5mt+Zkrv8A2cw=xSXp=J=sebtF0qxRdP-+WWZqo9USXRsg@mail.gmail.com>
References: <CAH2r5mt+Zkrv8A2cw=xSXp=J=sebtF0qxRdP-+WWZqo9USXRsg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-cifs.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5mt+Zkrv8A2cw=xSXp=J=sebtF0qxRdP-+WWZqo9USXRsg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/5.18-smb3-fixes-part1
X-PR-Tracked-Commit-Id: dca65818c80cf06e0f08ba2cf94060a5236e73c2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 105b6c05c58306c4d576b7fc098c2b5a421ab06d
Message-Id: <164797392375.17704.12700252556179098242.pr-tracker-bot@kernel.org>
Date:   Tue, 22 Mar 2022 18:32:03 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 21 Mar 2022 15:57:45 -0500:

> git://git.samba.org/sfrench/cifs-2.6.git tags/5.18-smb3-fixes-part1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/105b6c05c58306c4d576b7fc098c2b5a421ab06d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
