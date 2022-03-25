Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A8F4E7143
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 11:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358880AbiCYKcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 06:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348339AbiCYKco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 06:32:44 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B972C55A9;
        Fri, 25 Mar 2022 03:31:11 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: shreeya)
        with ESMTPSA id E983A1F460E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648204269;
        bh=GOvS6/pw00uQWPk8FwXeV72GGMNO/VFjmhsyaOW4hJs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YusUtmiBQKwKYDCfioUDiIMRJ/gxBnYuYzHru3tz5LPIdoSsFK4v2oK/GYHpvUamY
         7mJLF4AI3URoPCi5NSaJtXrmAIx0lXLq0tJkbRli/H4W8tgpy8XLoxIqqDEOrfGV/A
         qDYvh9fSvOApZGFFb7dMlI9o1HTOpdA2Mugdy7D+RhTq+/tf/FsVYe9FQWdRfi1v8C
         gmVP97KABSEIYHf5irJFnAmNcQGT9mCLmGmiYl4/ecm3QV20JCKCtXoYG6FAjObMoI
         hkX7foNVxhAPQGa+0TW9pQPMtiZUs5xkqW7TRldvebyfjctZzb2dpDeaCaERHgqCj4
         B/dD8xIB5bI/w==
From:   Shreeya Patel <shreeya.patel@collabora.com>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        Zhigang.Shi@liteon.com, krisman@collabora.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        alvaro.soliverez@collabora.com,
        Shreeya Patel <shreeya.patel@collabora.com>
Subject: [PATCH 1/3] dt-bindings: vendor-prefixes: Add 'ltr' as deprecated vendor prefix
Date:   Fri, 25 Mar 2022 16:00:12 +0530
Message-Id: <20220325103014.6597-2-shreeya.patel@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220325103014.6597-1-shreeya.patel@collabora.com>
References: <20220325103014.6597-1-shreeya.patel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'liteon' is the correct vendor prefix for devices released by
LITE-ON Technology Corp. But one of the released device which uses
ltr216a light sensor exposes the vendor prefix name as 'ltr' through
ACPI.

Hence, add 'ltr' as a deprecated vendor prefix which would suppress the
following warning in case the compatible string used in ltrf216a driver
is "ltr,ltrf216a"

WARNING: DT compatible string vendor "ltr" appears un-documented --
check ./Documentation/devicetree/bindings/vendor-prefixes.yaml
364: FILE: drivers/iio/light/ltrf216a.c:313:
+    { .compatible = "ltr,ltrf216a" },


Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index baed2b007d0e..e78091d51443 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -691,6 +691,9 @@ patternProperties:
     description: Linx Technologies
   "^liteon,.*":
     description: LITE-ON Technology Corp.
+  "^ltr,.*":
+    description: LITE-ON Technology Corp.
+    deprecated: true
   "^litex,.*":
     description: LiteX SoC builder
   "^lltc,.*":
-- 
2.30.2

