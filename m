Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 156AF482DF3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 06:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbiACFCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 00:02:06 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:38733 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229798AbiACFCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 00:02:05 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 6309A5C00CF;
        Mon,  3 Jan 2022 00:02:05 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 03 Jan 2022 00:02:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=4cqX3FuXJ8tSL
        ZGo1UClYYGPuduo/dAwTou1Y4V29To=; b=U1hbj/+XAL8c5MWhzKvyfKVYUXLkC
        8HIppp2gjmHuqJ5tRrvQgn58O5obx38K+/ju7I50dKVVF/o4QJcxpfhx4VKrv4aD
        cSmBOxFAa5Tz72ZHV6Q02riPb0ifYbQVwEAtilK84XqSceIXmpTJtIzIDP110eis
        iNunBlGamdPAb2gSfs6G6bAGjbbG19HzVi87DeS77SjNW49xAupm1I6M1NGgBcOV
        nkV3bUUggYBJEyRw+ce3y8H5ut9tAofbb4DnQ2FitRYAzkR9/T6tgpKdszP1+wfS
        p/BJDta/uSCes8NiIwTN/TS+ukm/qxEMFGvw+XK4GxWpHMqYQyFcKpamQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=4cqX3FuXJ8tSLZGo1UClYYGPuduo/dAwTou1Y4V29To=; b=IXFbuoRE
        W9Yyuq7tQ0oTWYs4BKhY/cbPGBsZ1yAs84b5RS8/JU/T7JWdE7cZZqjcYUjMMW29
        KqSEfJ29r7SCUwpAAtu/V5cv+ag5syGPp+Jv4GxvbnWO513jxfRiXg34eu2TLezn
        786DOHR5OpnUpi+fu3+WF9YNuezR0sgcPefa33UaoILxhoAY3ZH00ilKgaryUrAn
        JGuASAZAF/CCJ+NI3ZdxxEkTvZmMd+kgGK6Nq0rIFpPoe41HFUKUn1StO6qkqfr3
        qHxc7SG0ZxpGuN5pyFe+iekIU0sf+6/mFBBtY3vvOP85LkGmOGsJ51JROobgOXVu
        vscdaXc+WAy9fg==
X-ME-Sender: <xms:TYPSYQReu7MrbbAq0r_cfDXpz_BhpfpuCVBD1Mka3j2DOm5yWsyufA>
    <xme:TYPSYdy75Eh4YoCnZ0P-DqHEYhZy_T_Wv2TJOoM20gHOn-iQiFZK3Tg2AUKQ_O87b
    GvDcENTlPNpGphPvQ>
X-ME-Received: <xmr:TYPSYd38W3jd2fFoG0MZ-VAqVz_wlqiFeWnXwRiaI6GKYF2NK0eOeKmTKVkuRfNho68QdpzkNQJG_JoHjqfEn6RRvpIs9vrYqZsqop7fFucijg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudeftddgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegu
    gihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpefgkeduleekhfetvefhge
    fgvdegfeejfefguedvuddthffggffhhedtueeuteefieenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:TYPSYUCk-OpB2J4mXP8xrU4hgEf89G6lSRwBs2d8KtJA3ElU8afOug>
    <xmx:TYPSYZgzs5Y1tbNzYfD9eQ_eWAU2zWTWTndSrz-0YPTvl0ax5ssWwA>
    <xmx:TYPSYQokrgt72lwvB7Z6sHFlAyiDwRaQ1YE4KLo0p_C69KBVTGQvbw>
    <xmx:TYPSYXbhouaJg7hTT5gUbz31VaK0xOfWME4v2K1igSXiznYvbB8eAg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Jan 2022 00:02:00 -0500 (EST)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     arnd@arndb.de, gregkh@linuxfoundation.org, giometti@enneenne.com,
        linux-kernel@vger.kernel.org
