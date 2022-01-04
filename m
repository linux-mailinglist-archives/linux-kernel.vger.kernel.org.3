Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 465A2484281
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 14:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233615AbiADN3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 08:29:55 -0500
Received: from mail-0301.mail-europe.com ([188.165.51.139]:56589 "EHLO
        mail-0301.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233651AbiADN3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 08:29:54 -0500
Date:   Tue, 04 Jan 2022 13:29:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail2; t=1641302990;
        bh=ddOT8Uc+zAx4EeLE9VJ+W8yoFZ2uDF6RSAmpP8fOn38=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc;
        b=v8loG2w4cAXm+7XwVjVcpfYfczMxcFecsdq8N5vv5JsXU1IVo5a0S8cwqC3OkFgY+
         O/5mUd8ikegyWfIXXE+WGcRwfcIMGDjZXa0CgGg4iOu396jACCeoHzBsZ2x+Pqb2e4
         aq95QmTsY5P59beSi9OeEi+y49+rDyJaTBndDBbJvtxqPnJtEMNYNMqQ0WvDqCUEDB
         GH6LGDCNPGiK3pKLt/R6JNGwtbja6jMmnHPByHSjNjwKk5JIfTWLTLVUQmmD3Trows
         PMM4aDAMm52ltd9ejG21Zmca4uWwsR2p2mXG24G4/OpgFDykUxUUJh/PgrF58c+V4h
         CtVpodEbZZAmw==
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
Subject: [PATCH 6/7] arm64: dts: qcom: qcs404: Rename CPU and CPR OPP tables
Message-ID: <20220104132618.391799-7-y.oudjana@protonmail.com>
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

Rename CPU and CPR OPP table node names to match the nodename pattern
defined in the opp-v2-base DT schema.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 arch/arm64/boot/dts/qcom/qcs404.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qco=
m/qcs404.dtsi
index 6db753b49326..3f06f7cd3cf2 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -110,7 +110,7 @@ CPU_SLEEP_0: cpu-sleep-0 {
 =09=09};
 =09};
=20
-=09cpu_opp_table: cpu-opp-table {
+=09cpu_opp_table: opp-table-cpu {
 =09=09compatible =3D "operating-points-v2-kryo-cpu";
 =09=09opp-shared;
=20
@@ -128,7 +128,7 @@ opp-1401600000 {
 =09=09};
 =09};
=20
-=09cpr_opp_table: cpr-opp-table {
+=09cpr_opp_table: opp-table-cpr {
 =09=09compatible =3D "operating-points-v2-qcom-level";
=20
 =09=09cpr_opp1: opp1 {
--=20
2.34.1


