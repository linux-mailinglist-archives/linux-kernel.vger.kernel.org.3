Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 158E1591681
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 22:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234429AbiHLU6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 16:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233151AbiHLU6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 16:58:49 -0400
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C4FB2DB7
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 13:58:48 -0700 (PDT)
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4M4GHW4LxJzDrYp;
        Fri, 12 Aug 2022 20:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1660337927; bh=4hKi98zmcpOygJlC/brm5+e7Zm6yFWUFqTK/C2pjE6E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KxmILLhifmsCArKZceHkBvO5Hv0pfvwRrI/HEswBTu0FoWIXmYXcIQsRNYBXNB33z
         80oopLBZ6Ec3Jv/Q69iuWlNuG6ySuzXJbDY5M6NSZo5gXJ2mC0rpev94DxHo4EFgzP
         AaPJzDwCRnWJ58u2ulV+25KcNCWGu53ODXeV9Pvc=
X-Riseup-User-ID: 018427D77F8C1B0ED7E92F6C037AF4BED3A940C33AD9DA3F32EDD34960F4EA7B
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4M4GHT2hGdz5vTk;
        Fri, 12 Aug 2022 20:58:45 +0000 (UTC)
From:   =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Maxime Ripard <maxime@cerno.tech>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>,
        Alain Volmat <alain.volmat@foss.st.com>
Subject: [PATCH 4/5] drm/sti: Drop of_gpio header
Date:   Fri, 12 Aug 2022 17:57:45 -0300
Message-Id: <20220812205746.609107-5-mairacanal@riseup.net>
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
yet fail to use symbols from it, so drop this include.

Cc: Alain Volmat <alain.volmat@foss.st.com>
Signed-off-by: Maíra Canal <mairacanal@riseup.net>
---
 drivers/gpu/drm/sti/sti_dvo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sti/sti_dvo.c b/drivers/gpu/drm/sti/sti_dvo.c
index b6ee8a82e656..0fc7710b054a 100644
--- a/drivers/gpu/drm/sti/sti_dvo.c
+++ b/drivers/gpu/drm/sti/sti_dvo.c
@@ -8,7 +8,7 @@
 #include <linux/component.h>
 #include <linux/debugfs.h>
 #include <linux/module.h>
-#include <linux/of_gpio.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 
 #include <drm/drm_atomic_helper.h>
-- 
2.37.1

