Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29E634FEE59
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 06:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbiDMEqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 00:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbiDMEqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 00:46:04 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02DEB31DDD;
        Tue, 12 Apr 2022 21:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649825025; x=1681361025;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=Euy5GyMcnB1dcHLsisZMhR4czkWWcNeX4uR3GjmBfcw=;
  b=rV2BuH1Ma1k9AJGdycvPbJY6qE7b8Kib/9XNR5Yl9XJ0aL6PeOavKTyE
   63wHEjHDTy0Uhwn2PsSY+h/wSZzrfScVFfuBGHDYxwOwZi0QuQtX8l40o
   zAyvKDwKfB6YJqZpx3xB3MUGDZHZ70KDq2cX7yg1Sr4JOBCY4zEU469iV
   k=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 12 Apr 2022 21:43:44 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 21:43:44 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 12 Apr 2022 21:43:24 -0700
Received: from blr-ubuntu-173.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 12 Apr 2022 21:43:21 -0700
From:   Rajendra Nayak <quic_rjendra@quicinc.com>
To:     <tony@atomide.com>, <paul@pwsan.com>
CC:     <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Rajendra Nayak" <quic_rjendra@quicinc.com>
Subject: [PATCH] MAINTAINERS: omap: remove me as a maintainer
Date:   Wed, 13 Apr 2022 10:13:03 +0530
Message-ID: <1649824983-29400-1-git-send-email-quic_rjendra@quicinc.com>
X-Mailer: git-send-email 2.7.4
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

The codeaurora.org domain is no longer valid, remove my id
from the maintainers for OMAP PM frameworks.
I haven't contributed to them in years, neither do I plan to
in the future so not updating this with my new quicinc id.

Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 61d9f11..9dbadc8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14364,7 +14364,6 @@ F:	arch/arm/*omap*/*pm*
 F:	drivers/cpufreq/omap-cpufreq.c
 
 OMAP POWERDOMAIN SOC ADAPTATION LAYER SUPPORT
-M:	Rajendra Nayak <rnayak@codeaurora.org>
 M:	Paul Walmsley <paul@pwsan.com>
 L:	linux-omap@vger.kernel.org
 S:	Maintained
-- 
2.7.4

