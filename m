Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10BAF4FC4A3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 21:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349429AbiDKTIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 15:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349397AbiDKTHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 15:07:10 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A173388C;
        Mon, 11 Apr 2022 12:04:32 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id fc1656c0970162e0; Mon, 11 Apr 2022 21:04:30 +0200
Received: from kreacher.localnet (unknown [213.134.175.113])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id AD72966BDFD;
        Mon, 11 Apr 2022 21:04:29 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH 10/20] ACPICA: Removed some tabs and // comments
Date:   Mon, 11 Apr 2022 20:55:10 +0200
Message-ID: <8941089.CDJkKcVGEf@kreacher>
In-Reply-To: <5578328.DvuYhMxLoT@kreacher>
References: <5578328.DvuYhMxLoT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.175.113
X-CLIENT-HOSTNAME: 213.134.175.113
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrudekiedgudefhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepgfektdehueehteffueelleehhfffgfejtdehvddtfeetjeffveetheehvdejgfdunecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepvddufedrudefgedrudejhedruddufeenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrddujeehrdduudefpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeefpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosggvrhhtrdhmohhorhgvsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3 Fuz2=3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 0914618b553d6f3366e568409cebf2656891ca69

Automated cleanup; No functional changes.

Link: https://github.com/acpica/acpica/commit/0914618b
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/acpi/actbl1.h  |   12 ++++++------
 include/acpi/actbl2.h  |   40 ++++++++++++++++++++--------------------
 include/acpi/actypes.h |   16 ++++++++--------
 3 files changed, 34 insertions(+), 34 deletions(-)

