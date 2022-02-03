Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0BD4A7CD8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 01:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348568AbiBCA0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 19:26:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:53172 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348558AbiBCA0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 19:26:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643847971;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CpjdQzf+NbyUJzKzPJT9BNzbNv+UO/4apJmnSPwzfaE=;
        b=M4ra9KhWN53gL7EKBvVqGxSFsm1Iv0uO3FiR3fllsviSrLbHtAGZZEbrmNlHsiw67rnrn0
        vHH9yVuooyPK2Q7yRKzU6Msy2EWN6upMjB6L1w2Vt9AfVfmTXJTo2WcH0lAr53FXWfosuE
        lPULonpIHx4RS9NIL/4PyHHi+BxvaeY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-643-7y76-4_fOgiCCksINYlKOA-1; Wed, 02 Feb 2022 19:26:06 -0500
X-MC-Unique: 7y76-4_fOgiCCksINYlKOA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DD5751091DA6;
        Thu,  3 Feb 2022 00:26:04 +0000 (UTC)
Received: from cmirabil.remote.csb (unknown [10.22.8.140])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6815F56AA2;
        Thu,  3 Feb 2022 00:26:03 +0000 (UTC)
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
Subject: [PATCH 5/6] MAINTAINERS: Add sensehat driver authors to MAINTAINERS
Date:   Wed,  2 Feb 2022 19:25:20 -0500
Message-Id: <20220203002521.162878-6-cmirabil@redhat.com>
In-Reply-To: <20220203002521.162878-1-cmirabil@redhat.com>
References: <20220203002521.162878-1-cmirabil@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the driver authors to MAINAINERS.

Co-developed-by: Mwesigwa Guma <mguma@redhat.com>
Signed-off-by: Mwesigwa Guma <mguma@redhat.com>
Co-developed-by: Joel Savitz <jsavitz@redhat.com>
Signed-off-by: Joel Savitz <jsavitz@redhat.com>
Signed-off-by: Charles Mirabile <cmirabil@redhat.com>
---
 MAINTAINERS | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f41088418aae..338df96ca782 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17389,6 +17389,18 @@ F:	Documentation/ABI/testing/sysfs-bus-iio-chemical-sunrise-co2
 F:	Documentation/devicetree/bindings/iio/chemical/senseair,sunrise.yaml
 F:	drivers/iio/chemical/sunrise_co2.c
 
+SENSEHAT DRIVER
+M:	Charles Mirabile <cmirabil@redhat.com>
+M:	Mwesigwa Guma <mguma@redhat.com>
+M:	Joel Savitz <jsavitz@redhat.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/auxdisplay/raspberrypi,sensehat-display.yaml
+F:	Documentation/devicetree/bindings/input/raspberrypi,sensehat-joystick.yaml
+F:	Documentation/devicetree/bindings/mfd/raspberrypi,sensehat.yaml
+F:	drivers/auxdisplay/sensehat-display.c
+F:	drivers/input/joystick/sensehat-joystick.c
+F:	include/linux/mfd/sensehat.h
+
 SENSIRION SCD30 CARBON DIOXIDE SENSOR DRIVER
 M:	Tomasz Duszynski <tomasz.duszynski@octakon.com>
 S:	Maintained
-- 
2.31.1

