Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 734FE4FE971
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 22:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbiDLU2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 16:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232193AbiDLU1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 16:27:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E1E29DD972
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 13:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649794457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=liyDBksEV8Ds9UUCGHCo4lLnPFrUOPH88WtIoxg4upQ=;
        b=ikjxQWgczlg9yB+Ghi2Se8M9YW5ksD7f5UW4xWvcb+39nDaOJqQJ5DNH1ODX8fc2m+AIOb
        XK6BtTg7oDHV94vTLKksTy0Tc1yRkeZ0u1prnpwdzJ5v7Fni9W+x0HU52sHVOEzBInI2cs
        7R86l2KkZgHK7aBAcV69BSQtV/ewiGo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-410-Au-6FQUQOHajVPJRVZWeNw-1; Tue, 12 Apr 2022 16:14:14 -0400
X-MC-Unique: Au-6FQUQOHajVPJRVZWeNw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E4BA4185A7B2;
        Tue, 12 Apr 2022 20:14:13 +0000 (UTC)
Received: from cmirabil.remote.csb (unknown [10.22.32.76])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 79386416363;
        Tue, 12 Apr 2022 20:14:13 +0000 (UTC)
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
Subject: [PATCH v8 5/6] MAINTAINERS: Add sensehat driver authors to MAINTAINERS
Date:   Tue, 12 Apr 2022 16:13:42 -0400
Message-Id: <20220412201343.8074-6-cmirabil@redhat.com>
In-Reply-To: <20220412201343.8074-1-cmirabil@redhat.com>
References: <20220412201343.8074-1-cmirabil@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 61d9f114c37f..708bdccee4b3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17745,6 +17745,17 @@ F:	Documentation/ABI/testing/sysfs-bus-iio-chemical-sunrise-co2
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
+
 SENSIRION SCD30 CARBON DIOXIDE SENSOR DRIVER
 M:	Tomasz Duszynski <tomasz.duszynski@octakon.com>
 S:	Maintained
-- 
2.31.1

