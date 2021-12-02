Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7AD465AC2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354353AbhLBA1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:27:10 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:28422 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354319AbhLBA1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:27:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638404624; x=1669940624;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vWCDUXgq39Y+w++hQeAm65dYH90e5lNEEWVNoFCl61Q=;
  b=QEmXDtDo4R3seI6qCIdUsLqPi+O+T0pirRtljJWr8kM67KahvCs1uZ6U
   45Hf0mtO7dkfT2cFMyHEaLsKBJxieGupUlqzQyn+Wi5palIcu0HIbXXuW
   WoMsUVEDaXOzl/sMU8pXXXNyAC6hvB4/IIU8XkFFWvflYFDrFI2Hn9Uct
   I=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 01 Dec 2021 16:23:44 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 16:23:44 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 1 Dec 2021 16:23:43 -0800
Received: from hu-vamslank-sd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 1 Dec 2021 16:23:43 -0800
From:   <quic_vamslank@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <robh+dt@kernel.org>, <maz@kernel.org>, <tglx@linutronix.de>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Vamsi Krishna Lanka <quic_vamslank@quicinc.com>
Subject: [PATCH v6 0/1] Add Pdc bindings for SDX65 
Date:   Wed, 1 Dec 2021 16:23:29 -0800
Message-ID: <cover.1638403797.git.quic_vamslank@quicinc.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vamsi Krishna Lanka <quic_vamslank@quicinc.com>

Hello,

Based on the comments from Bjorn, posting this patch separately
to get this merged.
Previously, it was sent as part of the patch series
https://lore.kernel.org/linux-arm-msm/20211201222638.GB586@quicinc.com/

Vamsi Krishna Lanka (1):
  dt-bindings: qcom,pdc: Add compatible for SDX65

 .../devicetree/bindings/interrupt-controller/qcom,pdc.txt        | 1 +
 1 file changed, 1 insertion(+)


base-commit: 58e1100fdc5990b0cc0d4beaf2562a92e621ac7d
prerequisite-patch-id: 93a6639086d56aaaf0c5d0e108a7a7690d39967f
prerequisite-patch-id: d68e4461d9794d7682f2d01561752f00377c7bb2
prerequisite-patch-id: 3a57c470db8e8d3d8546374d1e76b38fcb0215a1
prerequisite-patch-id: ba1594c6d524ae889dd4325d0912848f5542633b
prerequisite-patch-id: 6efd062dc77400d108f3f4a0c66010c69759d64a
-- 
2.33.1

