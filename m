Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE4B5546C4A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 20:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350045AbiFJS0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 14:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346606AbiFJS0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 14:26:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2367129C9A;
        Fri, 10 Jun 2022 11:26:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B40A0621E1;
        Fri, 10 Jun 2022 18:25:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 28810C34114;
        Fri, 10 Jun 2022 18:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654885559;
        bh=kmv/sVRNXswSbDzreJQWTHBaeUQAge3ypdBeYlebc0M=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Fhhvdnh6WV2fcLpmnVLooZ8Ugzy51JhqO/mW0LH+Q4zyJBazmRADHZCrTNsuv5VsM
         Iul/dlKeHRoPgwHYKIDvwzFvr5Z0SaAJ261XBeJcBYvFRnfy1JcPqwFPw4s5ju7E+r
         0AMkuRP6FHmnSmtA6aJJ4jqVhV7xrQ6V726KgCnKd3CUD5pJiB44zBsosL+kWRO6Yz
         7+R0ey0cP+20UdmST4eO+kNlrM6+OxHLHdEudA0lU5uDBYV3LOIpcj23muX/cQPLdZ
         b0gYxmh5fnsQy8lQieYXOo1exLk3jEWXHYdrBLXF+9vAHMdV3ozhGipR8HxRDNMHwE
         4rBDNXynKAUtw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 15B8EE737EE;
        Fri, 10 Jun 2022 18:25:59 +0000 (UTC)
Subject: Re: [GIT PULL] MIPS fixes for v5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220610101033.GA10649@alpha.franken.de>
References: <20220610101033.GA10649@alpha.franken.de>
X-PR-Tracked-List-Id: <linux-mips.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220610101033.GA10649@alpha.franken.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips-fixes_5.19_1
X-PR-Tracked-Commit-Id: 41e456400212803704e82691716e1d7b0865114a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7d78b7ebdf7dac762c3807274182b7c582be7937
Message-Id: <165488555908.32117.6643057963147850358.pr-tracker-bot@kernel.org>
Date:   Fri, 10 Jun 2022 18:25:59 +0000
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     torvalds@linux-foundation.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 10 Jun 2022 12:10:33 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips-fixes_5.19_1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7d78b7ebdf7dac762c3807274182b7c582be7937

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
