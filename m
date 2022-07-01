Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF3F356389C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 19:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbiGARd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 13:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiGARdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 13:33:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D1F25296
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 10:33:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4C903B83107
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 17:33:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16463C3411E;
        Fri,  1 Jul 2022 17:33:44 +0000 (UTC)
Date:   Fri, 1 Jul 2022 18:33:41 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 fixes for 5.19-rc5
Message-ID: <Yr8v9alP3O4HZudw@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the arm64 fix below. Thanks.

The following changes since commit c50f11c6196f45c92ca48b16a5071615d4ae0572:

  arm64: mm: Don't invalidate FROM_DEVICE buffers at start of DMA transfer (2022-06-17 19:06:06 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to 410982303772993a86bb7a9cfa7ece34522b2636:

  arm64: hugetlb: Restore TLB invalidation for BBM on contiguous ptes (2022-07-01 18:29:26 +0100)

----------------------------------------------------------------
arm64 fix: restore TLB invalidation for the 'break-before-make' rule on
contiguous ptes (missed in a recent clean-up).

----------------------------------------------------------------
Will Deacon (1):
      arm64: hugetlb: Restore TLB invalidation for BBM on contiguous ptes

 arch/arm64/mm/hugetlbpage.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

-- 
Catalin
