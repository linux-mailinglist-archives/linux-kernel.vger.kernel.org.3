Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 402F855AE39
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 04:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233890AbiFZCVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 22:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232327AbiFZCVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 22:21:22 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1312140CF;
        Sat, 25 Jun 2022 19:21:21 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id a11-20020a17090acb8b00b001eca0041455so7790113pju.1;
        Sat, 25 Jun 2022 19:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UKuVgrfAGfBCGBeX0GMfO1FTTPGxEdMB1j0t79+AoRU=;
        b=mKPqYcHZZTA6wyYp+NwSh7M3tWPA4VSJBAumChpP5L/vxwaLDMbWPMZjPxU1/3Fqt/
         rDuiZ5U45NhY7lpyNfO2b9DvDWjBIn5sHBI6nZQrPAc+akbfAsieSkGVr/qp75fwp0av
         Ycr2WWmoK2PU5Ns7nMl/jqTQ1qoEyfx3fM2qRvysov3beilvPAoNvU1dsonKJ3wBZxLX
         e6EjUHXPxFyAFi9sZAVq7/lfzKCTntBR5uFSwf7hTril3zHtg6s5CIIPm7DF9jMxkhEI
         F84B2SnXIjzWPQusPdaD06HuHyC0wiWFhy/t1S5ul98Ctc8xV+q0TIVc/USlS+dK/5GL
         5nzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UKuVgrfAGfBCGBeX0GMfO1FTTPGxEdMB1j0t79+AoRU=;
        b=OjbNHYYtpdiKbhTKb1vbaDja9JbMiJuWrbkM/i+aUdeqhZD9KD5mcqGRnq4nWWiItW
         HC9HLEs7QnSCws/zDvrPgWVNH1F7Nunh+iqD5HJQs0jB2bzMzRKIJA6vgsgaC9j9rmsd
         4TFZUsHEkWcwMZjxXohvAVqsmOvEG9UVGc0hqa2bcKlPJYGGagmCL2CSC04KM4+Yinwq
         MDHOyG65uV5LzrzSGXq4UZwBn69+jQ7fLoAFqiZwxHXFzKer7JdXPWed1eNSlwxMPoHw
         FAxm3dpCVpu4/QA5qIj41AOd0HuQgexKKMAO1nPeevNqAdrmJwiwzec0N0VUEOjdZB78
         cQlQ==
X-Gm-Message-State: AJIora9JqlQ0Kusx0zOapkPu2dSn5xIi2E1VwSmatyOPDihN3tQAmXth
        G3gyQC4u8O0zGiU39HWMN+FdGon/QSv8+Gmh
X-Google-Smtp-Source: AGRyM1vqGyZPVrlI2a75lkP5iJWxI0Y6J2NJn8NhCkU/ywoeiQJFLmXXOEnWy+SwBfchoXbQIBlh1g==
X-Received: by 2002:a17:903:25ce:b0:16a:2684:8865 with SMTP id jc14-20020a17090325ce00b0016a26848865mr6984848plb.42.1656210081122;
        Sat, 25 Jun 2022 19:21:21 -0700 (PDT)
Received: from localhost.localdomain ([122.167.211.160])
        by smtp.gmail.com with ESMTPSA id 84-20020a621757000000b00524e8e48156sm4422504pfx.142.2022.06.25.19.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jun 2022 19:21:20 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     linux-ia64@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "Souptick Joarder (HPE)" <jrdr.linux@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] ia64: old_rr4 added under CONFIG_HUGETLB_PAGE
Date:   Sun, 26 Jun 2022 07:51:14 +0530
Message-Id: <20220626022114.4020-1-jrdr.linux@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Souptick Joarder (HPE)" <jrdr.linux@gmail.com>

kernel test robot throws below warning ->

arch/ia64/include/asm/mmu_context.h: In function 'reload_context':
   arch/ia64/include/asm/mmu_context.h:127:48: warning: variable
'old_rr4' set but not used [-Wunused-but-set-variable]
     127 |         unsigned long rr0, rr1, rr2, rr3, rr4, old_rr4;

Added it under CONFIG_HUGETLB_PAGE

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Souptick Joarder (HPE) <jrdr.linux@gmail.com>
---
 arch/ia64/include/asm/mmu_context.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/ia64/include/asm/mmu_context.h b/arch/ia64/include/asm/mmu_context.h
index 87a0d5bc11ef..06257e355d00 100644
--- a/arch/ia64/include/asm/mmu_context.h
+++ b/arch/ia64/include/asm/mmu_context.h
@@ -124,9 +124,12 @@ reload_context (nv_mm_context_t context)
 {
 	unsigned long rid;
 	unsigned long rid_incr = 0;
-	unsigned long rr0, rr1, rr2, rr3, rr4, old_rr4;
+	unsigned long rr0, rr1, rr2, rr3, rr4;
 
+#ifdef CONFIG_HUGETLB_PAGE
+	unsigned long old_rr4;
 	old_rr4 = ia64_get_rr(RGN_BASE(RGN_HPAGE));
+#endif
 	rid = context << 3;	/* make space for encoding the region number */
 	rid_incr = 1 << 8;
 
-- 
2.25.1

