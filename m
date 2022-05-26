Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8655D534DDB
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 13:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233076AbiEZLJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 07:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235938AbiEZLJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 07:09:38 -0400
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24930CFE00;
        Thu, 26 May 2022 04:09:38 -0700 (PDT)
Received: by mail-pj1-f65.google.com with SMTP id cv10so1447235pjb.4;
        Thu, 26 May 2022 04:09:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pLaR1c4A1+kJhjeDUMdwZ1PPmHOVlp2foYVmGTfi61k=;
        b=E7/+2KaB2E9axQIdKOWM6DU1y2jqHr6W1aie2NKa7vz6FuRj2WUSrEQP25cy5PN/D6
         6iAa/H0MWBXxSa5PvsB62ZifqY0pgEi76cwOwwJg7wafIJEWg02sbIFGwn+fA8R7XinR
         8vlXivTRcqUbSiVkmHbovT6DF33Kf32yjdWL4IoIhnnt96aPGnG0mYQnE9nmEElfy1cZ
         GeYf7r9EVEN1CQGIxeZh0pZX1wdaD37vARoVTIYvzz3Jjau/IlZqym+ljmkiagKXfax2
         lHBOGAoIt2IQKEfRyoWdxSN45feo846dWHKRlJaogR7oBc99WQOVr9fSllTbzLCVN87X
         PbOQ==
X-Gm-Message-State: AOAM531dIDrXznPRMzQNdKBvF+m1vNZZUPJQEhu1zzIcfFjcIgWxjdmf
        Qh/C2gnKR1w8/l97sbD3iw==
X-Google-Smtp-Source: ABdhPJxgO1yLM5Cvk1JePhQoExVJ/BzJCRPWCuzhAbUppMHYHIb77TC6N4JxwayD/qeX0Mz4me2Ahw==
X-Received: by 2002:a17:902:ea06:b0:163:584c:8ec with SMTP id s6-20020a170902ea0600b00163584c08ecmr7696743plg.103.1653563377651;
        Thu, 26 May 2022 04:09:37 -0700 (PDT)
Received: from localhost.localdomain (ns1003916.ip-51-81-154.us. [51.81.154.37])
        by smtp.gmail.com with ESMTPSA id ct10-20020a056a000f8a00b005182d505389sm1132107pfb.72.2022.05.26.04.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 04:09:37 -0700 (PDT)
From:   sunliming <sunliming@kylinos.cn>
To:     mingo@kernel.org, linux-tip-commits@vger.kernel.org,
        dave.hansen@linux.intel.com, rostedt@goodmis.org
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, sunliming@kylinos.cn,
        kelulanainsley@gmail.com
Subject: [PATCH V2] x86/idt: traceponit.c: fix comment for irq vector tracepoints
Date:   Thu, 26 May 2022 19:08:31 +0800
Message-Id: <20220526110831.175743-1-sunliming@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit:

  4b9a8dca0e58 ("x86/idt: Remove the tracing IDT completely")

removed the 'tracing IDT' from arch/x86/kernel/tracepoint.c,
but left related comment. So that the comment become anachronistic.
Just remove the comment.

Signed-off-by: sunliming <sunliming@kylinos.cn>
---
 arch/x86/kernel/tracepoint.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/kernel/tracepoint.c b/arch/x86/kernel/tracepoint.c
index fcfc077afe2d..065191022035 100644
--- a/arch/x86/kernel/tracepoint.c
+++ b/arch/x86/kernel/tracepoint.c
@@ -1,9 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Code for supporting irq vector tracepoints.
- *
  * Copyright (C) 2013 Seiji Aguchi <seiji.aguchi@hds.com>
- *
  */
 #include <linux/jump_label.h>
 #include <linux/atomic.h>
-- 
2.25.1

