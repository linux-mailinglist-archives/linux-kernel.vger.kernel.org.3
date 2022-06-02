Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CCE653B3EC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 08:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbiFBGy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 02:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbiFBGy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 02:54:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED09AF41
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 23:54:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8858061213
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 06:54:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8149CC34114;
        Thu,  2 Jun 2022 06:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654152864;
        bh=1oc2ObdIxnTxZG8zrZ3kSVkcaJwZpMA9Wz0uN315oO4=;
        h=Date:From:To:Cc:Subject:From;
        b=W/eEV5nc5y3VIuP4NO3kmiQX1C9c4eDUCJVnZ8670YO16N87g0nLMOnoPxw4z2Q2Z
         Sbgz2Wu+gszjKcbgg8CBW8JdK6gZaL9/7iLHYlYG4++MsqPcPI6nuYkdIg+Swws5Sa
         udbt4eGkS+h14QmRW5fcyPACvKBjSw6vOTus5ZWVIoLmg0UCNrtlxgpGDpAr+apa+j
         biciWoqgdjQ9nnEv8Qz4JGahUWqfrnNRw4RNg5llOUN8103Jgzsh5mrYgtj6S+awL+
         FwVFdDqtvaYA4EfqLtmBfPIujztza+MDUaqBiLF2crhMr47OqPYj/+z+YA7S2eAvqJ
         sYPEvR5WT3LFg==
Date:   Thu, 2 Jun 2022 09:54:17 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] memblock: test suite update
Message-ID: <YphemdvuA/6TYYfz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 672c0c5173427e6b3e2a9bbb7be51ceeec78093a:

  Linux 5.18-rc5 (2022-05-01 13:57:58 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock tags/memblock-v5.19-rc1

for you to fetch changes up to 000605cd1b14f0970465a44bfe89da93cca66348:

  memblock tests: remove completed TODO item (2022-05-09 13:10:58 +0300)

----------------------------------------------------------------
memblock: comment updates for memblock test suite

Update comments in the memblock tests so that they will have consistent
style.

----------------------------------------------------------------
Rebecca Mckeever (5):
      memblock tests: update style of comments for memblock_add_*() functions
      memblock tests: update style of comments for memblock_reserve_*() functions
      memblock tests: update style of comments for memblock_remove_*() functions
      memblock tests: update style of comments for memblock_free_*() functions
      memblock tests: remove completed TODO item

 tools/testing/memblock/TODO              |   3 -
 tools/testing/memblock/tests/basic_api.c | 392 ++++++++++++++++++++++---------
 2 files changed, 278 insertions(+), 117 deletions(-)

-- 
Sincerely yours,
Mike.
