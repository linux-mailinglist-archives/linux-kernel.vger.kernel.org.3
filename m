Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF70591680
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 22:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbiHLU6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 16:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234227AbiHLU6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 16:58:43 -0400
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB4BB3B18
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 13:58:43 -0700 (PDT)
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx0.riseup.net (Postfix) with ESMTPS id 4M4GHQ42MNz9s2H;
        Fri, 12 Aug 2022 20:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1660337922; bh=YOSyDteCND3ndEMO86/nMvrstN4s/JMsBfnofZVgVAc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BALkIqQaiZYXrIeHgtiGpfaBeTlXeWWyt4oxfTuEyQ/zSbf0BI74Kg9u2mii+gFKH
         NZooC5yEs/JF3bEjJ1hIL+tca2L0b+D3+QeArqjGjrKH/xDrzFobvYx8odxTidCjA5
         /oF5ET0c5Xh1c0Om5L8twfKnckTyLy1o2iOb0eWQ=
X-Riseup-User-ID: F6D98B7A89F4D59F7332F4EEFE6090DFB94B7A174B3A4C1F90ADC9E4F4AE482D
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4M4GHM57VBz5vTk;
        Fri, 12 Aug 2022 20:58:39 +0000 (UTC)
From:   =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Maxime Ripard <maxime@cerno.tech>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>
Subject: [PATCH 3/5] drm/msm: Drop of_gpio header
Date:   Fri, 12 Aug 2022 17:57:44 -0300
Message-Id: <20220812205746.609107-4-mairacanal@riseup.net>
In-Reply-To: <20220812205746.609107-1-mairacanal@riseup.net>
References: <20220812205746.609107-1-mairacanal@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These drivers include the deprecated OF GPIO header <linux/of_gpio.h>
yet fail to use symbols from it, so drop the include.

Cc: Rob Clark <robdclark@gmail.com>
Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Sean Paul <sean@poorly.run>
Signed-off-by: Maíra Canal <mairacanal@riseup.net>
---
 drivers/gpu/drm/msm/dp/dp_parser.c | 2 +-
 drivers/gpu/drm/msm/hdmi/hdmi.c    | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_parser.c b/drivers/gpu/drm/msm/dp/dp_parser.c
index f6ab3b5586ce..9a1bd92dcdc5 100644
--- a/drivers/gpu/drm/msm/dp/dp_parser.c
+++ b/drivers/gpu/drm/msm/dp/dp_parser.c
@@ -3,7 +3,7 @@
  * Copyright (c) 2012-2020, The Linux Foundation. All rights reserved.
  */
 
-#include <linux/of_gpio.h>
+#include <linux/of.h>
 #include <linux/phy/phy.h>
 
 #include <drm/drm_of.h>
diff --git a/drivers/gpu/drm/msm/hdmi/hdmi.c b/drivers/gpu/drm/msm/hdmi/hdmi.c
index 93fe61b86967..f178c424257b 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi.c
@@ -6,7 +6,6 @@
  */
 
 #include <linux/of_irq.h>
-#include <linux/of_gpio.h>
 
 #include <drm/drm_bridge_connector.h>
 #include <drm/drm_of.h>
-- 
2.37.1

