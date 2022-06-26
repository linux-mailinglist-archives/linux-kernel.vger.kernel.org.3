Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A36055B02A
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 10:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234133AbiFZIMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 04:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234012AbiFZIMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 04:12:12 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E079FF7;
        Sun, 26 Jun 2022 01:12:11 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id h192so6310866pgc.4;
        Sun, 26 Jun 2022 01:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pbpsC1hb5CjUNlmeqoQsYEqMGRYWPD0QrDgAfxQ1i2o=;
        b=aNm3Xpehhjsx25GLMWzN8F8F6PMo5uq/K3HNwt32ri39b/vDTuPTUrwbmh0ii4+E6w
         fu61v7b7y/1+0T8v5yFJQXIcbLWMD4P95Y2vYLDstET+CLJ7LYLpVUEd08yJxsZXMql6
         z0+IChArZSN8CovbzjA3rq0EPpP5ThvfpFFWc8mTgel0xmGZXj/4yA4T/HiKndes9bvB
         IvD1yF2TNXhtubCh/tERRnMNfonIf618LIyZVDsa5W+6dcRlQZMiS1rVZJ+th6BA0wjo
         Co7k0zqpTu+lryKFV7Ng7wlZZjCocRJ087vVADamKsC6A97zH7D1AFVqM4+0dogpzyHW
         BlQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pbpsC1hb5CjUNlmeqoQsYEqMGRYWPD0QrDgAfxQ1i2o=;
        b=j9EQN+IYkT9ID+MsgZ/oWIQ9Csq5p4pkSpPI3g5OpWbxcKUZcz7U0PeK/HkMTkdp1i
         ISnWgbPe45d/OWS7q+A1oMsWHYgxgOmXWiCno7dpIR+riz9GSMAIkdnXhuTtXZNj2AL5
         RHa4DIb/qQfv6Z2md7RlYr7/nlziox2OgqOLUuMbxH3OieoemCKEtyRgK22T8ORfSetY
         ymPaRlywnJrrDmLcQMTuHtc5uS7FrG2JzNpaPOn7daHxPXSc9s4kD41tPYCcLE/QklZQ
         NkFq0BTqeAgjkuQhNQOx9Cw4oAqiqS5H5+GMs2/s0iGXfX6ROp7NNW/OuA4ORQnpAPyg
         EA/Q==
X-Gm-Message-State: AJIora/63NVwKVE2xcDR1zP1S/HsEN4lPtfzrS6vuG4khbBUmAe+X7M0
        rzLimP9MNhntNgDKhJQUShw=
X-Google-Smtp-Source: AGRyM1vVCZavIfctuCs4ZrDWRPBmVBc1IT1GnyDNamQ6bJars7c1RdDmJXM6fWyDsCIq15O8F+IzYA==
X-Received: by 2002:a62:3302:0:b0:524:e839:c3b8 with SMTP id z2-20020a623302000000b00524e839c3b8mr8359218pfz.76.1656231131180;
        Sun, 26 Jun 2022 01:12:11 -0700 (PDT)
Received: from fedora.flets-east.jp ([2400:4050:c360:8200:8ae8:3c4:c0da:7419])
        by smtp.gmail.com with ESMTPSA id h9-20020a170902f70900b001663cf001besm4764021plo.174.2022.06.26.01.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jun 2022 01:12:10 -0700 (PDT)
From:   Akihiko Odaki <akihiko.odaki@gmail.com>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Akihiko Odaki <akihiko.odaki@gmail.com>
Subject: [PATCH] HID: hid-sensor-hub: Remove unused macros
Date:   Sun, 26 Jun 2022 17:12:01 +0900
Message-Id: <20220626081201.7145-1-akihiko.odaki@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit b0f847e16c1e ("HID: hid-sensor-hub: Force logical minimum to 1
for power and report state"), which removed the code using the macros,
did not remove them.

Signed-off-by: Akihiko Odaki <akihiko.odaki@gmail.com>
---
 drivers/hid/hid-ids.h        | 13 -------------
 drivers/hid/hid-sensor-hub.c |  2 --
 2 files changed, 15 deletions(-)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index d9eb676abe96..155fdd2cd30a 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -631,15 +631,6 @@
 #define USB_VENDOR_ID_ILITEK		0x222a
 #define USB_DEVICE_ID_ILITEK_MULTITOUCH	0x0001
 
-#define USB_VENDOR_ID_INTEL_0		0x8086
-#define USB_VENDOR_ID_INTEL_1		0x8087
-#define USB_DEVICE_ID_INTEL_HID_SENSOR_0	0x09fa
-#define USB_DEVICE_ID_INTEL_HID_SENSOR_1	0x0a04
-
-#define USB_VENDOR_ID_STM_0             0x0483
-#define USB_DEVICE_ID_STM_HID_SENSOR    0x91d1
-#define USB_DEVICE_ID_STM_HID_SENSOR_1  0x9100
-
 #define USB_VENDOR_ID_ION		0x15e4
 #define USB_DEVICE_ID_ICADE		0x0132
 
@@ -669,10 +660,7 @@
 #define USB_VENDOR_ID_ITE               0x048d
 #define I2C_VENDOR_ID_ITE		0x103c
 #define I2C_DEVICE_ID_ITE_VOYO_WINPAD_A15	0x184f
-#define USB_DEVICE_ID_ITE_LENOVO_YOGA   0x8386
-#define USB_DEVICE_ID_ITE_LENOVO_YOGA2  0x8350
 #define I2C_DEVICE_ID_ITE_LENOVO_LEGION_Y720	0x837a
-#define USB_DEVICE_ID_ITE_LENOVO_YOGA900	0x8396
 #define USB_DEVICE_ID_ITE8595		0x8595
 #define USB_DEVICE_ID_ITE_MEDION_E1239T	0xce50
 
@@ -1211,7 +1199,6 @@
 #define USB_DEVICE_ID_SYNAPTICS_ACER_ONE_S1003	0x73f5
 #define USB_DEVICE_ID_SYNAPTICS_ACER_SWITCH5	0x81a7
 
-#define USB_VENDOR_ID_TEXAS_INSTRUMENTS	0x2047
 #define USB_DEVICE_ID_TEXAS_INSTRUMENTS_LENOVO_YOGA	0x0855
 
 #define USB_VENDOR_ID_THINGM		0x27b8
diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index 6abd3e2a9094..22fd680f3f8f 100644
--- a/drivers/hid/hid-sensor-hub.c
+++ b/drivers/hid/hid-sensor-hub.c
@@ -14,8 +14,6 @@
 #include <linux/hid-sensor-hub.h>
 #include "hid-ids.h"
 
-#define HID_SENSOR_HUB_ENUM_QUIRK	0x01
-
 /**
  * struct sensor_hub_data - Hold a instance data for a HID hub device
  * @mutex:		Mutex to serialize synchronous request.
-- 
2.36.1

