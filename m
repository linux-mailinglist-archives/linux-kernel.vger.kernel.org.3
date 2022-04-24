Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A31B150CE24
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 02:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236648AbiDXAfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 20:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234377AbiDXAfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 20:35:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6463DCE15;
        Sat, 23 Apr 2022 17:32:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1CA8261163;
        Sun, 24 Apr 2022 00:32:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7B8C1C385A5;
        Sun, 24 Apr 2022 00:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650760355;
        bh=cY0UoqIWTmuADg+9JqpKHIbTPULIffXlLvBrQtecscY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=S1LfJaF9LKB53KDFq5pfY0vyHBz8Z9MIqYDYoaVczpg4HNVqZmuIcCmAcYFTTZpER
         NkDxHHWmemZNsQTLGNngKM7ByI27gX4tRgTNLiWoml9hkMPkQ0Cy3zIfRk7EoQZUGC
         AxTWTd0kb/XoHc4RG3R0E9E9SuPfA7uXormxOG8QtmL3sk4EMy9OA9mgW8SFEyYTWr
         fGMEQRBpbtoYF8aytQP7niAIb/e7WstfqgXL2ShCqWE6ey4CvUqMgYqM8HPbvMG2wN
         yRAwzPEaAH+KP01+nFUx+wygs+5+Y5wTxYamR0r9GxorK2GecPzkeSga87HzYseZuT
         2VXEfgzBhHo8A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 67853E8DBD4;
        Sun, 24 Apr 2022 00:32:35 +0000 (UTC)
Subject: Re: [GIT PULL] ksmbd server fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5muyG8HZJvOYi+wPa_Qj6Yce8Q4MR-Oh28DrT1j8iH8FuQ@mail.gmail.com>
References: <CAH2r5muyG8HZJvOYi+wPa_Qj6Yce8Q4MR-Oh28DrT1j8iH8FuQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-cifs.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5muyG8HZJvOYi+wPa_Qj6Yce8Q4MR-Oh28DrT1j8iH8FuQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/ksmbd.git tags/5.18-rc3-ksmbd-fixes
X-PR-Tracked-Commit-Id: 02655a70b7cc0f534531ee65fa72692f4d31a944
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 22da5264abf497a10a4ed629f07f4ba28a7ed5eb
Message-Id: <165076035541.3271.12557705507165091328.pr-tracker-bot@kernel.org>
Date:   Sun, 24 Apr 2022 00:32:35 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        Namjae Jeon <linkinjeon@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 23 Apr 2022 19:10:23 -0500:

> git://git.samba.org/ksmbd.git tags/5.18-rc3-ksmbd-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/22da5264abf497a10a4ed629f07f4ba28a7ed5eb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
