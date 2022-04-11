Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4F124FC49E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 21:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349463AbiDKTH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 15:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349414AbiDKTHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 15:07:13 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B1933E01;
        Mon, 11 Apr 2022 12:04:35 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id 637c3884135cd960; Mon, 11 Apr 2022 21:04:33 +0200
Received: from kreacher.localnet (unknown [213.134.175.113])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id C797266BDFC;
        Mon, 11 Apr 2022 21:04:32 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH 08/20] ACPICA: Clean up double word in comment
Date:   Mon, 11 Apr 2022 20:53:22 +0200
Message-ID: <21448490.EfDdHjke4D@kreacher>
In-Reply-To: <5578328.DvuYhMxLoT@kreacher>
References: <5578328.DvuYhMxLoT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.175.113
X-CLIENT-HOSTNAME: 213.134.175.113
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrudekiedgudefgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepgfektdehueehteffueelleehhfffgfejtdehvddtfeetjeffveetheehvdejgfdunecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepvddufedrudefgedrudejhedruddufeenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrddujeehrdduudefpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeefpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosggvrhhtrdhmohhorhgvsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3 Fuz2=3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

ACPICA commit 01f43b049722fa7613fca3c9fa657b150fae8ac1

Remove the second 'know' and 'than'.

Link: https://github.com/acpica/acpica/commit/01f43b04
Signed-off-by: Tom Rix <trix@redhat.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 exfldio.c |    2 +-
 hwregs.c  |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff -Nurp linux.before_name/drivers/acpi/acpica/exfldio.c linux.after_name/drivers/acpi/acpica/exfldio.c
--- linux.before_name/drivers/acpi/acpica/exfldio.c	2022-04-01 18:24:45.720672171 +0200
+++ linux.after_name/drivers/acpi/acpica/exfldio.c	2022-04-01 18:24:42.481713739 +0200
@@ -104,7 +104,7 @@ acpi_ex_setup_region(union acpi_operand_
 #ifdef ACPI_UNDER_DEVELOPMENT
 	/*
 	 * If the Field access is any_acc, we can now compute the optimal
-	 * access (because we know know the length of the parent region)
+	 * access (because we know the length of the parent region)
 	 */
 	if (!(obj_desc->common.flags & AOPOBJ_DATA_VALID)) {
 		if (ACPI_FAILURE(status)) {
diff -Nurp linux.before_name/drivers/acpi/acpica/hwregs.c linux.after_name/drivers/acpi/acpica/hwregs.c
--- linux.before_name/drivers/acpi/acpica/hwregs.c	2022-04-01 18:24:45.726672095 +0200
+++ linux.after_name/drivers/acpi/acpica/hwregs.c	2022-04-01 18:24:42.487713662 +0200
@@ -446,7 +446,7 @@ struct acpi_bit_register_info *acpi_hw_g
  * RETURN:      Status
  *
  * DESCRIPTION: Write the PM1 A/B control registers. These registers are
- *              different than than the PM1 A/B status and enable registers
+ *              different than the PM1 A/B status and enable registers
  *              in that different values can be written to the A/B registers.
  *              Most notably, the SLP_TYP bits can be different, as per the
  *              values returned from the _Sx predefined methods.



