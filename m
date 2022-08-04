Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50ECD5898D4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 09:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239351AbiHDHzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 03:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239348AbiHDHzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 03:55:13 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09072D93;
        Thu,  4 Aug 2022 00:55:12 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id f11so17260341pgj.7;
        Thu, 04 Aug 2022 00:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=wznkIL6qfpYzFMspwCeJlJB1nlJHNIimvzTogvlqPjs=;
        b=EQfeXpQQ+Gxh0+9HaNXsT19uegX3KHWon6EzK8Q1KqNAxiGxPnLG0y2FiKkndJc5xF
         exIIKjHRGPjtkV2FL3UXEqEbxBI2ESeMoy9s2gddJ3KyokGEeFqC+PEgwa6sROz7e6q6
         4NOw6sknsMRjxjheq2etEc5kfb3MDkL48XTJj7rqhpfdimLxcV3YPd+N4n37Slid8bV7
         +nL2Gxv4fc+fJ6G0bFIpJQNaUVXNvQIUpBkJk01m9kSznQzdDZN5c1UxrDM8fmSePnKu
         7Z8X1yUyT+5CuFYfg4HUwf283LL0zUDqUVpkSY7WozZMzefl9RE1Ypoip+1IEQ8BfnVc
         UBcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=wznkIL6qfpYzFMspwCeJlJB1nlJHNIimvzTogvlqPjs=;
        b=sMKG6NoxWIPi1hUXlcBLlz/y80dzOFOR/c8SjYM1rLzoR1m/XVBEN+0ZPfU4ZTZUmT
         p/T9l+E0ayTrjKz3wOA+10xBzST2vr7CDS3LSztaOF96GtZRdCXApexzBNh1+2OEEAIf
         U0qr/t/IkYZ5R/p3zwoni0I0KhZlmGXbL+ycpIAbI+CNOfWMG2Rt/PdFt/alC5Jcs8YN
         Y5KuvocTi2Sn1xGUJG4I6MridFqlzH78YN/0Lhmyk0QQfCJcRm+5C0Q/I64xAZdyU/ER
         3xNIjxcLoJ3Xal384XW1Om734W8XNMzgIKhNIV5msXFHDPZQK4LfS0ki+kYoEVkXG0rq
         HIfQ==
X-Gm-Message-State: ACgBeo3tFwUiA7wZvmhnE7Aih/ouGvb1BT/CHF2DEeZcV3dcpjGwAZ2j
        mBwsqAz523iXDYYdWJOgnpU=
X-Google-Smtp-Source: AA6agR59WXR8HB1Fzh7rCwEA4pDHCxPXITi8cwSZjha7oKGw7AT6H5VKbOxGfJ0sYXJ6Xd/2pFUnAw==
X-Received: by 2002:a05:6a00:1343:b0:52e:61b1:4a9f with SMTP id k3-20020a056a00134300b0052e61b14a9fmr793141pfu.6.1659599711410;
        Thu, 04 Aug 2022 00:55:11 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-23.three.co.id. [180.214.232.23])
        by smtp.gmail.com with ESMTPSA id a6-20020a170902710600b0016f02fceff4sm232053pll.57.2022.08.04.00.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 00:55:10 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 4ACEF103BFE; Thu,  4 Aug 2022 14:55:05 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     linux-doc@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-next@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 3/3] Documentation: cxl: remove dangling kernel-doc reference
Date:   Thu,  4 Aug 2022 14:54:48 +0700
Message-Id: <20220804075448.98241-4-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220804075448.98241-1-bagasdotme@gmail.com>
References: <20220804075448.98241-1-bagasdotme@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1131; i=bagasdotme@gmail.com; h=from:subject; bh=blM3WPeKk4vfg8s8TUxTvxY5mz7mY5WMx84fxwCOq3E=; b=owGbwMvMwCn83935mHOB8QHG02pJDEmvqz0KfDb0sE19OcHfy9nwe/z6f6G+bHYPdR1m2DpZ/TsU znS2YyoLgzAng6yYIsubyt1iHB9WHu0P/p4JM4eVCWQIAxenAExkYQhjna71Sq1luoFpu9dMc4oV9j Lz+vrlxayDIbteHj0wz+G5efp/3R7HiyH7V+k8uGZgOotFmbGh/d/vWzXxRhICoX8nLfoSZPzqZKaP u5rcGsa6MlXGrTs3/5zz+t3vvQ1Sqzi3T1vaGWQEAA==
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=EC79BB1608F0A9C58F53F769FF4743C6437033C0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sphinx reported kernel-doc failure warning, pointing to non-existent
drivers/cxl/region.h (which doesn't also exist throughout repo history):

WARNING: kernel-doc './scripts/kernel-doc -rst -enable-lineno -sphinx-version 2.4.4 -no-doc-sections ./drivers/cxl/region.h' failed with return code 1

Above cause error message to be displayed on htmldocs output.

Delete the reference.

Fixes: 779dd20cfb56c5 ("cxl/region: Add region creation support")
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/driver-api/cxl/memory-devices.rst | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/driver-api/cxl/memory-devices.rst b/Documentation/driver-api/cxl/memory-devices.rst
index 66ddc58a21b159..5149ecdc53c796 100644
--- a/Documentation/driver-api/cxl/memory-devices.rst
+++ b/Documentation/driver-api/cxl/memory-devices.rst
@@ -364,9 +364,6 @@ CXL Core
 
 CXL Regions
 -----------
-.. kernel-doc:: drivers/cxl/region.h
-   :identifiers:
-
 .. kernel-doc:: drivers/cxl/core/region.c
    :doc: cxl core region
 
-- 
An old man doll... just what I always wanted! - Clara

