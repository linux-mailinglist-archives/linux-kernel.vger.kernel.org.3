Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C15B65735D9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 13:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236101AbiGMLzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 07:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbiGMLzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 07:55:32 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDCAAF54D7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 04:55:30 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R831e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VJDr3B3_1657713325;
Received: from localhost(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0VJDr3B3_1657713325)
          by smtp.aliyun-inc.com;
          Wed, 13 Jul 2022 19:55:26 +0800
From:   Xianting Tian <xianting.tian@linux.alibaba.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, alexandre.ghiti@canonical.com,
        guoren@kernel.org, anup@brainfault.org, mick@ics.forth.gr,
        rppt@kernel.org, heiko@sntech.de
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        huanyi.xj@alibaba-inc.com,
        Xianting Tian <xianting.tian@linux.alibaba.com>
Subject: [PATCH 0/2] Improve vmcoreinfo and memory layout dump 
Date:   Wed, 13 Jul 2022 19:55:21 +0800
Message-Id: <20220713115523.357817-1-xianting.tian@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xianting Tian (2):
  RISC-V: Add arch_crash_save_vmcoreinfo support
  riscv: Add modules to virtual kernel memory layout dump

 arch/riscv/kernel/Makefile     |  1 +
 arch/riscv/kernel/crash_core.c | 28 ++++++++++++++++++++++++++++
 arch/riscv/mm/init.c           |  2 ++
 3 files changed, 31 insertions(+)
 create mode 100644 arch/riscv/kernel/crash_core.c

-- 
2.17.1

