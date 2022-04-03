Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3FB4F0C7C
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 22:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357497AbiDCUcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 16:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376460AbiDCUb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 16:31:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386AE33896
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 13:30:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C466C60C79
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 20:30:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2C7FCC34113;
        Sun,  3 Apr 2022 20:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649017801;
        bh=hJ+cR2dw6A3aiR2haiOBgAqyQy8RWgeFsCXoLvdoK9c=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=RjlVOKy0AZcWo3BwYr1tRw7dZlOG6RM0fVQaf+JuQalq5l3YOAVcJ+7A7JV6iCVcJ
         XBjGF7stJUmXby1VIqXtisBydkMhjea/m7nFRN1Ol3cLofi9/nHUUzd4j+bChneD4C
         cWoFw6Ap4mcivN53wpDNFDLb+Ri3wUnOVW8GHkklS9XG8IcNDnBs11BWIlW/3lx3P7
         yDHuSeAvx/2HjK6wCHsFmhCb85aUyj6q6BD2icI/boFYYKb6E4acwWlYoLCrI95IYJ
         SP9yyE4dLxZNjKmGiapC2gk8QK3pcDXK6Y0FWOYLZ7KUxP/BlkxNieW2DpXLa8OMPp
         QgQ2SarNvhc+A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 17D98F03839;
        Sun,  3 Apr 2022 20:30:01 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: Updates to tracing 5.18 pull request
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220403105030.3968c6d3@rorschach.local.home>
References: <20220403105030.3968c6d3@rorschach.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220403105030.3968c6d3@rorschach.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.18-2
X-PR-Tracked-Commit-Id: 5cfff569cab8bf544bab62c911c5d6efd5af5e05
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 09bb8856d4a7cf3128dedd79cd07d75bbf4a9f04
Message-Id: <164901780109.22329.12856364381839252268.pr-tracker-bot@kernel.org>
Date:   Sun, 03 Apr 2022 20:30:01 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Lv Ruyi <lv.ruyi@zte.com.cn>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 3 Apr 2022 10:50:30 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.18-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/09bb8856d4a7cf3128dedd79cd07d75bbf4a9f04

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
