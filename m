Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 188E24A7FCF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 08:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349389AbiBCH0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 02:26:42 -0500
Received: from mail-4027.protonmail.ch ([185.70.40.27]:30561 "EHLO
        mail-4027.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239780AbiBCH0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 02:26:40 -0500
Date:   Thu, 03 Feb 2022 07:26:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail2; t=1643873199;
        bh=sR/YQB+9UhT4OEEpJHtDhmgJhmBoOU3G+c+isEuYc2M=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc;
        b=L7I8i48AEjkvaGzpqm67XPHRxmYUv74nDisBs2akkn/5Bt+FYV8WzT9LTonnzNiYc
         p+G4RY0/s22DToWqP12Ftb4eFSZB/FGOEns4BSYqHqBUC/WNhBJr2syvMFTIf2wwzv
         yfs7puyGNP3UajyIMGRmThrY0JupX3Nx9T92o2fIKgthYYfDgorgxN4zNV7KP5xIu5
         T+BMHcXhZqGJOZZPA96h+xz5ZNnq96d1JktgpuhBrOPXgONkD8oqUGmg4PLIvYzUxx
         N778Q3Kmn6cZ6pHJSvECWXgivUQDXCjNN1u0BPbEegVTKX/xEGNEHm4gJ+giUo85qL
         NCEmOrhmg8hag==
To:     Rob Herring <robh@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org
From:   Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-kernel@vger.kernel.org
Reply-To: Yassine Oudjana <y.oudjana@protonmail.com>
Subject: [PATCH RESEND v3 5/7] arm64: dts: qcom: msm8996: Rename cluster OPP tables
Message-ID: <20220203072226.51482-6-y.oudjana@protonmail.com>
In-Reply-To: <20220203072226.51482-1-y.oudjana@protonmail.com>
References: <20220203072226.51482-1-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        T_SCC_BODY_TEXT_LINE shortcircuit=no autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename cluster OPP table node names to match the nodename pattern
defined in the opp-v2-base DT schema.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qc=
om/msm8996.dtsi
index 91bc974aeb0a..036de52c54f1 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -134,7 +134,7 @@ CPU_SLEEP_0: cpu-sleep-0 {
 =09=09};
 =09};
=20
-=09cluster0_opp: opp_table0 {
+=09cluster0_opp: opp-table-cluster0 {
 =09=09compatible =3D "operating-points-v2-kryo-cpu";
 =09=09nvmem-cells =3D <&speedbin_efuse>;
 =09=09opp-shared;
@@ -222,7 +222,7 @@ opp-1593600000 {
 =09=09};
 =09};
=20
-=09cluster1_opp: opp_table1 {
+=09cluster1_opp: opp-table-cluster1 {
 =09=09compatible =3D "operating-points-v2-kryo-cpu";
 =09=09nvmem-cells =3D <&speedbin_efuse>;
 =09=09opp-shared;
--=20
2.34.1


