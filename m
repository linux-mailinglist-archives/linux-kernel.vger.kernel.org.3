Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 912BD4FA26B
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 06:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240801AbiDIEUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 00:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239169AbiDIEUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 00:20:39 -0400
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47405DAFF4;
        Fri,  8 Apr 2022 21:18:34 -0700 (PDT)
Date:   Sat, 09 Apr 2022 04:18:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1649477906;
        bh=U8tO9Uhx7aZ+Pgz6/NCzhtoBXj9rP0uBOrQKLUzwmWM=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID;
        b=wPjR91ZkD46y7ThmPzkK+l+0OF+IGAPNI5jhaw6xgRQ+yAI3VAG/iWpa0UJSd7Y0e
         lZhPiMfGOcWr7Di8vhcA2vuG+zO9BDmW5EdWqNgAMLI8xh4b9yZle3D2Ho/DQertnC
         6anlEkeRRekGJ9Hif+m3FKImrQi3Jtl8wwg6KB1zUKDaRp9pYbmrKeaFFRDEj+46Nl
         prWkVLdFS2hW3g2goylh17jXmhdZyfY5G9ZmOe8wBVbCuxY4iUnqyWfE+hvEn5y0yL
         KYutgCcUDWY5G5QeUg1FS6iqQZiDyhKmAR2sDLIyDKBXwPjfsUinvOxEGqDICrKpJU
         Nl8ApQNZTGOaw==
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
Subject: [PATCH v2 6/9] arm64: dts: qcom: msm8996: Remove MSM8996 Pro speed bins from cluster OPP tables
Message-ID: <deu5V6KmodOfeN73k_rpdUq7HRgepFlptThaAuPcJOVkx8GAR-k8c216zSFqvWPgvYqN1Xb4ZJlOWEzTJIUdtAKGFcSxZ3SRQnaopVo6ZVU=@protonmail.com>
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

Now that qcom-cpufreq-nvmem doesn't use SMEM to combine both MSM8996
and MSM8996 Pro speed bins into the same supported-hw bitmask, remove
bits 4,5,6 from all opp-supported-hw in cluster OPPs. These bits will
be placed in a separate device tree for MSM8996 Pro.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 82 +++++++++++++--------------
 1 file changed, 41 insertions(+), 41 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qc=
