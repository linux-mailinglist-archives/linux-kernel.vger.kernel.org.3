Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACB644DE1E4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 20:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240391AbiCRTkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 15:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240380AbiCRTkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 15:40:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E3610CF36;
        Fri, 18 Mar 2022 12:38:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8270061BC8;
        Fri, 18 Mar 2022 19:38:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E5787C340ED;
        Fri, 18 Mar 2022 19:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647632336;
        bh=zxsdRYNoeRoXFVngk54VQB8LcDBO0SmY/oHX6wS907I=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=fpMNd9j3cmiyuKWT3RBXJlskdsN0019W6I62GxbuwwiECqc+ts/RhE0QKSbiKIGGn
         capLjodVAoYwc5lSU4OVPk5MzNh2qTmH+XAQ6MutbU08HyeQNWm5VXUuLvhosNpaJp
         VCEFA6ZUslvpmQMA+SegNcq5Yk/pmHsvimw1rJ3oRH+DsYVKz8JI/uCOB35b7oiQ17
         UEDQfvPvuGwu+hZ8oJdJFwlFIsjODi5Aczn93c4CVKGx0JKSZeUt7z3yUawFFuAI+B
         rCBuzom6XmXfIjl8WlNupnQfA+Oyyj7GX0AblmtBFadkcUEy3olH8p7oHQ/HhDgzFc
         QgFnTFNfP6+AA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CE8C8E6D44B;
        Fri, 18 Mar 2022 19:38:56 +0000 (UTC)
Subject: Re: [GIT PULL] smb3 fix
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5mvgGMBOXhSvDw67aUoHLoEeDFh-hAUfHmdFsEptMkT+LA@mail.gmail.com>
References: <CAH2r5mvgGMBOXhSvDw67aUoHLoEeDFh-hAUfHmdFsEptMkT+LA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-cifs.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5mvgGMBOXhSvDw67aUoHLoEeDFh-hAUfHmdFsEptMkT+LA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/5.17-rc8-smb3-fix
X-PR-Tracked-Commit-Id: e3ee9fb22652f228225c352bd4fabec330cac5f0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6e4069881a7f9dceb6dfb97e436d55e3c7f43e81
Message-Id: <164763233684.31275.18111973779611415664.pr-tracker-bot@kernel.org>
Date:   Fri, 18 Mar 2022 19:38:56 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 18 Mar 2022 12:14:45 -0500:

> git://git.samba.org/sfrench/cifs-2.6.git tags/5.17-rc8-smb3-fix

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6e4069881a7f9dceb6dfb97e436d55e3c7f43e81

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
