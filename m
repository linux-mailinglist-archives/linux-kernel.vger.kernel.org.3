Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 661A548B1DC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 17:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242322AbiAKQQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 11:16:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349928AbiAKQQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 11:16:35 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB0F7C06175B;
        Tue, 11 Jan 2022 08:16:32 -0800 (PST)
Received: from localhost.localdomain (unknown [IPv6:2a00:c281:14a3:8100:5418:23c4:e539:4c3e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dafna)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 003DA1F43ADB;
        Tue, 11 Jan 2022 16:16:29 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641917791;
        bh=drd7pjo9KNm9SXbJqSjRnoiOHd+JUDMpVHIVQiFuY6Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nBoApyKVtVK3vf3OpbLaU4Bz/0+dX1/hLI95ZiTNS3q6sCAMCZqq/G7CwNRh1fRba
         QIiGoumj8ecNFX56B0eVxLiGvI9VzhjBIlTcge+sUWg9ULOF+Dv6aK+s+KlauNWogG
         lpiLdnJ4jceDq59zGl2MP4sm1HR79QVgdnHcoIEFF8UAy/KNVkc7EmKTA5PWqCRjG0
         oOJRvv3tBoCiFoi2dtyA/S/vqxFNUCr8sHG3GsfjOwpQMN9isUHGP7UQnwF2y1hlFV
         EU+tKBeHAEZNLvm0DXFER0W8UuznFgHcduR88I8KvYp9ruHYLi7Q4MHDEjK97x55Ze
         JEk70YN8pVXHg==
From:   Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
To:     linux-media@vger.kernel.org
Cc:     Robert Beckett <bob.beckett@collabora.com>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev (open list:STAGING SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list),
        laurent.pinchart@ideasonboard.com, hverkuil@xs4all.nl,
        kernel@collabora.com, dafna3@gmail.com,
        kiril.bicevski@collabora.com,
        Nas Chung <nas.chung@chipsnmedia.com>,
        lafley.kim@chipsnmedia.com, scott.woo@chipsnmedia.com,
        olivier.crete@collabora.com, dan.carpenter@oracle.com,
        rdunlap@infradead.org, daniel@0x0f.com
Subject: [PATCH v5 6/6] media: wave5: Add wave5 driver to maintainers file
Date:   Tue, 11 Jan 2022 18:16:04 +0200
Message-Id: <20220111161604.22579-7-dafna.hirschfeld@collabora.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220111161604.22579-1-dafna.hirschfeld@collabora.com>
References: <20220111161604.22579-1-dafna.hirschfeld@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robert Beckett <bob.beckett@collabora.com>

Add the Chips&Media wave5 encoder/decoder driver
to the maintainers file

Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0e6594a4ad8f..5704b8c17f72 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19962,6 +19962,15 @@ F:	drivers/watchdog/
 F:	include/linux/watchdog.h
 F:	include/uapi/linux/watchdog.h
 
+WAVE5 VPU CODEC DRIVER
+M:	Nas Chung <nas.chung@chipsnmedia.com>
+M:	Robert Beckett <bob.beckett@collabora.com>
+M:	Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
+L:	linux-media@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/staging/media/cnm,wave.yaml
+F:	drivers/staging/media/wave5/
+
 WHISKEYCOVE PMIC GPIO DRIVER
 M:	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
 L:	linux-gpio@vger.kernel.org
-- 
2.17.1

