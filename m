Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D73E50B8F2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 15:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448023AbiDVNsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 09:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352444AbiDVNsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 09:48:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6970CBB8
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 06:45:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1C4E3B82AC6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 13:45:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0072C385A4;
        Fri, 22 Apr 2022 13:45:33 +0000 (UTC)
Date:   Fri, 22 Apr 2022 14:45:30 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/mm: Compute PTRS_PER_[PMD|PUD] independently of
 PTRS_PER_PTE
Message-ID: <YmKxehhwVIzVo3Di@arm.com>
References: <20220408041009.1259701-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220408041009.1259701-1-anshuman.khandual@arm.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2022 at 09:40:09AM +0530, Anshuman Khandual wrote:
> Possible page table entries (or pointers) on non-zero page table levels are
> dependent on a single page size i.e PAGE_SIZE and size required for each
> individual page table entry i.e 8 bytes. PTRS_PER_[PMD|PUD] as such are not
> related to PTRS_PER_PTE in any manner, as being implied currently. So lets
> just make this very explicit and compute these macros independently.

OTOH, we have lots of other assumptions about pmd etc. being updated
using the pte macros. Anyway, I'm fine with this.

-- 
Catalin
