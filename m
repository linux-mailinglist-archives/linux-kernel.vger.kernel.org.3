Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D31E9577115
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 21:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbiGPT2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 15:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbiGPT15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 15:27:57 -0400
Received: from relay04.th.seeweb.it (relay04.th.seeweb.it [IPv6:2001:4b7a:2000:18::165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4803C193FA
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 12:27:54 -0700 (PDT)
Received: from localhost.localdomain (abxj77.neoplus.adsl.tpnet.pl [83.9.3.77])
        by m-r1.th.seeweb.it (Postfix) with ESMTPA id 9AB481F928;
        Sat, 16 Jul 2022 21:27:52 +0200 (CEST)
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
To:     ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: soc: qcom: qcom,smd-rpm: Add a compatible for SM6375
Date:   Sat, 16 Jul 2022 21:27:41 +0200
Message-Id: <20220716192743.454168-1-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the compatible for SM6375.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml
index cc1b35080162..3936654360d8 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml
@@ -46,6 +46,7 @@ properties:
       - qcom,rpm-sm6125
       - qcom,rpm-qcm2290
       - qcom,rpm-qcs404
+      - qcom,sm6375-rpm
 
   clock-controller:
     $ref: /schemas/clock/qcom,rpmcc.yaml#
-- 
2.37.0

