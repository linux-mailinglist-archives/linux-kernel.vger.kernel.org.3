Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 747AA490229
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 07:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237226AbiAQGzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 01:55:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237182AbiAQGy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 01:54:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DBBBC061574
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 22:54:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D140B60F2A
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 06:54:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4504DC36AE3;
        Mon, 17 Jan 2022 06:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642402497;
        bh=Z9FC3Og25bQuzjGgkjTpc1dbdgHJpSSjhoXKuNr/2zE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jy4LKi9hUsrU/pyclDKQRltMAVMy/qO6Tu6Zn6E/MGzPgweCWLhEClikcSUddXijf
         EiTLoZO2km8PuXf9Id+okpTpXCzQyx4W9w71zeI7RcnA7zP+xv9WNVA1ZVXbTijigq
         zLxt8DXdY7gzUou8TJRbEG3krFTBA8ugfby+EXlx8GJefSA8Mq03CIMSyTUXHjLXuI
         eWLCIhDrozJns/N6CaWuTbVffxNs1DMSWpcIqP2CGRcpwW+Hv5OqYIWaoiJPc8EWcL
         rKwmUmw5uZaFID6fRp4jEQl9yYFZKRhAGxTxIXoampYwn6jbxOCQ+ZDkzgu9jYVP32
         DS//++z8zcdeA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 34A80F60798;
        Mon, 17 Jan 2022 06:54:57 +0000 (UTC)
Subject: Re: [GIT PULL] I3C changes for 5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YeSIwUuZHPeBcAKR@piout.net>
References: <YeSIwUuZHPeBcAKR@piout.net>
X-PR-Tracked-List-Id: <linux-i3c.lists.infradead.org>
X-PR-Tracked-Message-Id: <YeSIwUuZHPeBcAKR@piout.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git tags/i3c/for-5.17
X-PR-Tracked-Commit-Id: 13462ba1815db5a96891293a9cfaa2451f7bd623
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4b3789512f018819e0c4b0776731dc4ce694c484
Message-Id: <164240249721.26213.4168214220727839345.pr-tracker-bot@kernel.org>
Date:   Mon, 17 Jan 2022 06:54:57 +0000
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 16 Jan 2022 22:06:09 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git tags/i3c/for-5.17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4b3789512f018819e0c4b0776731dc4ce694c484

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
