Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ECFE53F326
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 02:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235548AbiFGA7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 20:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232513AbiFGA7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 20:59:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2058D110D
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 17:59:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 45FACB81C8A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 00:59:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 00240C385A9;
        Tue,  7 Jun 2022 00:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654563555;
        bh=qhUMQOw5KQrmEgJP6K0Cw72gee4T5pVmV1HiwYo1mGs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Ysb4zzgvWvEVRSTJxA9YgXEHuyGu1FMjOyR7BNKSAHEURXOZeVkzjpsqH54Nfw2Kb
         19MK31SAYmekjxgVeiGtyz6Vmx6anM+VQv0PPieKXZpCmftez7WgqMolcXLrQB1mzn
         hEHrEZkgBwN9RTtZQRFCQ26p6JVx6nDiDPciN5BtfTHigPlT7b7ZF0p3FvNKukYomt
         e8irEhIL8TuqkXcvXXM9COcMU1hNnawah1Sg1YwY4CDPTzlNv/cROzjrKDcWP30yZn
         IEFBka2NFuLC3rdv9D9dNK420t6pBjMa7HhQA/woOm/GYJWmPD5OLvo0sawJeiXS0H
         GwpSbk4xoCQpQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DE945E737ED;
        Tue,  7 Jun 2022 00:59:14 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping fixes for 5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yp2g9SGrXn0eSvnA@infradead.org>
References: <Yp2g9SGrXn0eSvnA@infradead.org>
X-PR-Tracked-List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
X-PR-Tracked-Message-Id: <Yp2g9SGrXn0eSvnA@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.19-2022-06-06
X-PR-Tracked-Commit-Id: e15db62bc5648ab459a570862f654e787c498faf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e71e60cd74df9386c3f684c54888f2367050b831
Message-Id: <165456355490.3209.6140029243498184002.pr-tracker-bot@kernel.org>
Date:   Tue, 07 Jun 2022 00:59:14 +0000
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 6 Jun 2022 08:38:45 +0200:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.19-2022-06-06

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e71e60cd74df9386c3f684c54888f2367050b831

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