om/msm8996.dtsi
index 6fb3ef9df05b..5695671bb934 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -142,82 +142,82 @@ cluster0_opp: opp-table-cluster0 {
 =09=09/* Nominal fmax for now */
 =09=09opp-307200000 {
 =09=09=09opp-hz =3D /bits/ 64 <307200000>;
-=09=09=09opp-supported-hw =3D <0x77>;
+=09=09=09opp-supported-hw =3D <0x7>;
 =09=09=09clock-latency-ns =3D <200000>;
 =09=09};
 =09=09opp-422400000 {
 =09=09=09opp-hz =3D /bits/ 64 <422400000>;
-=09=09=09opp-supported-hw =3D <0x77>;
+=09=09=09opp-supported-hw =3D <0x7>;
 =09=09=09clock-latency-ns =3D <200000>;
 =09=09};
 =09=09opp-480000000 {
 =09=09=09opp-hz =3D /bits/ 64 <480000000>;
-=09=09=09opp-supported-hw =3D <0x77>;
+=09=09=09opp-supported-hw =3D <0x7>;
 =09=09=09clock-latency-ns =3D <200000>;
 =09=09};
 =09=09opp-556800000 {
 =09=09=09opp-hz =3D /bits/ 64 <556800000>;
-=09=09=09opp-supported-hw =3D <0x77>;
+=09=09=09opp-supported-hw =3D <0x7>;
 =09=09=09clock-latency-ns =3D <200000>;
 =09=09};
 =09=09opp-652800000 {
 =09=09=09opp-hz =3D /bits/ 64 <652800000>;
-=09=09=09opp-supported-hw =3D <0x77>;
+=09=09=09opp-supported-hw =3D <0x7>;
 =09=09=09clock-latency-ns =3D <200000>;
 =09=09};
 =09=09opp-729600000 {
 =09=09=09opp-hz =3D /bits/ 64 <729600000>;
-=09=09=09opp-supported-hw =3D <0x77>;
+=09=09=09opp-supported-hw =3D <0x7>;
 =09=09=09clock-latency-ns =3D <200000>;
 =09=09};
 =09=09opp-844800000 {
 =09=09=09opp-hz =3D /bits/ 64 <844800000>;
-=09=09=09opp-supported-hw =3D <0x77>;
+=09=09=09opp-supported-hw =3D <0x7>;
 =09=09=09clock-latency-ns =3D <200000>;
 =09=09};
 =09=09opp-960000000 {
 =09=09=09opp-hz =3D /bits/ 64 <960000000>;
-=09=09=09opp-supported-hw =3D <0x77>;
+=09=09=09opp-supported-hw =3D <0x7>;
 =09=09=09clock-latency-ns =3D <200000>;
 =09=09};
 =09=09opp-1036800000 {
 =09=09=09opp-hz =3D /bits/ 64 <1036800000>;
-=09=09=09opp-supported-hw =3D <0x77>;
+=09=09=09opp-supported-hw =3D <0x7>;
 =09=09=09clock-latency-ns =3D <200000>;
 =09=09};
 =09=09opp-1113600000 {
 =09=09=09opp-hz =3D /bits/ 64 <1113600000>;
-=09=09=09opp-supported-hw =3D <0x77>;
+=09=09=09opp-supported-hw =3D <0x7>;
 =09=09=09clock-latency-ns =3D <200000>;
 =09=09};
 =09=09opp-1190400000 {
 =09=09=09opp-hz =3D /bits/ 64 <1190400000>;
-=09=09=09opp-supported-hw =3D <0x77>;
+=09=09=09opp-supported-hw =3D <0x7>;
 =09=09=09clock-latency-ns =3D <200000>;
 =09=09};
 =09=09opp-1228800000 {
 =09=09=09opp-hz =3D /bits/ 64 <1228800000>;
-=09=09=09opp-supported-hw =3D <0x77>;
+=09=09=09opp-supported-hw =3D <0x7>;
 =09=09=09clock-latency-ns =3D <200000>;
 =09=09};
 =09=09opp-1324800000 {
 =09=09=09opp-hz =3D /bits/ 64 <1324800000>;
-=09=09=09opp-supported-hw =3D <0x77>;
+=09=09=09opp-supported-hw =3D <0x7>;
 =09=09=09clock-latency-ns =3D <200000>;
 =09=09};
 =09=09opp-1401600000 {
 =09=09=09opp-hz =3D /bits/ 64 <1401600000>;
-=09=09=09opp-supported-hw =3D <0x77>;
+=09=09=09opp-supported-hw =3D <0x7>;
 =09=09=09clock-latency-ns =3D <200000>;
 =09=09};
 =09=09opp-1478400000 {
 =09=09=09opp-hz =3D /bits/ 64 <1478400000>;
-=09=09=09opp-supported-hw =3D <0x77>;
+=09=09=09opp-supported-hw =3D <0x7>;
 =09=09=09clock-latency-ns =3D <200000>;
 =09=09};
 =09=09opp-1593600000 {
 =09=09=09opp-hz =3D /bits/ 64 <1593600000>;
-=09=09=09opp-supported-hw =3D <0x77>;
+=09=09=09opp-supported-hw =3D <0x7>;
 =09=09=09clock-latency-ns =3D <200000>;
 =09=09};
 =09};
