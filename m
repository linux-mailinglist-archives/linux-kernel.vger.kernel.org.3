Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3361470CED
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 23:12:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344675AbhLJWPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 17:15:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37661 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344651AbhLJWP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 17:15:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639174311;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o97PuPxghjn0KID9kthE/S1KHwTR2J2Ic4BvShM4jFk=;
        b=ZpYrv0H7xOoD3QAJKywWe7fXy8Kq1X1Q5GQ967Q8CDHZE4GveZrA8kDsQ/LkzM4RwduAtX
        H6EaR3MnKYKL3mNM89C+oq7QgEPL/kiynmtjFEoOa/e1CRTwy+UcNxthmvbvlvEuqpc8Rx
        rNuXUqiAkF2+6EeoGglnoTCXdTLY+WA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-418-AmQRElz0NIeUDVfrbnszZA-1; Fri, 10 Dec 2021 17:11:47 -0500
X-MC-Unique: AmQRElz0NIeUDVfrbnszZA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 98E43801962;
        Fri, 10 Dec 2021 22:11:46 +0000 (UTC)
Received: from cmirabil.remote.csb (unknown [10.22.8.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CDDDD779D2;
        Fri, 10 Dec 2021 22:11:44 +0000 (UTC)
From:   Charles Mirabile <cmirabil@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Charles Mirabile <cmirabil@redhat.com>,
        Serge Schneider <serge@raspberrypi.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Mattias Brugger <mbrugger@suse.com>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, fedora-rpi@googlegroups.com,
        Mwesigwa Guma <mguma@redhat.com>,
        Joel Savitz <jsavitz@redhat.com>
Subject: [PATCH V5 5/6] MAINTAINERS: Add sensehat driver authors to MAINTAINERS
Date:   Fri, 10 Dec 2021 17:10:32 -0500
Message-Id: <20211210221033.912430-6-cmirabil@redhat.com>
In-Reply-To: <20211210221033.912430-1-cmirabil@redhat.com>
References: <20211210221033.912430-1-cmirabil@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the driver authors to MAINAINERS.

Signed-off-by: Charles Mirabile <cmirabil@redhat.com>
Co-developed-by: Mwesigwa Guma <mguma@redhat.com>
Signed-off-by: Mwesigwa Guma <mguma@redhat.com>
Co-developed-by: Joel Savitz <jsavitz@redhat.com>
Signed-off-by: Joel Savitz <jsavitz@redhat.com>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8691c531e297..8deb59e209e0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17167,6 +17167,17 @@ F:	Documentation/ABI/testing/sysfs-bus-iio-chemical-sunrise-co2
 F:	Documentation/devicetree/bindings/iio/chemical/senseair,sunrise.yaml
 F:	drivers/iio/chemical/sunrise_co2.c
 
+SENSEHAT DRIVER
+M:	Charles Mirabile <cmirabil@redhat.com>
+M:	Mwesigwa Guma <mguma@redhat.com>
+M:	Joel Savitz <jsavitz@redhat.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/mfd/raspberrypi,sensehat.yaml
+F:	drivers/auxdisplay/sensehat-display.c
+F:	drivers/input/joystick/sensehat-joystick.c
+F:	drivers/mfd/sensehat-core.c
+F:	include/linux/mfd/sensehat.h
+
 SENSIRION SCD30 CARBON DIOXIDE SENSOR DRIVER
 M:	Tomasz Duszynski <tomasz.duszynski@octakon.com>
 S:	Maintained
-- 
2.31.1

