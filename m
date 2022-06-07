Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7062542666
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382552AbiFHBxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 21:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1583025AbiFGXqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 19:46:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9852E4391;
        Tue,  7 Jun 2022 15:06:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1C5FAB82456;
        Tue,  7 Jun 2022 22:06:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CF913C385A2;
        Tue,  7 Jun 2022 22:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654639570;
        bh=RRlJzCWCZfZMbkpaSDZsgTcnf8hYwEfy32E7RVLd1wk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=pZEPOuC7ua4P3ml30W9JhWc1wxyA3JBUazUt7jNeKwXYg6k6abOcxyyE9E37Z4Qlh
         VAoX7E7Se8l3QlK330ZjS+wNn12E51teQZe9FN7MgTSzOrR7EOqnCrRZogSuaXYMLu
         5DngjxZuXnxLgjaULMeOWDOMrCEqDgyQlmaBfqQPDZecKNqxoKOdDNLEgrEftkA6Mq
         ZM2ay4YSkichat+z6U240i45OGoZ+fZONZmgKI/fFTfEKMkqKpCDPch1dJz8lbqivp
         Rrcnr7hwlbHMN4QAYyW2tIetKlMNnnf52822K5mee1OlrWp7lnVGpGokR4Jl1FxyYZ
         trfwaABDkTPRA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BA93CE737E8;
        Tue,  7 Jun 2022 22:06:10 +0000 (UTC)
Subject: Re: [GIT PULL] MMC fixes for v5.19-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220607094743.204021-1-ulf.hansson@linaro.org>
References: <20220607094743.204021-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-mmc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220607094743.204021-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.19-2
X-PR-Tracked-Commit-Id: 479260419fa4cb30e3e5d935a857fbdf0ffdd854
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f7a447eda2120ab8988b0f8c708c1fd3bd4d3729
Message-Id: <165463957075.23279.17574785845775017961.pr-tracker-bot@kernel.org>
Date:   Tue, 07 Jun 2022 22:06:10 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue,  7 Jun 2022 11:47:43 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.19-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f7a447eda2120ab8988b0f8c708c1fd3bd4d3729

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
