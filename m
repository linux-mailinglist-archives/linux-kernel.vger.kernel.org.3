Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73D77484278
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 14:29:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233590AbiADN3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 08:29:32 -0500
Received: from mail-0301.mail-europe.com ([188.165.51.139]:46509 "EHLO
        mail-0301.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiADN3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 08:29:31 -0500
Date:   Tue, 04 Jan 2022 13:29:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail2; t=1641302967;
        bh=sR/YQB+9UhT4OEEpJHtDhmgJhmBoOU3G+c+isEuYc2M=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc;
        b=VuBt7aVyrB38xmnjFUII3WhHHLmOJULT7fk8AY3i+3Ws/08S2eWnCNUu1mPkrR5E9
         dW65Kvue8FdK9X0QtAbpirfaCooT0AWTsqJabyKsrLwwv0Anqz7A3DgTg+C1/0Lv2b
         DX6zxTqNTIWYl4HQnveWAIkhq+zMIXWwGZwssFRLlysWGm2ofwzqAMaZc5q1yb/ybS
         QK6ru1NQKknky552Yc735ys9XJe9nyqhX16J77UkRLbfA3uG+QLNjz1gcNxBDwnmKQ
         I5m7t3vxlmcgvYvRaCi5yX8i6OBuOa6A19Bdh4hcIe9MX5ih/M/gvF6jv4JWfZMhFW
         3v3dUrYfCe3Fg==
To:     Rob Herring <robh+dt@kernel.org>, Ilia Lin <ilia.lin@kernel.org>,
        Niklas Cassel <nks@flawful.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org
From:   Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-kernel@vger.kernel.org
Reply-To: Yassine Oudjana <y.oudjana@protonmail.com>
Subject: [PATCH 5/7] arm64: dts: qcom: msm8996: Rename cluster OPP tables
Message-ID: <20220104132618.391799-6-y.oudjana@protonmail.com>
In-Reply-To: <20220104132618.391799-1-y.oudjana@protonmail.com>
References: <20220104132618.391799-1-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
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


