Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63968563621
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 16:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233057AbiGAOty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 10:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232543AbiGAOtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 10:49:53 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604652E6
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 07:49:52 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id a11-20020a17090acb8b00b001eca0041455so5193270pju.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 07:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3vqMPQtU37IxiTme7xHTFWRTRc8mWdx5vr6fec9+J5c=;
        b=bNd6Nz2tuQ8R/dyalSpVz0eAwvX1ZuyBJDD5Pz/SKSg8M6UK04QQwzG2FZO5gs4P/R
         pI3JSFMDvapCYRRi/CxUyTP6RUrNX2XYbfL355Wn6qynoMq4cjMSFaRw8ytF1BCvedoP
         LH7x6YykB+vW27KJpBtO7+0e4435+5bohAJiwik9rsbHlMsUfJ24mlqYZpfSbbLXWKns
         0bLJwuXfg60PyN+lqlO3utXiJACyr2urFQ1MDz+J/vWrd2KLVzoRO3P/InGu6CwikJPJ
         jWV3Xr6doQXDEyx4hrXmLZgW6Rz4mNGcbAhqUkxFRqlhh7F5QbCJa03exc6Pwhrj2PPg
         SiOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=3vqMPQtU37IxiTme7xHTFWRTRc8mWdx5vr6fec9+J5c=;
        b=tNnur4xTPe1oWGicEM6SKvL+vlfykzTymvbA7xKFBJSnQ4U4ni+Qn5lA/fTlv8zdgS
         O5XuIycWHXwI6+p06MFveB6mZ6DzMFFCkJteWJHrrW4aQmhaUey5J2z4dG1DWJhdsWfh
         fwUVOwicnjG6gel+miVgS/Oaa3tJvP8GVX2MHJBrXtJbI9UjtjrT9wrTEftPh9Trk0h6
         rKc6bQ2/SwBGSkM59fJAYIv5b88aD4azR0CJ/PaH/oq7gCRBiq3f+9eNSR/exAPF1A70
         GR9NGbPTOfNYi3S+nE9C5G/83CQJWDEIB+K76EheO0tW9+24c+h+9Wr7XcTUU/4uak3l
         LHEg==
X-Gm-Message-State: AJIora95PhKgq8fQtkujBKQAa5frXibe+7KgisYImqvo4LKbkTk0oJE/
        ETrmi9d/63hYOpGaDoOMNXI=
X-Google-Smtp-Source: AGRyM1s3a/8qDkZ1jLM98EE1MomStP2B4y1Fufcw9fKblb53FNAn7/gurQKxKjYhxHDYg3omITWF0w==
X-Received: by 2002:a17:90b:3d86:b0:1ee:ec85:ec07 with SMTP id pq6-20020a17090b3d8600b001eeec85ec07mr19086770pjb.81.1656686991826;
        Fri, 01 Jul 2022 07:49:51 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x15-20020a170902ec8f00b001663cf001besm729235plg.174.2022.07.01.07.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 07:49:51 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     WANG Xuerui <kernel@xen0n.name>, Guo Ren <guoren@kernel.org>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 1/3] LoongArch: page.h: Add missing include file
Date:   Fri,  1 Jul 2022 07:49:44 -0700
Message-Id: <20220701144946.2528972-2-linux@roeck-us.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220701144946.2528972-1-linux@roeck-us.net>
References: <20220701144946.2528972-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building loongarch:tinyconfig fails with the following error.

./arch/loongarch/include/asm/page.h: In function 'pfn_valid':
./arch/loongarch/include/asm/page.h:42:32: error: 'PHYS_OFFSET' undeclared

Add the missing include file.

Fixes: 09cfefb7fa70 ("LoongArch: Add memory management")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/loongarch/include/asm/page.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/loongarch/include/asm/page.h b/arch/loongarch/include/asm/page.h
index 3dba4986f6c9..8cee37f832aa 100644
--- a/arch/loongarch/include/asm/page.h
+++ b/arch/loongarch/include/asm/page.h
@@ -5,6 +5,7 @@
 #ifndef _ASM_PAGE_H
 #define _ASM_PAGE_H
 
+#include <asm/addrspace.h>
 #include <linux/const.h>
 
 /*
-- 
2.35.1

