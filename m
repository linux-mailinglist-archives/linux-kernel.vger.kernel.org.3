Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1312B52CB8A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 07:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234054AbiESFkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 01:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232611AbiESFkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 01:40:47 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58EBD389;
        Wed, 18 May 2022 22:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652938846; x=1684474846;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=N95pkwbu4izN6QqsZsdSNkwCyLorSYTPgc1DJCQgzAw=;
  b=kymqE7XshrKlB7qmXm+2Amdp/Dd/pE2cwO9/rJb8fXwZPfCrcWCMbxMK
   21L9JpdAHXEiu1lEE1DLBjGBqITQ+aE+7BKdqTyK+lXExuZmbeZP4Pj65
   dDy83W7k4PJ1yaRTgu8Z3nnr55fqCGYHyihb7NzY1KezJMS/ygFBIN3hC
   Y=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 18 May 2022 22:40:45 -0700
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 22:40:45 -0700
Received: from bgodavar-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 18 May 2022 22:40:41 -0700
From:   Balakrishna Godavarthi <quic_bgodavar@quicinc.com>
To:     <marcel@holtmann.org>, <johan.hedberg@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
CC:     <mka@chromium.org>, <linux-bluetooth@vger.kernel.org>,
        <quic_hemantg@quicinc.com>, <quic_bgodavar@quicinc.com>,
        <quic_rjliao@quicinc.com>, <mcchou@chromium.org>
Subject: [PATCH v1] MAINTAINERS: add maintainers for qualcomm uart based BT drivers
Date:   Thu, 19 May 2022 11:10:24 +0530
Message-ID: <1652938824-28976-1-git-send-email-quic_bgodavar@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding myself and rocky Liao as a maintainers for qualcomm
uart based bluetooth drivers.

Signed-off-by: Balakrishna Godavarthi <quic_bgodavar@quicinc.com>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 69b597a..22d4d00 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16295,6 +16295,16 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/net/qcom,bam-dmux.yaml
 F:	drivers/net/wwan/qcom_bam_dmux.c
 
+QUALCOMM BLUETOOTH DRIVER
+M:	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>
+M:	Rocky Liao <quic_rjliao@quicinc.com>
+L:	linux-bluetooth@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/net/qualcomm-bluetooth.yaml
+F:	drivers/bluetooth/btqca.c
+F:	drivers/bluetooth/btqca.h
+F:	drivers/bluetooth/hci_qca.c
+
 QUALCOMM CAMERA SUBSYSTEM DRIVER
 M:	Robert Foss <robert.foss@linaro.org>
 M:	Todor Tomov <todor.too@gmail.com>
-- 
2.7.4