Cc:     Daniel Xu <dxu@dxuuu.xyz>, thesven73@gmail.com, ojeda@kernel.org
Subject: [RFC char-misc-next 2/2] pps: Fix use-after-free cdev bug on module unload
Date:   Sun,  2 Jan 2022 21:01:40 -0800
Message-Id: <bd7cb7db45c11f50495697ad23804a30a2e3b2d4.1641185192.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1641185192.git.dxu@dxuuu.xyz>
References: <cover.1641185192.git.dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, a use-after-free KASAN splat could be reliably triggered
with:

    # insmod ./pps-ktimer.ko
    # rmmod pps-ktimer.ko
    <boom>

and CONFIG_DEBUG_KOBJECT_RELEASE=y.

This commit moves the driver to use cdev_alloc() instead of cdev_init()
to decouple the lifetime of struct cdev from struct pps_device.

We also make use of the previous commit's new cdev->private field to
store a pointer to the containing struct. We have to do this because
container_of() does not work when we store a pointer to struct cdev.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 drivers/pps/pps.c          | 20 +++++++++++---------
 include/linux/pps_kernel.h |  2 +-
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/pps/pps.c b/drivers/pps/pps.c
index 22a65ad4e46e..97ce26f67806 100644
--- a/drivers/pps/pps.c
+++ b/drivers/pps/pps.c
@@ -298,8 +298,7 @@ static long pps_cdev_compat_ioctl(struct file *file,
 
 static int pps_cdev_open(struct inode *inode, struct file *file)
 {
-	struct pps_device *pps = container_of(inode->i_cdev,
-						struct pps_device, cdev);
+	struct pps_device *pps = inode->i_cdev->private;
 	file->private_data = pps;
 	kobject_get(&pps->dev->kobj);
 	return 0;
@@ -307,8 +306,7 @@ static int pps_cdev_open(struct inode *inode, struct file *file)
 
 static int pps_cdev_release(struct inode *inode, struct file *file)
 {
-	struct pps_device *pps = container_of(inode->i_cdev,
-						struct pps_device, cdev);
+	struct pps_device *pps = inode->i_cdev->private;
 	kobject_put(&pps->dev->kobj);
 	return 0;
 }
@@ -332,7 +330,7 @@ static void pps_device_destruct(struct device *dev)
 {
 	struct pps_device *pps = dev_get_drvdata(dev);
 
-	cdev_del(&pps->cdev);
+	cdev_del(pps->cdev);
 
 	/* Now we can release the ID for re-use */
 	pr_debug("deallocating pps%d\n", pps->id);
@@ -368,10 +366,14 @@ int pps_register_cdev(struct pps_device *pps)
 
 	devt = MKDEV(MAJOR(pps_devt), pps->id);
 
-	cdev_init(&pps->cdev, &pps_cdev_fops);
-	pps->cdev.owner = pps->info.owner;
+	pps->cdev = cdev_alloc();
+	if (!pps->cdev)
+		goto free_idr;
+	pps->cdev->owner = pps->info.owner;
+	pps->cdev->ops = &pps_cdev_fops;
+	pps->cdev->private = pps;
 
-	err = cdev_add(&pps->cdev, devt, 1);
+	err = cdev_add(pps->cdev, devt, 1);
 	if (err) {
 		pr_err("%s: failed to add char device %d:%d\n",
 				pps->info.name, MAJOR(pps_devt), pps->id);
@@ -393,7 +395,7 @@ int pps_register_cdev(struct pps_device *pps)
 	return 0;
 
 del_cdev:
-	cdev_del(&pps->cdev);
+	cdev_del(pps->cdev);
 
 free_idr:
 	mutex_lock(&pps_idr_lock);
diff --git a/include/linux/pps_kernel.h b/include/linux/pps_kernel.h
index 78c8ac4951b5..4e401793880f 100644
--- a/include/linux/pps_kernel.h
+++ b/include/linux/pps_kernel.h
@@ -56,7 +56,7 @@ struct pps_device {
 
 	unsigned int id;			/* PPS source unique ID */
 	void const *lookup_cookie;		/* For pps_lookup_dev() only */
-	struct cdev cdev;
+	struct cdev *cdev;
 	struct device *dev;
 	struct fasync_struct *async_queue;	/* fasync method */
 	spinlock_t lock;
-- 
2.34.1

