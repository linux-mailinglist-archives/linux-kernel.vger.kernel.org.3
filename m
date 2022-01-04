Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 304E048426C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 14:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232321AbiADN21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 08:28:27 -0500
Received: from mail-0301.mail-europe.com ([188.165.51.139]:44856 "EHLO
        mail-0301.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232228AbiADN2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 08:28:25 -0500
Date:   Tue, 04 Jan 2022 13:28:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail2; t=1641302902;
        bh=lOKwV9QwmnGefgwF0yxQqPFeIi3qE0U6ftnrx44o+cI=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc;
        b=HVwUFnGD/zBOtOTcrD9+RHsPBg3k6YopPNV1oQSP+iPYrN+wgZ5Hu6oFcUNtGygIv
         9X26HIR66xH6I2ICH5+WgM1u1kuNjUlR8FfeESvXcyxOWHc2csf/aKYUAr9gjVdFjz
         v4NaGQLLkPqDuuloizzA4ALTfhU4HMTXAO4aLbopPFZTuB02ILU1aPDUYtSavrcqIQ
         s8Y5dxlP7FyKdpK/juqVIutTrQnY+ML+JfV5gvyZ5atny/SFx7bC8WbTY0rXR+jwAQ
         qW/2HtjOQ+NlXugx0ZGApC8oDYC+eawxgrdSDR5X/ykt9hWtkSLNQnDcc62+gQ72yx
         7MpwTzeRpZP8A==
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
Subject: [PATCH 2/7] arm64: dts: qcom: msm8996-mtp: Add msm8996 compatible
Message-ID: <20220104132618.391799-3-y.oudjana@protonmail.com>
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

Add qcom,msm8996 compatible to match DT schema.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 arch/arm64/boot/dts/qcom/msm8996-mtp.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996-mtp.dts b/arch/arm64/boot/dts=
/qcom/msm8996-mtp.dts
index 7d9fc35bc7a0..6a1699a96c99 100644
--- a/arch/arm64/boot/dts/qcom/msm8996-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/msm8996-mtp.dts
@@ -9,7 +9,7 @@
=20
 / {
 =09model =3D "Qualcomm Technologies, Inc. MSM 8996 MTP";
-=09compatible =3D "qcom,msm8996-mtp";
+=09compatible =3D "qcom,msm8996-mtp", "qcom,msm8996";
=20
 =09aliases {
 =09=09serial0 =3D &blsp2_uart2;
--=20
2.34.1


