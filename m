Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B63154AED72
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 10:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239162AbiBIJCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 04:02:06 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:48698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236752AbiBIJBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 04:01:54 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39387E063CA8;
        Wed,  9 Feb 2022 01:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644397312; x=1675933312;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=W1vbGig1ggXixsjNE2mO6qoA8DXkKDyDegvqnRj1LrY=;
  b=IljA1k1l6vqrivtRLoJOFz89KqLxdccSbW/3fKD8Drm1CsSovw8JarO7
   BjJbc+u8odH83vGhQaizY+mjrUjmIsDdZZkHzxvOEU/5K9/66+bfYdiNW
   LHwTTH+nqCLRpAzqI9tfEg0BaMLpsZBUpzs/2EHqBn3NSC+okB+Tx62a1
   0=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 09 Feb 2022 00:55:59 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 00:55:58 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 9 Feb 2022 00:55:58 -0800
Received: from sbillaka-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 9 Feb 2022 00:55:51 -0800
From:   Sankeerth Billakanti <quic_sbillaka@quicinc.com>
To:     <dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <agross@kernel.org>,
        <bjorn.andersson@linaro.org>, <robh+dt@kernel.org>,
        <robdclark@gmail.com>, <seanpaul@chromium.org>,
        <swboyd@chromium.org>, <dianders@chromium.org>,
        <krzysztof.kozlowski@canonical.com>, <thierry.reding@gmail.com>,
        <sam@ravnborg.org>, <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        <quic_kalyant@quicinc.com>, <quic_abhinavk@quicinc.com>,
        <quic_khsieh@quicinc.com>, <quic_mkrishn@quicinc.com>,
        <quic_vproddut@quicinc.com>
Subject: [PATCH v3 1/4] dt-bindings: display: simple: Add sharp LQ140M1JW46 panel
Date:   Wed, 9 Feb 2022 14:25:29 +0530
Message-ID: <1644396932-17932-2-git-send-email-quic_sbillaka@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1644396932-17932-1-git-send-email-quic_sbillaka@quicinc.com>
References: <1644396932-17932-1-git-send-email-quic_sbillaka@quicinc.com>
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

Add support for sharp LQ140M1JW46 display panel. It is a 14" eDP panel
with 1920x1080 display resolution.

Signed-off-by: Sankeerth Billakanti <quic_sbillaka@quicinc.com>
---

Changes in v3:
  None

 Documentation/devicetree/bindings/display/panel/panel-simple.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index 9cf5588..1eb9dd4 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -284,6 +284,8 @@ properties:
       - sharp,lq101k1ly04
         # Sharp 12.3" (2400x1600 pixels) TFT LCD panel
       - sharp,lq123p1jx31
+        # Sharp 14" (1920x1080 pixels) TFT LCD panel
+      - sharp,lq140m1jw46
         # Sharp LS020B1DD01D 2.0" HQVGA TFT LCD panel
       - sharp,ls020b1dd01d
         # Shelly SCA07010-BFN-LNN 7.0" WVGA TFT LCD panel
-- 
2.7.4

