Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBA5A4BDF5A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353312AbiBUKXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 05:23:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353195AbiBUKW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 05:22:57 -0500
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050::465:101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7CB3E0F7;
        Mon, 21 Feb 2022 01:42:40 -0800 (PST)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4K2HQl1wDfz9sdR;
        Mon, 21 Feb 2022 10:42:39 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sylv.io; s=MBO0001;
        t=1645436557;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QlxYiSQLXtOgUJhWdCR53g7RwR21q6ocLhh0OLfCWng=;
        b=iexhAn7a0X6e5+v3BwqI2mZWVusxhQnAGAHeG/vURlR2VQMLKvRt9NtMLLmcdsAzqwHBQ0
        twwqiZFdiXU3/dsDxUc9dX2xV6FrWbu086wB5TZC7n0ccpqTA2mstk7XhGHgCuAfaQhr/j
        EkmiUtLovQEMLOfCfE2mZhw6dRpXv+x0ilyWyRUPJgwlsTttDsgdkkh6sNeEwWW3OUPM7d
        3WRjcKNE0tCurcit9dycUuqOQYO/wkIBiF/g2/9JRMbHNLDK/r2QAppFNz0GXqm4qTXOiB
        KpchcqAICXJXeDjsm1eQslwD9n4W2oOngvzi4hZZsKcZ/Em5AcpjZv72Dhf+Pg==
From:   Marcello Sylvester Bauer <sylv@sylv.io>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Marcello Sylvester Bauer <sylv@sylv.io>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v4 1/4] dt-bindings: vendor-prefixes: add Vicor Corporation
Date:   Mon, 21 Feb 2022 10:42:04 +0100
Message-Id: <5b487a0b68d58b64022662f1e527ac80a6ad81ef.1645435888.git.sylv@sylv.io>
In-Reply-To: <cover.1645435888.git.sylv@sylv.io>
References: <cover.1645435888.git.sylv@sylv.io>
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

