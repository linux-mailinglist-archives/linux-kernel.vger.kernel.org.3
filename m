Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA4734814B4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 16:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240914AbhL2Ppb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 10:45:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240606AbhL2Po7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 10:44:59 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D088CC06173E
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 07:44:58 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2b8I-0006sE-HY; Wed, 29 Dec 2021 16:44:54 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2b8I-007KHh-4T; Wed, 29 Dec 2021 16:44:53 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2b8G-000162-MJ; Wed, 29 Dec 2021 16:44:52 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     linux-iio@vger.kernel.org, kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 23/23] counter: remove old and now unused registration API
Date:   Wed, 29 Dec 2021 16:44:41 +0100
Message-Id: <20211229154441.38045-24-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211229154441.38045-1-u.kleine-koenig@pengutronix.de>
References: <20211229154441.38045-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=5703; h=from:subject; bh=d+n4DdZbQkz6lWvicNyaheFb+rPgVDrBk6eJ2FPNHVA=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBhzIJj+NcEdqt/DjAYBt+///jJf1VqDzQwBEQU4TsO Ll0kPLaJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYcyCYwAKCRDB/BR4rcrsCWMcB/ 9H0crukzp2NJOXiQFRnWPtk0YaX2hx9XviQikRmf57UPC+EE8lKGYmRwo4k3N1bTNgaEHJXcAmIEcD ldm+2IHCa6SaqnXnrUBjbRdzINAncMMbuzTWso/GVLBL2yoCH62vI57CVsnioYtww8biZ5lGkyXBMR Z3uRYURSASGyRj+xF5UliMBoRBhVHJ/93zFQzQTS6CqNUTAhTt2ahyoMqu/BAq5XGvM4dvbdFNbfsv jfd5w9DJBL4Y01NgFpZhS3Yxtm6WyIRWe1oJ2ezYZVeliIiw9I/a07sUbnud2PXv5LKe92vchd7uSX Ys0e1ckCHVR6XpKsvMuG3zlpGBN379
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Usage of counter_register() yields issues in device lifetime tracking. All
drivers were converted to the new API, so the old one can go away.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/counter/counter-core.c | 100 ++-------------------------------
 include/linux/counter.h        |  12 ----
 2 files changed, 4 insertions(+), 108 deletions(-)

diff --git a/drivers/counter/counter-core.c b/drivers/counter/counter-core.c
index b3fa15bbcbdb..7e0957eea094 100644
--- a/drivers/counter/counter-core.c
+++ b/drivers/counter/counter-core.c
@@ -43,8 +43,7 @@ static void counter_device_release(struct device *dev)
 	counter_chrdev_remove(counter);
 	ida_free(&counter_ida, dev->id);
 
