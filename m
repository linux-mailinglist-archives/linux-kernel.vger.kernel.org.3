Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F07C4EB29B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 19:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240144AbiC2RXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 13:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240131AbiC2RXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 13:23:09 -0400
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1D217942F;
        Tue, 29 Mar 2022 10:21:26 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id j2so32809225ybu.0;
        Tue, 29 Mar 2022 10:21:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=r7CR/Z3/sm99oIj+VfKWrNGOkB1FFtE6thjbTjuUH9s=;
        b=68ln0HiBrvJj9hF3tkTIenM0dGEXTQqxl5rUhJipvV59GieN2kEhyKKQmJSN2+K/Pj
         lr0M/kUyJs0UVsNJ6KJ0S1WSQnM+GU1Jb4dB0wyTsUy3rlSWYA4lS2qMNcS2vSvz39S5
         BfelijA9km8XrYXkkbQ3/XJk2Yp9r07aW5Fhjx0cCuBhT2PsIvezm9T3KLJ1sZ3Y0r8L
         1edZzmToiiumAVRqyZ0fwt8TkZ3a+WMFvnaEhvJ1Z4oK5BiOaOMdaR0ixIjFwNvsJD/k
         xuxSNLCIv86lUz2pdOPZktHmOWmrm5rfx6q/8a9KnO134sXlboz0BM32JR2X9HmR14mr
         sV/A==
X-Gm-Message-State: AOAM533KYFgNWWO1QHuhTbn0Jzf5CXa7R7Kf+6n1nQfcVSkSql51n9lo
        MsNt72NAecCyg32DRzk7IPGYp2+fSfBs+wppBJaRHaOFeis=
X-Google-Smtp-Source: ABdhPJzcZRQJO/IgQuH5n4OH9QT9g2LgQj0VTrw97ZuIEOuXuxePGJ3i7cuXVbbmWtCsRo1TlRk1krNXlXUTsERbz5o=
X-Received: by 2002:a25:bbc1:0:b0:610:b4ce:31db with SMTP id
 c1-20020a25bbc1000000b00610b4ce31dbmr29314502ybk.482.1648574485880; Tue, 29
 Mar 2022 10:21:25 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 29 Mar 2022 19:21:15 +0200
Message-ID: <CAJZ5v0iwvLGqzv=QQcqdoH99GnVx56qjeufcKRqoOGo=FRUHdg@mail.gmail.com>
Subject: [GIT PULL] Device properties code update for v5.18-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 devprop-5.18-rc1

with top-most commit b2638e56c2ced2ca258d22f939c47327b189e00c

 device property: Don't split fwnode_get_irq*() APIs in the code

on top of commit 754e0b0e35608ed5206d6a67a791563c631cec07

 Linux 5.17-rc4

to receive a device properties code update for 5.18-rc1.

This includes new i2c material for 5.18-rc1 and simply reorganizes
the code on top of it so as to group similar functions together (Andy
Shevchenko).

Thanks!


---------------

Akhil R (3):
      device property: Add fwnode_irq_get_byname
      docs: firmware-guide: ACPI: Add named interrupt doc
      i2c: smbus: Use device_*() functions instead of of_*()

Andy Shevchenko (1):
      device property: Don't split fwnode_get_irq*() APIs in the code

---------------

 Documentation/firmware-guide/acpi/enumeration.rst | 39 ++++++++++++++++++++
 drivers/base/property.c                           | 45 +++++++++++++++++++----
 drivers/i2c/i2c-core-base.c                       |  2 +-
 drivers/i2c/i2c-core-smbus.c                      | 11 +++---
 drivers/i2c/i2c-smbus.c                           |  5 ++-
 include/linux/i2c-smbus.h                         |  6 +--
 include/linux/property.h                          |  7 ++--
 7 files changed, 93 insertions(+), 22 deletions(-)
