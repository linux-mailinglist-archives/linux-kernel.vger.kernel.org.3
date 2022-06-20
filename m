Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86BD9551FC7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 17:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241314AbiFTPHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 11:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242487AbiFTPHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 11:07:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B18426105
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 07:45:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B14166119B
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 14:44:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1ED9DC3411B;
        Mon, 20 Jun 2022 14:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655736279;
        bh=BNeslKVmd3jvxQWIBQe1ylqJrzC04i9s7he5Fynox0M=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=dCNqyivp5vSaY/lYdisTmi5hMpBY8kcLfLzPOQEvfP4xWnGjDxHCC4HT9BambMhfZ
         jQ0OBsuCmJF2ntkYQsqrrvmZXh07sVO7Z5VX7UHAg3rWv040KfXXRrvhLt3mIVn+C6
         8bbj9AgaDxCRPubVjhcHHuF+JVcdOAy8TS6BrXS/IiAlv5S44GIQ3dSpGsyiFewHI/
         ZDU1BIBjEHv+Zq4x2aVYPyRdg0DB9hxvkr/hYrO+eYEj8YA9x3aRq8eRxNAfFUb3Nm
         MoaR6ssnAML+W3fq8IfWby1+agjb1lgArlVLAduQ/yoGPb9PwPppZCfDf9E2Ei1zEe
         YwvYiguP6g2Pg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0A70BE737E8;
        Mon, 20 Jun 2022 14:44:39 +0000 (UTC)
Subject: Re: [GIT PULL] slab fixes for 5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <a8082f00-3e00-f781-f5f0-20b4853b3335@suse.cz>
References: <a8082f00-3e00-f781-f5f0-20b4853b3335@suse.cz>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <a8082f00-3e00-f781-f5f0-20b4853b3335@suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git tags/slab-for-5.19-fixup
X-PR-Tracked-Commit-Id: eeaa345e128515135ccb864c04482180c08e3259
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 59b785fe2abbe21267516799f6c584cf4fe5f08b
Message-Id: <165573627903.17677.13888569351342590014.pr-tracker-bot@kernel.org>
Date:   Mon, 20 Jun 2022 14:44:39 +0000
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, patches@lists.linux.dev,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 20 Jun 2022 14:02:45 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git tags/slab-for-5.19-fixup

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/59b785fe2abbe21267516799f6c584cf4fe5f08b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
