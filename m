Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 968154FA262
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 06:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240788AbiDIEUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 00:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240790AbiDIETz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 00:19:55 -0400
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB6CDB49C;
        Fri,  8 Apr 2022 21:17:46 -0700 (PDT)
Date:   Sat, 09 Apr 2022 04:17:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1649477860;
        bh=ZfIKnNDAxApXki3WuLZmf8+0MPXOOLvWlEKIqT1Ljj8=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID;
        b=cTZp5G2Ouna2kDcu/68f3ettd4a25+E1GF8ZpuZ5xI8TkavvJc7KO2ruZqqD/mpBy
         iWeJsBDi/PRIEieqjdW00r8cicPieKZki6gx2dDLtkgokv5fQjNJMyzzJZVpCp05PU
         08cAYoyn254Ic5Sf3cLCOCKBrNuJOcQy62qAPPLft0RyXjrBBN797ZWYbnRpSre5Zp
         KhAP0J4i+6C12lU7TjDhy/K1iLvXNux/OKiANdDSerGuza9vl3zzceRr2CqP1NL7Jl
         LyTOtP1m5YiMK+is8JVOGanVmYvTgMMS/oTwa5UgeYS5unb5LdJy9XdLBeNMHZIXC8
         nTO1YAFfvf0OA==
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
From:   Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org
Reply-To: Yassine Oudjana <y.oudjana@protonmail.com>
Subject: [PATCH v2 5/9] dt-bindings: opp: opp-v2-kryo-cpu: Remove SMEM
Message-ID: <T-ZqipM8xIaRroty0k9MEPCfD31BvtDXY6IaSm8uCD_ffIgJKYAcY-EZ49w0S-uX0w9sn1mUfBALTv0SqOb7OM1Uh6pskewGKxkOFYRJwfM=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

qcom-cpufreq-nvmem no longer uses SMEM. Remove all references
to SMEM and change the description and maximum value of
opp-supported-hw to reflect the new set of possible values.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 .../bindings/opp/opp-v2-kryo-cpu.yaml         | 56 +++++++++----------
 1 file changed, 26 insertions(+), 30 deletions(-)

diff --git a/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml b/D=
ocumentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
index 8c2e9ac5f68d..30f7b596d609 100644
--- a/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
+++ b/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
@@ -17,10 +17,10 @@ description: |
   the CPU frequencies subset and voltage value of each OPP varies based on
   the silicon variant in use.
   Qualcomm Technologies, Inc. Process Voltage Scaling Tables
-  defines the voltage and frequency value based on the msm-id in SMEM
-  and speedbin blown in the efuse combination.
-  The qcom-cpufreq-nvmem driver reads the msm-id and efuse value from the =
SoC
-  to provide the OPP framework with required information (existing HW bitm=
ap).
+  defines the voltage and frequency value based on the speedbin blown in
+  the efuse combination.
+  The qcom-cpufreq-nvmem driver reads the efuse value from the SoC to prov=
ide
+  the OPP framework with required information (existing HW bitmap).
   This is used to determine the voltage and frequency value for each OPP o=
f
   operating-points-v2 table when it is parsed by the OPP framework.

@@ -50,15 +50,11 @@ patternProperties:
         description: |
           A single 32 bit bitmap value, representing compatible HW.
           Bitmap:
-          0:  MSM8996 V3, speedbin 0
-          1:  MSM8996 V3, speedbin 1
-          2:  MSM8996 V3, speedbin 2
-          3:  unused
-          4:  MSM8996 SG, speedbin 0
-          5:  MSM8996 SG, speedbin 1
-          6:  MSM8996 SG, speedbin 2
-          7-31:  unused
-        maximum: 0x77
+          0:  MSM8996, speedbin 0
+          1:  MSM8996, speedbin 1
+          2:  MSM8996, speedbin 2
+          3-31:  unused
+        maximum: 0x7

       clock-latency-ns: true

@@ -184,19 +180,19 @@ examples:
             opp-307200000 {
                 opp-hz =3D /bits/ 64 <307200000>;
                 opp-microvolt =3D <905000 905000 1140000>;
-                opp-supported-hw =3D <0x77>;
+                opp-supported-hw =3D <0x7>;
                 clock-latency-ns =3D <200000>;
             };
-            opp-1593600000 {
-                opp-hz =3D /bits/ 64 <1593600000>;
+            opp-1401600000 {
+                opp-hz =3D /bits/ 64 <1401600000>;
                 opp-microvolt =3D <1140000 905000 1140000>;
-                opp-supported-hw =3D <0x71>;
+                opp-supported-hw =3D <0x5>;
                 clock-latency-ns =3D <200000>;
             };
-            opp-2188800000 {
-                opp-hz =3D /bits/ 64 <2188800000>;
+            opp-1593600000 {
+                opp-hz =3D /bits/ 64 <1593600000>;
                 opp-microvolt =3D <1140000 905000 1140000>;
-                opp-supported-hw =3D <0x10>;
+                opp-supported-hw =3D <0x1>;
                 clock-latency-ns =3D <200000>;
             };
         };
@@ -209,25 +205,25 @@ examples:
             opp-307200000 {
                 opp-hz =3D /bits/ 64 <307200000>;
                 opp-microvolt =3D <905000 905000 1140000>;
-                opp-supported-hw =3D <0x77>;
+                opp-supported-hw =3D <0x7>;
                 clock-latency-ns =3D <200000>;
             };
-            opp-1593600000 {
-                opp-hz =3D /bits/ 64 <1593600000>;
+            opp-1804800000 {
+                opp-hz =3D /bits/ 64 <1804800000>;
                 opp-microvolt =3D <1140000 905000 1140000>;
-                opp-supported-hw =3D <0x70>;
+                opp-supported-hw =3D <0x6>;
                 clock-latency-ns =3D <200000>;
             };
-            opp-2150400000 {
-                opp-hz =3D /bits/ 64 <2150400000>;
+            opp-1900800000 {
+                opp-hz =3D /bits/ 64 <1900800000>;
                 opp-microvolt =3D <1140000 905000 1140000>;
-                opp-supported-hw =3D <0x31>;
+                opp-supported-hw =3D <0x4>;
                 clock-latency-ns =3D <200000>;
             };
-            opp-2342400000 {
-                opp-hz =3D /bits/ 64 <2342400000>;
+            opp-2150400000 {
+                opp-hz =3D /bits/ 64 <2150400000>;
                 opp-microvolt =3D <1140000 905000 1140000>;
-                opp-supported-hw =3D <0x10>;
+                opp-supported-hw =3D <0x1>;
                 clock-latency-ns =3D <200000>;
             };
         };
--
2.35.1

