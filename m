Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A64F4DD0C5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 23:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbiCQWcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 18:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbiCQWcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 18:32:20 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D49018006E
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 15:31:01 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 01FFB2C0AE0;
        Thu, 17 Mar 2022 22:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1647556260;
        bh=CB9o5+iAQCH3vvVKMRvsbRs7DvyhBXWTzdG/VJgZrQI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DqMZa1NQkjW9x3ndN2WpCPdlTImxyUrB9k3h48QYxcxCGFZn+aecnwp3E5nscaCNd
         lVfsmi4gpFaSzCMh+uCAXHjVOYC5gnX+treV3T3VXHP9TCHk7/9CxeZV9i3BPzZvA6
         FHM4cjbwjWRpepb7/MJDREWnZoNwLEeCAiE1K304t2LcVKNFdXhtVdlhN/nS1P7IBT
         G5oUhFlTzfMoehjSten+SuSe9/Vaeidxavoeo8GV4s4hamB1tU0UvpQ1gENhBwHxk6
         18c4wVqqO2o4oxeqmCbft5QqJo6nhMzgGJOGC65RrncYMV8WIieFD+9Ia4VoXB9f3x
         1py/vFxz58Mcg==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B6233b6a30001>; Fri, 18 Mar 2022 11:30:59 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by pat.atlnz.lc (Postfix) with ESMTP id A23B213EE37;
        Fri, 18 Mar 2022 11:30:59 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id A1E892A004D; Fri, 18 Mar 2022 11:30:56 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v2 1/3] dt-bindings: hwmon: Document adt7475 pin-function properties
Date:   Fri, 18 Mar 2022 11:30:48 +1300
Message-Id: <20220317223051.1227110-2-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220317223051.1227110-1-chris.packham@alliedtelesis.co.nz>
References: <20220317223051.1227110-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=Cfh2G4jl c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=o8Y5sQTvuykA:10 a=VwQbUJbxAAAA:8 a=XrEdriJqPTbsqx2b3kgA:9 a=AjGcO6oz07-iQ99wixmX:22
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The adt7473, adt7475, adt7476 and adt7490 have pins that can be used for
different functions. Add bindings so that it is possible to describe
what pin functions are intended by the hardware design.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
---

Notes:
    Changes in v2:
    - Add review from Krzysztof

 .../devicetree/bindings/hwmon/adt7475.yaml    | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/devicetree/bindings/hwmon/adt7475.yaml b/Docum=
entation/devicetree/bindings/hwmon/adt7475.yaml
index 7d9c083632b9..22beb37f1bf1 100644
--- a/Documentation/devicetree/bindings/hwmon/adt7475.yaml
+++ b/Documentation/devicetree/bindings/hwmon/adt7475.yaml
@@ -61,6 +61,26 @@ patternProperties:
     $ref: /schemas/types.yaml#/definitions/uint32
     enum: [0, 1]
=20
+  "adi,pin(5|10)-function":
+    description: |
+      Configures the function for pin 5 on the adi,adt7473 and adi,adt74=
75. Or
+      pin 10 on the adi,adt7476 and adi,adt7490.
+    $ref: /schemas/types.yaml#/definitions/string
+    enum:
+      - pwm2
+      - smbalert#
+
+  "adi,pin(9|14)-function":
+    description: |
+      Configures the function for pin 9 on the adi,adt7473 and adi,adt74=
75. Or
+      pin 14 on the adi,adt7476 and adi,adt7490
+    $ref: /schemas/types.yaml#/definitions/string
+    enum:
+      - tach4
+      - therm#
+      - smbalert#
+      - gpio
+
 required:
   - compatible
   - reg
@@ -79,6 +99,8 @@ examples:
         adi,bypass-attenuator-in0 =3D <1>;
         adi,bypass-attenuator-in1 =3D <0>;
         adi,pwm-active-state =3D <1 0 1>;
+        adi,pin10-function =3D "smbalert#";
+        adi,pin14-function =3D "tach4";
       };
     };
=20
--=20
2.35.1

