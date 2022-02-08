Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0CF4AE01A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 18:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384608AbiBHR4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 12:56:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384589AbiBHRzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 12:55:54 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E46EC03FEDC;
        Tue,  8 Feb 2022 09:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644342948; x=1675878948;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=0DBJMX6CN9Q62n1+xR/XbkjpUIrkdnw82/25SwLtiv4=;
  b=hiD/yWCgIvGiKRDHG4bKLmLr5BXj0W+/OylJiCqroNaCH6sxYPuEQ8Mj
   qf/iaKOoWojFy+qBYUKm3MNvLoRbsN0GQS8/CNPdrjFzBX4eQTm4NElWJ
   kaK4solylmprWpI2lhNPRBX/1kUNzHjhZMc67/WM9b60CkGB+AkA58evs
   w=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 08 Feb 2022 09:55:48 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 09:55:47 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 8 Feb 2022 09:55:47 -0800
Received: from blr-ubuntu-525.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 8 Feb 2022 09:55:42 -0800
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
To:     <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <pure.logic@nexus-software.ie>,
        <bjorn.andersson@linaro.org>, <greg@kroah.com>, <robh@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <quic_tsoni@quicinc.com>,
        <quic_psodagud@quicinc.com>, <quic_satyap@quicinc.com>,
        <quic_pheragu@quicinc.com>, <quic_rjendra@quicinc.com>,
        <quic_sibis@quicinc.com>, <quic_saipraka@quicinc.com>,
        <quic_schowdhu@quicinc.com>
Subject: [PATCH V6 6/6] MAINTAINERS: Add maintainer entry for EUD
Date:   Tue, 8 Feb 2022 23:24:29 +0530
Message-ID: <50cc73b4432c3d118361e6c9d47a9b0f7682e8ae.1644339918.git.quic_schowdhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1644339918.git.quic_schowdhu@quicinc.com>
References: <cover.1644339918.git.quic_schowdhu@quicinc.com>
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
+F:	drivers/usb/misc/qcom_eud.c
+
 EXEC & BINFMT API
 R:	Eric Biederman <ebiederm@xmission.com>
 R:	Kees Cook <keescook@chromium.org>
--
2.7.4

