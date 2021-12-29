Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE973481498
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 16:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240662AbhL2PpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 10:45:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240620AbhL2Po6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 10:44:58 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 308C9C06173F
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 07:44:58 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2b8H-0006qU-8c; Wed, 29 Dec 2021 16:44:53 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2b8F-007KHK-VV; Wed, 29 Dec 2021 16:44:51 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2b8F-00014b-3L; Wed, 29 Dec 2021 16:44:51 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     linux-iio@vger.kernel.org, kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v3 14/23] counter: Update documentation for new counter registration functions
Date:   Wed, 29 Dec 2021 16:44:32 +0100
Message-Id: <20211229154441.38045-15-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211229154441.38045-1-u.kleine-koenig@pengutronix.de>
References: <20211229154441.38045-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1617; h=from:subject; bh=TASnXEH0lKlhSbBqFcgfSSsxVpWQVBj8v5aw8rDjyLo=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBhzIJAbsujyQnO74nW8GN1Q48yFonVn/gcNuRf6YZz YmlfROKJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYcyCQAAKCRDB/BR4rcrsCeMsB/ 9Ph8A0sFeBLDxXqgu3t8qiOeUrzOpZ9klRNgk2lgvwiF4Goqex/TlX25PIc/s7glKbtRb14qqEbyFw 8Xf/w1msF0RGsaikCmcU4Mwohi4/uiZwPRchi5DSz5lHDUdnT7NnU/wbDRqJ1okHnvhdvtOX6FtS5m mHM5YE6dcgBA24qjpDI95ayOtLD8oU9/t+J3QXNidpYWulgmaf5G4ZsnjsiItkSdETV9CRpbESD78e D1R1VFBgN3s6+IBp9CgfYCbPEgnWX0OmoQdlqcMP77sP3lf6uyocPhwH2H/ska1pQzzzylVxbV2lNJ 5v/Wy1e3ohI/bN+zyrnornC1wv9SkS
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to replace the counter registration API also update the
documentation to the new way.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 Documentation/driver-api/generic-counter.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/driver-api/generic-counter.rst b/Documentation/driver-api/generic-counter.rst
index 1b487a331467..71ccc30e586b 100644
--- a/Documentation/driver-api/generic-counter.rst
+++ b/Documentation/driver-api/generic-counter.rst
@@ -262,11 +262,11 @@ order to communicate with the device: to read and write various Signals
 and Counts, and to set and get the "action mode" and "function mode" for
 various Synapses and Counts respectively.
 
-A defined counter_device structure may be registered to the system by
-passing it to the counter_register function, and unregistered by passing
-it to the counter_unregister function. Similarly, the
-devm_counter_register function may be used if device memory-managed
-registration is desired.
+A counter_device structure is allocated using counter_alloc() and then
+registered to the system by passing it to the counter_add() function, and
+unregistered by passing it to the counter_unregister function. There are
+device managed variants of these functions: devm_counter_alloc() and
+devm_counter_add().
 
 The struct counter_comp structure is used to define counter extensions
 for Signals, Synapses, and Counts.
-- 
2.34.1

