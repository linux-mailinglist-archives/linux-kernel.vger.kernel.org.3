Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 681A95507FB
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 05:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbiFSDCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 23:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbiFSDCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 23:02:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB03EE05;
        Sat, 18 Jun 2022 20:02:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 212E2B8068D;
        Sun, 19 Jun 2022 03:02:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DE9F0C341C0;
        Sun, 19 Jun 2022 03:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655607741;
        bh=gCcWfmX5YoxFjVKMAgaNE1dtoZEMfcprUTP4IEHGKTg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=sfqFSPwxCkV6W6+GvnLK7LYP1wXQLRwqlWG2b8/SeR5xIa6erFTSlRAN5MMryI3Ks
         IW16Jm+jdU4qD1udXGIfXYcXYdjLVaDveYn9WpMP5hvL1oc6z8azS7uiAJKh4DnZPb
         5DpiXRGTfX+eRTOtEV0bSLGnPl3XOnKy50dSEW5/IxbVXC6La8yePeH+q6igeSGuM3
         bMK9odPoLP6dDZcvmG2vADqQICVnCckt0pRbb7UKY5utnrkkafGFLAzSnOoerTUW8d
         WN05MRqs35Gsqpug7yn8s/7mNMx4UYyp3Sh6g2ZObfEloFJBwUX2JXBs9iOrS+u2xB
         dGnBzEctf6OpQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CBABAE73856;
        Sun, 19 Jun 2022 03:02:21 +0000 (UTC)
Subject: Re: [GIT PULL] SMB3 client fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5mtJnW8Uq2Dk2xjid4Au9rM=g9_oBJC5ojJMd-Qksne+6g@mail.gmail.com>
References: <CAH2r5mtJnW8Uq2Dk2xjid4Au9rM=g9_oBJC5ojJMd-Qksne+6g@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-cifs.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5mtJnW8Uq2Dk2xjid4Au9rM=g9_oBJC5ojJMd-Qksne+6g@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/5.19-rc2-smb3-client-fixes
X-PR-Tracked-Commit-Id: 5d24968f5b7e00bae564b1646c3b9e0e3750aabe
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ace2045ed56f9b00beb4cd23c76a5b6cae69f2fe
Message-Id: <165560774182.16247.637044880710976675.pr-tracker-bot@kernel.org>
Date:   Sun, 19 Jun 2022 03:02:21 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        CIFS <linux-cifs@vger.kernel.org>,
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

The pull request you sent on Sat, 18 Jun 2022 17:38:54 -0500:

> git://git.samba.org/sfrench/cifs-2.6.git tags/5.19-rc2-smb3-client-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ace2045ed56f9b00beb4cd23c76a5b6cae69f2fe

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
