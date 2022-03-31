Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 311CE4EDF7A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 19:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbiCaRTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 13:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiCaRSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 13:18:55 -0400
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B608E0E2;
        Thu, 31 Mar 2022 10:17:08 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-2e5e176e1b6so5319817b3.13;
        Thu, 31 Mar 2022 10:17:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Bi64VQ+Khg5UK1gSOPf2RqNXb/UgNoMXBN9uv9DgbzQ=;
        b=wL2XuTZ/ZYrXoHN/ea3tZmKvPyqfNbuwdoWposBHiHm2hq6oWGyebTgV2rzvs2wFco
         LCbJEMK8DTBYwOFOc73C/8pqJd6MreldVCMzzYrzWjDE1TP80lCSURrwWv4nlaSAzTMo
         jhx9Tm8flQRq2M1gHm4Scgowjcy19ej+W8YUrxAiwZD55XC8nIHz8Ai/e3P++YEU/uqV
         fEEmEJ5/O83aCe5gAXmF90rugNN8d+K4yhcV6cJb4XBHQ8TLZvXijkUhQ+dJI3i+GMIl
         QbBVqdQowVPv/mnWpbzAEc6IxmxOy2tYI0xPvdWILxGS4arJlO/tPtKWnndMq5zZO0gM
         km7w==
X-Gm-Message-State: AOAM530BoGO1Nvh4fVCqyqoup2qAncUIkRg/aPCMF/fgtQC9ZCkbAFoG
        SDoEhJ/pVU84M/eBk8nBDNPx8gjCVNqlSDIy0ciFDNXHsc0=
X-Google-Smtp-Source: ABdhPJxq3HfUPuua8v/lJf49OO3v7vDilX+C+f+juAjPZ/drrEh/EOFycgrf3bXJvgpitqxN8aCEG3LQeanA44bgQCY=
X-Received: by 2002:a81:6887:0:b0:2e6:126d:3102 with SMTP id
 d129-20020a816887000000b002e6126d3102mr5995555ywc.7.1648747027545; Thu, 31
 Mar 2022 10:17:07 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 31 Mar 2022 19:16:56 +0200
Message-ID: <CAJZ5v0hGTCBsbrFt7xcS_J+X1hG1qOAL=UecfGyHuhAcHjZ0eQ@mail.gmail.com>
Subject: [GIT PULL] More ACPI updates for v5.18-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
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
 acpi-5.18-rc1-2

with top-most commit 4a13e559af0b177eb934c39338f100a9f692a37b

 Merge branches 'acpi-ipmi', 'acpi-tables' and 'acpi-apei'

on top of commit 242ba6656d604aa8dc87451fc08143cb28d5a587

 Merge tag 'acpi-5.18-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive more ACPI updates for 5.18-rc1.

These are fixes and cleanup on top of the previously merged ACPI
material for 5.18-rc1.

Specifics:

 - Avoid out-of-bounds access when parsing _CPC data (Rafael Wysocki).

 - Change default error code and clean up debug messages in ACPI CPPC
   probe (Rafael Wysocki).

 - Replace usage of found with a dedicated list iterator variable in
   the ACPI IPMI driver (Jakob Koschel).

 - Clean up variable name confusion in APEI (Jakob Koschel).

 - Make LAPIC_ADDR_OVR address readable in a message parsed during
   MADT parsing (Vasant Hegde).

Thanks!


---------------

Jakob Koschel (2):
      ACPI, APEI: Use the correct variable for sizeof()
      ACPI: IPMI: replace usage of found with dedicated list iterator variable

Rafael J. Wysocki (2):
      ACPI: CPPC: Avoid out of bounds access when parsing _CPC data
      ACPI: CPPC: Change default error code and clean up debug messages in probe

Vasant Hegde (1):
      ACPI: tables: Make LAPIC_ADDR_OVR address readable in message

---------------

 drivers/acpi/acpi_ipmi.c      | 39 ++++++++++++++++++---------------------
 drivers/acpi/apei/apei-base.c |  2 +-
 drivers/acpi/cppc_acpi.c      | 32 ++++++++++++++++++++------------
 drivers/acpi/tables.c         |  4 ++--
 4 files changed, 41 insertions(+), 36 deletions(-)
