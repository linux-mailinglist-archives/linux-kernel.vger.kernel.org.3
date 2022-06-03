Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0839353D22F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 21:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347985AbiFCTHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 15:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240321AbiFCTHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 15:07:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31B4186E5
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 12:07:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 41C2A619FC
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 19:07:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A9F83C385A9;
        Fri,  3 Jun 2022 19:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654283224;
        bh=WpiLtqhXgrMBixYqrAKOPvPBLebRiMoe1sed0VHn8+4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=uR2jzhjbVAPuG6k6uHsA9b+xs8n7jLBJf2mhVbTTE/qBwU2H7mC6pkacQDHqzRG9t
         fyB63G2mRlL9D63GZ7hWced0t235xDbrNFKPDlbeYreTij8KJVw6U9Dc60G2hEukx8
         ZnQVStD66G2y3OkTA8chFRlD8noGB36fF2zeJNYlMtLlGzTyUQSMQ6GpNAUxT1/bky
         Q2EwgOds1j3kQBmzO13PI0Mx/G9PvPgWXEqpI97q6tDa0tQbgqqudGMgKqwQrJLgaV
         YCX7jZ4VHRw1/lA/KpBh2vS20LFYyLQO3tYot2SAbiPFKofL7FAsLC/OVLapmoELk/
         EPKHQ28IIP9aA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 98729F0394E;
        Fri,  3 Jun 2022 19:07:04 +0000 (UTC)
Subject: Re: [GIT PULL] Driver core changes for 5.19-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YpnwZ/Q5yTKRDBOD@kroah.com>
References: <YpnwZ/Q5yTKRDBOD@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YpnwZ/Q5yTKRDBOD@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.19-rc1
X-PR-Tracked-Commit-Id: b232b02bf3c205b13a26dcec08e53baddd8e59ed
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 500a434fc593f1fdb274c0e6fe09a0b9c0711a4b
Message-Id: <165428322461.25509.5264419923913572572.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Jun 2022 19:07:04 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Saravana Kannan <saravanak@google.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 3 Jun 2022 13:28:39 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.19-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/500a434fc593f1fdb274c0e6fe09a0b9c0711a4b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
