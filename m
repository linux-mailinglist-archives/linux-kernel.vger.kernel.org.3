Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBD674A34E5
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 08:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354311AbiA3HbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 02:31:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240201AbiA3HbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 02:31:05 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511F0C061714;
        Sat, 29 Jan 2022 23:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=KNo/wYXupJxN+WijaxxcLpJqSYozhDUbi1Ts8pO+7F0=; b=mlIoAY5DYUVczCzT9bVeRlI6t8
        5g5/FEBFz5Yvd1kdDsMzKfgYgfqCL5DMCR7oOs1wxFLYDagAkxsnCFISgI9rXzoqO2OFt+7SWsP+E
        804TC8RYzPN+O0uVlh5mK+3vNmoVOYW1ea7vTUwLq6m3ZcJ2KVqdFZ/nj/EqNdWiFcRtBkYe7u+h/
        BeqHRoybBRTiiWJrH9MKG3aUv79Nb3DstWZFBJwkTGNItQoA/YTKEun8ePH2t6OL4Rd+eWsV9QwTs
        77zK4o7vUsPeVfA+FIBopVDqvQ6qWP2jZuEHlsUlNnQAln+HxkMB6ZbxW8i1P7sL3ONOGXDWutUhf
        YX4olcmg==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nE4fw-0064lK-28; Sun, 30 Jan 2022 07:31:04 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org
Subject: [PATCH] gpio/consumer.h: don't use "/**" for non-kernel-doc comments
Date:   Sat, 29 Jan 2022 23:31:03 -0800
Message-Id: <20220130073103.26792-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use "/*" to begin non-kernel-doc comments instead of "/**",
which indicates the beginning of kernel-doc notation.

Quietens these kernel-doc warnings:

consumer.h:13: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * Opaque descriptor for a GPIO. These are obtained using gpiod_get() and are
consumer.h:13: warning: missing initial short description on line:
 * Opaque descriptor for a GPIO. These are obtained using gpiod_get() and are
consumer.h:22: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * Opaque descriptor for a structure of GPIO array attributes.  This structure
consumer.h:22: warning: missing initial short description on line:
 * Opaque descriptor for a structure of GPIO array attributes.  This structure
consumer.h:30: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * Struct containing an array of descriptors that can be obtained using
consumer.h:30: warning: missing initial short description on line:
 * Struct containing an array of descriptors that can be obtained using
consumer.h:46: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * Optional flags that can be passed to one of gpiod_* to configure direction
consumer.h:46: warning: missing initial short description on line:
 * Optional flags that can be passed to one of gpiod_* to configure direction

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-gpio@vger.kernel.org
---
 include/linux/gpio/consumer.h |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- linux-next-20220128.orig/include/linux/gpio/consumer.h
+++ linux-next-20220128/include/linux/gpio/consumer.h
@@ -9,7 +9,7 @@
 
 struct device;
 
-/**
+/*
  * Opaque descriptor for a GPIO. These are obtained using gpiod_get() and are
  * preferable to the old integer-based handles.
  *
@@ -18,7 +18,7 @@ struct device;
  */
 struct gpio_desc;
 
-/**
+/*
  * Opaque descriptor for a structure of GPIO array attributes.  This structure
  * is attached to struct gpiod_descs obtained from gpiod_get_array() and can be
  * passed back to get/set array functions in order to activate fast processing
@@ -26,7 +26,7 @@ struct gpio_desc;
  */
 struct gpio_array;
 
-/**
+/*
  * Struct containing an array of descriptors that can be obtained using
  * gpiod_get_array().
  */
@@ -42,7 +42,7 @@ struct gpio_descs {
 #define GPIOD_FLAGS_BIT_OPEN_DRAIN	BIT(3)
 #define GPIOD_FLAGS_BIT_NONEXCLUSIVE	BIT(4)
 
-/**
+/*
  * Optional flags that can be passed to one of gpiod_* to configure direction
  * and output value. These values cannot be OR'd.
  */
