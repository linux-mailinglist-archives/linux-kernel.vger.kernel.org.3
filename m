Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49B974FC491
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 21:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349365AbiDKTGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 15:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349336AbiDKTGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 15:06:37 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD9A14007;
        Mon, 11 Apr 2022 12:04:20 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id 0b0baabfe54f0db8; Mon, 11 Apr 2022 21:04:18 +0200
Received: from kreacher.localnet (unknown [213.134.175.113])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id EBB3A66BDFD;
        Mon, 11 Apr 2022 21:04:17 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH 18/20] ACPICA: IORT: Updates for revision E.d
Date:   Mon, 11 Apr 2022 21:02:33 +0200
Message-ID: <44610361.fMDQidcC6G@kreacher>
In-Reply-To: <5578328.DvuYhMxLoT@kreacher>
References: <5578328.DvuYhMxLoT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.175.113
X-CLIENT-HOSTNAME: 213.134.175.113
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrudekiedgudefgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepgfektdehueehteffueelleehhfffgfejtdehvddtfeetjeffveetheehvdejgfdunecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepvddufedrudefgedrudejhedruddufeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrddujeehrdduudefpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeefpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosggvrhhtrdhmohhorhgvsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3 Fuz2=3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

ACPICA commit 87a2e39b8abdfedfb86b0a105708e37e895becd9

IORT revision is now updated to E.d (ARM DEN 0049E.d) and
contains a few additions like,
    -Added descriptor in the root complex node for specifying
     PASID width supported by the root complex.
    -Updated RMR node Flags field.
    -Introduced memory access attributes in the RMR node.

Please note that IORT Rev E.c is deprecated and not supported.

Link: https://github.com/acpica/acpica/commit/87a2e39b
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/acpi/actbl2.h |   27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

Index: linux-pm/include/acpi/actbl2.h
===================================================================
--- linux-pm.orig/include/acpi/actbl2.h
+++ linux-pm/include/acpi/actbl2.h
@@ -357,7 +357,7 @@ struct acpi_table_bdat {
  * IORT - IO Remapping Table
  *
  * Conforms to "IO Remapping Table System Software on ARM Platforms",
- * Document number: ARM DEN 0049E.b, Feb 2021
+ * Document number: ARM DEN 0049E.d, Feb 2022
  *
  ******************************************************************************/
 
@@ -454,7 +454,8 @@ struct acpi_iort_root_complex {
 	u32 ats_attribute;
 	u32 pci_segment_number;
 	u8 memory_address_limit;	/* Memory address size limit */
-	u8 reserved[3];		/* Reserved, must be zero */
+	u16 pasid_capabilities;	/* PASID Capabilities */
+	u8 reserved[1];		/* Reserved, must be zero */
 };
 
 /* Masks for ats_attribute field above */
@@ -463,6 +464,9 @@ struct acpi_iort_root_complex {
 #define ACPI_IORT_PRI_SUPPORTED         (1<<1)	/* The root complex PRI support */
 #define ACPI_IORT_PASID_FWD_SUPPORTED   (1<<2)	/* The root complex PASID forward support */
 
+/* Masks for pasid_capabilities field above */
+#define ACPI_IORT_PASID_MAX_WIDTH       (0x1F)	/* Bits 0-4 */
+
 struct acpi_iort_smmu {
 	u64 base_address;	/* SMMU base address */
 	u64 span;		/* Length of memory range */
@@ -538,6 +542,25 @@ struct acpi_iort_rmr {
 	u32 rmr_offset;
 };
 
+/* Masks for Flags field above */
+#define ACPI_IORT_RMR_REMAP_PERMITTED      (1)
+#define ACPI_IORT_RMR_ACCESS_PRIVILEGE     (1<<1)
+
+/*
+ * Macro to access the Access Attributes in flags field above:
+ *  Access Attributes is encoded in bits 9:2
+ */
+#define ACPI_IORT_RMR_ACCESS_ATTRIBUTES(flags)          (((flags) >> 2) & 0xFF)
+
+/* Values for above Access Attributes */
+
+#define ACPI_IORT_RMR_ATTR_DEVICE_NGNRNE   0x00
+#define ACPI_IORT_RMR_ATTR_DEVICE_NGNRE    0x01
+#define ACPI_IORT_RMR_ATTR_DEVICE_NGRE     0x02
+#define ACPI_IORT_RMR_ATTR_DEVICE_GRE      0x03
+#define ACPI_IORT_RMR_ATTR_NORMAL_NC       0x04
+#define ACPI_IORT_RMR_ATTR_NORMAL_IWB_OWB  0x05
+
 struct acpi_iort_rmr_desc {
 	u64 base_address;
 	u64 length;



