Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8F14531C35
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbiEWTq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 15:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbiEWTqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 15:46:47 -0400
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804AA1D335;
        Mon, 23 May 2022 12:46:45 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id a3so27299585ybg.5;
        Mon, 23 May 2022 12:46:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=vJUS6B664Q4V/weoSAGzo3BrorTtXJYFNe41saOLkKc=;
        b=e8C56tge6e5VaFaO7W04YYI3PRoKZEAR/VS3ISdNvGtC4zKyLarBvzSczMYzdpvDCx
         IKNujRqh3VXY1MCcQ7kpiHxhHEjtWxFIbAwG8X44eSqBIyy0Yhry59xBj4fCxeL7dsh3
         pqRqTUyPAQdcaT0MYiDOSFHumup54t1bab7BmwWdlYyrDjuSgz4n+MxPOzf63jPKDCCs
         pQOTe4NAISKTmBwKBir4m5i2k1IFEhIFxG5UZThVO2bIgBgfAn15VprZ6dOTZwDTXePE
         D69zso1Rm063uh7C5BCxEZ9tuJW4dokuO2NufBbDNd79zPEQ7pv2Ls3fJO0Zxh+EPbJD
         In0Q==
X-Gm-Message-State: AOAM532241HPb6C1UhxppgTDuPHMs7AbNQ+hTjRy0va1g7ckIOkqr0xS
        eA4TZj26zbQ6cw31nhO7xmMbdaLPa7zY1kp9WOEBF08a2Ig=
X-Google-Smtp-Source: ABdhPJwbVzpP24aePlMzYTxYfjzJaBy3wlttazNF4fiCxNw5iTtwW14zChXChThD/qO6bblanmDgZbp01rJVODA7qxA=
X-Received: by 2002:a05:6902:100a:b0:64f:44ec:13ff with SMTP id
 w10-20020a056902100a00b0064f44ec13ffmr21299941ybt.137.1653335204786; Mon, 23
 May 2022 12:46:44 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 23 May 2022 21:46:34 +0200
Message-ID: <CAJZ5v0hprw1AQSq+aO9WFz-2Evh6E3-Grn6uB1zQ7ex=Q8N0Rw@mail.gmail.com>
Subject: [GIT PULL] Device properties framework updates for v5.19-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
 devprop-5.19-rc1

with top-most commit f6e109a0afedec2a9470fec31a567071e2f01e46

 device property: Advertise fwnode and device property count API calls

on top of commit 3123109284176b1532874591f7c81f3837bbdc17

 Linux 5.18-rc1

to receive device properties framework updates for 5.19-rc1.

These mostly extend the device property API and make it easier to use
in some cases.

Specifics:

 - Allow error pointer to be passed to fwnode APIs (Andy Shevchenko).

 - Introduce fwnode_for_each_parent_node() (Andy Shevchenko, Douglas
   Anderson).

 - Advertise fwnode and device property count API calls (Andy
   Shevchenko).

 - Clean up fwnode_is_ancestor_of() (Andy Shevchenko).

 - Convert device_{dma_supported,get_dma_attr} to fwnode (Sakari Ailus).

 - Release subnode properties with data nodes (Sakari Ailus).

 - Add ->iomap() and ->irq_get() to fwnode operations (Sakari Ailus).

Thanks!


---------------

Andy Shevchenko (4):
      device property: Allow error pointer to be passed to fwnode APIs
      device property: Introduce fwnode_for_each_parent_node()
      device property: Drop 'test' prefix in parameters of
fwnode_is_ancestor_of()
      device property: Advertise fwnode and device property count API calls

Douglas Anderson (1):
      device property: Fix recent breakage of fwnode_get_next_parent_dev()

Sakari Ailus (5):
      device property: Convert device_{dma_supported,get_dma_attr} to fwnode
      ACPI: property: Move acpi_fwnode_device_get_match_data() up
      device property: Add iomap to fwnode operations
      device property: Add irq_get to fwnode operation
      ACPI: property: Release subnode properties with data nodes

---------------

 drivers/acpi/property.c  |  54 +++++++++---
 drivers/base/property.c  | 217 +++++++++++++++++++++++++----------------------
 drivers/of/property.c    |  34 ++++++++
 include/linux/fwnode.h   |  15 ++--
 include/linux/property.h |  12 ++-
 5 files changed, 211 insertions(+), 121 deletions(-)
