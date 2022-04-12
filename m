Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A117B4FE975
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 22:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiDLU2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 16:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232218AbiDLU1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 16:27:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E2599DD975
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 13:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649794458;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wKeEjLPVCQWQYsPyoUlmVTqyS0GcmUXtUuQ8I/MM+9k=;
        b=d1APatTUtJgTTmLWKehB8mbBAuQPeaXhE7p9YFm+MmGo4ja/FFno4+FEofGTvyeX5gNU3P
        IOpT9zp0uU5PlCfeJBiFyaiIPlnbEP0e27O0YpzjcRS3YTqnLXVI9Z3lIISYYRMsYGZCy1
        kKNK9DnhbhWryN9x3jlwQG+Mm0IzsN0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-460-9r7wI2JXNEKUjGeycyMjeA-1; Tue, 12 Apr 2022 16:14:14 -0400
X-MC-Unique: 9r7wI2JXNEKUjGeycyMjeA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 68A721C05155;
        Tue, 12 Apr 2022 20:14:14 +0000 (UTC)
Received: from cmirabil.remote.csb (unknown [10.22.32.76])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F3397416363;
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
Subject: [PATCH v8 6/6] DO NOT MERGE: full sensehat device tree overlay for raspberry pi 4
Date:   Tue, 12 Apr 2022 16:13:43 -0400
Message-Id: <20220412201343.8074-7-cmirabil@redhat.com>
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

This patch shold not be merged - dtbs files are not stored in the
kernel tree. We just provide this file so the code can be tested.

This overlay is suitable for testing the driver, it can be compiled with
dtc and put in the /boot/overlays/ folder then specified in config.txt
by putting the lines:

dtoverlay=		#suppress loading of default overlay for HAT
dtoverlay=sensehat	#load custom overlay

at the beginning before any other lines in config.txt

Co-developed-by: Mwesigwa Guma <mguma@redhat.com>
Signed-off-by: Mwesigwa Guma <mguma@redhat.com>
Co-developed-by: Joel Savitz <jsavitz@redhat.com>
Signed-off-by: Joel Savitz <jsavitz@redhat.com>
Signed-off-by: Charles Mirabile <cmirabil@redhat.com>
---
 sensehat.dtbs | 54 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 sensehat.dtbs

diff --git a/sensehat.dtbs b/sensehat.dtbs
new file mode 100644
index 000000000000..82d129c847fb
--- /dev/null
+++ b/sensehat.dtbs
@@ -0,0 +1,54 @@
+/dts-v1/;
+/plugin/;
+
+/ {
+	compatible = "brcm,bcm2835";
+};
+
+&i2c1 {
+	#address-cells = <0x01>;
+	#size-cells = <0x00>;
+	status = "okay";
+
+	sensehat@46 {
+		#address-cells = <0x01>;
+		#size-cells = <0x00>;
+		compatible = "raspberrypi,sensehat";
+		reg = <0x46>;
+		interrupt-parent = <&gpio>;
+		status = "okay";
+		display {
+			compatible = "raspberrypi,sensehat-display";
+			status = "okay";
+		};
+		joystick {
+			compatible = "raspberrypi,sensehat-joystick";
+			interrupts = <23 1>;
+			status = "okay";
+		};
+	};
+
+	lsm9ds1-magn@1c {
+		compatible = "st,lsm9ds1-magn";
+		reg = <0x1c>;
+		status = "okay";
+	};
+
+	lsm9ds1-accel@6a {
+		compatible = "st,lsm9ds1-accel";
+		reg = <0x6a>;
+		status = "okay";
+	};
+
+	lps25h-press@5c {
+		compatible = "st,lps25h-press";
+		reg = <0x5c>;
+		status = "okay";
+	};
+
+	hts221-humid@5f {
+		compatible = "st,hts221-humid\0st,hts221";
+		reg = <0x5f>;
+		status = "okay";
+	};
+};
-- 
2.31.1

