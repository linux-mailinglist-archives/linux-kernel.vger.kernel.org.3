Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F244F4F0E7D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 07:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377303AbiDDFGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 01:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377283AbiDDFGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 01:06:34 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 745AA340F9;
        Sun,  3 Apr 2022 22:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649048680; x=1680584680;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=584gxbE7qmUjxyiXbeyOwNuQgni0eenLmMpZKOsgTKk=;
  b=TKswPqB2hqgGNRB2SKTdETqkQf6P5jwO9TXsTgNnRrqjMhRRIO/JgD5S
   khxXrv2JCnNwRJN7RTq/7DOlOXmgw9imYRUBpdkwNpSw7Y/oZcanY81dN
   IPY/46W+g0aF+w1xjr3UzwwIHEjzgbvdRZykzwI/Kg1jjrTt+oFDN+OZ3
   c=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 03 Apr 2022 22:04:39 -0700
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 03 Apr 2022 22:04:37 -0700
X-QCInternal: smtphost
Received: from hu-rohiagar-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.106.138])
  by ironmsg01-blr.qualcomm.com with ESMTP; 04 Apr 2022 10:34:21 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id 04D053943; Mon,  4 Apr 2022 10:34:20 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        linus.walleij@linaro.org, robh+dt@kernel.org, krzk+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH 1/2] dt-bindings: pinctrl: qcom-pmic-gpio: Add pmx65 support
Date:   Mon,  4 Apr 2022 10:34:09 +0530
Message-Id: <1649048650-14059-2-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1649048650-14059-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1649048650-14059-1-git-send-email-quic_rohiagar@quicinc.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the PMX65 GPIO support to the Qualcomm PMIC GPIO
binding.

Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
---
 Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
index fe2bcf0..22dbcba 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
@@ -53,6 +53,7 @@ properties:
           - qcom,pmr735b-gpio
           - qcom,pms405-gpio
           - qcom,pmx55-gpio
+          - qcom,pmx65-gpio
 
       - enum:
           - qcom,spmi-gpio
@@ -140,6 +141,7 @@ $defs:
                                             and gpio10)
                  - gpio1-gpio11 for pmx55 (holes on gpio3, gpio7, gpio10
                                             and gpio11)
+                 - gpio1-gpio16 for pmx65
 
         items:
           pattern: "^gpio([0-9]+)$"
-- 
2.7.4

