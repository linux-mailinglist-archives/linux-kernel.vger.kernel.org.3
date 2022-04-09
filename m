Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 845294FA230
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 06:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239160AbiDIEG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 00:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233633AbiDIEGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 00:06:21 -0400
X-Greylist: delayed 160 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 08 Apr 2022 21:04:15 PDT
Received: from mail-40135.protonmail.ch (mail-40135.protonmail.ch [185.70.40.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58BA4C6F36;
        Fri,  8 Apr 2022 21:04:14 -0700 (PDT)
Date:   Sat, 09 Apr 2022 04:04:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1649477053;
        bh=Y1zqS1p1xTQlaWGJMwqSQ0yqlmiD4KsM20dmnV9xv8k=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID;
        b=PTVKZIB6SJRX0yP1yNKI1tqpRwHxrgYwk8T2OI4vSB1ZYJ9C7puN4XWO2p6IZvWID
         XkAmIkLmG7wSRhruZAqp4iIj1GQyllkenaacE9uJeoLxTZOaPjuYVBf5nCJsS8gb05
         zzbOfsgcRnd6my4P++UpFZrV2KhPBmRseiU0wnqEy7MQlsL/AwDMZe3cXtsIOpiafL
         3oCPjM8DCkC6nFOOUuIvHvuJdAbi+f7CAL9bcnG+d6phD8YIwgOF0rSgw7OlYaeyRA
         0g7bz9x5yngRnfQpPEq0k6U3oEibDoR9oDqJreeRoqr1ObVgDKY6MV07TDGXOTNVZs
         NViUkXxwAi2Wg==
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
Subject: [PATCH v2 1/9] dt-bindings: clk: qcom: msm8996-apcc: Add CBF
Message-ID: <gA4wyUQEk7ycvxLnZjHBYG8aW-XEQuaeNc-JWNFcb5DQsF-Cxc2WBwVM1IonLdFLFdwPJmAOS_G3OKghpNCvR5W5nKTigC0IAVRH19r8jnw=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add CBF clock and reg.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/clock/qcom,msm8996-apcc.yaml   | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,msm8996-apcc.yaml=
 b/Documentation/devicetree/bindings/clock/qcom,msm8996-apcc.yaml
index a20cb10636dd..325f8aef53b2 100644
--- a/Documentation/devicetree/bindings/clock/qcom,msm8996-apcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,msm8996-apcc.yaml
@@ -10,8 +10,8 @@ maintainers:
   - Loic Poulain <loic.poulain@linaro.org>

 description: |
-  Qualcomm CPU clock controller for MSM8996 CPUs, clock 0 is for Power clu=
ster
-  and clock 1 is for Perf cluster.
+  Qualcomm CPU clock controller for MSM8996 CPUs, clock 0 is for Power clu=
ster,
+  clock 1 is for Perf cluster, and clock 2 is for Coherent bus fabric (CBF=
).

 properties:
   compatible:
@@ -19,7 +19,9 @@ properties:
       - qcom,msm8996-apcc

   reg:
-    maxItems: 1
+    items:
+      - description: Cluster clock registers
+      - description: CBF clock registers

   '#clock-cells':
     const: 1
@@ -49,6 +51,6 @@ examples:
   - |
     kryocc: clock-controller@6400000 {
         compatible =3D "qcom,msm8996-apcc";
-        reg =3D <0x6400000 0x90000>;
+        reg =3D <0x6400000 0x90000>, <0x09a11000 0x10000>;
         #clock-cells =3D <1>;
     };
--
2.35.1

