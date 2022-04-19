Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D699D507AD8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 22:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352355AbiDSUUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 16:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235759AbiDSUUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 16:20:07 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE9D741306
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 13:17:23 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id j17so9403352pfi.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 13:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=subject:date:message-id:mime-version:content-transfer-encoding:cc
         :from:to;
        bh=njBQHRt2JNELpmysy2Ho9Dr1cUDqEsm6PMq8c5+PjEU=;
        b=MDbXI5kWR2BDcqIfRaKmzVcQ5N5PNVSbwrb9I6aeAV6SspjEAEbqSRRAy6JK4bvEDv
         ygi3Zld5WhIBRpY/+GGzDJTxUNHvzc0OMQ71XmQQtjDXJYIDsqL9yPCkHANDoIMivXPa
         DSVQ5WGTSxzyoT3HX2EMFdw9q87xTi/TCJUk6EpXgX+KWRWBr34WTXWmwL9AtuspLX5C
         XefYbEP4mPGAlyxp7DaZQWhnU6MCt7JgpmxQrBxwkp2iBq1PAuMCDga0CXe5jVtXWVEO
         IIzN+p7j50ZMWAVXVKmhGrmXOBnKHEPzc7OPwwNttVWcRIpRYgPpn1qNsxMkL+YDz8Un
         tQnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:date:message-id:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=njBQHRt2JNELpmysy2Ho9Dr1cUDqEsm6PMq8c5+PjEU=;
        b=SxdMxOWZua0fj5oe7CAv6FUutpD0NY4CDAqw1vHZAwkdXGwTzgVqHlZ9DdImYWUAoC
         GGNnBkEAfu6txjE80wPVCYJ1crMRSHjFxxtpEqyfa9OXVwdse2nOjscUiqjOw6IqAuqj
         lbz3zaKVG11tXM7btE3x93S+FU/hd/UzaobyxnaAFJVDAE6I0MVIzzfiD26X5Ywxf7JB
         fH7n/4bEzzngAygfg1e12LuvCYfWiIK21rpAUtJtvBfH9yizLe6qf1h6/6frIKp5GsLQ
         AJw/sEqMYUgs1dx2zPP3ZmkGQt33hXXePhberIx9UzFYkGyIY3fD0becFZ3ygZBPnvly
         fweg==
X-Gm-Message-State: AOAM530SF4tpeLnNkqRmt//tZRcel3DUYOr8tahVcvNa+6ks7DY3uKX7
        tfEnehoMVAYV5eGo8xoCfWDfLyBOGJmufg==
X-Google-Smtp-Source: ABdhPJwc1cDd46DD18k94nqv3B1MaYAJuzolHAyuzWppQKf5G9zabmUr9J9UF4SppMe0nIj783Ymfw==
X-Received: by 2002:a05:6a00:4211:b0:506:5061:3e38 with SMTP id cd17-20020a056a00421100b0050650613e38mr19354994pfb.74.1650399443400;
        Tue, 19 Apr 2022 13:17:23 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id 204-20020a6302d5000000b00385f29b02b2sm17176543pgc.50.2022.04.19.13.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 13:17:23 -0700 (PDT)
Subject: [PATCH v1] RISC-V: Add braces around an empty if statement bodies
Date:   Tue, 19 Apr 2022 12:48:46 -0700
Message-Id: <20220419194846.18318-1-palmer@rivosinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        alexandre.ghiti@canonical.com, jszhang@kernel.org,
        wangkefeng.wang@huawei.com, mick@ics.forth.gr,
        vitaly.wool@konsulko.com, rppt@kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>,
        kernel test robot <lkp@intel.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     panqinglin2020@iscas.ac.cn
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmer@rivosinc.com>

This triggers -Wempty-body, which will cause the next statement (eventually
create_pmd_mapping) to be dropped.  Both of these were introduced by the same
commit.  This is safe for the reporting config (which is 32-bit), but IIUC
could result in breakages for 64-bit configs without 4/5 level paging like the
XIP configs.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 677b9eb8810e ("riscv: mm: Prepare pt_ops helper functions for sv57")
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
Might be better to define these to functions that are empty, but that's
slightly different than just fixing the commit/warning in question.
---
 arch/riscv/mm/init.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 9535bea8688c..637916857c4d 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -798,13 +798,15 @@ static void __init create_fdt_early_page_table(pgd_t *pgdir, uintptr_t dtb_pa)
 			   PGDIR_SIZE,
 			   IS_ENABLED(CONFIG_64BIT) ? PAGE_TABLE : PAGE_KERNEL);
 
-	if (pgtable_l5_enabled)
+	if (pgtable_l5_enabled) {
 		create_p4d_mapping(early_dtb_p4d, DTB_EARLY_BASE_VA,
 				   (uintptr_t)early_dtb_pud, P4D_SIZE, PAGE_TABLE);
+	}
 
-	if (pgtable_l4_enabled)
+	if (pgtable_l4_enabled) {
 		create_pud_mapping(early_dtb_pud, DTB_EARLY_BASE_VA,
 				   (uintptr_t)early_dtb_pmd, PUD_SIZE, PAGE_TABLE);
+	}
 
 	if (IS_ENABLED(CONFIG_64BIT)) {
 		create_pmd_mapping(early_dtb_pmd, DTB_EARLY_BASE_VA,
-- 
2.34.1

