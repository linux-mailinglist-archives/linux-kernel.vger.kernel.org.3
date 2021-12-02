Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3111C4660F7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 10:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356843AbhLBJ6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 04:58:22 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:27019 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1356821AbhLBJ4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 04:56:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638438812; x=1669974812;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=ApkT5CfALdPrbby3Mvv70S+36/G3OWU+coKJm3QqI+U=;
  b=h9b+8iETBrnZC79hvjEVt2LCgGwVOuMWhYXcJTklez1982F2dz3SjF3G
   cCoDr4n/W4mHZHctSDjO6m1u4ivFV3Muqrc4CERPufdy1vb8ZcTTVdjso
   HC6XAByE6cf6kMzye8MibSy76Kw583Gvk0ntXTAdbA8L5OR20zRB/zCiT
   s=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 02 Dec 2021 01:53:31 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 01:53:18 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 2 Dec 2021 01:53:14 -0800
Received: from blr-ubuntu-525.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 2 Dec 2021 01:53:08 -0800
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
To:     <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <pure.logic@nexus-software.ie>,
        <bjorn.andersson@linaro.org>, <greg@kroah.com>, <robh@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <quic_tsoni@quicinc.com>,
        <quic_psodagud@quicinc.com>, <quic_satyap@quicinc.com>,
        <quic_pheragu@quicinc.com>, <quic_rjendra@quicinc.com>,
        <quic_sibis@quicinc.com>, <quic_saipraka@quicinc.com>,
        Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Subject: [PATCH V2 8/8] MAINTAINERS: Add maintainer entry for EUD
Date:   Thu, 2 Dec 2021 15:21:27 +0530
Message-ID: <7e5fbfa45746143fb0ee3235d9e00557cdfcac9a.1638430506.git.quic_schowdhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1638430506.git.quic_schowdhu@quicinc.com>
References: <cover.1638430506.git.quic_schowdhu@quicinc.com>
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
+M:	Souradeep Chowdhury <quic_schowdhu@quicinc.com>
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

