Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE044B2592
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 13:24:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349969AbiBKMY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 07:24:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349957AbiBKMY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 07:24:28 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7574ADC3;
        Fri, 11 Feb 2022 04:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644582266; x=1676118266;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=u0NFQSqU8nFRCacBmC6t3+7/vZNIdJqiy1WnYmvJT2E=;
  b=OnocrvH6198AAB4hbENghshtnMOZ+D+AdohIpYa+TK5WfSBXcM5Xr1kT
   MAozqHKWNxQMfg8KNrYgri5wZ/YcO5iJ1XFhS/XtrA1HJ3fqIOQ3FIn+r
   I8qBEBODFlJ85TOfAozQ3TGUXHD4GUJ8+bCBzrMcWSF8eIOCptkX8vNcN
   U=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 11 Feb 2022 04:24:26 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 04:24:25 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 11 Feb 2022 04:24:25 -0800
Received: from blr-ubuntu-525.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Fri, 11 Feb 2022 04:24:20 -0800
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
To:     <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <pure.logic@nexus-software.ie>,
        <bjorn.andersson@linaro.org>, <greg@kroah.com>, <robh@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <quic_tsoni@quicinc.com>,
        <quic_psodagud@quicinc.com>, <quic_satyap@quicinc.com>,
        <quic_pheragu@quicinc.com>, <quic_rjendra@quicinc.com>,
        <quic_sibis@quicinc.com>, <quic_saipraka@quicinc.com>,
        <quic_schowdhu@quicinc.com>
Subject: [PATCH V7] MAINTAINERS: Add maintainer entry for EUD
Date:   Fri, 11 Feb 2022 17:53:44 +0530
Message-ID: <b7a9d113f610e2edf67c6a813fc173b1857b9919.1644580972.git.quic_schowdhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
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

Add the entry for maintainer for EUD driver
and other associated files.

Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes in V7

* Added the Maintainer entry in the sorted order.

Changes in V6

* Added the review tags from V5 and moved qcom_eud.c to drivers/usb/misc.

Changes in V5

* Added the review tags and implemented comments on V4 of the patch.

Changes in V4

* Aligned the device tree node structure of EUD as per discussion.

* Changes to usb-connector.yaml is no longer required and is not
  included in the patch series.

* Implemented the rest of the comments on Version 3 of the patch.

Changes in V3

* Removed the patch for registration of EUD connector as it is no longer
  required.

* Added the description to include EUD in usb-connector.yaml

* Implemented comments on V2 of the patch.

Changes in V2

* Fixed the yaml issue and also implemented comments on yaml in V1.

Changes in V1

* EUD has now been mapped as a separate DT node as it is an independent QCOM IP.

* EUD is attached to the connector child of dwc3 via port end point since EUD
  driver needs the connector for role-switching.

* EUD driver has been moved now to drivers/soc/qcom/qcom_eud.c.

* All the comments from version 0 of the patch has been implemented.

---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 68f21d4..fe43371 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13981,6 +13981,14 @@ L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 S:	Supported
 F:	sound/soc/qcom/

+QCOM EMBEDDED USB DEBUGGER(EUD)
+M:	Souradeep Chowdhury <quic_schowdhu@quicinc.com>
+L:	linux-arm-msm@vger.kernel.org
+S:	Maintained
+F:	Documentation/ABI/testing/sysfs-driver-eud
+F:	Documentation/devicetree/bindings/soc/qcom/qcom,eud.yaml
+F:	drivers/usb/misc/qcom_eud.c
+
 QCOM IPA DRIVER
 M:	Alex Elder <elder@kernel.org>
 L:	netdev@vger.kernel.org
--
2.7.4

