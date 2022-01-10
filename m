Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB6E489F22
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 19:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238949AbiAJSXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 13:23:11 -0500
Received: from aposti.net ([89.234.176.197]:35278 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239088AbiAJSXJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 13:23:09 -0500
From:   Paul Cercueil <paul@crapouillou.net>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, list@opendingux.net,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v3 1/2] ABI: hwmon: Document "label" sysfs attribute
Date:   Mon, 10 Jan 2022 18:22:55 +0000
Message-Id: <20220110182256.30763-2-paul@crapouillou.net>
In-Reply-To: <20220110182256.30763-1-paul@crapouillou.net>
References: <20220110182256.30763-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the "label" sysfs attribute, which can contain a descriptive label
that allows to uniquely identify a device within the system.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
    v2: New patch
    v3: No change

 Documentation/ABI/testing/sysfs-class-hwmon | 8 ++++++++
 Documentation/hwmon/sysfs-interface.rst     | 4 ++++
 2 files changed, 12 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-hwmon b/Documentation/ABI/testing/sysfs-class-hwmon
index 1f20687def44..653d4c75eddb 100644
--- a/Documentation/ABI/testing/sysfs-class-hwmon
+++ b/Documentation/ABI/testing/sysfs-class-hwmon
@@ -9,6 +9,14 @@ Description:
 
 		RO
 
+What:		/sys/class/hwmon/hwmonX/label
+Description:
+		A descriptive label that allows to uniquely identify a
+		device within the system.
+		The contents of the label are free-form.
+
+		RO
+
 What:		/sys/class/hwmon/hwmonX/update_interval
 Description:
 		The interval at which the chip will update readings.
diff --git a/Documentation/hwmon/sysfs-interface.rst b/Documentation/hwmon/sysfs-interface.rst
index 85652a6aaa3e..209626fb2405 100644
--- a/Documentation/hwmon/sysfs-interface.rst
+++ b/Documentation/hwmon/sysfs-interface.rst
@@ -99,6 +99,10 @@ Global attributes
 `name`
 		The chip name.
 
+`label`
+		A descriptive label that allows to uniquely identify a device
+		within the system.
+
 `update_interval`
 		The interval at which the chip will update readings.
 
-- 
2.34.1

