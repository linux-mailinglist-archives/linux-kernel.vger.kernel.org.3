Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56ECC531F65
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 01:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbiEWXwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 19:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbiEWXve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 19:51:34 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E1654F9B
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 16:51:33 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id l20-20020a17090a409400b001dd2a9d555bso723999pjg.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 16:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Dq3AsKzhmTYW0tA0YoLO/eJ29e5Y/pkFqc/1LVLFraE=;
        b=3C34eaCyigYOkdD65FlDbvkYzpM9trPLaEqMfj0j3D3ooPHmSCpbNrjWDlt/rGZm1u
         me5aaFSKBtTCB1vAW9OUmNaQ3xcnFROdaqnRSP4/FuDPG3ZDYC4bqJZpuhVp4RTOicQQ
         TeMyn2DB8VAG8TMBlcQFLXessN/io7Q5tOx0yrs/Q4pu14gUzvmzZlchgqVUfulCulrp
         mUdykRRbrFYdzv3+ncM/0LtSwOyPkxVsMfVT9W8nvJvlsY4xpVk/kUU0pSeSr690/zgw
         A3b2zlz25MHAmaNA9FNBdsZEF1ueR1FiRNY7b1DBSuwioR9GLKBpw40yzjzSqQWyXMyZ
         tnzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dq3AsKzhmTYW0tA0YoLO/eJ29e5Y/pkFqc/1LVLFraE=;
        b=jt8muedzGlFzMQaz0qFdZmGHuGbD84d1cKDrbd1Z/W4wJhUAP24y6orjaRLIbIVxkk
         7AzQWwSX1IJxvAyHHO5ZxlsuIJlNYns/86KUibrbvNFobgWXSjCn2P9LtuulFSEjk7tX
         XEJxfI3VO6eTg30PLODKXuXqZpNbTEE97OmQ0D/CnUUra154EiePWREkvTGW4ryfSD2o
         4AeZteLKDlYm849g2va+shtr+xqMn/PAUytmEOZLV1Xp9vmKhojZWI/G/hkmjLcJygXx
         JzQMfNLnTpb8tFup0cksSgoryPB0gSjBKSN+b76lycnjxGSIYfPhnLdb6i9mycPAeXa3
         U9nA==
X-Gm-Message-State: AOAM533wLYxrzuUfRfqvarO+2KMVDTamd94wAOZjU8qsrG+3pHEBkTn0
        Y1Hy9pQ0sGRLPT86gkEuPL3hIMJNKi45dg==
X-Google-Smtp-Source: ABdhPJwTvA0wBvRIRvoC+12HUAR4TZ1YHMbulwqAvB1SNKR97lwLm1GVa80DCvJGG1WHbxXlA04Ocg==
X-Received: by 2002:a17:90b:380f:b0:1e0:aa6:9e24 with SMTP id mq15-20020a17090b380f00b001e00aa69e24mr1511239pjb.232.1653349892632;
        Mon, 23 May 2022 16:51:32 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id pl15-20020a17090b268f00b001df4b919937sm257084pjb.16.2022.05.23.16.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 16:51:31 -0700 (PDT)
From:   Atish Patra <atishp@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Bin Meng <bmeng.cn@gmail.com>,
        Alistair Francis <alistair.francis@wdc.com>,
        Atish Patra <atishp@rivosinc.com>,
        Bin Meng <bin.meng@windriver.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, qemu-devel@nongnu.org,
        qemu-riscv@nongnu.org
Subject: [PATCH v9 05/12] target/riscv: Implement mcountinhibit CSR
Date:   Mon, 23 May 2022 16:50:50 -0700
Message-Id: <20220523235057.123882-6-atishp@rivosinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220523235057.123882-1-atishp@rivosinc.com>
References: <20220523235057.123882-1-atishp@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Atish Patra <atish.patra@wdc.com>

As per the privilege specification v1.11, mcountinhibit allows to start/stop
a pmu counter selectively.

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Atish Patra <atish.patra@wdc.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 target/riscv/cpu.h      |  2 ++
 target/riscv/cpu_bits.h |  4 ++++
 target/riscv/csr.c      | 25 +++++++++++++++++++++++++
 target/riscv/machine.c  |  1 +
 4 files changed, 32 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 7cbcd8d62fc1..45ac0f2d2614 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -269,6 +269,8 @@ struct CPUArchState {
     target_ulong scounteren;
     target_ulong mcounteren;
 
+    target_ulong mcountinhibit;
+
     target_ulong sscratch;
     target_ulong mscratch;
 
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 4d04b20d064e..b3f7fa713000 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -367,6 +367,10 @@
 #define CSR_MHPMCOUNTER29   0xb1d
 #define CSR_MHPMCOUNTER30   0xb1e
 #define CSR_MHPMCOUNTER31   0xb1f
+
+/* Machine counter-inhibit register */
+#define CSR_MCOUNTINHIBIT   0x320
+
 #define CSR_MHPMEVENT3      0x323
 #define CSR_MHPMEVENT4      0x324
 #define CSR_MHPMEVENT5      0x325
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 7e14f7685fb9..ea1cde68610c 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -1475,6 +1475,28 @@ static RISCVException write_mtvec(CPURISCVState *env, int csrno,
     return RISCV_EXCP_NONE;
 }
 
+static RISCVException read_mcountinhibit(CPURISCVState *env, int csrno,
+                                         target_ulong *val)
+{
+    if (env->priv_ver < PRIV_VERSION_1_11_0) {
+        return RISCV_EXCP_ILLEGAL_INST;
+    }
+
+    *val = env->mcountinhibit;
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException write_mcountinhibit(CPURISCVState *env, int csrno,
+                                          target_ulong val)
+{
+    if (env->priv_ver < PRIV_VERSION_1_11_0) {
+        return RISCV_EXCP_ILLEGAL_INST;
+    }
+
+    env->mcountinhibit = val;
+    return RISCV_EXCP_NONE;
+}
+
 static RISCVException read_mcounteren(CPURISCVState *env, int csrno,
                                       target_ulong *val)
 {
@@ -3741,6 +3763,9 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     [CSR_MHPMCOUNTER30]  = { "mhpmcounter30",  mctr,   read_zero },
     [CSR_MHPMCOUNTER31]  = { "mhpmcounter31",  mctr,   read_zero },
 
+    [CSR_MCOUNTINHIBIT]  = { "mcountinhibit",   any,    read_mcountinhibit,
+                                                       write_mcountinhibit },
+
     [CSR_MHPMEVENT3]     = { "mhpmevent3",     any,    read_zero },
     [CSR_MHPMEVENT4]     = { "mhpmevent4",     any,    read_zero },
     [CSR_MHPMEVENT5]     = { "mhpmevent5",     any,    read_zero },
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 2a437b29a1ce..87cd55bfd3a7 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -330,6 +330,7 @@ const VMStateDescription vmstate_riscv_cpu = {
         VMSTATE_UINTTL(env.siselect, RISCVCPU),
         VMSTATE_UINTTL(env.scounteren, RISCVCPU),
         VMSTATE_UINTTL(env.mcounteren, RISCVCPU),
+        VMSTATE_UINTTL(env.mcountinhibit, RISCVCPU),
         VMSTATE_UINTTL(env.sscratch, RISCVCPU),
         VMSTATE_UINTTL(env.mscratch, RISCVCPU),
         VMSTATE_UINT64(env.mfromhost, RISCVCPU),
-- 
2.25.1

