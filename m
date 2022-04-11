Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 021EE4FC490
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 21:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349360AbiDKTGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 15:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349338AbiDKTGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 15:06:37 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E61AA17E32;
        Mon, 11 Apr 2022 12:04:21 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id cf7a92b9eec07bc9; Mon, 11 Apr 2022 21:04:20 +0200
Received: from kreacher.localnet (unknown [213.134.175.113])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 8637566BDFD;
        Mon, 11 Apr 2022 21:04:19 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH 17/20] ACPICA: executer/exsystem: Fix some typo mistakes
Date:   Mon, 11 Apr 2022 21:01:36 +0200
Message-ID: <1879458.taCxCBeP46@kreacher>
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

From: Selvarasu Ganesan <selvarasu.ganesan@arm.com>

ACPICA commit 441747f1dcff770d692acbfd4d85b2cfaabdb38a

Link: https://github.com/acpica/acpica/commit/441747f1
Signed-off-by: Selvarasu Ganesan <selvarasu.ganesan@arm.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 exsystem.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff -Nurp linux.before_name/drivers/acpi/acpica/exsystem.c linux.after_name/drivers/acpi/acpica/exsystem.c
--- linux.before_name/drivers/acpi/acpica/exsystem.c	2022-04-01 18:28:19.025995819 +0200
+++ linux.after_name/drivers/acpi/acpica/exsystem.c	2022-04-01 18:28:14.163056634 +0200
@@ -137,7 +137,7 @@ acpi_status acpi_ex_system_do_stall(u32
 			    "Time parameter is too large (%u)", how_long_us));
 		status = AE_AML_OPERAND_VALUE;
 	} else {
-		if (how_long_US > 100) {
+		if (how_long_us > 100) {
 			ACPI_WARNING((AE_INFO,
 				      "Time parameter %u us > 100 us violating ACPI spec, please fix the firmware.",
 				      how_long_us));
@@ -175,8 +175,8 @@ acpi_status acpi_ex_system_do_sleep(u64
 	 */
 	if (how_long_ms > 10) {
 		ACPI_WARNING((AE_INFO,
-			      "Firmware issue: Excessive sleep time (%llu ms > 10 ms) in ACPI Control Method",
-			      how_long_us));
+			      "Firmware issue: Excessive sleep time (%lu ms > 10 ms) in ACPI Control Method",
+			      how_long_ms));
 	}
 
 	/*



