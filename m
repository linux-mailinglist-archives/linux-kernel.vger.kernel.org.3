Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0CA4A8278
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 11:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350127AbiBCKgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 05:36:15 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:38630 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349980AbiBCKgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 05:36:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1643884570; x=1675420570;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=ijsmehNMI2+B/KXb/s5HerwlB555lt5C7U7VoLIaUvQ=;
  b=G8J4PdJLC8PrXWSbQSwid6/B9zH6J9NcKxTLb25oqJJV3ul3iNxla9Nx
   3jqct0ahtG4p/K2vED2dV3utrB8kXra8/EBCAuoGfqU4hA2LPt00U13/A
   HlRZbEu9UtKh6aZ5j2Yj5BlavicMSI1dP+pXny11cDR/afgFe+uehzhHq
   o=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 03 Feb 2022 02:36:09 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 02:36:08 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 3 Feb 2022 02:36:07 -0800
Received: from blr-ubuntu-525.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 3 Feb 2022 02:36:02 -0800
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
To:     <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <pure.logic@nexus-software.ie>,
        <bjorn.andersson@linaro.org>, <greg@kroah.com>, <robh@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <quic_tsoni@quicinc.com>,
        <quic_psodagud@quicinc.com>, <quic_satyap@quicinc.com>,
        <quic_pheragu@quicinc.com>, <quic_rjendra@quicinc.com>,
        <quic_sibis@quicinc.com>, <quic_saipraka@quicinc.com>,
        <quic_schowdhu@quicinc.com>
Subject: [PATCH V5 6/6] MAINTAINERS: Add maintainer entry for EUD
Date:   Thu, 3 Feb 2022 16:04:35 +0530
Message-ID: <a3f8925e46d88babb22879ab9e7266615ff26d12.1643880577.git.quic_schowdhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1643880577.git.quic_schowdhu@quicinc.com>
References: <cover.1643880577.git.quic_schowdhu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the entry for maintainer for EUD driver
and other associated files.

Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b84e2d5..f86ec0e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7227,6 +7227,14 @@ F:	include/uapi/linux/mdio.h
 F:	include/uapi/linux/mii.h
 F:	net/core/of_net.c
 
+QCOM EMBEDDED USB DEBUGGER(EUD)
+M:	Souradeep Chowdhury <quic_schowdhu@quicinc.com>
+L:	linux-arm-msm@vger.kernel.org
+S:	Maintained
+F:	Documentation/ABI/testing/sysfs-driver-eud
+F:	Documentation/devicetree/bindings/soc/qcom/qcom,eud.yaml
+F:	drivers/usb/common/qcom_eud.c
+
 EXEC & BINFMT API
 R:	Eric Biederman <ebiederm@xmission.com>
 R:	Kees Cook <keescook@chromium.org>
-- 
2.7.4

