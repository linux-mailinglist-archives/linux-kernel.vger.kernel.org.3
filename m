Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96F1B4FA278
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 06:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240825AbiDIEVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 00:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240820AbiDIEVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 00:21:41 -0400
X-Greylist: delayed 111 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 08 Apr 2022 21:19:34 PDT
Received: from mail-4319.protonmail.ch (mail-4319.protonmail.ch [185.70.43.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DDE2DCE2C;
        Fri,  8 Apr 2022 21:19:32 -0700 (PDT)
Date:   Sat, 09 Apr 2022 04:19:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1649477970;
        bh=wy0nyV8pXmZrAsC2qhEUVrK28XtZ8SPJ4QzwPaSMkhI=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID;
        b=C8nfVu9eLpGmcjv0REq/uyN6gcvj5OX2F/GIYKtblEmYdkQyF5MwEGmk7IhXNgxxv
         XNofPklt36QkppZYcfduxCsabKIH76QDvwWhdlX5mtOwg1WFvfmt5R/itTHa7HmGU0
         QqneG1UyQrhl5T9pMXWaajhqgnz/kEOAtU1iiIzNpJB3/JDVuSgJTxqu8jkXoPAHV5
         69WRXugfimLyPoRsve2dvN9upbxGZUHyEAx4VV648z3GFworwW+iRGefQZTSUKNIm7
         P+IfJ11Z3pigPCV1so7k0mjSgwVtAFh7Po22bp1rP/7Zy7BHmpmVPxkmc9wfxsDqsX
         cSpWOjKA8OUiw==
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
Subject: [PATCH v2 8/9] arm64: dts: qcom: msm8996: Add MSM8996 Pro support
Message-ID: <zv8C8ixX6ek-epBgxQzVNLamp8vylaa0vJZGFskE8cNtXcXQOQQO1JSV5Cm8F4N4j6RqWYtYMMfCZgVTHMe86AldBSH2styNiQtwRV4tB6Y=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new DTSI for MSM8996 Pro (MSM8996SG) with msm-id and CPU/GPU OPPs.
CBF OPPs and CPR parameters will be added to it as well once support for
CBF scaling and CPR is introduced.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 arch/arm64/boot/dts/qcom/msm8996pro.dtsi | 281 +++++++++++++++++++++++
 1 file changed, 281 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/msm8996pro.dtsi

diff --git a/arch/arm64/boot/dts/qcom/msm8996pro.dtsi b/arch/arm64/boot/dts=
/qcom/msm8996pro.dtsi
new file mode 100644
index 000000000000..8c8dd5614f4d
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8996pro.dtsi
@@ -0,0 +1,281 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2021, Yassine Oudjana <y.oudjana@protonmail.com>
+ */
+
+#include "msm8996.dtsi"
+
+/*
+ * MSM8996 Pro (also known as MSM8996SG) is a revision of MSM8996 with
+ * different CPU, CBF and GPU frequencies as well as CPR parameters.
+ */
+/delete-node/ &cluster0_opp;
+/delete-node/ &cluster1_opp;
+
+/ {
+=09qcom,msm-id =3D <305 0x10000>;
+
+=09cluster0_opp: opp_table0 {
+=09=09compatible =3D "operating-points-v2-kryo-cpu";
+=09=09nvmem-cells =3D <&speedbin_efuse>;
+=09=09opp-shared;
+
+=09=09opp-307200000 {
+=09=09=09opp-hz =3D /bits/ 64 <307200000>;
+=09=09=09opp-supported-hw =3D <0x7>;
+=09=09=09clock-latency-ns =3D <200000>;
+=09=09};
+=09=09opp-384000000 {
+=09=09=09opp-hz =3D /bits/ 64 <384000000>;
+=09=09=09opp-supported-hw =3D <0x7>;
+=09=09=09clock-latency-ns =3D <200000>;
+=09=09};
+=09=09opp-460800000 {
+=09=09=09opp-hz =3D /bits/ 64 <460800000>;
+=09=09=09opp-supported-hw =3D <0x7>;
+=09=09=09clock-latency-ns =3D <200000>;
+=09=09};
+=09=09opp-537600000 {
+=09=09=09opp-hz =3D /bits/ 64 <537600000>;
+=09=09=09opp-supported-hw =3D <0x7>;
+=09=09=09clock-latency-ns =3D <200000>;
+=09=09};
+=09=09opp-614400000 {
+=09=09=09opp-hz =3D /bits/ 64 <614400000>;
+=09=09=09opp-supported-hw =3D <0x7>;
+=09=09=09clock-latency-ns =3D <200000>;
+=09=09};
+=09=09opp-691200000 {
+=09=09=09opp-hz =3D /bits/ 64 <691200000>;
+=09=09=09opp-supported-hw =3D <0x7>;
+=09=09=09clock-latency-ns =3D <200000>;
+=09=09};
+=09=09opp-768000000 {
+=09=09=09opp-hz =3D /bits/ 64 <768000000>;
+=09=09=09opp-supported-hw =3D <0x7>;
+=09=09=09clock-latency-ns =3D <200000>;
+=09=09};
+=09=09opp-844800000 {
+=09=09=09opp-hz =3D /bits/ 64 <844800000>;
+=09=09=09opp-supported-hw =3D <0x7>;
+=09=09=09clock-latency-ns =3D <200000>;
+=09=09};
+=09=09opp-902400000 {
+=09=09=09opp-hz =3D /bits/ 64 <902400000>;
+=09=09=09opp-supported-hw =3D <0x7>;
+=09=09=09clock-latency-ns =3D <200000>;
+=09=09};
+=09=09opp-979200000 {
+=09=09=09opp-hz =3D /bits/ 64 <979200000>;
+=09=09=09opp-supported-hw =3D <0x7>;
+=09=09=09clock-latency-ns =3D <200000>;
+=09=09};
+=09=09opp-1056000000 {
+=09=09=09opp-hz =3D /bits/ 64 <1056000000>;
+=09=09=09opp-supported-hw =3D <0x7>;
+=09=09=09clock-latency-ns =3D <200000>;
+=09=09};
+=09=09opp-1132800000 {
+=09=09=09opp-hz =3D /bits/ 64 <1132800000>;
+=09=09=09opp-supported-hw =3D <0x7>;
+=09=09=09clock-latency-ns =3D <200000>;
+=09=09};
+=09=09opp-1209600000 {
+=09=09=09opp-hz =3D /bits/ 64 <1209600000>;
+=09=09=09opp-supported-hw =3D <0x7>;
+=09=09=09clock-latency-ns =3D <200000>;
+=09=09};
+=09=09opp-1286400000 {
+=09=09=09opp-hz =3D /bits/ 64 <1286400000>;
+=09=09=09opp-supported-hw =3D <0x7>;
+=09=09=09clock-latency-ns =3D <200000>;
+=09=09};
+=09=09opp-1363200000 {
+=09=09=09opp-hz =3D /bits/ 64 <1363200000>;
+=09=09=09opp-supported-hw =3D <0x7>;
+=09=09=09clock-latency-ns =3D <200000>;
+=09=09};
+=09=09opp-1440000000 {
+=09=09=09opp-hz =3D /bits/ 64 <1440000000>;
+=09=09=09opp-supported-hw =3D <0x7>;
+=09=09=09clock-latency-ns =3D <200000>;
+=09=09};
+=09=09opp-1516800000 {
+=09=09=09opp-hz =3D /bits/ 64 <1516800000>;
+=09=09=09opp-supported-hw =3D <0x7>;
+=09=09=09clock-latency-ns =3D <200000>;
+=09=09};
+=09=09opp-1593600000 {
+=09=09=09opp-hz =3D /bits/ 64 <1593600000>;
+=09=09=09opp-supported-hw =3D <0x7>;
+=09=09=09clock-latency-ns =3D <200000>;
+=09=09};
+=09=09opp-1996800000 {
+=09=09=09opp-hz =3D /bits/ 64 <1996800000>;
+=09=09=09opp-supported-hw =3D <0x2>;
+=09=09=09clock-latency-ns =3D <200000>;
+=09=09};
+=09=09opp-2188800000 {
+=09=09=09opp-hz =3D /bits/ 64 <2188800000>;
+=09=09=09opp-supported-hw =3D <0x1>;
+=09=09=09clock-latency-ns =3D <200000>;
+=09=09};
+=09};
+
+=09cluster1_opp: opp_table1 {
+=09=09compatible =3D "operating-points-v2-kryo-cpu";
+=09=09nvmem-cells =3D <&speedbin_efuse>;
+=09=09opp-shared;
+
+=09=09opp-307200000 {
+=09=09=09opp-hz =3D /bits/ 64 <307200000>;
+=09=09=09opp-supported-hw =3D <0x7>;
+=09=09=09clock-latency-ns =3D <200000>;
+=09=09};
+=09=09opp-384000000 {
+=09=09=09opp-hz =3D /bits/ 64 <384000000>;
+=09=09=09opp-supported-hw =3D <0x7>;
+=09=09=09clock-latency-ns =3D <200000>;
+=09=09};
+=09=09opp-460800000 {
+=09=09=09opp-hz =3D /bits/ 64 <460800000>;
+=09=09=09opp-supported-hw =3D <0x7>;
+=09=09=09clock-latency-ns =3D <200000>;
+=09=09};
+=09=09opp-537600000 {
+=09=09=09opp-hz =3D /bits/ 64 <537600000>;
+=09=09=09opp-supported-hw =3D <0x7>;
+=09=09=09clock-latency-ns =3D <200000>;
+=09=09};
+=09=09opp-614400000 {
+=09=09=09opp-hz =3D /bits/ 64 <614400000>;
+=09=09=09opp-supported-hw =3D <0x7>;
+=09=09=09clock-latency-ns =3D <200000>;
+=09=09};
+=09=09opp-691200000 {
+=09=09=09opp-hz =3D /bits/ 64 <691200000>;
+=09=09=09opp-supported-hw =3D <0x7>;
+=09=09=09clock-latency-ns =3D <200000>;
+=09=09};
+=09=09opp-748800000 {
+=09=09=09opp-hz =3D /bits/ 64 <748800000>;
+=09=09=09opp-supported-hw =3D <0x7>;
+=09=09=09clock-latency-ns =3D <200000>;
+=09=09};
+=09=09opp-825600000 {
+=09=09=09opp-hz =3D /bits/ 64 <825600000>;
+=09=09=09opp-supported-hw =3D <0x7>;
+=09=09=09clock-latency-ns =3D <200000>;
+=09=09};
+=09=09opp-902400000 {
+=09=09=09opp-hz =3D /bits/ 64 <902400000>;
+=09=09=09opp-supported-hw =3D <0x7>;
+=09=09=09clock-latency-ns =3D <200000>;
+=09=09};
+=09=09opp-979200000 {
+=09=09=09opp-hz =3D /bits/ 64 <979200000>;
+=09=09=09opp-supported-hw =3D <0x7>;
+=09=09=09clock-latency-ns =3D <200000>;
+=09=09};
+=09=09opp-1056000000 {
+=09=09=09opp-hz =3D /bits/ 64 <1056000000>;
+=09=09=09opp-supported-hw =3D <0x7>;
+=09=09=09clock-latency-ns =3D <200000>;
+=09=09};
+=09=09opp-1132800000 {
+=09=09=09opp-hz =3D /bits/ 64 <1132800000>;
+=09=09=09opp-supported-hw =3D <0x7>;
+=09=09=09clock-latency-ns =3D <200000>;
+=09=09};
+=09=09opp-1209600000 {
+=09=09=09opp-hz =3D /bits/ 64 <1209600000>;
+=09=09=09opp-supported-hw =3D <0x7>;
+=09=09=09clock-latency-ns =3D <200000>;
+=09=09};
+=09=09opp-1286400000 {
+=09=09=09opp-hz =3D /bits/ 64 <1286400000>;
+=09=09=09opp-supported-hw =3D <0x7>;
+=09=09=09clock-latency-ns =3D <200000>;
+=09=09};
+=09=09opp-1363200000 {
+=09=09=09opp-hz =3D /bits/ 64 <1363200000>;
+=09=09=09opp-supported-hw =3D <0x7>;
+=09=09=09clock-latency-ns =3D <200000>;
+=09=09};
+=09=09opp-1440000000 {
+=09=09=09opp-hz =3D /bits/ 64 <1440000000>;
+=09=09=09opp-supported-hw =3D <0x7>;
+=09=09=09clock-latency-ns =3D <200000>;
+=09=09};
+=09=09opp-1516800000 {
+=09=09=09opp-hz =3D /bits/ 64 <1516800000>;
+=09=09=09opp-supported-hw =3D <0x7>;
+=09=09=09clock-latency-ns =3D <200000>;
+=09=09};
+=09=09opp-1593600000 {
+=09=09=09opp-hz =3D /bits/ 64 <1593600000>;
+=09=09=09opp-supported-hw =3D <0x7>;
+=09=09=09clock-latency-ns =3D <200000>;
+=09=09};
+=09=09opp-1670400000 {
+=09=09=09opp-hz =3D /bits/ 64 <1670400000>;
+=09=09=09opp-supported-hw =3D <0x7>;
+=09=09=09clock-latency-ns =3D <200000>;
+=09=09};
+=09=09opp-1747200000 {
+=09=09=09opp-hz =3D /bits/ 64 <1747200000>;
+=09=09=09opp-supported-hw =3D <0x7>;
+=09=09=09clock-latency-ns =3D <200000>;
+=09=09};
+=09=09opp-1824000000 {
+=09=09=09opp-hz =3D /bits/ 64 <1824000000>;
+=09=09=09opp-supported-hw =3D <0x7>;
+=09=09=09clock-latency-ns =3D <200000>;
+=09=09};
+=09=09opp-1900800000 {
+=09=09=09opp-hz =3D /bits/ 64 <1900800000>;
+=09=09=09opp-supported-hw =3D <0x7>;
+=09=09=09clock-latency-ns =3D <200000>;
+=09=09};
+=09=09opp-1977600000 {
+=09=09=09opp-hz =3D /bits/ 64 <1977600000>;
+=09=09=09opp-supported-hw =3D <0x3>;
+=09=09=09clock-latency-ns =3D <200000>;
+=09=09};
+=09=09opp-2054400000 {
+=09=09=09opp-hz =3D /bits/ 64 <2054400000>;
+=09=09=09opp-supported-hw =3D <0x3>;
+=09=09=09clock-latency-ns =3D <200000>;
+=09=09};
+=09=09opp-2150400000 {
+=09=09=09opp-hz =3D /bits/ 64 <2150400000>;
+=09=09=09opp-supported-hw =3D <0x3>;
+=09=09=09clock-latency-ns =3D <200000>;
+=09=09};
+=09=09opp-2246400000 {
+=09=09=09opp-hz =3D /bits/ 64 <2246400000>;
+=09=09=09opp-supported-hw =3D <0x1>;
+=09=09=09clock-latency-ns =3D <200000>;
+=09=09};
+=09=09opp-2342400000 {
+=09=09=09opp-hz =3D /bits/ 64 <2342400000>;
+=09=09=09opp-supported-hw =3D <0x1>;
+=09=09=09clock-latency-ns =3D <200000>;
+=09=09};
+=09};
+};
+
+&gpu_opp_table {
+=09/*
+=09 * All MSM8996 GPU OPPs are available on MSM8996 Pro,
+=09 * in addition to one:
+=09 */
+=09opp-652800000 {
+=09=09opp-hz =3D /bits/ 64 <652800000>;
+=09=09opp-supported-hw =3D <0x1>;
+=09};
+};
+
+&kryocc {
+=09compatible =3D "qcom,msm8996pro-apcc";
+};
--
2.35.1

