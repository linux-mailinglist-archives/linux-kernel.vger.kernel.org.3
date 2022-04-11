Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED02F4FC4B4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 21:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349515AbiDKTJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 15:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349509AbiDKTHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 15:07:40 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B432344EA;
        Mon, 11 Apr 2022 12:04:50 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id 56e7639797693efe; Mon, 11 Apr 2022 21:04:48 +0200
Received: from kreacher.localnet (unknown [213.134.175.113])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 24B0066BDFC;
        Mon, 11 Apr 2022 21:04:48 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH 00/20] ACPICA: ACPICA 20220331
Date:   Mon, 11 Apr 2022 20:46:03 +0200
Message-ID: <5578328.DvuYhMxLoT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.175.113
X-CLIENT-HOSTNAME: 213.134.175.113
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrudekiedgudefgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnheptdeihfelgfekieeuteffvdefkedthffhteehjeegfeelkefgjedtfeffhfetleeinecuffhomhgrihhnpegrtghpihgtrgdrohhrghenucfkphepvddufedrudefgedrudejhedruddufeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrddujeehrdduudefpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeefpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosggvrhhtrdhmohhorhgvsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3 Fuz2=3
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,SUBJ_ALL_CAPS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

This series of patches is a set of ACPICA 20220331 changes described at
https://acpica.org/sites/acpica/files/changes_62.txt ported to Linux.

It contains the following material:

Besar Wicaksono (1):
      ACPICA: Add support for ARM Performance Monitoring Unit Table.

Bob Moore (7):
      ACPICA: Add new acpi 6.4 semantics to the Load() operator
      ACPICA: Add new acpi 6.4 semantics for LoadTable() operator
      ACPICA: Update copyright notices to the year 2022
      ACPICA: Removed some tabs and // comments
      ACPICA: iASL/MADT: Add OEM-defined subtable
      ACPICA: exsystem.c: Use ACPI_FORMAT_UINT64 for 64-bit output.
      ACPICA: Update version to 20220331

Gustavo A. R. Silva (1):
      ACPICA: Headers: Replace zero-length array with flexible-array member

Lawrence Hileman (1):
      ACPICA: Add the subtable CFMWS to the CEDT table

Mario Limonciello (1):
      ACPICA: Add support for the Windows 11 _OSI string

Paul Menzel (3):
      ACPICA: executer/exsystem: Add units to time variable names
      ACPICA: executer/exsystem: Inform users about ACPI spec violation
      ACPICA: executer/exsystem: Warn about sleeps greater than 10 ms

Piotr Maziarz (3):
      ACPICA: iASL: NHLT: Treat Terminator as specific_config
      ACPICA: iASL: NHLT: Fix parsing undocumented bytes at the end of Endpoint Descriptor
      ACPICA: iASL: NHLT: Rename linux specific strucures to device_info

Selvarasu Ganesan (1):
      ACPICA: executer/exsystem: Fix some typo mistakes

Shameer Kolothum (1):
      ACPICA: IORT: Updates for revision E.d

Tom Rix (1):
      ACPICA: cleanup double word in comment

Thanks!



