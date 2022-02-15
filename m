Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0B44B77B8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243623AbiBOTUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 14:20:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235134AbiBOTT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 14:19:56 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8305113DA1;
        Tue, 15 Feb 2022 11:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644952785; x=1676488785;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=VqmqdFqQfU3ky6dw6FWZJiZ19fu4Cs3hMyuJyVnXJtE=;
  b=QEBlr7lBq/44ak8DiFXdk6jmuM5oDD9EIDLcp/+TgjqB70u2gT99ckGo
   2TAp8hSxrhfGn9iZBFUY3VA4wNDSYxsYAoNkru1JSLPYj5zwRP1sywRNQ
   6qZPvc7XeMiQ6e7djOcTtYAzTjerQ6/f0DONJMNZVLLezTcqYrXKja0pN
   M=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 15 Feb 2022 11:19:45 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 11:19:45 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 15 Feb 2022 11:19:44 -0800
Received: from c-sanm-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 15 Feb 2022 11:19:38 -0800
From:   Sandeep Maheswaram <quic_c_sanm@quicinc.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wesley Cheng <wcheng@codeaurora.org>,
        "Stephen Boyd" <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        "Matthias Kaehlcke" <mka@chromium.org>
CC:     <evicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <linux-usb@vger.kernel.org>, <quic_pkondeti@quicinc.com>,
        <quic_ppratap@quicinc.com>,
        Sandeep Maheswaram <quic_c_sanm@quicinc.com>
Subject: [PATCH 1/3] dt-bindings: phy: qcom,usb-snps-femto-v2: Add phy override params bindings
Date:   Wed, 16 Feb 2022 00:49:13 +0530
Message-ID: <1644952755-15527-2-git-send-email-quic_c_sanm@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1644952755-15527-1-git-send-email-quic_c_sanm@quicinc.com>
References: <1644952755-15527-1-git-send-email-quic_c_sanm@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for overriding SNPS phy tuning parameters in device tree
bindings.

Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
---
 .../devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml  | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml b/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
index 0dfe691..44cf3bf 100644
--- a/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
@@ -50,6 +50,22 @@ properties:
   vdda33-supply:
     description: phandle to the regulator 3.3V supply node.
 
+  qcom,override_x0:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Override value for hs disconnect and squelch detector threshold.
+
+  qcom,override_x1:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Override value for hs amplitude, pre-emphasis duration and amplitude.
+
+  qcom,override_x2:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Override value for hs rise/fall time, cross over voltage, output impedance.
+
+  qcom,override_x3:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Override value for ls/fs output impedance.
+
 required:
   - compatible
   - reg
-- 
2.7.4

