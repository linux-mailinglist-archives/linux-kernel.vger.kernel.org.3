Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B35B44FA251
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 06:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240779AbiDIESH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 00:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbiDIESC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 00:18:02 -0400
Received: from mail-40138.protonmail.ch (mail-40138.protonmail.ch [185.70.40.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA71D7474;
        Fri,  8 Apr 2022 21:15:52 -0700 (PDT)
Date:   Sat, 09 Apr 2022 04:15:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1649477750;
        bh=npXgoXRx+9HFRGd6aAeIa8FyN8+DtEfq/LX1t5DjnYM=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID;
        b=XClRdOwjDQEh4IJzkCha2WqyRgHG3KWS2CDtcJ62DLMf+vqfnzQK9qBwLU9cnzqHH
         Np9XhnoL3WLU8ZeCfQQf73K78a20rswqVajNrUO7ZQ2W9CPNpqGgep4G2irBvhJQ19
         vFMh/WRE3VxdnoCw6CUR9/jyRx0DHr+gh28KRKAEAT95kzFLRqlmGuZl609w5TJTbv
         h3ZYQA0Ao+4j4EkKyG+nIiR5IsKYY0FiPff1dFtbk+6W3QEJE72jcBzB9TheTSFEMu
         +cMM4uwzd/qyh3xQ6DPf7AdrAINf7rF6+3WdpT29y/sTBlS2+j8rf11p8tYDKqRN+7
         1abAK7v1PqFWA==
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
Subject: [PATCH v2 2/9] dt-bindings: clk: qcom: msm8996-apcc: Add MSM8996 Pro
Message-ID: <tq7Iqnh6zYv9x2YXh2KNwpIwz1do_6L9OZVHH1Wtd-HsD0vMC5bogTrq4uYfbnIOaRd2o50Q9TKa0E_oBZjPY5Vhuv3dIHfRxSc-N1Wghto=@protonmail.com>
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

Add a compatible string for msm8996pro-apcc.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/clock/qcom,msm8996-apcc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,msm8996-apcc.yaml=
 b/Documentation/devicetree/bindings/clock/qcom,msm8996-apcc.yaml
index 325f8aef53b2..ad77175dda45 100644
--- a/Documentation/devicetree/bindings/clock/qcom,msm8996-apcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,msm8996-apcc.yaml
@@ -17,6 +17,7 @@ properties:
   compatible:
     enum:
       - qcom,msm8996-apcc
+      - qcom,msm8996pro-apcc

   reg:
     items:
--
2.35.1

