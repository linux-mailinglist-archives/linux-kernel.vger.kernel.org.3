Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6F1535720
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 02:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233737AbiE0AdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 20:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235499AbiE0Ac7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 20:32:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC585E27A2
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 17:32:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B81C61D2E
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 00:32:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7F5C5C34116;
        Fri, 27 May 2022 00:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653611577;
        bh=jpsnKfN0XtgsYHiVoQJxTMWBCzeiS9DixxGqk4RlREk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=gVAg96tHTTdMKUit0Oo/VnFdR9NUwEK9pVNfrzLhLU+8t1AQqUdxCcerNxH+QspAW
         GEHfgTrSpdC8U/dDChvnHsuYFDiimXuBi8pDqZIWSm9pijz924d2OGjQVXIe2xhNUj
         wM7YkZcevWD1f8oWFKFtAB5q8E0tFD8rXerOLhQFyF2uZU1UE3jxDvhcRD9m+cYEKZ
         wJnsq+Jdf3JMWr+cXSQjjkCbe0V2OZOsjVrn8Q27sygV/4lxpSRcEvkpuOfASn5zgJ
         98NeWP6QR9egP75RS7KOzpagMlr2oQR+AcAeWQjQ5Sfkld/eeE6Y3HU+BXpWzn5jkT
         /zMSzOyJq5P+A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6D084F0394B;
        Fri, 27 May 2022 00:32:57 +0000 (UTC)
Subject: Re: [GIT PULL] ARC changes for 5.19-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <a22af786-288f-92ad-79a0-0f40768cfdbc@kernel.org>
References: <a22af786-288f-92ad-79a0-0f40768cfdbc@kernel.org>
X-PR-Tracked-List-Id: Linux on Synopsys ARC Processors <linux-snps-arc.lists.infradead.org>
X-PR-Tracked-Message-Id: <a22af786-288f-92ad-79a0-0f40768cfdbc@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git/ tags/arc-5.19-rc1
X-PR-Tracked-Commit-Id: 6aa98f6217861889523e38b0141c8c71b2ef8a83
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ba62a537b48d7ae60524000efe01c9e76e2a5b2d
Message-Id: <165361157744.27205.7451494152434674625.pr-tracker-bot@kernel.org>
Date:   Fri, 27 May 2022 00:32:57 +0000
To:     Vineet Gupta <vgupta@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        lkml <linux-kernel@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        abrodkin@synopsys.com, "geomatsi@gmail.com" <geomatsi@gmail.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 25 May 2022 20:40:39 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git/ tags/arc-5.19-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ba62a537b48d7ae60524000efe01c9e76e2a5b2d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
