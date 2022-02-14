Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 721704B5066
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 13:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353300AbiBNMlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 07:41:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbiBNMlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 07:41:32 -0500
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [IPv6:2001:67c:2050::465:202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B341C9;
        Mon, 14 Feb 2022 04:41:22 -0800 (PST)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:105:465:1:4:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Jy3k83bjXz9sQR;
        Mon, 14 Feb 2022 13:41:20 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sylv.io; s=MBO0001;
        t=1644842478;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QlxYiSQLXtOgUJhWdCR53g7RwR21q6ocLhh0OLfCWng=;
        b=indUhyCVGN3Aj1m3rLW3oo6ZHul1YJYnVRC1ahcOYuMoA9kPgaHUqFxV+46igduhF9UKn1
        Bk/QSzYsf8aEzy/LnsNH90tHVfww2088LR9EFSjO0GWWj1rQB7KqVopBfhSmPo65qTk1BW
        49eDzgjKC/sIr8xJKbCAeJAWNj1m5yXH5Mih3kUEGxJMx9iI3yaiv1W4Ml7MQ2cJTEXaSh
        3APhY2FeSwAlvkP3NhPMFYGeilH78y1RTnBUEnoCHy/FpxlIlw0v3zHYXAeMkmcdysXlUN
        TPFYesUlE6HdyqScJh7vlNvqQInrnPhXdHiUR/ku0hCQbvR5Lb+YHIGJarAriQ==
From:   Marcello Sylvester Bauer <sylv@sylv.io>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Marcello Sylvester Bauer <sylv@sylv.io>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v2 1/4] dt-bindings: vendor-prefixes: add Vicor Corporation
Date:   Mon, 14 Feb 2022 13:40:32 +0100
Message-Id: <d000eb43e403f1bd4a94141b94f68305b4965a33.1644834803.git.sylv@sylv.io>
In-Reply-To: <cover.1644834803.git.sylv@sylv.io>
References: <cover.1644834803.git.sylv@sylv.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vendor prefix for Vicor Corporation.

Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 294093d45a23..047a83a089ce 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1298,6 +1298,8 @@ patternProperties:
     description: Vertexcom Technologies, Inc.
   "^via,.*":
     description: VIA Technologies, Inc.
+  "^vicor,.*":
+    description: Vicor Corporation
   "^videostrong,.*":
     description: Videostrong Technology Co., Ltd.
   "^virtio,.*":
-- 
2.34.1

