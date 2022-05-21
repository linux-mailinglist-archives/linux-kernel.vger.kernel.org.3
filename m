Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6EF552FBEB
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 13:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355189AbiEULUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 07:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352848AbiEULMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 07:12:18 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85AC930F76;
        Sat, 21 May 2022 04:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qcJTHawlRKoeOim3g0cgniU9sUekvVwjFkRe7wj2hDQ=;
  b=WO6dpJmgWMyl0xCWIpgSlZaD3CQxpEXfBfcqtqHEOz9uoxKGHTKjBNDM
   cj8gchDORum81IfppDCRi1SdSLge8YG3laSbf1NH/6PpeBNbQoUWhIpo2
   6brK3HY41/mxcaIUu8bQzR3FJYfpLevtJBcnQXpFnushgG4NlLxkKfG+Z
   8=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.91,242,1647298800"; 
   d="scan'208";a="14727934"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2022 13:11:58 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Michael Walle <michael@walle.cc>
Cc:     kernel-janitors@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: fix typo in comment
Date:   Sat, 21 May 2022 13:10:47 +0200
Message-Id: <20220521111145.81697-37-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Spelling mistake (triple letters) in comment.
Detected with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 drivers/hwmon/sl28cpld-hwmon.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/sl28cpld-hwmon.c b/drivers/hwmon/sl28cpld-hwmon.c
index e2fc60bf40bd..9ce4899a81a5 100644
--- a/drivers/hwmon/sl28cpld-hwmon.c
+++ b/drivers/hwmon/sl28cpld-hwmon.c
@@ -54,7 +54,7 @@ static int sl28cpld_hwmon_read(struct device *dev,
 
 		/*
 		 * The counter period is 1000ms and the sysfs specification
-		 * says we should asssume 2 pulses per revolution.
+		 * says we should assume 2 pulses per revolution.
 		 */
 		value *= 60 / 2;
 

