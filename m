Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 208EE4E4AE7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 03:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbiCWC2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 22:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241361AbiCWC2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 22:28:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C358770853
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 19:27:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 74FD8B81DE5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 02:27:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 183CCC340EC;
        Wed, 23 Mar 2022 02:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648002427;
        bh=6Dfiij/36UK3hcmEqkq+37w1b/VU8TcmXwZ+JsZ8RgM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=O1SDJE5Clri1A8mU9JUilL+6a6GY+PmNV7OMu6HzIR24doW8wz+2rkR5Bh+HasiRw
         ACEvuw03nBlctxDb0qpu3mBl3zBL2erfNxBUXuiswsjKWIN3Nh3paTi/VZ4Jx8IbXR
         cT8dUKHxjlST/LbM+gWcxTwE/vo0oBkMqih6QeWAP5nUR2SvC9XqYNuv5C9zNuFYuU
         xshN6MLEvFfWjf5P/8x9smvveekTE5EFPLJpSLgeb/UVgZrNV77tvM5jwW1e9pSBRG
         cqhAnK8ZMkGP8Nqf2GIvWPwjt3tk3+FQSo4RlQs+/cjT3ETlLnVYGQRLZN9k/GEh3b
         /x3KeQ52jPr8w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 06223E6D406;
        Wed, 23 Mar 2022 02:27:07 +0000 (UTC)
Subject: Re: Re: [GIT PULL] Folio patches for 5.18 (MM part)
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yji6plPgEAeWuq38@casper.infradead.org>
References: <Yjh+EuacJURShtJI@casper.infradead.org>
 <9ae0a8e4-41b7-04f4-4435-17cbba9850fb@redhat.com>
 <d5676cf0-30f9-8497-95a8-332767dede46@redhat.com>
 <YjiaSbUBLJP+9Jtt@casper.infradead.org>
 <9ece8da5-ae0c-fe1c-ff2f-961f641c00fe@redhat.com>
 <YjittBLCYpft5ALc@casper.infradead.org>
 <74cd5e99-a52b-610c-89aa-a5fac43cdab6@redhat.com> <Yji6plPgEAeWuq38@casper.infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yji6plPgEAeWuq38@casper.infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/willy/pagecache.git tags/folio-5.18c
X-PR-Tracked-Commit-Id: 2a3c4bce3edb0d54983384aa8a88c0da330638f4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9030fb0bb9d607908d51f9ee02efdbe01da355ee
Message-Id: <164800242702.31111.11874847797311658927.pr-tracker-bot@kernel.org>
Date:   Wed, 23 Mar 2022 02:27:07 +0000
To:     Matthew Wilcox <willy@infradead.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Hugh Dickins <hughd@google.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Alistair Popple <apopple@nvidia.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Rapoport <rppt@kernel.org>,
        William Kucharski <william.kucharski@oracle.com>
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 21 Mar 2022 17:49:26 +0000:

> git://git.infradead.org/users/willy/pagecache.git tags/folio-5.18c

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9030fb0bb9d607908d51f9ee02efdbe01da355ee

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
