Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC3948F36E
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 01:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbiAOARs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 19:17:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbiAOARr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 19:17:47 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52EE0C061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 16:17:47 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 127-20020a250f85000000b00611ab6484abso18223675ybp.23
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 16:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:cc;
        bh=TEFOv4YS0Pv2L4ioEdK41WD5FaS6ABhUfwsLXh99f8U=;
        b=sN3IkgdFVVNugkPBMVaX1NQErDxMw2JjTs7fEo2IZHsKKUM7LTSV9HHpFS166HaH3W
         1smmvnBfC2u30IE5BLIk409N1YZOuqDC+aTiCGUwbpoHdcN4OqjXMxCsDTaFeS5P2VRq
         SmBZHpg8uW1ouZ/j7p3S+qI/pSM5yUosczI2Nj3gMldT1HQfoC/iWUsehWtmsGMiln9/
         RhEvTEGlrfQRvTK/FqSw7xhLyNl7Aq9RiFRjCvHxZr5sv0MlpTkooxxRhlsXEQfp/npd
         ki3xenMHB3KDK07iMrpR5qm5ThgDpUmuK8M6KClCzYuOt6imy1PMm2w3D2hS04k8KW0L
         NlbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:cc;
        bh=TEFOv4YS0Pv2L4ioEdK41WD5FaS6ABhUfwsLXh99f8U=;
        b=0Us+N09ndPN7VNW5JahGKAWiZrx8oM7hxjUXR8hf0o0lrGz3i7sZzee+49v0M7U/SQ
         Jyw8DS6/II35Fyg7d0IISeGsXdk8xJwvkR53wp3WtnNIyEseZgCrTii2JgkSPJg70nkX
         lNbaGd8pqpSH7qhYmEkx6GNUQjDOdBoSB7dtiK0t6a1JqLrjVqouqG605aaxx419kIiq
         jllkawco9/145QevBj+uvzHZXo5rn5545KW2kO6HjObYaPQ/DP6ez6mi7RL9CeYp4jU8
         Qqcbpp3f19KYfBp2Uma/RMgj521v6wl5ofH5cLnwtX+G05ghWu8BzGRK2h2v+8h2t+fz
         23jw==
X-Gm-Message-State: AOAM532LBf+FyIgGNxjMrGK531qI2tFu5Af50qogWXP1StmYiKCoBgNo
        6QicdaCAj5KS4YUKRVNlBcdHik58CA==
X-Google-Smtp-Source: ABdhPJy8BbTFgHr7s6eDuLFYTIX87Wx1uQElAp//NDt5ogwcOGsWsYZHV8KXA3KKsn6Yu2DSgNTdK49S4w==
X-Received: from nhuck.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:39cc])
 (user=nhuck job=sendgmr) by 2002:a5b:3c2:: with SMTP id t2mr16685965ybp.747.1642205866524;
 Fri, 14 Jan 2022 16:17:46 -0800 (PST)
Date:   Fri, 14 Jan 2022 18:17:19 -0600
Message-Id: <20220115001719.1040897-1-nhuck@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
Subject: [PATCH] crypto: x86 - Convert to SPDX identifier
From:   Nathan Huckleberry <nhuck@google.com>
Cc:     Nathan Huckleberry <nhuck@google.com>,
        James Guilford <james.guilford@intel.com>,
        Sean Gulley <sean.m.gulley@intel.com>,
        Chandramouli Narayanan <mouli@linux.intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use SPDX-License-Identifier instead of a verbose license text and
update external link.

Cc: James Guilford <james.guilford@intel.com>
Cc: Sean Gulley <sean.m.gulley@intel.com>
Cc: Chandramouli Narayanan <mouli@linux.intel.com>
Signed-off-by: Nathan Huckleberry <nhuck@google.com>
---
 arch/x86/crypto/aes_ctrby8_avx-x86_64.S | 63 ++++---------------------
 1 file changed, 10 insertions(+), 53 deletions(-)

diff --git a/arch/x86/crypto/aes_ctrby8_avx-x86_64.S b/arch/x86/crypto/aes_ctrby8_avx-x86_64.S
index c799838242a6..43852ba6e19c 100644
--- a/arch/x86/crypto/aes_ctrby8_avx-x86_64.S
+++ b/arch/x86/crypto/aes_ctrby8_avx-x86_64.S
@@ -1,65 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-3-Clause */
 /*
- *	Implement AES CTR mode by8 optimization with AVX instructions. (x86_64)
- *
- * This is AES128/192/256 CTR mode optimization implementation. It requires
- * the support of Intel(R) AESNI and AVX instructions.
- *
- * This work was inspired by the AES CTR mode optimization published
- * in Intel Optimized IPSEC Cryptograhpic library.
- * Additional information on it can be found at:
- *    http://downloadcenter.intel.com/Detail_Desc.aspx?agr=Y&DwnldID=22972
- *
- * This file is provided under a dual BSD/GPLv2 license.  When using or
- * redistributing this file, you may do so under either license.
- *
- * GPL LICENSE SUMMARY
+ * AES CTR mode by8 optimization with AVX instructions. (x86_64)
  *
  * Copyright(c) 2014 Intel Corporation.
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
  * Contact Information:
  * James Guilford <james.guilford@intel.com>
  * Sean Gulley <sean.m.gulley@intel.com>
  * Chandramouli Narayanan <mouli@linux.intel.com>
+ */
+/*
+ * This is AES128/192/256 CTR mode optimization implementation. It requires
+ * the support of Intel(R) AESNI and AVX instructions.
  *
- * BSD LICENSE
- *
- * Copyright(c) 2014 Intel Corporation.
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions
- * are met:
- *
- * Redistributions of source code must retain the above copyright
- * notice, this list of conditions and the following disclaimer.
- * Redistributions in binary form must reproduce the above copyright
- * notice, this list of conditions and the following disclaimer in
- * the documentation and/or other materials provided with the
- * distribution.
- * Neither the name of Intel Corporation nor the names of its
- * contributors may be used to endorse or promote products derived
- * from this software without specific prior written permission.
- *
- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
- * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
- * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
- * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
- * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
- * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
- * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
- * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
- * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
- * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
+ * This work was inspired by the AES CTR mode optimization published
+ * in Intel Optimized IPSEC Cryptographic library.
+ * Additional information on it can be found at:
+ *    https://github.com/intel/intel-ipsec-mb
  */
 
 #include <linux/linkage.h>
-- 
2.34.1.703.g22d0c6ccf7-goog

