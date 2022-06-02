Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2F0A53BC13
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 18:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236816AbiFBQHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 12:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236770AbiFBQHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 12:07:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D81C186281
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 09:07:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF7B9614AB
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 16:07:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 29EC3C385A5;
        Thu,  2 Jun 2022 16:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654186061;
        bh=XMFFxZYBEUXGll5mLuRWL85TlIfSzcamJ0XcoQepX3o=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=CDzJD4YrgAia7b4M0ZhVeI3NOewGNEAhZVEWcao02sltgYNeJwu4kC4PpscEr68hQ
         U6V2oUm/aDy2/Tpce0xVgVKTee9LlCUgT5FwerRd4H0y6fAy5woqYt18JiwYr1M45b
         nJlLHJgX4tEWgT4Kf3gh8CO45Hw+q7W0Wsami49n5J1lkoDzXRlG51+zqTQEwEo8sA
         uS0103YnRu7XY3dX+pi33oMPbn78ocrQ4BVAceJrA1Vya99Hj/aGf3/0WqWzFhiIuP
         eDgmM+3ev1JxAKXgW+vl2igAqFxj6onnavrIX1gAv0X/L2KHRrt80VUsqXt3Wr/ELf
         cvJ3YQTRWsXHQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 167C2EAC09C;
        Thu,  2 Jun 2022 16:07:41 +0000 (UTC)
Subject: Re: [GIT PULL] memblock: test suite update
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YphemdvuA/6TYYfz@kernel.org>
References: <YphemdvuA/6TYYfz@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YphemdvuA/6TYYfz@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock tags/memblock-v5.19-rc1
X-PR-Tracked-Commit-Id: 000605cd1b14f0970465a44bfe89da93cca66348
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ca1dcc6d0c569e1e5f5b4a764329d9530760a416
Message-Id: <165418606108.19639.8516954894168661582.pr-tracker-bot@kernel.org>
Date:   Thu, 02 Jun 2022 16:07:41 +0000
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 2 Jun 2022 09:54:17 +0300:

> https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock tags/memblock-v5.19-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ca1dcc6d0c569e1e5f5b4a764329d9530760a416

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
