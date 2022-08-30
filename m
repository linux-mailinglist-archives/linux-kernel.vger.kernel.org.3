Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28D8B5A6082
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 12:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbiH3KRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 06:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbiH3KQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 06:16:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E3C7F23FB
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 03:13:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3CE1B61467
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 10:13:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17631C433D7;
        Tue, 30 Aug 2022 10:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661854414;
        bh=tokvs6zH6CHXeOS1wMLKfLFiBpqk5htmIJm9wAVZXJg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=btKHrg3BHP3wS272Iha4/v1GmFwsOk8wsjWgvmvgcKH1zktBkXOuw6D8rdxYKiXHZ
         SXp0j5jHjVokD/+Uil032UuaiHwI2bFFARai6LQ5feTdKUrySVaYmlsssxaQoRKzkA
         oK6MrRabdzjIndM1m/ylHHDd9IbCUJPG0E31+DHVDJdpGxiaYBOfwgV5RELaRK6Aci
         y8eNIHGkS7ZQ81sjQdk8TDpLlC9K7u/4fTswaZEgnMWqLRQ5qQ6Aau3sIeqLDmD1rI
         VpRhJlcw4JbItO7na10tJwABbysxyX8mU/6sFb0TzOp3pheGjpk8J0oYPEnhXlhxKw
         9mW40nks0iQkQ==
Date:   Tue, 30 Aug 2022 13:13:18 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Rebecca Mckeever <remckee0@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v3 0/8] memblock tests: update and extend memblock
 simulator
Message-ID: <Yw3ivnYL4urhRlCQ@kernel.org>
References: <cover.1661578349.git.remckee0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1661578349.git.remckee0@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 27, 2022 at 12:42:42AM -0500, Rebecca Mckeever wrote:
> These patches update existing tests in memblock simulator, add
> additional tests for memblock functions that are already being tested,
> and add test coverage for additional memblock functions.
> 
> Rebecca Mckeever (8):
>   memblock tests: update tests to check if memblock_alloc zeroed memory
>   memblock tests: update zeroed memory check for memblock_alloc_* tests
>   memblock tests: add labels to verbose output for generic alloc tests
>   memblock tests: add additional tests for basic api and memblock_alloc
>   memblock tests: update alloc_api to test memblock_alloc_raw
>   memblock tests: update alloc_nid_api to test
>     memblock_alloc_try_nid_raw
>   memblock tests: add tests for memblock_*bottom_up functions
>   memblock tests: add tests for memblock_trim_memory
> 
>  tools/testing/memblock/tests/alloc_api.c      | 168 +++-
>  .../memblock/tests/alloc_helpers_api.c        |  20 +-
>  tools/testing/memblock/tests/alloc_nid_api.c  | 252 +++---
>  tools/testing/memblock/tests/basic_api.c      | 767 ++++++++++++++++++
>  tools/testing/memblock/tests/common.c         |   7 +
>  tools/testing/memblock/tests/common.h         |  55 ++
>  6 files changed, 1082 insertions(+), 187 deletions(-)

Applied, thanks!

-- 
Sincerely yours,
Mike.
