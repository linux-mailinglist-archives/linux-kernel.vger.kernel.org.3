Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA1649EB00
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 20:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245521AbiA0T0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 14:26:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232674AbiA0T0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 14:26:52 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C227C061714;
        Thu, 27 Jan 2022 11:26:52 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id h16so3740068qvk.10;
        Thu, 27 Jan 2022 11:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IUyZurcgp73u2N91uyDJxFEbTaBRmHOl6pbvJG2v+HE=;
        b=OKw4RiISMf5lEk+9pwFYNy8PnNGdBXQWsZx2iSAVNjnGA6PkT/FcUxvemajn9uhIGc
         lJIZthav4wJjvQ5mrEBwBr5UXHSYWW6AxYGFmIBUIYcuPGwMwjEpEnuuTwBCbW6cInLs
         mm/xc//7uiXjYdbXaA9JyEGgy3SsreZ8RpXousj1Fqd29ImUdZHXWd7wQdi361Jjr/rY
         LQxUfwfqd3kM8mjZk2kwX3uR1W/NqnTTSFsBzoLobZYxLSOPGoWyBNkLpxP8AfRDJjcg
         DLgS2YUK3tvlm1zMIwq4ye0RysnmtfkhwaYdT2maqEQG0LbEIyx/xd/t2f0/1NBXbNWl
         YfWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IUyZurcgp73u2N91uyDJxFEbTaBRmHOl6pbvJG2v+HE=;
        b=t6l/mv9zmaSRGc8ukOeAzU474Kzq+l5y/rmH5NK+JULbmdb35XNf+tn6B6En4swpdW
         wbtW7qsSffqvIaneTVcGv3AFaWOZaT2YrJj+40g+/0muG8F4usoOPuenRbmwtiyOEopB
         9Z5XDfarO4Fm5vzQKb0r5CMFMu7b16AH5IWoH1wCz+fkiksjFBdXpykyfqRl+RVQ2Cr6
         y19ZCnoERiMiiyeeg6qtWf+MZFJT6PHliM7r2uWfpg69gdS/8GBpy+9Bt9qnsSECGbEO
         AYLepqCNCMvcO2/qF0chvi9WMGzLLgpbxNdbdUvRGMi0jrDRBimh2tqcNcC04fLOlgoH
         2oFQ==
X-Gm-Message-State: AOAM5329cMg3UbfmfBxDRN2EV4dunZY+Fx/MEdzFObDCAjRua+Ljn3jX
        hDrSy2C4krtkY/BJxQtyPjI=
X-Google-Smtp-Source: ABdhPJwhnFoyb2YwObfsklplMLzmiWySRisI+GVjD/2QSRgC5UCHKhWTF7AoLw0MCBamuJRGmqQYXQ==
X-Received: by 2002:a05:6214:20e7:: with SMTP id 7mr4887129qvk.104.1643311611767;
        Thu, 27 Jan 2022 11:26:51 -0800 (PST)
Received: from localhost.localdomain (c-67-187-90-124.hsd1.tn.comcast.net. [67.187.90.124])
        by smtp.gmail.com with ESMTPSA id f5sm1994002qkp.40.2022.01.27.11.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 11:26:51 -0800 (PST)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] of: unittest: update text of expected warnings
Date:   Thu, 27 Jan 2022 13:26:43 -0600
Message-Id: <20220127192643.2534941-1-frowand.list@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

The text of various warning messages triggered by unittest has
changed.  Update the text of expected warnings to match.

The expected vs actual warnings are most easily seen by filtering
the boot console messages with the of_unittest_expect program at
https://github.com/frowand/dt_tools.git.  The filter prefixes
problem lines with '***', and prefixes lines that match expected
errors with 'ok '.  All other lines are prefixed with '   '.
Unrelated lines have been deleted in the following examples.

The mismatch appears as:

-> ### dt-test ### start of unittest - you will see error messages
      OF: /testcase-data/phandle-tests/consumer-a: #phandle-cells = 3 found 1
   ** of_unittest_expect WARNING - not found ---> OF: /testcase-data/phandle-tests/consumer-a: #phandle-cells = 3 found -1
      OF: /testcase-data/phandle-tests/consumer-a: #phandle-cells = 3 found 1
   ** of_unittest_expect WARNING - not found ---> OF: /testcase-data/phandle-tests/consumer-a: #phandle-cells = 3 found -1
      OF: /testcase-data/phandle-tests/consumer-b: #phandle-cells = 2 found 1
   ** of_unittest_expect WARNING - not found ---> OF: /testcase-data/phandle-tests/consumer-b: #phandle-cells = 2 found -1
      platform testcase-data:testcase-device2: error -ENXIO: IRQ index 0 not found
   ** of_unittest_expect WARNING - not found ---> platform testcase-data:testcase-device2: IRQ index 0 not found
   -> ### dt-test ### end of unittest - 254 passed, 0 failed
   ** EXPECT statistics:
   **
   **   EXPECT found          :   42
   **   EXPECT not found      :    4

