Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC5859167E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 22:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233681AbiHLU6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 16:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233820AbiHLU6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 16:58:19 -0400
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 459F5B3B07
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 13:58:17 -0700 (PDT)
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4M4GGw4RvvzDr9c;
        Fri, 12 Aug 2022 20:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1660337896; bh=Cj/IV1pw2ThI7GI1gCVGS2XtSOAt2LEW66sQ/W0zDOU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qjv7ooXV5hcNn11uVqo1AjqyWEKF0hYSRght/Gy3ctPMqdRkLWeWPwTMNANw6NBeB
         5EVKe92ObXlU1aX4oF9LNl173v0YBocA/1+Mphw4Ss5peB6cJgA17RLyYfC28qmkG/
         9XFIpHMK0asP3h9la42Eb9hC1VwOiyNDlkUPe+/4=
X-Riseup-User-ID: 708B23FB59B0A5C365B1067DF54257BAC0DDD0CFCD81A4E994BA249C443765C8
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4M4GGr5fn5z5vTk;
        Fri, 12 Aug 2022 20:58:12 +0000 (UTC)
From:   =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Maxime Ripard <maxime@cerno.tech>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 1/5] drm/bridge: anx7625: Drop of_gpio header
Date:   Fri, 12 Aug 2022 17:57:42 -0300
Message-Id: <20220812205746.609107-2-mairacanal@riseup.net>
In-Reply-To: <20220812205746.609107-1-mairacanal@riseup.net>
References: <20220812205746.609107-1-mairacanal@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver includes the deprecated OF GPIO header <linux/of_gpio.h>
yet fail to use symbols from it, so drop the include.

Cc: Andrzej Hajda <andrzej.hajda@intel.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>
Cc: Robert Foss <robert.foss@linaro.org>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: Jonas Karlman <jonas@kwiboo.se>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
Signed-off-by: Maíra Canal <mairacanal@riseup.net>
---
 drivers/gpu/drm/bridge/analogix/anx7625.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
index 79fc7a50b497..d7d4ca1c8b30 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
@@ -17,7 +17,6 @@
 #include <linux/types.h>
 #include <linux/workqueue.h>
 
-#include <linux/of_gpio.h>
 #include <linux/of_graph.h>
 #include <linux/of_platform.h>
 
-- 
2.37.1

