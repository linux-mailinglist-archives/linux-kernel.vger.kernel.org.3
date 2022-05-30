Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8AEB53879D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 20:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241370AbiE3S6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 14:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239684AbiE3S6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 14:58:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB59C2D1DB;
        Mon, 30 May 2022 11:58:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6CD87B80ED4;
        Mon, 30 May 2022 18:58:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3EC3AC34119;
        Mon, 30 May 2022 18:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653937099;
        bh=qe1Xrcz6TB2pIcatHkqZ/+MjP+/zP77KwcCZKP5Tht8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=OOlliKTWJi6hGsg85S/ba1Gy8MD7XRnoZ6qqvd5px5RuIJ6g55tPOiOSHW8kv8pvg
         G8BhIXRN4z1yef6+P8QQJZCiJFAuFqWbwca3AT6ApbfrxthmdfAK56oN+ov3LG2SM5
         C1GJRxWo8F3r/uwsp4hDmXi6EGVa7kH65eklekubT8pyLb5m/0vvSdn7sJi4Z0cYZn
         ZLGVXPCsxwzgdjbkyaALRUyBLda5qR5bEd82ABatykqFErw7a57zp9xmr3RtZld09f
         tdsONnPh/yn/gd7DTt8He7iMdx/54cWK1ghvijQM9ZyuUl57zXXLBAozg6g3qNJN78
         rbQc6Jdn4SRPQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2A7D7EAC09C;
        Mon, 30 May 2022 18:58:19 +0000 (UTC)
Subject: Re: [GIT PULL] parisc architecture updates for v5.19-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YpUQWLSW4OPOc2wX@p100>
References: <YpUQWLSW4OPOc2wX@p100>
X-PR-Tracked-List-Id: <linux-parisc.vger.kernel.org>
X-PR-Tracked-Message-Id: <YpUQWLSW4OPOc2wX@p100>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/for-5.19/parisc-1
X-PR-Tracked-Commit-Id: 72acadfeb378915a3c4990f4252ab33ce8225491
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e11a93567d3f1e843300ed98ff049a4335db8015
Message-Id: <165393709916.18327.16740808652213032400.pr-tracker-bot@kernel.org>
Date:   Mon, 30 May 2022 18:58:19 +0000
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 30 May 2022 20:43:36 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/for-5.19/parisc-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e11a93567d3f1e843300ed98ff049a4335db8015

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
