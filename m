Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBB96484163
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 13:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbiADMAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 07:00:15 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:3750 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232800AbiADMAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 07:00:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1641297610; x=1672833610;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=Z4lRkDztl8kkMzv5y4vn6o4suy5hREey12tivQS1lgQ=;
  b=SU9KAVtdZdSQ7KKjehkNjExqe+beFzzvc+8t8Ffx4t33TsAPZzViv/3s
   XbWMOpIRWGhzJWQy8nsKzt53E9Kct1TwTRRxhA3p/LMpGkpgqm0td2Jgv
   jDmlfazOQnq30Dfi5ZcTj2eVbaVJS91rJmlphrQoq9u74oVJYgZiSMK3g
   Q=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 04 Jan 2022 04:00:10 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 04:00:08 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 4 Jan 2022 04:00:08 -0800
Received: from blr-ubuntu-525.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 4 Jan 2022 04:00:03 -0800
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
To:     <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <pure.logic@nexus-software.ie>,
        <bjorn.andersson@linaro.org>, <greg@kroah.com>
CC:     <linux-kernel@vger.kernel.org>, <tsoni@codeaurora.org>,
        <psodagud@codeaurora.org>, <satyap@codeaurora.org>,
        <pheragu@codeaurora.org>, <rnayak@codeaurora.org>,
        <sibis@codeaurora.org>, <saiprakash.ranjan@codeaurora.org>,
        <quic_schowdhu@quicinc.com>
Subject: [PATCH V3 7/7] MAINTAINERS: Add maintainer entry for EUD
Date:   Tue, 4 Jan 2022 17:28:20 +0530
Message-ID: <e0d3661ea69a5706ea0fec3b4a38c5cd43a2e790.1641288286.git.quic_schowdhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1641288286.git.quic_schowdhu@quicinc.com>
References: <cover.1641288286.git.quic_schowdhu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the entry for maintainer for EUD driver
and other associated files.

Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0227e15..54f616a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7018,6 +7018,14 @@ F:	include/trace/events/mdio.h
 F:	include/uapi/linux/mdio.h
 F:	include/uapi/linux/mii.h
 
+EUD-QCOM
+M:	Souradeep Chowdhury <schowdhu@codeaurora.org>
+L:	linux-arm-msm@vger.kernel.org
+S:	Maintained
+F:	Documentation/ABI/testing/sysfs-driver-eud
+F:	Documentation/devicetree/bindings/arm/msm/qcom,eud.yaml
+F:	drivers/usb/common/qcom_eud.c
+
 EXFAT FILE SYSTEM
 M:	Namjae Jeon <linkinjeon@kernel.org>
 M:	Sungjong Seo <sj1557.seo@samsung.com>
-- 
2.7.4

