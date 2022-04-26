Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D04250F219
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 09:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343834AbiDZHWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 03:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiDZHWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 03:22:11 -0400
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [IPv6:2605:2700:0:5::4713:9cab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 030519A9BD;
        Tue, 26 Apr 2022 00:19:03 -0700 (PDT)
Received: from hatter.bewilderbeest.net (174-21-187-98.tukw.qwest.net [174.21.187.98])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 3BAEC3BA;
        Tue, 26 Apr 2022 00:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1650957543;
        bh=a7d5HgjSck+kLktoYQpx+Gz8Wrhd4xbxiVJ4ra53z1E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PgomL2EtKY8sddCwJYlXrDU6iQeZq8/91wez6jWg+8WRmBsvFrzwliIPUxudzNhPf
         J32+fgUONeILnv3lrChcLoAeAOEDVSfm3AuAXiGBJI7pVsv6dT2cVYURj5FLPsz9QA
         3rjPoJ7H7+4KcsFf0trgbRG3vlLt0RtL/6E6yo6Q=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     Zev Weiss <zev@bewilderbeest.net>, Renze Nicolai <renze@rnplus.nl>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v3 1/6] dt-bindings: trivial-devices: Add Nuvoton Super I/O chips
Date:   Tue, 26 Apr 2022 00:18:43 -0700
Message-Id: <20220426071848.11619-2-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220426071848.11619-1-zev@bewilderbeest.net>
References: <20220426071848.11619-1-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These Super I/O chips have an i2c interface that some systems expose
to a BMC, which may have it described in its device tree.

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
---
 .../devicetree/bindings/trivial-devices.yaml       | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 550a2e5c9e05..2262dec4289e 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -277,6 +277,20 @@ properties:
           - national,lm85
             # I2C ±0.33°C Accurate, 12-Bit + Sign Temperature Sensor and Thermal Window Comparator
           - national,lm92
+            # Nuvoton Super I/O chips
+          - nuvoton,nct6775
+          - nuvoton,nct6106
+          - nuvoton,nct6116
+          - nuvoton,nct6775
+          - nuvoton,nct6776
+          - nuvoton,nct6779
+          - nuvoton,nct6791
+          - nuvoton,nct6792
+          - nuvoton,nct6793
+          - nuvoton,nct6795
+          - nuvoton,nct6796
+          - nuvoton,nct6797
+          - nuvoton,nct6798
             # i2c trusted platform module (TPM)
           - nuvoton,npct501
             # i2c trusted platform module (TPM2)
-- 
2.36.0

