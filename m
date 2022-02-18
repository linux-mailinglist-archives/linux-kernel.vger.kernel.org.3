Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB3DB4BBFF1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 19:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235818AbiBRSvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 13:51:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbiBRSvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 13:51:06 -0500
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE0DF4F9D1;
        Fri, 18 Feb 2022 10:50:47 -0800 (PST)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-2d646fffcc2so75981667b3.4;
        Fri, 18 Feb 2022 10:50:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=FzZ5B9W1k/xR96/hBg427el+YqdSOSu1G9k+959cWqs=;
        b=OQOiYFqJxqJXtXb+VIKHMlJaaG0vl7EY7rwZwIIYPHP9iS0q9WlwQWYcmFSTCEznX1
         4P/ywGlyhqB+R9BmaWw8vGRfSR7zVMWdIFfYgghyjWUA+bdtw4vxEwNYNHWC7ir1wCyv
         UrSkaTqzKHDOKD207T+9h/BC/xJ5TXsY4jzAFD7Bi2Ty9boXeSJ7Pg/1PkZ3SehWBWiI
         dozDdX+jpMSAii5TtfR6GJfHlYKrKY1wxiFHx4/8WdjBx1h2Z2mbJsJ+fI9Yrz3q7frX
         EBw9siHnsmv4+LQbrWvtN7N2R8LyMtq9NmYurJC4Qdf7Vvsd4A2FTIzaC6aEL44lA+Bd
         nrRQ==
X-Gm-Message-State: AOAM530Gu8bAG/DgsmzivG5UPRXICIq64G9RlBByVsDgHqkB64bFtkZ9
        bzyh3shvS2i+/h0K9Ku0grm/xGhvlR0nei7Kkt0=
X-Google-Smtp-Source: ABdhPJy47r4CwcBqlT6iTHARgLLEgzxN3uRCzMxvN//kYyiv9J6ZtEYCuc2C9JwqHKwuLWTqf3hqwOPJsIrxbuHZzS8=
X-Received: by 2002:a81:f008:0:b0:2d0:cd72:74e5 with SMTP id
 p8-20020a81f008000000b002d0cd7274e5mr8945474ywm.301.1645210247173; Fri, 18
 Feb 2022 10:50:47 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 18 Feb 2022 19:50:36 +0100
Message-ID: <CAJZ5v0hpQzGdX0HW94fgFG0LjTcKs0s9PgczzjVUcz8AaRPpqg@mail.gmail.com>
Subject: [GIT PULL] ACPI fixes for v5.17-rc5
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-5.17-rc5

with top-most commit 8292656464e5f066d46cb73da957930613a2c597

 Merge branch 'acpi-processor'

on top of commit 754e0b0e35608ed5206d6a67a791563c631cec07

 Linux 5.17-rc4

to receive ACPI fixes for 5.17-rc5.

These make an excess warning message go away and fix a recently
introduced boot failure on a vintage machine.

Specifics:

 - Change the log level of the "table not found" message in
   acpi_table_parse_entries_array() to debug to prevent it from
   showing up in the logs unnecessarily (Dan Williams).

 - Add a C-state limit quirk for 32-bit ThinkPad T40 to prevent it
   from crashing on boot after recent changes in the ACPI processor
   driver (Woody Suwalski).

Thanks!


---------------

Dan Williams (1):
      ACPI: tables: Quiet ACPI table not found warning

Woody Suwalski (1):
      ACPI: processor: idle: fix lockup regression on 32-bit ThinkPad T40

---------------

 drivers/acpi/processor_idle.c | 5 +++++
 drivers/acpi/tables.c         | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)
