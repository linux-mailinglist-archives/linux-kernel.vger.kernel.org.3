Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E318E4F0DAC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 05:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376983AbiDDDUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 23:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346706AbiDDDUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 23:20:18 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 73CF82D1FB
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 20:18:23 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 033D01FB;
        Sun,  3 Apr 2022 20:18:23 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.36.163])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CEEE73F73B;
        Sun,  3 Apr 2022 20:18:20 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 0/2] mm: protection_map[] cleanups
Date:   Mon,  4 Apr 2022 08:48:38 +0530
Message-Id: <20220404031840.588321-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a split series from an earlier work which tried to drop the array
protection_map[] on various platforms. This series applies on v5.18-rc1.

https://lore.kernel.org/all/1646045273-9343-1-git-send-email-anshuman.khandual@arm.com/

Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>

Anshuman Khandual (2):
  mm/debug_vm_pgtable: Drop protection_map[] usage
  mm/mmap: Clarify protection_map[] indices

 mm/debug_vm_pgtable.c | 31 +++++++++++++++++++------------
 mm/mmap.c             | 18 ++++++++++++++++--
 2 files changed, 35 insertions(+), 14 deletions(-)

-- 
2.25.1

