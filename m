Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0994CC42F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 18:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235160AbiCCRli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 12:41:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235456AbiCCRlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 12:41:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2DC6C1A1C7B
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 09:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646329239;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=75fiNtP6TryBTCoq0L/i/NBN7hNVOksPnCdMHr7ZliA=;
        b=dQejRnglxA2Q1TYu31sMo4wV6Z40MdmCP7dUbw0n+lH+fFQHENYTnGR9MNo1mgmZB1Ox5r
        fpbP75wjlvQAJ9m6Ddebx+m/ArAUBut2+4O3mD5kijp0+f41VZk7p5s1aCIpjW5R1dGe2R
        mAd/iPmEWjq6+G38MWet3I0wCaxzgNY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-355-nrzwoSsEPMSvrs6vDyll6g-1; Thu, 03 Mar 2022 12:40:36 -0500
X-MC-Unique: nrzwoSsEPMSvrs6vDyll6g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 968F81091DA3;
        Thu,  3 Mar 2022 17:40:34 +0000 (UTC)
Received: from cmirabil.remote.csb (unknown [10.22.9.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6BFFE804F7;
        Thu,  3 Mar 2022 17:40:33 +0000 (UTC)
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
Subject: [PATCH v7 6/6] DO NOT MERGE: full sensehat device tree overlay for raspberry pi 4
Date:   Thu,  3 Mar 2022 12:39:35 -0500
Message-Id: <20220303173935.100622-7-cmirabil@redhat.com>
In-Reply-To: <20220303173935.100622-1-cmirabil@redhat.com>
References: <20220303173935.100622-1-cmirabil@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch should not be merged - dtbs files are not stored in the
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

