Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 245D6481D82
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 16:03:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241397AbhL3PDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 10:03:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240856AbhL3PDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 10:03:14 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5843EC061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 07:03:14 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2wxP-0000cY-8J; Thu, 30 Dec 2021 16:03:07 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2wxP-007VL9-14; Thu, 30 Dec 2021 16:03:06 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2wxN-0007ih-8t; Thu, 30 Dec 2021 16:03:05 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v4 14/23] counter: Update documentation for new counter registration functions
Date:   Thu, 30 Dec 2021 16:02:51 +0100
Message-Id: <20211230150300.72196-15-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211230150300.72196-1-u.kleine-koenig@pengutronix.de>
References: <20211230150300.72196-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1617; h=from:subject; bh=TASnXEH0lKlhSbBqFcgfSSsxVpWQVBj8v5aw8rDjyLo=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBhzcmYbsujyQnO74nW8GN1Q48yFonVn/gcNuRf6YZz YmlfROKJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYc3JmAAKCRDB/BR4rcrsCfUWB/ 9Faomy7n8b/MYtxZZPQRuDcj0oxoBwjJRTOx3XGzwxRxvjLn0KPpzn+d3dCkndzZBpkHQYZGJEU8o1 dk+UBA39NgBVE9+8ypxCVRTPmWCC86tXBqEMyAhCfjSnHAN3f5MGR3WOqPRaBX3hvYCUlIjz1uDGbB 6i+fExlTeDn6rJz1csmtY54p3ljkuRrsOOwMYtX2Plu51ggtC5MmXheKaaYidH0DctO3ZHtYgYvMZp strt0aP7160xhFNXb5yQ1JLoPGe5xLvHCdQeJ+YWf5WIYZScR2l7WOcaatw6nJ0cy/iS4+9aRswdFv oof4ozAKHdi/GHXUK9nVYqHP7H5wlO
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

