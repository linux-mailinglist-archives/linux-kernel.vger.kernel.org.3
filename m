Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EEAA4C633D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 07:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233344AbiB1Gk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 01:40:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233335AbiB1Gkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 01:40:52 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626523CFFF;
        Sun, 27 Feb 2022 22:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1646030411; x=1677566411;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=bS9bdC9cgUN0ZMd9zmyc+OAsWWEL36/MhYU9UfQLxI4=;
  b=czRoWifEq68tPg+0hMRFn3us5NceC5Jn2yhAf1bXcFeiobzt5bf7G5jt
   8oMfphYgO+33DCydHU6IXnMh+uTFMOxaELtLaeii9xjASzLsBsEsHtPCL
   xHw4/m2wvDiP5JM8biHPomIVLTKsDF7UBFLJIvYEwCNlnX7JbrGZVOUxr
   Q=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 27 Feb 2022 22:40:11 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2022 22:40:09 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Sun, 27 Feb 2022 22:40:09 -0800
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Sun, 27 Feb 2022 22:40:03 -0800
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <quic_plai@quicinc.com>, <bgoswami@codeaurora.org>,
        <perex@perex.cz>, <tiwai@suse.com>,
        <srinivas.kandagatla@linaro.org>, <rohitkr@codeaurora.org>,
        <linux-arm-msm@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <swboyd@chromium.org>, <judyhsiao@chromium.org>,
        <yung-chuan.liao@linux.intel.com>,
        <pierre-louis.bossart@linux.intel.com>, <sanyog.r.kale@intel.com>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        "Venkata Prasad Potturu" <quic_potturu@quicinc.com>
Subject: [PATCH v5 2/2] dt-bindings: soundwire: qcom: Add bindings for audio CSR reset control property
Date:   Mon, 28 Feb 2022 12:09:37 +0530
Message-ID: <1646030377-12092-3-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1646030377-12092-1-git-send-email-quic_srivasam@quicinc.com>
References: <1646030377-12092-1-git-send-email-quic_srivasam@quicinc.com>
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

Update description for audio CSR reset control property, which is
required for latest chipsets to allow software enabling in CGCR HCLK register.

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
---
 Documentation/devicetree/bindings/soundwire/qcom,sdw.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/soundwire/qcom,sdw.txt b/Documentation/devicetree/bindings/soundwire/qcom,sdw.txt
index b93a2b3..84c8f54 100644
--- a/Documentation/devicetree/bindings/soundwire/qcom,sdw.txt
+++ b/Documentation/devicetree/bindings/soundwire/qcom,sdw.txt
@@ -150,6 +150,18 @@ board specific bus parameters.
 		    or applicable for the respective data port.
 		    More info in MIPI Alliance SoundWire 1.0 Specifications.
 
+- reset:
+	Usage: optional
+	Value type: <prop-encoded-array>
+	Definition: Should specify the SoundWire audio CSR reset controller interface,
+		    which is required for SoundWire version 1.6.0 and above.
+
+- reset-names:
+	Usage: optional
+	Value type: <stringlist>
+	Definition: should be "swr_audio_cgcr" for SoundWire audio CSR reset
+		    controller interface.
+
 Note:
 	More Information on detail of encoding of these fields can be
 found in MIPI Alliance SoundWire 1.0 Specifications.
-- 
2.7.4

