Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3504B51EF98
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 21:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbiEHTGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 15:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379968AbiEHSov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 14:44:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1561BCA6
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 11:41:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79DE9612A0
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 18:41:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E1F8DC385B0;
        Sun,  8 May 2022 18:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652035259;
        bh=782JbC/pDhsfGTVohWw4dLV3JHYCIq5I1J9oQSm5Fjk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=FgFlBvh8CwQhKZ1FQmzeISr9Ji7huqeMKWx7dAA/SrImjC5zIaYXg9J3VhSC1DXLe
         GZmeFo109B0vZX3ujsZymvQv5sfv04ncgIvHoIHIJ68E+LRK+JnpIdTXuqpdequ8Xw
         EIAK7PWon6lZ1gXV9tr4wUOvdUPhNHI7awqnJSHlOtU1eAc2S1I1eO920ckz7OuGqR
         Z56AuttSqtUXnTH9zyjshPhem5MvEicpX9B0pVnoSd2jyXIUwYh9lhSCWEZnDeTxGr
         7BFqDpOcJh9TQe6NIHu0NV9u7t+5g4O8CTft4wYXVsuYB9wvABgp++7eBar96wWH5X
         3cMaswpAqZxXA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BBF09F03876;
        Sun,  8 May 2022 18:40:59 +0000 (UTC)
Subject: Re: [GIT pull] irq/urgent for v5.18-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <165201148219.536527.2201418994305067142.tglx@xen13>
References: <165201148069.536527.1960632033331546251.tglx@xen13> <165201148219.536527.2201418994305067142.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <165201148219.536527.2201418994305067142.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2022-05-08
X-PR-Tracked-Commit-Id: 8707898e22fd665bc1d7b18b809be4b56ce25bdd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9692df0581eae29abcc925ca3c12babc6c194741
Message-Id: <165203525975.974.810523761998126342.pr-tracker-bot@kernel.org>
Date:   Sun, 08 May 2022 18:40:59 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun,  8 May 2022 14:05:21 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2022-05-08

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9692df0581eae29abcc925ca3c12babc6c194741

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
