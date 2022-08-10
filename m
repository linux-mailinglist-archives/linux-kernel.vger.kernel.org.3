Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9E358F04C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 18:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbiHJQXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 12:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231557AbiHJQXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 12:23:34 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDDA075FFA
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 09:23:33 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id w11-20020a17090a380b00b001f73f75a1feso2685889pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 09:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=l8jhnzzqeUT5rXTZfmZY4lz5ekShp+fFejfQhPINonU=;
        b=VhANZ/q4aqvEs0EeI/8SuOVCaH8vxi28tvShKjDV/ju2ZX1OV7fEpSOLKwmr24AOil
         nCzLc2WEEpb+uhU66hB5q4Xo6kodhi/kjxdnv9tObLw/YWf8nELjzcx86Fy/6imXbO1L
         eAAF6VKmrWkvCTICh9BPkrnWubsegUWjHMlYtJ+f87fGI5I0a6anSI1Y3iehWDcNP8A+
         WuUmZPdEcYaoAetjaz+MRizyIET0lFomI+Yc6KTbTbcvcaL7dyx2AJkejFIePXtusjw+
         mGF1IDBzXzx8v7ZweCFVMIJSjukqeKmqhzmw2Yx3QAxYz4jtjG2Kz+1YLFaVDmKaxmFG
         /Deg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=l8jhnzzqeUT5rXTZfmZY4lz5ekShp+fFejfQhPINonU=;
        b=CwecSD9gyUrM1yMyuVUDhk8NESRCEcS8S0n9nb9Tn3VuGHLT3Ptfs69XgQcgJh9M45
         3Ur9XRFptt7GS9YjCErLV7X8upRrxFxhFDNEvZB65gAHHq8Q5DV0sYNnhT1JfdY9A7ms
         QYOnUkSIqFz1sLji8n+frlGTpMwN/xy13yR0REjCLxEb0YK9nRl2cABBoX+ze18wmryz
         Eo/DrN+asvvC3k05kNbnQbLNMAF2ThgmS/YhzsbqkxxGRs5WkL3mdtNhebz5g68+KFsO
         GEVs2dENMrFiZl8Mcr1O69B7/RW5t6wqctsOqWiFM2TPotr21sWWjhfdIrPUu+ZtsOzF
         91aQ==
X-Gm-Message-State: ACgBeo0iBDm8RSmYUbWptA0xZ3shnuLozEtn1e/UlaU+5OtIcXgm31Om
        lMe+R+9DhU3D5idnr8+iYPXciwxRGN26YBPBDXqrNQ==
X-Google-Smtp-Source: AA6agR4OvhdIkxW4LvoYb4FzC7Lsm5mQfR6T+5vFXIuNHryu6LWpDn/2oTNhAq1Rm5tFAzkNDd87dg==
X-Received: by 2002:a17:902:7c01:b0:16f:9649:be73 with SMTP id x1-20020a1709027c0100b0016f9649be73mr23601802pll.70.1660148613445;
        Wed, 10 Aug 2022 09:23:33 -0700 (PDT)
Received: from localhost.localdomain ([223.79.192.142])
        by smtp.gmail.com with ESMTPSA id u13-20020a170902e80d00b0015e8d4eb1f7sm13307539plg.65.2022.08.10.09.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 09:23:32 -0700 (PDT)
From:   John Sanpe <sanpeqf@gmail.com>
To:     philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
        christoph.boehmwalder@linbit.com
Cc:     drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        John Sanpe <sanpeqf@gmail.com>
Subject: [PATCH] lib/ubsan: add missing line feed of alignment-assumption.
Date:   Thu, 11 Aug 2022 00:23:01 +0800
Message-Id: <20220810162301.201540-1-sanpeqf@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added three missing '\n' to pr_err format.

Signed-off-by: John Sanpe <sanpeqf@gmail.com>
---
 lib/ubsan.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/ubsan.c b/lib/ubsan.c
index 36bd75e33426..705250ba88bf 100644
--- a/lib/ubsan.c
+++ b/lib/ubsan.c
@@ -371,14 +371,14 @@ void __ubsan_handle_alignment_assumption(void *_data, unsigned long ptr,
 	ubsan_prologue(&data->location, "alignment-assumption");
 
 	if (offset)
-		pr_err("assumption of %lu byte alignment (with offset of %lu byte) for pointer of type %s failed",
+		pr_err("assumption of %lu byte alignment (with offset of %lu byte) for pointer of type %s failed\n",
 		       align, offset, data->type->type_name);
 	else
-		pr_err("assumption of %lu byte alignment for pointer of type %s failed",
+		pr_err("assumption of %lu byte alignment for pointer of type %s failed\n",
 		       align, data->type->type_name);
 
 	real_ptr = ptr - offset;
-	pr_err("%saddress is %lu aligned, misalignment offset is %lu bytes",
+	pr_err("%saddress is %lu aligned, misalignment offset is %lu bytes\n",
 	       offset ? "offset " : "", BIT(real_ptr ? __ffs(real_ptr) : 0),
 	       real_ptr & (align - 1));
 
-- 
2.36.1

