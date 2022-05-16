Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46BC15293CB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 00:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349820AbiEPWt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 18:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349871AbiEPWsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 18:48:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD6934132F
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 15:48:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 79744B81681
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 22:48:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2776C385AA;
        Mon, 16 May 2022 22:48:39 +0000 (UTC)
Date:   Mon, 16 May 2022 23:48:36 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     will@kernel.org, akpm@linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, hch@infradead.org, arnd@arndb.de
Subject: Re: [PATCH v2 5/5] arm64: Add HAVE_IOREMAP_PROT support
Message-ID: <YoLUxPyTsuANbKQX@arm.com>
References: <20220429103225.75121-1-wangkefeng.wang@huawei.com>
 <20220429103225.75121-6-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429103225.75121-6-wangkefeng.wang@huawei.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 06:32:25PM +0800, Kefeng Wang wrote:
> With ioremap_prot() defination from generic ioremap, also move
> pte_pgprot() from hugetlbpage.c into pgtable.h, then arm64 could
> have HAVE_IOREMAP_PROT, which will enable generic_access_phys()
> code.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
