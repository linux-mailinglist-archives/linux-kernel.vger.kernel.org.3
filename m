Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B765559060D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 19:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235373AbiHKRnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 13:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbiHKRnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 13:43:40 -0400
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A11C844F8;
        Thu, 11 Aug 2022 10:43:39 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-32868f43dd6so180140257b3.8;
        Thu, 11 Aug 2022 10:43:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=52kaS5zi69zPVsumf70MYG0Kaej7AEwB3wMdTH4bz1s=;
        b=QdcjS/vPZ2pB208Uvc3KKZq59Kd29+nSamj9J5Tlrq9lSOHJ+w6BSEnf3WE83/SG5S
         IuSrZ6Kuqpo7zZD87tXO0o2OinSyhN+iYx9ngwqH1UoyPKgFUw3hg5g83tT89vDQdBy5
         JZBpTtfBQ1mdSDwV66Rzo92hYPYtksunKuUhrpp4Vat9qL5eocpM++WgmfkbtJw6Iu1y
         1i/i0N+7p3iFh+8BVG7SLRigtKp7UT68bd82aRh69dm2AM0dqxa922JtmrgChitp/z8g
         AVH5N/jvRkkg4RkOK5Bvj3SpbVSpcPjRBfj1wrpsHzJs7wJkUjvb4xgmy46cEbdGdI2g
         NwOQ==
X-Gm-Message-State: ACgBeo0JdzMvC9nDfdGeKotBSsA+9DV6Cr2N2z94jUTERppDFsCiASCg
        KqiXt16V0YZRmGfNNIpMJjN+FGuOgbpZag9oPaNWkaOEHeE=
X-Google-Smtp-Source: AA6agR6w+TremIqN7YSZcgR9Dx9cgHPfXASqT0jzXAj8WtNY/VVM4TpIChillkxC1MQl7mSXbfAaKXvP7lFs7jBkJPk=
X-Received: by 2002:a0d:d694:0:b0:325:1881:6a52 with SMTP id
 y142-20020a0dd694000000b0032518816a52mr318697ywd.149.1660239818725; Thu, 11
 Aug 2022 10:43:38 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 11 Aug 2022 19:43:27 +0200
Message-ID: <CAJZ5v0hu2y0jwZ4DFxOaZzArPuaoSEH-iKHakHWRpW3e7i9x7Q@mail.gmail.com>
Subject: [GIT PULL] More ACPI updates for v5.20-rc1
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
 acpi-5.20-rc1-2

with top-most commit da2679f26bd6ae20b06d49e53eedc2880cf5e65e

 Merge branch 'acpi-properties'

on top of commit 8fa0db3a9b8ef310eb40cf91481141ece084f584

 Merge tag 'acpi-5.20-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive more ACPI updates for 5.20-rc1.

These fix up direct references to the fwnode field in struct
device and extend ACPI device properties support.

Specifics:

 - Replace direct references to the fwnode field in struct device with
   dev_fwnode() and device_match_fwnode() (Andy Shevchenko).

 - Make the ACPI code handling device properties support properties
   with buffer values (Sakari Ailus).

Thanks!


---------------

Andy Shevchenko (1):
      ACPI: VIOT: Do not dereference fwnode in struct device

Sakari Ailus (9):
      ACPI: property: Return type of acpi_add_nondev_subnodes() should be bool
      ACPI: property: Tie data nodes to acpi handles
      ACPI: property: Use acpi_object_type consistently in property ref parsing
      ACPI: property: Move property ref argument parsing into a new function
      ACPI: property: Switch node property referencing from ifs to a switch
      ACPI: property: Unify integer value reading functions
      ACPI: property: Add support for parsing buffer property UUID
      ACPI: property: Read buffer properties as integers
      ACPI: property: Fix error handling in acpi_init_properties()

---------------

 drivers/acpi/property.c | 464 ++++++++++++++++++++++++++++++++----------------
 drivers/acpi/viot.c     |   6 +-
 include/acpi/acpi_bus.h |   3 +-
 include/linux/acpi.h    |   2 +-
 4 files changed, 321 insertions(+), 154 deletions(-)