Index: linux-pm/include/acpi/actbl1.h
===================================================================
--- linux-pm.orig/include/acpi/actbl1.h
+++ linux-pm/include/acpi/actbl1.h
@@ -379,15 +379,15 @@ struct acpi_cedt_cfmws_target_element {
 
 /* Values for Interleave Arithmetic field above */
 
-#define ACPI_CEDT_CFMWS_ARITHMETIC_MODULO	(0)
+#define ACPI_CEDT_CFMWS_ARITHMETIC_MODULO   (0)
 
 /* Values for Restrictions field above */
 
-#define ACPI_CEDT_CFMWS_RESTRICT_TYPE2		(1)
-#define ACPI_CEDT_CFMWS_RESTRICT_TYPE3		(1<<1)
-#define ACPI_CEDT_CFMWS_RESTRICT_VOLATILE	(1<<2)
-#define ACPI_CEDT_CFMWS_RESTRICT_PMEM		(1<<3)
-#define ACPI_CEDT_CFMWS_RESTRICT_FIXED		(1<<4)
+#define ACPI_CEDT_CFMWS_RESTRICT_TYPE2      (1)
+#define ACPI_CEDT_CFMWS_RESTRICT_TYPE3      (1<<1)
+#define ACPI_CEDT_CFMWS_RESTRICT_VOLATILE   (1<<2)
+#define ACPI_CEDT_CFMWS_RESTRICT_PMEM       (1<<3)
+#define ACPI_CEDT_CFMWS_RESTRICT_FIXED      (1<<4)
 
 /*******************************************************************************
  *
Index: linux-pm/include/acpi/actbl2.h
===================================================================
--- linux-pm.orig/include/acpi/actbl2.h
+++ linux-pm/include/acpi/actbl2.h
@@ -978,8 +978,8 @@ struct acpi_madt_multiproc_wakeup {
 	u64 base_address;
 };
 
-#define ACPI_MULTIPROC_WAKEUP_MB_OS_SIZE	2032
-#define ACPI_MULTIPROC_WAKEUP_MB_FIRMWARE_SIZE	2048
+#define ACPI_MULTIPROC_WAKEUP_MB_OS_SIZE        2032
+#define ACPI_MULTIPROC_WAKEUP_MB_FIRMWARE_SIZE  2048
 
 struct acpi_madt_multiproc_wakeup_mailbox {
 	u16 command;
@@ -1597,7 +1597,7 @@ struct acpi_nhlt_mic_device_specific_con
 
 /* Values for array_type_ext above */
 
-#define ACPI_NHLT_ARRAY_TYPE_RESERVED               0x09	// 9 and below are reserved
+#define ACPI_NHLT_ARRAY_TYPE_RESERVED               0x09	/* 9 and below are reserved */
 #define ACPI_NHLT_SMALL_LINEAR_2ELEMENT             0x0A
 #define ACPI_NHLT_BIG_LINEAR_2ELEMENT               0x0B
 #define ACPI_NHLT_FIRST_GEOMETRY_LINEAR_4ELEMENT    0x0C
@@ -1617,17 +1617,17 @@ struct acpi_nhlt_vendor_mic_count {
 struct acpi_nhlt_vendor_mic_config {
 	u8 type;
 	u8 panel;
-	u16 speaker_position_distance;	// mm
-	u16 horizontal_offset;	// mm
-	u16 vertical_offset;	// mm
-	u8 frequency_low_band;	// 5*hz
-	u8 frequency_high_band;	// 500*hz
-	u16 direction_angle;	// -180 - + 180
-	u16 elevation_angle;	// -180 - + 180
-	u16 work_vertical_angle_begin;	// -180 - + 180 with 2 deg step
-	u16 work_vertical_angle_end;	// -180 - + 180 with 2 deg step
-	u16 work_horizontal_angle_begin;	// -180 - + 180 with 2 deg step
-	u16 work_horizontal_angle_end;	// -180 - + 180 with 2 deg step
+	u16 speaker_position_distance;	/* mm */
+	u16 horizontal_offset;	/* mm */
+	u16 vertical_offset;	/* mm */
+	u8 frequency_low_band;	/* 5*Hz */
+	u8 frequency_high_band;	/* 500*Hz */
+	u16 direction_angle;	/* -180 - + 180 */
+	u16 elevation_angle;	/* -180 - + 180 */
+	u16 work_vertical_angle_begin;	/* -180 - + 180 with 2 deg step */
+	u16 work_vertical_angle_end;	/* -180 - + 180 with 2 deg step */
+	u16 work_horizontal_angle_begin;	/* -180 - + 180 with 2 deg step */
+	u16 work_horizontal_angle_end;	/* -180 - + 180 with 2 deg step */
 };
 
 /* Values for Type field above */
@@ -1638,9 +1638,9 @@ struct acpi_nhlt_vendor_mic_config {
 #define ACPI_NHLT_MIC_SUPER_CARDIOID        3
 #define ACPI_NHLT_MIC_HYPER_CARDIOID        4
 #define ACPI_NHLT_MIC_8_SHAPED              5
-#define ACPI_NHLT_MIC_RESERVED6             6	// 6 is reserved
+#define ACPI_NHLT_MIC_RESERVED6             6	/* 6 is reserved */
 #define ACPI_NHLT_MIC_VENDOR_DEFINED        7
-#define ACPI_NHLT_MIC_RESERVED              8	// 8 and above are reserved
+#define ACPI_NHLT_MIC_RESERVED              8	/* 8 and above are reserved */
 
 /* Values for Panel field above */
 
@@ -1650,12 +1650,12 @@ struct acpi_nhlt_vendor_mic_config {
 #define ACPI_NHLT_MIC_POSITION_RIGHT        3
 #define ACPI_NHLT_MIC_POSITION_FRONT        4
 #define ACPI_NHLT_MIC_POSITION_BACK         5
-#define ACPI_NHLT_MIC_POSITION_RESERVED     6	// 6 and above are reserved
+#define ACPI_NHLT_MIC_POSITION_RESERVED     6	/* 6 and above are reserved */
 
 struct acpi_nhlt_vendor_mic_device_specific_config {
 	struct acpi_nhlt_mic_device_specific_config mic_array_device_config;
 	u8 number_of_microphones;
-	struct acpi_nhlt_vendor_mic_config mic_config[];	// indexed by number_of_microphones
+	struct acpi_nhlt_vendor_mic_config mic_config[];	/* Indexed by number_of_microphones */
 };
 
 /* Microphone SNR and Sensitivity extension */
@@ -1668,8 +1668,8 @@ struct acpi_nhlt_mic_snr_sensitivity_ext
 /* Render device with feedback */
 
 struct acpi_nhlt_render_feedback_device_specific_config {
-	u8 feedback_virtual_slot;	// render slot in case of capture
-	u16 feedback_channels;	// informative only
+	u8 feedback_virtual_slot;	/* Render slot in case of capture */
+	u16 feedback_channels;	/* Informative only */
 	u16 feedback_valid_bits_per_sample;
 };
 
Index: linux-pm/include/acpi/actypes.h
===================================================================
--- linux-pm.orig/include/acpi/actypes.h
+++ linux-pm/include/acpi/actypes.h
@@ -539,14 +539,14 @@ typedef u64 acpi_integer;
  * Can be used with access_width of struct acpi_generic_address and access_size of
  * struct acpi_resource_generic_register.
  */
-#define ACPI_ACCESS_BIT_SHIFT		2
-#define ACPI_ACCESS_BYTE_SHIFT		-1
-#define ACPI_ACCESS_BIT_MAX		(31 - ACPI_ACCESS_BIT_SHIFT)
-#define ACPI_ACCESS_BYTE_MAX		(31 - ACPI_ACCESS_BYTE_SHIFT)
-#define ACPI_ACCESS_BIT_DEFAULT		(8 - ACPI_ACCESS_BIT_SHIFT)
-#define ACPI_ACCESS_BYTE_DEFAULT	(8 - ACPI_ACCESS_BYTE_SHIFT)
-#define ACPI_ACCESS_BIT_WIDTH(size)	(1 << ((size) + ACPI_ACCESS_BIT_SHIFT))
-#define ACPI_ACCESS_BYTE_WIDTH(size)	(1 << ((size) + ACPI_ACCESS_BYTE_SHIFT))
+#define ACPI_ACCESS_BIT_SHIFT           2
+#define ACPI_ACCESS_BYTE_SHIFT          -1
+#define ACPI_ACCESS_BIT_MAX             (31 - ACPI_ACCESS_BIT_SHIFT)
+#define ACPI_ACCESS_BYTE_MAX            (31 - ACPI_ACCESS_BYTE_SHIFT)
+#define ACPI_ACCESS_BIT_DEFAULT         (8 - ACPI_ACCESS_BIT_SHIFT)
+#define ACPI_ACCESS_BYTE_DEFAULT        (8 - ACPI_ACCESS_BYTE_SHIFT)
+#define ACPI_ACCESS_BIT_WIDTH(size)     (1 << ((size) + ACPI_ACCESS_BIT_SHIFT))
+#define ACPI_ACCESS_BYTE_WIDTH(size)    (1 << ((size) + ACPI_ACCESS_BYTE_SHIFT))
 
 /*******************************************************************************
  *



