Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2D1A58F9D2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 11:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234933AbiHKJPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 05:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234807AbiHKJPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 05:15:22 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F5E12D03;
        Thu, 11 Aug 2022 02:15:21 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id z19so16465093plb.1;
        Thu, 11 Aug 2022 02:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc;
        bh=xeV5w55lD/8l2ULyl9xM1Q0IXxSqEdlHZRDGCNK8N/8=;
        b=B8kU3zg+qjo7oINU7mqjajTQGFBjprXSK+GPUcdFMCENAUDG91GvSBafZHp1uIWjwm
         R2G0PG0CotUvBOsTZpN1IwvOXq3a30tL1UeM5hQCNMozI1k6NN9YuI0Ym4t8QuWper2p
         0mjhaYOWE9Nrtr0IrXUkWy6G6mIIM5TSu/fFZCDTIhHHcyoI46waqM/E9Iq4ChVmxTQE
         HSMmowrgZmQx5jst63sgn5NXR7l2aclafo267QkJ9sy6ONY9XjcPAaC+oLJrbohQcdAV
         Vwua66FjsbjZBPX4oUDIhtQR6JtlWrFcAt7L9DeN0utSdWlLf6Ai/+Sz+dzWroPKTWt2
         ytjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc;
        bh=xeV5w55lD/8l2ULyl9xM1Q0IXxSqEdlHZRDGCNK8N/8=;
        b=jixc9/1kbga0J9pmqjBzUtutxcSDu5G3YRkh0iBU7jmtNqxxv4rmoNOFM3PJa8eAgY
         Ay0PzGt5RkWyFhCd4GUOU184iLUfSJxicuW5Q3M1dIga0W6qRgpXu3z2OT54fnRN52/b
         HuDFZK/7917xnUTguFdbGswvtT1vadpFIksnRPAk8C25JzUbu1HT71Sxkg+XIbmCBnVX
         9ZHmCj4xWTe/FwW24TDznE4P7g4vGzEwbD6WwaSOhctkMi4JVUPO/ANaedsjUtxfIM/V
         Vn/FFeGJj1h76qH0N62vgAZdZVlpSWFsx6F/Xwm6WbkBJhvTjwcsiNdpdMZS/6j2QpNE
         0RRg==
X-Gm-Message-State: ACgBeo1+ApufpMCErZ9+Fj/ya25xEv1g1M8gvvfs1bMS+gWlo0POZeA3
        504pNYK5KXVkrBMoJAZtQqXxS7BompU=
X-Google-Smtp-Source: AA6agR5cwZSlSuKYKBffCnXyI0U9C3kZTA8MsweUWShiT8os0yhMGipOBnk2aoU9OoOt/Lruq2OB1w==
X-Received: by 2002:a17:902:7d83:b0:170:9353:f299 with SMTP id a3-20020a1709027d8300b001709353f299mr21364330plm.41.1660209320578;
        Thu, 11 Aug 2022 02:15:20 -0700 (PDT)
Received: from localhost.localdomain ([180.177.3.114])
        by smtp.gmail.com with ESMTPSA id nb15-20020a17090b35cf00b001f327021900sm3107037pjb.1.2022.08.11.02.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 02:15:20 -0700 (PDT)
From:   Eric Lin <dslin1010@gmail.com>
To:     maz@kernel.org, corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: irqdomain: Fix typo of "at least once"
Date:   Thu, 11 Aug 2022 17:15:16 +0800
Message-Id: <20220811091516.2107908-1-dslin1010@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Eric Lin <dslin1010@gmail.com>
---
 Documentation/core-api/irq/irq-domain.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/core-api/irq/irq-domain.rst b/Documentation/core-api/irq/irq-domain.rst
index d30b4d0a9769..f88a6ee67a35 100644
--- a/Documentation/core-api/irq/irq-domain.rst
+++ b/Documentation/core-api/irq/irq-domain.rst
@@ -71,7 +71,7 @@ variety of methods:
 Note that irq domain lookups must happen in contexts that are
 compatible with a RCU read-side critical section.
 
-The irq_create_mapping() function must be called *atleast once*
+The irq_create_mapping() function must be called *at least once*
 before any call to irq_find_mapping(), lest the descriptor will not
 be allocated.
 
-- 
2.25.1

