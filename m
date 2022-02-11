Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC8A44B2B8C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 18:19:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352024AbiBKRR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 12:17:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351980AbiBKRRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 12:17:52 -0500
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050::465:101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EBC22E8;
        Fri, 11 Feb 2022 09:17:50 -0800 (PST)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4JwL0W4y0Tz9sTp;
        Fri, 11 Feb 2022 18:17:47 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sylv.io; s=MBO0001;
        t=1644599865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QlxYiSQLXtOgUJhWdCR53g7RwR21q6ocLhh0OLfCWng=;
        b=Vx3/vOXbz6lHcmYsPp5LIQuGPmqlQVCos+vTM5whOzQGTg8ou9VJ5VtSBHxrw3oDF51m/e
        ZjeiWviJ30CkBtpura+DHu0IyxWQJ3IzXWNXDzkrnU8djDhHwqlRUr2HI7TsaO4IELJ7vj
        FKRXUGZFd2j/05+pr+C1nu1EM6gP2fTCDFGMjStS+f5+NMQBZ1risGHyYxYH37iNdxLy/g
        Vm/69y89QtePjEpjoMZ5ToA/V0Ep6B/OdhehUbbooSU6JeW99ElEiv7qNnaMw9j748oBrE
        eeIxkn1eiVHN106Lzs4g82q2xxqxhz2Zu30NVoi4BtljItjRxQo7EHORfc0yCA==
From:   Marcello Sylvester Bauer <sylv@sylv.io>
To:     linux-hwmon@vger.kernel.org
Cc:     Marcello Sylvester Bauer <sylv@sylv.io>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/4] dt-bindings: vendor-prefixes: add Vicor Corporation
Date:   Fri, 11 Feb 2022 18:17:10 +0100
Message-Id: <3d5b4029f262a61d75c0c37839e02d67de96fae6.1644597670.git.sylv@sylv.io>
In-Reply-To: <cover.1644597670.git.sylv@sylv.io>
References: <cover.1644597670.git.sylv@sylv.io>
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

