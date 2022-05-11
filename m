Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC9BB52383B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 18:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344393AbiEKQK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 12:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344373AbiEKQKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 12:10:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7700264F
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 09:10:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3BB0AB8255A
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 16:10:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A81EEC34113;
        Wed, 11 May 2022 16:10:44 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     linux-arm-kernel@lists.infradead.org,
        Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Will Deacon <will@kernel.org>, steve.capper@arm.com,
        Mike Kravetz <mike.kravetz@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/hugetlb: Drop TLB flush from get_clear_flush()
Date:   Wed, 11 May 2022 17:10:42 +0100
Message-Id: <165228543800.1284917.10527861663163138917.b4-ty@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220510043930.2410985-1-anshuman.khandual@arm.com>
References: <20220510043930.2410985-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 May 2022 10:09:30 +0530, Anshuman Khandual wrote:
> This drops now redundant TLB flush in get_clear_flush() which is no longer
> required after recent commit 697a1d44af8b ("tlb: hugetlb: Add more sizes to
> tlb_remove_huge_tlb_entry"). It also renames this function i.e dropping off
> '_flush' and replacing it with '__contig' as appropriate.
> 
> 

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64/hugetlb: Drop TLB flush from get_clear_flush()
      https://git.kernel.org/arm64/c/fb396bb459c1

-- 
Catalin

