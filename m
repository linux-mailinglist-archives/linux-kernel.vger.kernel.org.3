Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A54947D558
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 17:44:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344192AbhLVQo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 11:44:26 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:64872 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343994AbhLVQna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 11:43:30 -0500
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 4.0.0)
 id 6d670e2c93a6c7f1; Wed, 22 Dec 2021 17:43:29 +0100
Received: from kreacher.localnet (unknown [213.134.181.48])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 05FAF66AF2B;
        Wed, 22 Dec 2021 17:43:28 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH 00/19] ACPICA: ACPICA 20211217
Date:   Wed, 22 Dec 2021 16:56:02 +0100
Message-ID: <11889746.O9o76ZdvQC@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.181.48
X-CLIENT-HOSTNAME: 213.134.181.48
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvuddruddtiedgkeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedtiefhlefgkeeiueetffdvfeektdfhhfetheejgeefleekgfejtdeffffhteelieenucffohhmrghinheprggtphhitggrrdhorhhgnecukfhppedvudefrddufeegrddukedurdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrddukedurdegkedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohgsvghrthdrmhhoohhrvgesihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3 Fuz2=3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

This series of patches is a set of ACPICA 20211217 changes described at
https://acpica.org/sites/acpica/files/changes_61.txt ported to Linux.

It contains the following material:

Bob Moore (7):
      ACPICA: iASL/Disassembler: Additional support for NHLT table
      ACPICA: iASL Table Compiler: Complete NHLT table support
      ACPICA: Change a return_ACPI_STATUS (AE_BAD_PARAMETER)
      ACPICA: Fixed a couple of warnings under MSVC
      ACPICA: iASL: Add TDEL table to both compiler/disassembler
      ACPICA: iASL/NHLT table: "Specific Data" field support
      ACPICA: Update version to 20211217

Ilkka Koskinen (1):
      ACPICA: iASL: Add suppport for AGDI table

Jessica Clarke (4):
      ACPICA: Use original data_table_region pointer for accesses
      ACPICA: Use original pointer for virtual origin tables
      ACPICA: Macros: Remove ACPI_PHYSADDR_TO_PTR
      ACPICA: Avoid subobject buffer overflow when validating RSDP signature

Kirill A. Shutemov (1):
      ACPICA: Hardware: Do not flush CPU cache when entering S4 and S5

Mark Langsdorf (1):
      ACPICA: actypes.h: Expand the ACPI_ACCESS_ definitions

Rafael J. Wysocki (2):
      ACPICA: Utilities: Avoid deleting the same object twice in a row
      ACPICA: Executer: Fix the REFCLASS_REFOF case in acpi_ex_opcode_1A_0T_1R ()

Shuuichirou Ishii (1):
      ACPICA: Fix AEST Processor generic resource substructure data field byte length

Sudeep Holla (2):
      ACPICA: Fix wrong interpretation of PCC address
      ACPICA: Add support for PCC Opregion special context data

Thanks!



