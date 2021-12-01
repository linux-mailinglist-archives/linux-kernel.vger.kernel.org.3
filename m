Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3177846546E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 18:57:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352051AbhLASAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 13:00:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351970AbhLAR77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 12:59:59 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F240BC061574;
        Wed,  1 Dec 2021 09:56:37 -0800 (PST)
Received: from localhost.localdomain (unknown [IPv6:2a00:c281:1409:4a00:c103:6980:2c3:d021])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dafna)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 407D11F45E51;
        Wed,  1 Dec 2021 17:56:35 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1638381396; bh=drd7pjo9KNm9SXbJqSjRnoiOHd+JUDMpVHIVQiFuY6Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rs9dTCspvK0yN9odNIzBxH9LzxiAYb8KWZgWm905fImZ9rf4Jbs1OLFmJIUaxGInS
         8Bh2FuxfkxPGkgJveQFiU1IrpTafTjNwIzEoiQpCrFfhKmk1YpqCTlrIya++0sirPC
         EnwAxQb44JywZakm2uLDaiNJ4/cLH20ZnKyq3Nd6Imi71ZzdCztxNqsXdROguRKmbM
         0yL7AN+X7MICrr7L9jUJU7qEH+xevfMrrJQ2fpIivTfIr9cOpwR3LEA71VhipVnWjT
         FbbPHYM3NyxxxY/WJJcj+vmMwteOTKBbYBo0wcvRZHSrTCUK9327VwK7NmMfIIMG2Y
         s/zl5pUGAFM7A==
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
Subject: [PATCH v4 6/6] media: wave5: Add wave5 driver to maintainers file
Date:   Wed,  1 Dec 2021 19:56:13 +0200
Message-Id: <20211201175613.13710-7-dafna.hirschfeld@collabora.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211201175613.13710-1-dafna.hirschfeld@collabora.com>
References: <20211201175613.13710-1-dafna.hirschfeld@collabora.com>
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

