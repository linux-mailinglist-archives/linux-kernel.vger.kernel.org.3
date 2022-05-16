Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0F9B5293D9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 00:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346049AbiEPWvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 18:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349862AbiEPWvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 18:51:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A92411C3E
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 15:51:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1653860B11
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 22:51:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D87F3C385AA;
        Mon, 16 May 2022 22:51:03 +0000 (UTC)
Date:   Mon, 16 May 2022 23:51:00 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     will@kernel.org, akpm@linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, hch@infradead.org, arnd@arndb.de
Subject: Re: [PATCH v2 0/5] arm64: Cleanup ioremap() and support
 ioremap_prot()
Message-ID: <YoLVVJXRnDXCPVO8@arm.com>
References: <20220429103225.75121-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429103225.75121-1-wangkefeng.wang@huawei.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 06:32:20PM +0800, Kefeng Wang wrote:
> Kefeng Wang (5):
>   mm: ioremap: Use more sensibly name in ioremap_prot()
>   mm: ioremap: Setup phys_addr of struct vm_struct
>   mm: ioremap: Add arch_ioremap/iounmap()
>   arm64: mm: Convert to GENERIC_IOREMAP
>   arm64: Add HAVE_IOREMAP_PROT support
> 
>  .../features/vm/ioremap_prot/arch-support.txt |  2 +-
>  arch/arm64/Kconfig                            |  2 +
>  arch/arm64/include/asm/io.h                   | 20 +++--
>  arch/arm64/include/asm/pgtable.h              | 10 +++
>  arch/arm64/kernel/acpi.c                      |  2 +-
>  arch/arm64/mm/hugetlbpage.c                   | 10 ---
>  arch/arm64/mm/ioremap.c                       | 85 +++----------------
>  include/asm-generic/io.h                      | 16 +++-
>  mm/ioremap.c                                  | 27 ++++--
>  9 files changed, 74 insertions(+), 100 deletions(-)

These patches touch the generic mm parts. Andrew, would you like to
merge these patches or are happy for them to go via the arm64 tree.

Thanks.

-- 
Catalin