With this commit applied, the mismatch is resolved:

   -> ### dt-test ### start of unittest - you will see error messages
   ok OF: /testcase-data/phandle-tests/consumer-a: #phandle-cells = 3 found 1
   ok OF: /testcase-data/phandle-tests/consumer-a: #phandle-cells = 3 found 1
   ok OF: /testcase-data/phandle-tests/consumer-b: #phandle-cells = 2 found 1
   ok platform testcase-data:testcase-device2: error -ENXIO: IRQ index 0 not found
   -> ### dt-test ### end of unittest - 254 passed, 0 failed
   ** EXPECT statistics:
   **
   **   EXPECT found          :   46
   **   EXPECT not found      :    0

Fixes: 2043727c2882 ("driver core: platform: Make use of the helper function dev_err_probe()")
Fixes: 94a4950a4acf ("of: base: Fix phandle argument length mismatch error message")
Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 drivers/of/unittest.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 70992103c07d..2c2fb161b572 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -513,24 +513,24 @@ static void __init of_unittest_parse_phandle_with_args(void)
 	memset(&args, 0, sizeof(args));
 
 	EXPECT_BEGIN(KERN_INFO,
-		     "OF: /testcase-data/phandle-tests/consumer-a: #phandle-cells = 3 found -1");
+		     "OF: /testcase-data/phandle-tests/consumer-a: #phandle-cells = 3 found 1");
 
 	rc = of_parse_phandle_with_args(np, "phandle-list-bad-args",
 					"#phandle-cells", 1, &args);
 
 	EXPECT_END(KERN_INFO,
-		   "OF: /testcase-data/phandle-tests/consumer-a: #phandle-cells = 3 found -1");
+		   "OF: /testcase-data/phandle-tests/consumer-a: #phandle-cells = 3 found 1");
 
 	unittest(rc == -EINVAL, "expected:%i got:%i\n", -EINVAL, rc);
 
 	EXPECT_BEGIN(KERN_INFO,
-		     "OF: /testcase-data/phandle-tests/consumer-a: #phandle-cells = 3 found -1");
+		     "OF: /testcase-data/phandle-tests/consumer-a: #phandle-cells = 3 found 1");
 
 	rc = of_count_phandle_with_args(np, "phandle-list-bad-args",
 					"#phandle-cells");
 
 	EXPECT_END(KERN_INFO,
-		   "OF: /testcase-data/phandle-tests/consumer-a: #phandle-cells = 3 found -1");
+		   "OF: /testcase-data/phandle-tests/consumer-a: #phandle-cells = 3 found 1");
 
 	unittest(rc == -EINVAL, "expected:%i got:%i\n", -EINVAL, rc);
 }
@@ -670,12 +670,12 @@ static void __init of_unittest_parse_phandle_with_args_map(void)
 	memset(&args, 0, sizeof(args));
 
 	EXPECT_BEGIN(KERN_INFO,
-		     "OF: /testcase-data/phandle-tests/consumer-b: #phandle-cells = 2 found -1");
+		     "OF: /testcase-data/phandle-tests/consumer-b: #phandle-cells = 2 found 1");
 
 	rc = of_parse_phandle_with_args_map(np, "phandle-list-bad-args",
 					    "phandle", 1, &args);
 	EXPECT_END(KERN_INFO,
-		   "OF: /testcase-data/phandle-tests/consumer-b: #phandle-cells = 2 found -1");
+		   "OF: /testcase-data/phandle-tests/consumer-b: #phandle-cells = 2 found 1");
 
 	unittest(rc == -EINVAL, "expected:%i got:%i\n", -EINVAL, rc);
 }
@@ -1257,12 +1257,12 @@ static void __init of_unittest_platform_populate(void)
 		unittest(pdev, "device 2 creation failed\n");
 
 		EXPECT_BEGIN(KERN_INFO,
-			     "platform testcase-data:testcase-device2: IRQ index 0 not found");
+			     "platform testcase-data:testcase-device2: error -ENXIO: IRQ index 0 not found");
 
 		irq = platform_get_irq(pdev, 0);
 
 		EXPECT_END(KERN_INFO,
-			   "platform testcase-data:testcase-device2: IRQ index 0 not found");
+			   "platform testcase-data:testcase-device2: error -ENXIO: IRQ index 0 not found");
 
 		unittest(irq < 0 && irq != -EPROBE_DEFER,
 			 "device parsing error failed - %d\n", irq);
-- 
Frank Rowand <frank.rowand@sony.com>

