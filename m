Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4733C4EA987
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 10:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234130AbiC2Iq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 04:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234084AbiC2IqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 04:46:24 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7EC4168089;
        Tue, 29 Mar 2022 01:44:41 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id k14so14267089pga.0;
        Tue, 29 Mar 2022 01:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bl9cvCOl2JsstIJeBTKBLK/6QRxHIhdaBkcmq7o09pQ=;
        b=iYpODQl0mjzOo7uUwTlz/c0sB/UJyUUKf0ObUBob9thwUmNV8OhzmJtBk15vBcG2nJ
         crtxxKWXrMYHXEdeJUxJaqbFDd7aTawyF4jSWc+Kpf3tX2SmZ+zXtOj4vpT9XznKRsU/
         y4MndpIGP4FJat1V2YR2Qu1MQgEo530Ppfd7X/aw09aQG0O+pBpI9nYr/wzQ98M2gd46
         Pw5U6CEAT9+v36zc6SxkS0aB92U/+1nS2WOjsUBiSVzZAgXsvFbmD2XEOqORHGrKq516
         00b5btUDJE4X7P3te+l+MUkGiXtEt52CqlR+skuvAPPH0Up62qsxXuK8SPITPXygXvxj
         deBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bl9cvCOl2JsstIJeBTKBLK/6QRxHIhdaBkcmq7o09pQ=;
        b=G1y3Jh99IGJ9mgWMFOR459zzVlCHB4nqUQjG7HHHw/5P3cjnfH0oczfZ+2wmdIWE2I
         3oZQytcX8ouWBDlfNbTtQFbb2digTojELbTTOmr2t3A9g4a4ZWQVgHzhI1UHEYeGPs+n
         y45Qwu+SU/lyw8oQx2o1+tsku1v+X/h1R6gvzHR+Vs6YV83DwSSoKdr7qsLCElwOK/Oe
         7tpjoHVFtt9jKX974pT/c00kDeIh473Yv8j4mRe3qKNgYireFq8C+FrUoxpVj9y58plD
         zP1nfWnCxhpw1XPqy/VinZ1U3W+vJRGTHI9T/8f/ogPqADFoXDGRY9e3ExnDK/O7pIqX
         QmQw==
X-Gm-Message-State: AOAM530DJ/t+aaG+43T32VB9D+/1EYmssbHbaWv/bxPKLM0ZL2E2R2kS
        IaRxuhulVcvz5p/1AViCA8L2ft9wkBswHeSG
X-Google-Smtp-Source: ABdhPJy4YxKPspAhcyCCA4hkOFGK0e0KzBesKL2CsRvCVyLxQB+WAQCCxCBEvJ4sul5l4GY6/KX7ZA==
X-Received: by 2002:a63:18f:0:b0:37c:4671:a2ce with SMTP id 137-20020a63018f000000b0037c4671a2cemr1271439pgb.429.1648543480977;
        Tue, 29 Mar 2022 01:44:40 -0700 (PDT)
Received: from ubuntu.mate (subs03-180-214-233-75.three.co.id. [180.214.233.75])
        by smtp.gmail.com with ESMTPSA id q10-20020a056a00088a00b004f7ceff389esm20320601pfj.152.2022.03.29.01.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 01:44:39 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     linux-doc@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul@pwsan.com>,
        Atish Patra <atish.patra@wdc.com>,
        Atish Patra <atishp@atishpatra.org>,
        Atish Patra <atishp@rivosinc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        linux-riscv@lists.infradead.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] Documentation: riscv: remove non-existent document from table of contents
Date:   Tue, 29 Mar 2022 15:44:28 +0700
Message-Id: <20220329084428.376003-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.35.1
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

Remove reference to non-existent pmu.rst from table of contents tree
in Documentation/riscv/index.rst.

Fixes: 23b1f18326ec ("Documentation: riscv: Remove the old
documentation")
Link: https://lore.kernel.org/linux-next/20220329133412.591d6882@canb.auug.org.au/
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Atish Patra <atish.patra@wdc.com>
Cc: Atish Patra <atishp@atishpatra.org>
Cc: Atish Patra <atishp@rivosinc.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: linux-riscv@lists.infradead.org
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/riscv/index.rst | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/riscv/index.rst b/Documentation/riscv/index.rst
index ea915c1960488a..e23b876ad6ebb6 100644
--- a/Documentation/riscv/index.rst
+++ b/Documentation/riscv/index.rst
@@ -7,7 +7,6 @@ RISC-V architecture
 
     boot-image-header
     vm-layout
-    pmu
     patch-acceptance
 
     features

base-commit: 1930a6e739c4b4a654a69164dbe39e554d228915
-- 
An old man doll... just what I always wanted! - Clara

