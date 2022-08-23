Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C87359EBF3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 21:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbiHWTOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 15:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232460AbiHWTN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 15:13:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C42EC122BD5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 10:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661277006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CVE4380sDAsovAGhR6AZYNuZ8oLCxAJEqDFiZxuOg2E=;
        b=E8ehTqZt4vQtsTnIq2s/VyNMvx7JAQzA4VS/ikBMGOXMf9Bb0guFa2FEDDECldvDxmKW4H
        AbJfbEMpFiwrihN/4LsTXOVZhtqO9sxr3FDz+Hdby+fYMEatvwIpj9/MbXFhZ7Fb4QQVSo
        K2QATkcOAyXGyADverqGcMGFwMJExLI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-9-Zfk5GIb7MMiRaz01Ckvxkw-1; Tue, 23 Aug 2022 13:42:55 -0400
X-MC-Unique: Zfk5GIb7MMiRaz01Ckvxkw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C1845101E985;
        Tue, 23 Aug 2022 17:42:54 +0000 (UTC)
Received: from cmirabil.redhat.com (unknown [10.22.33.37])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5368214152E0;
        Tue, 23 Aug 2022 17:42:54 +0000 (UTC)
From:   Charles Mirabile <cmirabil@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Charles Mirabile <cmirabil@redhat.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        Serge Schneider <serge@raspberrypi.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Nicolas Saenz Julienne <nicolassaenzj@gmail.com>,
        Mattias Brugger <mbrugger@suse.com>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, rh-kdlp@googlegroups.com,
        Joel Savitz <jsavitz@redhat.com>
Subject: [PATCH 4/5] MAINTAINERS: Add sensehat driver authors to MAINTAINERS
Date:   Tue, 23 Aug 2022 13:41:57 -0400
Message-Id: <20220823174158.45579-5-cmirabil@redhat.com>
In-Reply-To: <20220823174158.45579-1-cmirabil@redhat.com>
References: <20220823174158.45579-1-cmirabil@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the driver authors to MAINAINERS.

Co-developed-by: Joel Savitz <jsavitz@redhat.com>
Signed-off-by: Joel Savitz <jsavitz@redhat.com>
Signed-off-by: Charles Mirabile <cmirabil@redhat.com>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 96f47a7865d6..3af3238a1535 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18344,6 +18344,16 @@ F:	Documentation/ABI/testing/sysfs-bus-iio-chemical-sunrise-co2
 F:	Documentation/devicetree/bindings/iio/chemical/senseair,sunrise.yaml
 F:	drivers/iio/chemical/sunrise_co2.c
 
+SENSEHAT DRIVER
+M:	Charles Mirabile <cmirabil@redhat.com>
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

