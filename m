Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32A2F490C49
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 17:13:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240958AbiAQQNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 11:13:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240909AbiAQQNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 11:13:30 -0500
Received: from mout-y-209.mailbox.org (mout-y-209.mailbox.org [IPv6:2001:67c:2050:1::465:209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B01C06161C;
        Mon, 17 Jan 2022 08:13:30 -0800 (PST)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:105:465:1:4:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-y-209.mailbox.org (Postfix) with ESMTPS id 4Jcxlr4Ctgz9scp;
        Mon, 17 Jan 2022 17:13:28 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sylv.io; s=MBO0001;
        t=1642436006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PeyOtioc+HMGOCLtGIToDJpGx5LhgE+HjONIButej2I=;
        b=FEUv+9mT8jrC475KPKqZckBgK5ik+cRAxH4LG1Lz8SEWLUTN23vGcEJ2rmNkJrW6tuV0Za
        jE2iOrJ+KGRHWbuO2Ep+P967C60CUrI+e/74lJ+1ZGkTNq43KQwOM3u01CpX1EDl31cwoz
        rVc/IJrDAhHmT2HQmg7zIh2zPKmP9dxEqsYah2SZabO5ysOvHIL+QIoLgkM32bEHUy4qkS
        dBr30yfH2dCi5CP0Zdb1vZ1tn/Lhbl7sxRcSw+rQrDwq3GmAFU1DotRWYnhWbWJRYfeH+y
        2oz56oSm2EoQ8WZ1JI4ibUKQgiN/plMIoBtG97lx2hUc7clcaPFLs1rjdAbxCA==
From:   Marcello Sylvester Bauer <sylv@sylv.io>
To:     linux-hwmon@vger.kernel.org
Cc:     Marcello Sylvester Bauer <sylv@sylv.io>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/4] dt-bindings: vendor-prefixes: add Vicor Corporation
Date:   Mon, 17 Jan 2022 17:12:47 +0100
Message-Id: <58d2c7501edf746f3677681327c283fc3faaf872.1642434222.git.sylv@sylv.io>
In-Reply-To: <cover.1642434222.git.sylv@sylv.io>
References: <cover.1642434222.git.sylv@sylv.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vendor prefix for Vicor Corporation.

Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 66d6432fd781..8a2a205d6d34 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1273,6 +1273,8 @@ patternProperties:
   "^vdl,.*":
     description: Van der Laan b.v.
   "^via,.*":
+    description: Vicor Corporation
+  "^vicor,.*":
     description: VIA Technologies, Inc.
   "^videostrong,.*":
     description: Videostrong Technology Co., Ltd.
-- 
2.33.1

