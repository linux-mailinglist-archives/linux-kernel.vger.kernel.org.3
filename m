Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1014B2D29
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 19:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236566AbiBKSxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 13:53:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235513AbiBKSxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 13:53:10 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A378CD8
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 10:53:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 56FCACE2A47
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 18:53:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D46DC340E9;
        Fri, 11 Feb 2022 18:53:04 +0000 (UTC)
Date:   Fri, 11 Feb 2022 18:53:00 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 fixes for 5.17-rc4
Message-ID: <YgawjGlDGS4l5pBY@arm.com>
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

Please pull the arm64 fixes below. Thanks.

The following changes since commit 297ae1eb23b04c5a46111ab53c8d0f69af43f402:

  arm64: cpufeature: List early Cortex-A510 parts as having broken dbm (2022-01-28 16:15:46 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to da5fb9e1ad3fbf632dce735f1bdad257ca528499:

  ACPI/IORT: Check node revision for PMCG resources (2022-02-09 18:16:22 +0000)

----------------------------------------------------------------
arm64 fixes:

- Enable Cortex-A510 erratum 2051678 by default as we do with other
  errata.

- arm64 IORT: Check the node revision for PMCG resources to cope with
  old firmware based on a broken revision of the spec that had no way to
  describe the second register page (when an implementation is using the
  recommended RELOC_CTRS feature).

----------------------------------------------------------------
Mark Brown (1):
      arm64: Enable Cortex-A510 erratum 2051678 by default

Robin Murphy (1):
      ACPI/IORT: Check node revision for PMCG resources

 arch/arm64/Kconfig        |  1 +
 drivers/acpi/arm64/iort.c | 14 +++++++++++---
 2 files changed, 12 insertions(+), 3 deletions(-)

-- 
Catalin
