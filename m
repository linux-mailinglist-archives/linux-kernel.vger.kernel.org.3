Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFFC550EE37
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 03:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238711AbiDZBtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 21:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbiDZBtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 21:49:01 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4774431DF9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 18:45:55 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id q12so14790750pgj.13
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 18:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fs39rG0hSjZgIyHtZoCrNmwLvEpFlExf0UyCmWSPVJU=;
        b=EJ6EB8ibaSZ7fpoRT+N+rrv7FqwPDOGoqJWhG7TlJm2BZJfXXBSW+5+xKU/fNtZAcY
         D0dr7hKl7tUDVHhHdA4Hfub20Gq76UFcTova6j8bYKkmHOrgYLwXle7gcsP34ma9uhfo
         EpzKbBD7GU+1tF63uKQl3J+8PjBqDb3uDJW6I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fs39rG0hSjZgIyHtZoCrNmwLvEpFlExf0UyCmWSPVJU=;
        b=YF3/bYwnt1mYym6QG/fc4Lal5JYl6Q4k7nJIH8ZgtA+pMccHrO3OyjyuPTvX5uxhX7
         9KSawFETRi4tgaQ+WgFCHmErb8okvUD95KMF6m/RSVZYQ9J+gAej/Q+307i1f7zUhepU
         MXwqnyW0HigW3NEIOvto6l8PDOv84jtmhjmrTVLep+MtDHggqsjeHCwDw3ptpcRTfIb8
         i45TJ24s1GtmoRoaeN8bFRUFupRrsC5skgWKrDeL1PtHxwuF5YKGmPCgHixijRDrdI4W
         PzG1Mvps/gnCKuDrUtCfJQVO8jA8n7Lx7OJS+C/Bwvk4kGLRYt0mSHvMvhejQeWySzfr
         lVGw==
X-Gm-Message-State: AOAM531OTTANKu23cquWAG988HkfLO/eeLCJqhd27vmtmY4zPUWIyNDS
        YUvI7w7F2G5/zK1YkJuAtUnF1w==
X-Google-Smtp-Source: ABdhPJwdR5XizZKoGXDfQ7ukYvyvVepyzL47uugvCgpFGVfG+bCqh1tu06W/3af5zp4pxeMahoOX/Q==
X-Received: by 2002:a63:c1b:0:b0:39d:93f7:4b7b with SMTP id b27-20020a630c1b000000b0039d93f74b7bmr17628068pgl.595.1650937554798;
        Mon, 25 Apr 2022 18:45:54 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:84c6:2d6d:c16:1a1b])
        by smtp.gmail.com with UTF8SMTPSA id n20-20020a634d54000000b0039d18bf7864sm10908937pgl.20.2022.04.25.18.45.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 18:45:54 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Heiko Stuebner <heiko@sntech.de>, Arnd Bergmann <arnd@arndb.de>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH v3 1/3] soc: rockchip: Clean up Kconfig whitespace
Date:   Mon, 25 Apr 2022 18:45:42 -0700
Message-Id: <20220426014545.628100-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are spaces instead of tabs, and other inconsistent indentation.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

(no changes since v2)

Changes in v2:
 * New patch

 drivers/soc/rockchip/Kconfig | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/soc/rockchip/Kconfig b/drivers/soc/rockchip/Kconfig
index 156ac0e0c8fe..aff2f7e95237 100644
--- a/drivers/soc/rockchip/Kconfig
+++ b/drivers/soc/rockchip/Kconfig
@@ -23,23 +23,23 @@ config ROCKCHIP_IODOMAIN
 	  voltage supplied by the regulators.
 
 config ROCKCHIP_PM_DOMAINS
-        bool "Rockchip generic power domain"
-        depends on PM
-        select PM_GENERIC_DOMAINS
-        help
-          Say y here to enable power domain support.
-          In order to meet high performance and low power requirements, a power
-          management unit is designed or saving power when RK3288 in low power
-          mode. The RK3288 PMU is dedicated for managing the power of the whole chip.
+	bool "Rockchip generic power domain"
+	depends on PM
+	select PM_GENERIC_DOMAINS
+	help
+	  Say y here to enable power domain support.
+	  In order to meet high performance and low power requirements, a power
+	  management unit is designed or saving power when RK3288 in low power
+	  mode. The RK3288 PMU is dedicated for managing the power of the whole chip.
 
-          If unsure, say N.
+	  If unsure, say N.
 
 config ROCKCHIP_DTPM
 	tristate "Rockchip DTPM hierarchy"
 	depends on DTPM && m
 	help
-	 Describe the hierarchy for the Dynamic Thermal Power
-	 Management tree on this platform. That will create all the
-	 power capping capable devices.
+	  Describe the hierarchy for the Dynamic Thermal Power Management tree
+	  on this platform. That will create all the power capping capable
+	  devices.
 
 endif
-- 
2.36.0.rc2.479.g8af0fa9b8e-goog

