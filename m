Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAC42554760
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235635AbiFVKNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 06:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346962AbiFVKNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 06:13:49 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE4FC15729;
        Wed, 22 Jun 2022 03:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1655892828; x=1687428828;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=FdbuCESvF6sDFvc2UhQ68eQw+NWfPZ6BbVp5AMkpCt8=;
  b=GV2rLl6/tdigQX5xGGU1lBH32Z2PKw0+MZJt/KbciywpQSy7J2bz1f9h
   XXNghMG2lVt9oUR7pLuyIwMyHUcu2KwI2EKW1AATKWmroTyXgfSfJpAKD
   gBWNQWyCCV8oTGs3w5dveqZ8/CYMDS2MMpVTVZLU4zE+1If+gJHWOpMEy
   A=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 22 Jun 2022 03:13:48 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 03:13:47 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 22 Jun 2022 03:13:47 -0700
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 22 Jun 2022 03:13:41 -0700
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <quic_plai@quicinc.com>, <bgoswami@quicinc.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <srinivas.kandagatla@linaro.org>,
        <quic_rohkumar@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <swboyd@chromium.org>, <judyhsiao@chromium.org>,
        <devicetree@vger.kernel.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Subject: [PATCH 1/2] ASoC: google: dt-bindings: Update sc7280-audioreach-herobrine compatible name
Date:   Wed, 22 Jun 2022 15:43:18 +0530
Message-ID: <1655892799-29641-2-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1655892799-29641-1-git-send-email-quic_srivasam@quicinc.com>
References: <1655892799-29641-1-git-send-email-quic_srivasam@quicinc.com>
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

Update audioreach based compatible string for sc7280 based ADSP enabled
platforms.

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
---
 Documentation/devicetree/bindings/sound/google,sc7280-herobrine.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/google,sc7280-herobrine.yaml b/Documentation/devicetree/bindings/sound/google,sc7280-herobrine.yaml
index 869b403..d3885e5 100644
--- a/Documentation/devicetree/bindings/sound/google,sc7280-herobrine.yaml
+++ b/Documentation/devicetree/bindings/sound/google,sc7280-herobrine.yaml
@@ -17,6 +17,7 @@ properties:
   compatible:
     enum:
       - google,sc7280-herobrine
+      - google,sc7280-audioreach-herobrine
 
   audio-routing:
     $ref: /schemas/types.yaml#/definitions/non-unique-string-array
-- 
2.7.4

