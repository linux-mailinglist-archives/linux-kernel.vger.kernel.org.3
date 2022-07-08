Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 882A456B39F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 09:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237600AbiGHHb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 03:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237115AbiGHHb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 03:31:57 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B6B7B379
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 00:31:56 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VIij5CL_1657265513;
Received: from localhost(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0VIij5CL_1657265513)
          by smtp.aliyun-inc.com;
          Fri, 08 Jul 2022 15:31:53 +0800
From:   Xianting Tian <xianting.tian@linux.alibaba.com>
To:     palmer@dabbelt.com
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        guoren@kernel.org, Xianting Tian <xianting.tian@linux.alibaba.com>
Subject: [RESEND PATCH V5 0/2] Two fixups for 5.19-rcx
Date:   Fri,  8 Jul 2022 15:31:48 +0800
Message-Id: <20220708073150.352830-1-xianting.tian@linux.alibaba.com>
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

Hi Palmer,
The 2 patches are some obviously fixups, could you please have a look?
Recently, I finished the development of Crash-utility for RISCV64,
I will submit the patches soon.
We expect we can normally use Kdump & Crash for 5.19-rcx.
thanks.

Xianting Tian (2):
  RISC-V: Fixup fast call of crash_kexec()
  RISC-V: use __smp_processor_id() instead of smp_processor_id()

 arch/riscv/kernel/machine_kexec.c | 2 +-
 arch/riscv/kernel/traps.c         | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

-- 
2.17.1

