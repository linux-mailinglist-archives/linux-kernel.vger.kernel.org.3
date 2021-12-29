Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5529948149D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 16:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240677AbhL2PpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 10:45:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240619AbhL2Po6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 10:44:58 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B8BC061746
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 07:44:58 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2b8H-0006qQ-8e; Wed, 29 Dec 2021 16:44:53 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2b8E-007KH7-Qe; Wed, 29 Dec 2021 16:44:50 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2b8D-00013X-OB; Wed, 29 Dec 2021 16:44:49 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     linux-iio@vger.kernel.org, kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Patrick Havelange <patrick.havelange@essensium.com>
Subject: [PATCH v3 09/23] counter: ftm-quaddec: Convert to counter_priv() wrapper
Date:   Wed, 29 Dec 2021 16:44:27 +0100
Message-Id: <20211229154441.38045-10-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211229154441.38045-1-u.kleine-koenig@pengutronix.de>
References: <20211229154441.38045-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1951; h=from:subject; bh=CBgQ6yn9pj3aVonUUpdY82noKJTEGFd3OM3t7zq90/s=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBhzIItbT6rcc1P8BZoC0eWIxD1oV+ZfaY7kIdK/vmy liV1RpmJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYcyCLQAKCRDB/BR4rcrsCbUoCA CNvOVDtSfeW0cudvIpVteI31yLjT6T8PakcWUN3Tev54PdIPMIYwLap3qDEPk/ZrNbCJVP1TIM15yq NGi/La9bonRNw0Is7TNjuEft3Zj6XtnPGvzrRSi9cTiRIUZtHcd2GUhtGobnEO8TjWNN988+EETV28 0I1bx/6hUtDp8nXR+JfBxcFM8WONY3TPJL1DUEoC6+/6U0+RxH5QAzulNNhrnVCFSFcAziiNiyZqSB RXfnzv2AFOEkh+1v+FVib7MAc7tphryiTz7k7Qb7mZZMRahSrsRoBuCbWJBbEWFcN7A8Xoxa4O11yf uXDJ4NLVC32a6ULRBeG0W4iwmCbxJs
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a straight forward conversion to the new counter_priv() wrapper.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/counter/ftm-quaddec.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/counter/ftm-quaddec.c b/drivers/counter/ftm-quaddec.c
index 9272f7b58beb..f5d92df6a611 100644
--- a/drivers/counter/ftm-quaddec.c
+++ b/drivers/counter/ftm-quaddec.c
@@ -118,7 +118,7 @@ static void ftm_quaddec_disable(void *ftm)
 static int ftm_quaddec_get_prescaler(struct counter_device *counter,
 				     struct counter_count *count, u32 *cnt_mode)
 {
-	struct ftm_quaddec *ftm = counter->priv;
+	struct ftm_quaddec *ftm = counter_priv(counter);
 	uint32_t scflags;
 
 	ftm_read(ftm, FTM_SC, &scflags);
@@ -131,7 +131,7 @@ static int ftm_quaddec_get_prescaler(struct counter_device *counter,
 static int ftm_quaddec_set_prescaler(struct counter_device *counter,
 				     struct counter_count *count, u32 cnt_mode)
 {
-	struct ftm_quaddec *ftm = counter->priv;
+	struct ftm_quaddec *ftm = counter_priv(counter);
 
 	mutex_lock(&ftm->ftm_quaddec_mutex);
 
@@ -162,7 +162,7 @@ static int ftm_quaddec_count_read(struct counter_device *counter,
 				  struct counter_count *count,
 				  u64 *val)
 {
-	struct ftm_quaddec *const ftm = counter->priv;
+	struct ftm_quaddec *const ftm = counter_priv(counter);
 	uint32_t cntval;
 
 	ftm_read(ftm, FTM_CNT, &cntval);
@@ -176,7 +176,7 @@ static int ftm_quaddec_count_write(struct counter_device *counter,
 				   struct counter_count *count,
 				   const u64 val)
 {
-	struct ftm_quaddec *const ftm = counter->priv;
+	struct ftm_quaddec *const ftm = counter_priv(counter);
 
 	if (val != 0) {
 		dev_warn(&ftm->pdev->dev, "Can only accept '0' as new counter value\n");
-- 
2.34.1