-	if (!counter->legacy_device)
-		kfree(container_of(counter, struct counter_device_allochelper, counter));
+	kfree(container_of(counter, struct counter_device_allochelper, counter));
 }
 
 static struct device_type counter_device_type = {
@@ -67,76 +66,13 @@ static dev_t counter_devt;
  */
 void *counter_priv(const struct counter_device *const counter)
 {
-	if (counter->legacy_device) {
-		return counter->priv;
-	} else {
-		struct counter_device_allochelper *ch =
-			container_of(counter, struct counter_device_allochelper, counter);
+	struct counter_device_allochelper *ch =
+		container_of(counter, struct counter_device_allochelper, counter);
 
-		return &ch->privdata;
-	}
+	return &ch->privdata;
 }
 EXPORT_SYMBOL_GPL(counter_priv);
 
-/**
- * counter_register - register Counter to the system
- * @counter:	pointer to Counter to register
- *
- * This function registers a Counter to the system. A sysfs "counter" directory
- * will be created and populated with sysfs attributes correlating with the
- * Counter Signals, Synapses, and Counts respectively.
- *
- * RETURNS:
- * 0 on success, negative error number on failure.
- */
-int counter_register(struct counter_device *const counter)
-{
-	struct device *const dev = &counter->dev;
-	int id;
-	int err;
-
-	counter->legacy_device = true;
-
-	/* Acquire unique ID */
-	id = ida_alloc(&counter_ida, GFP_KERNEL);
-	if (id < 0)
-		return id;
-
-	mutex_init(&counter->ops_exist_lock);
-
-	/* Configure device structure for Counter */
-	dev->id = id;
-	dev->type = &counter_device_type;
-	dev->bus = &counter_bus_type;
-	dev->devt = MKDEV(MAJOR(counter_devt), id);
-	if (counter->parent) {
-		dev->parent = counter->parent;
-		dev->of_node = counter->parent->of_node;
-	}
-	device_initialize(dev);
-
-	err = counter_sysfs_add(counter);
-	if (err < 0)
-		goto err_free_id;
-
-	err = counter_chrdev_add(counter);
-	if (err < 0)
-		goto err_free_id;
-
-	err = cdev_device_add(&counter->chrdev, dev);
-	if (err < 0)
-		goto err_remove_chrdev;
-
-	return 0;
-
-err_remove_chrdev:
-	counter_chrdev_remove(counter);
-err_free_id:
-	put_device(dev);
-	return err;
-}
-EXPORT_SYMBOL_GPL(counter_register);
-
 /**
  * counter_alloc - allocate a counter_device
  * @sizeof_priv: size of the driver private data
@@ -245,9 +181,6 @@ void counter_unregister(struct counter_device *const counter)
 	wake_up(&counter->events_wait);
 
 	mutex_unlock(&counter->ops_exist_lock);
-
-	if (counter->legacy_device)
-		put_device(&counter->dev);
 }
 EXPORT_SYMBOL_GPL(counter_unregister);
 
@@ -256,31 +189,6 @@ static void devm_counter_release(void *counter)
 	counter_unregister(counter);
 }
 
-/**
- * devm_counter_register - Resource-managed counter_register
- * @dev:	device to allocate counter_device for
- * @counter:	pointer to Counter to register
- *
- * Managed counter_register. The Counter registered with this function is
- * automatically unregistered on driver detach. This function calls
- * counter_register internally. Refer to that function for more information.
- *
- * RETURNS:
- * 0 on success, negative error number on failure.
- */
-int devm_counter_register(struct device *dev,
-			  struct counter_device *const counter)
-{
-	int err;
-
-	err = counter_register(counter);
-	if (err < 0)
-		return err;
-
-	return devm_add_action_or_reset(dev, devm_counter_release, counter);
-}
-EXPORT_SYMBOL_GPL(devm_counter_register);
-
 static void devm_counter_put(void *counter)
 {
 	counter_put(counter);
diff --git a/include/linux/counter.h b/include/linux/counter.h
index f1350a43cd48..9afa0f1e9cea 100644
--- a/include/linux/counter.h
+++ b/include/linux/counter.h
@@ -314,8 +314,6 @@ struct counter_device {
 	struct counter_comp *ext;
 	size_t num_ext;
 
-	void *priv;
-
 	struct device dev;
 	struct cdev chrdev;
 	struct list_head events_list;
@@ -327,25 +325,15 @@ struct counter_device {
 	spinlock_t events_in_lock;
 	struct mutex events_out_lock;
 	struct mutex ops_exist_lock;
-
-	/*
-	 * This can go away once all drivers are converted to
-	 * counter_alloc()/counter_add().
-	 */
-	bool legacy_device;
 };
 
 void *counter_priv(const struct counter_device *const counter);
 
-int counter_register(struct counter_device *const counter);
-
 struct counter_device *counter_alloc(size_t sizeof_priv);
 void counter_put(struct counter_device *const counter);
 int counter_add(struct counter_device *const counter);
 
 void counter_unregister(struct counter_device *const counter);
-int devm_counter_register(struct device *dev,
-			  struct counter_device *const counter);
 struct counter_device *devm_counter_alloc(struct device *dev,
 					  size_t sizeof_priv);
 int devm_counter_add(struct device *dev,
-- 
2.34.1

