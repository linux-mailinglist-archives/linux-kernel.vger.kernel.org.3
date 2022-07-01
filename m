Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AEAF56331D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 14:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235229AbiGAMFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 08:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiGAMFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 08:05:53 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01C97D1FC
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 05:05:52 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R961e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VI2JbZl_1656677148;
Received: from localhost(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0VI2JbZl_1656677148)
          by smtp.aliyun-inc.com;
          Fri, 01 Jul 2022 20:05:49 +0800
From:   Xianting Tian <xianting.tian@linux.alibaba.com>
To:     palmer@dabbelt.com
Cc:     guoren@kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v5 0/3] RISC-V: three fixup and cleanups
Date:   Fri,  1 Jul 2022 20:05:45 +0800
Message-Id: <20220701120548.228261-1-xianting.tian@linux.alibaba.com>
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
These 3 patches are some obviously fixup and cleanups, please have a look, thanks.

Xianting Tian (2):
    RISC-V: use __smp_processor_id() instead of smp_processor_id()    
    RISC-V: Fixup fast call of crash_kexec()

Guo Ren (1):
    riscv: atomic: Clean up unnecessary acquire and release definitions