@@ -230,127 +230,127 @@ cluster1_opp: opp-table-cluster1 {
 =09=09/* Nominal fmax for now */
 =09=09opp-307200000 {
 =09=09=09opp-hz =3D /bits/ 64 <307200000>;
-=09=09=09opp-supported-hw =3D <0x77>;
+=09=09=09opp-supported-hw =3D <0x7>;
 =09=09=09clock-latency-ns =3D <200000>;
 =09=09};
 =09=09opp-403200000 {
 =09=09=09opp-hz =3D /bits/ 64 <403200000>;
-=09=09=09opp-supported-hw =3D <0x77>;
+=09=09=09opp-supported-hw =3D <0x7>;
 =09=09=09clock-latency-ns =3D <200000>;
 =09=09};
 =09=09opp-480000000 {
 =09=09=09opp-hz =3D /bits/ 64 <480000000>;
-=09=09=09opp-supported-hw =3D <0x77>;
+=09=09=09opp-supported-hw =3D <0x7>;
 =09=09=09clock-latency-ns =3D <200000>;
 =09=09};
 =09=09opp-556800000 {
 =09=09=09opp-hz =3D /bits/ 64 <556800000>;
-=09=09=09opp-supported-hw =3D <0x77>;
+=09=09=09opp-supported-hw =3D <0x7>;
 =09=09=09clock-latency-ns =3D <200000>;
 =09=09};
 =09=09opp-652800000 {
 =09=09=09opp-hz =3D /bits/ 64 <652800000>;
-=09=09=09opp-supported-hw =3D <0x77>;
+=09=09=09opp-supported-hw =3D <0x7>;
 =09=09=09clock-latency-ns =3D <200000>;
 =09=09};
 =09=09opp-729600000 {
 =09=09=09opp-hz =3D /bits/ 64 <729600000>;
-=09=09=09opp-supported-hw =3D <0x77>;
+=09=09=09opp-supported-hw =3D <0x7>;
 =09=09=09clock-latency-ns =3D <200000>;
 =09=09};
 =09=09opp-806400000 {
 =09=09=09opp-hz =3D /bits/ 64 <806400000>;
-=09=09=09opp-supported-hw =3D <0x77>;
+=09=09=09opp-supported-hw =3D <0x7>;
 =09=09=09clock-latency-ns =3D <200000>;
 =09=09};
 =09=09opp-883200000 {
 =09=09=09opp-hz =3D /bits/ 64 <883200000>;
-=09=09=09opp-supported-hw =3D <0x77>;
+=09=09=09opp-supported-hw =3D <0x7>;
 =09=09=09clock-latency-ns =3D <200000>;
 =09=09};
 =09=09opp-940800000 {
 =09=09=09opp-hz =3D /bits/ 64 <940800000>;
-=09=09=09opp-supported-hw =3D <0x77>;
+=09=09=09opp-supported-hw =3D <0x7>;
 =09=09=09clock-latency-ns =3D <200000>;
 =09=09};
 =09=09opp-1036800000 {
 =09=09=09opp-hz =3D /bits/ 64 <1036800000>;
-=09=09=09opp-supported-hw =3D <0x77>;
+=09=09=09opp-supported-hw =3D <0x7>;
 =09=09=09clock-latency-ns =3D <200000>;
 =09=09};
 =09=09opp-1113600000 {
 =09=09=09opp-hz =3D /bits/ 64 <1113600000>;
-=09=09=09opp-supported-hw =3D <0x77>;
+=09=09=09opp-supported-hw =3D <0x7>;
 =09=09=09clock-latency-ns =3D <200000>;
 =09=09};
 =09=09opp-1190400000 {
 =09=09=09opp-hz =3D /bits/ 64 <1190400000>;
-=09=09=09opp-supported-hw =3D <0x77>;
+=09=09=09opp-supported-hw =3D <0x7>;
 =09=09=09clock-latency-ns =3D <200000>;
 =09=09};
 =09=09opp-1248000000 {
 =09=09=09opp-hz =3D /bits/ 64 <1248000000>;
-=09=09=09opp-supported-hw =3D <0x77>;
+=09=09=09opp-supported-hw =3D <0x7>;
 =09=09=09clock-latency-ns =3D <200000>;
 =09=09};
 =09=09opp-1324800000 {
 =09=09=09opp-hz =3D /bits/ 64 <1324800000>;
-=09=09=09opp-supported-hw =3D <0x77>;
+=09=09=09opp-supported-hw =3D <0x7>;
 =09=09=09clock-latency-ns =3D <200000>;
 =09=09};
 =09=09opp-1401600000 {
 =09=09=09opp-hz =3D /bits/ 64 <1401600000>;
-=09=09=09opp-supported-hw =3D <0x77>;
+=09=09=09opp-supported-hw =3D <0x7>;
 =09=09=09clock-latency-ns =3D <200000>;
 =09=09};
 =09=09opp-1478400000 {
 =09=09=09opp-hz =3D /bits/ 64 <1478400000>;
-=09=09=09opp-supported-hw =3D <0x77>;
+=09=09=09opp-supported-hw =3D <0x7>;
 =09=09=09clock-latency-ns =3D <200000>;
 =09=09};
 =09=09opp-1555200000 {
 =09=09=09opp-hz =3D /bits/ 64 <1555200000>;
-=09=09=09opp-supported-hw =3D <0x77>;
+=09=09=09opp-supported-hw =3D <0x7>;
 =09=09=09clock-latency-ns =3D <200000>;
 =09=09};
 =09=09opp-1632000000 {
 =09=09=09opp-hz =3D /bits/ 64 <1632000000>;
-=09=09=09opp-supported-hw =3D <0x77>;
+=09=09=09opp-supported-hw =3D <0x7>;
 =09=09=09clock-latency-ns =3D <200000>;
 =09=09};
 =09=09opp-1708800000 {
 =09=09=09opp-hz =3D /bits/ 64 <1708800000>;
-=09=09=09opp-supported-hw =3D <0x77>;
+=09=09=09opp-supported-hw =3D <0x7>;
 =09=09=09clock-latency-ns =3D <200000>;
 =09=09};
 =09=09opp-1785600000 {
 =09=09=09opp-hz =3D /bits/ 64 <1785600000>;
-=09=09=09opp-supported-hw =3D <0x77>;
+=09=09=09opp-supported-hw =3D <0x7>;
 =09=09=09clock-latency-ns =3D <200000>;
 =09=09};
 =09=09opp-1824000000 {
 =09=09=09opp-hz =3D /bits/ 64 <1824000000>;
-=09=09=09opp-supported-hw =3D <0x77>;
+=09=09=09opp-supported-hw =3D <0x7>;
 =09=09=09clock-latency-ns =3D <200000>;
 =09=09};
 =09=09opp-1920000000 {
 =09=09=09opp-hz =3D /bits/ 64 <1920000000>;
-=09=09=09opp-supported-hw =3D <0x77>;
+=09=09=09opp-supported-hw =3D <0x7>;
 =09=09=09clock-latency-ns =3D <200000>;
 =09=09};
 =09=09opp-1996800000 {
 =09=09=09opp-hz =3D /bits/ 64 <1996800000>;
-=09=09=09opp-supported-hw =3D <0x77>;
+=09=09=09opp-supported-hw =3D <0x7>;
 =09=09=09clock-latency-ns =3D <200000>;
 =09=09};
 =09=09opp-2073600000 {
 =09=09=09opp-hz =3D /bits/ 64 <2073600000>;
-=09=09=09opp-supported-hw =3D <0x77>;
+=09=09=09opp-supported-hw =3D <0x7>;
 =09=09=09clock-latency-ns =3D <200000>;
 =09=09};
 =09=09opp-2150400000 {
 =09=09=09opp-hz =3D /bits/ 64 <2150400000>;
-=09=09=09opp-supported-hw =3D <0x77>;
+=09=09=09opp-supported-hw =3D <0x7>;
 =09=09=09clock-latency-ns =3D <200000>;
 =09=09};
 =09};
--
2.35.1

