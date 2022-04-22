Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB90050BFEF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 20:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbiDVSvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 14:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiDVSvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 14:51:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E685716E6B8
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 11:47:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 861AF6194A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 18:27:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9D11C385A4;
        Fri, 22 Apr 2022 18:27:48 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/mm: Compute PTRS_PER_[PMD|PUD] independently of PTRS_PER_PTE
Date:   Fri, 22 Apr 2022 19:27:46 +0100
Message-Id: <165065206268.1611310.15902401003988061413.b4-ty@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220408041009.1259701-1-anshuman.khandual@arm.com>
References: <20220408041009.1259701-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Apr 2022 09:40:09 +0530, Anshuman Khandual wrote:
> Possible page table entries (or pointers) on non-zero page table levels are
> dependent on a single page size i.e PAGE_SIZE and size required for each
> individual page table entry i.e 8 bytes. PTRS_PER_[PMD|PUD] as such are not
> related to PTRS_PER_PTE in any manner, as being implied currently. So lets
> just make this very explicit and compute these macros independently.
> 
> 
> [...]

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64/mm: Compute PTRS_PER_[PMD|PUD] independently of PTRS_PER_PTE
      https://git.kernel.org/arm64/c/2a2848e7c2fd

-- 
Catalin

