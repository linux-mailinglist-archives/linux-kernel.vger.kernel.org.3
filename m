Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A89D9484267
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 14:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233569AbiADN2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 08:28:15 -0500
Received: from mail-0301.mail-europe.com ([188.165.51.139]:57625 "EHLO
        mail-0301.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbiADN2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 08:28:07 -0500
Date:   Tue, 04 Jan 2022 13:27:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail2; t=1641302883;
        bh=3X5n8MBArw9+bXt6ARg+ayrMy1Es+lxMQ0jQMneoxpg=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc;
        b=etEd2xN57xgLkXUe+BqjdkZ68xHTiQsfYiAAWUpkg8vrE8tmMhD4HSqqKFvGtEkX4
         Bil2Zfrp5/4A65sc94RECToh6MyKT3+qKiL0JSOL0AU4BQgIwuXDXo1uARTucluDSh
         hg4cJHpBxUuT2f9CtAfqXJKvaqDag5TS2Snq/c+rQVJ1IyC0ieAboe5BrJTyzoKtHY
         mPnT2zcQbJtRVraTA7/wFJgDZOKHFJjqRQZfW69+nuq6p3y2d73K5fwYfAGu4dvOA8
         +GUU1/SKExq9bZXZK/Rba/LB8NDTt8s5FB92UppW1gmTUMzP5Znx7t87+G5C7TnRjs
         4nvSlCu5LCV4A==
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
Subject: [PATCH 1/7] dt-bindings: arm: qcom: Add msm8996 and apq8096 compatibles
Message-ID: <20220104132618.391799-2-y.oudjana@protonmail.com>
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

Add compatibles for MSM8996 and APQ8096 and all supported devices
that have them.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentatio=
n/devicetree/bindings/arm/qcom.yaml
index 04ff0b55bb85..da6b2608f10b 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -172,7 +172,21 @@ properties:
           - const: qcom,apq8094
=20
       - items:
-          - const: qcom,msm8996-mtp
+          - enum:
+              - arrow,apq8096-db820c
+              - inforce,ifc6640
+          - const: qcom,apq8096-sbc
+          - const: qcom,apq8096
+
+      - items:
+          - enum:
+              - qcom,msm8996-mtp
+              - sony,dora-row
+              - sony,kagura-row
+              - sony,keyaki-row
+              - xiaomi,gemini
+              - xiaomi,scorpio
+          - const: qcom,msm8996
=20
       - items:
           - enum:
--=20
2.34.1


