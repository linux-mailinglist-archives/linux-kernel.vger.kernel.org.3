Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2432E57D3BA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 20:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233641AbiGUS6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 14:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233273AbiGUS6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 14:58:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A7C8CCB5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 11:58:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 11B84B82636
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 18:58:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A60F1C3411E;
        Thu, 21 Jul 2022 18:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658429880;
        bh=L1a1dJ1Q7yv/Uynd18WPyAqSHQ1eoKFvhjTWuxPZnhk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=fg6FusY7IZ6xqVSxhaivnLD9p8O/UtSWhobOzkl6SXrwWyXd3n/v3Uf3E6wu1sJqW
         c0mgmHtK/T9wB4zVJkl2vxkiNoJSgDTKQIiYR61eK+UqHSWMOgc3Qh2QIvuBHUxRTt
         eR3RlEmWoBEwgrAeYyjl9eYzURrkou4MJbWDo71mC24Q+eFskA3cKHUtz7ucEZf5S0
         NQXiI47NC9YwP04N/4/CCVj8IkUFZfZgczGNAbWPTSzWbcVKeA0ywsdCY/ONgg976A
         n0soDooFTnIeMxtSpR1QKk8z0QQD76Weo0vlfyolVBHvCRgWUwRTC5eMF0JiutVQ+2
         LeL6tL9AZSkow==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 94517E451B0;
        Thu, 21 Jul 2022 18:58:00 +0000 (UTC)
Subject: Re: [GIT PULL] MTD fix for 5.19-final
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1803003448.13661.1658415349943.JavaMail.zimbra@nod.at>
References: <1803003448.13661.1658415349943.JavaMail.zimbra@nod.at>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1803003448.13661.1658415349943.JavaMail.zimbra@nod.at>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/fixes-for-5.19-final
X-PR-Tracked-Commit-Id: 0fddf9ad06fd9f439f137139861556671673e31c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 68e77ffbfd06ae3ef8f2abf1c3b971383c866983
Message-Id: <165842988060.25323.8126060370434664563.pr-tracker-bot@kernel.org>
Date:   Thu, 21 Jul 2022 18:58:00 +0000
To:     Richard Weinberger <richard@nod.at>
Cc:     torvalds <torvalds@linux-foundation.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        miquel.raynal@bootlin.com, vigneshr@ti.com
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 21 Jul 2022 16:55:49 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/fixes-for-5.19-final

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/68e77ffbfd06ae3ef8f2abf1c3b971383c866983

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
