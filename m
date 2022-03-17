Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 384454DC734
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 14:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbiCQNFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 09:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235337AbiCQNDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 09:03:47 -0400
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C91D148674;
        Thu, 17 Mar 2022 06:02:27 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id v130so10007569ybe.13;
        Thu, 17 Mar 2022 06:02:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=B7qYsNUbGJYHdxCIQHkf/OD/PW64BsHLYhrDQx+Tw6A=;
        b=l/T/ddD3wQRP2CLVQA8G66Mj6xL8Ss119WlpsqKk2PhPEDBLfTPxUhG+B1yy4RLy9N
         5xXPorTviJDEjjGBRPDkXKJ+Tv/fHFRB4yoy/Oz5Gjg6wi6Rg2NLqjtq6N2klXq8hR6c
         Hq6C+uaI/K/BbJGvhnnyZaWHons1hb/iix62jobVnYS3a6ypyiOY5RSRu07Gvl9LeWEx
         nM5/W6V6hM+24ZdaKDnYeFeg4Cb7gfyMS8ks8HV99HBHLwFc31yMvoE9Z0Y54epG4bMR
         iCeMSZxo1uB5y9LNrI82/xtHeO6/SVX0UtGDLPd4N67ix4lLH50hmhrQePEnRV1oqvOg
         QwdA==
X-Gm-Message-State: AOAM530DSjSd9+GJ2z9wd7EgoJ0anarUUJmpS21KjFAeMgb9WssSHk6L
        T3H2r/cFl/tXWGYzOJqJEHJQhOcyBSwbX8ho9D3tSJ6ldCc=
X-Google-Smtp-Source: ABdhPJyOqVbWlCAFoVtJfjG/++NcPW/hSsSa5o6Ghrd0pjN2FM5kxovkHkVhqvNZMaTH468GRkVguvNg9V55mgYPkjA=
X-Received: by 2002:a25:9d8a:0:b0:633:9668:c48a with SMTP id
 v10-20020a259d8a000000b006339668c48amr4653467ybp.153.1647522146210; Thu, 17
 Mar 2022 06:02:26 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 17 Mar 2022 14:02:15 +0100
Message-ID: <CAJZ5v0gcZb9mq4WfHuGC-3zMx215u_cYMzwTkx1jxgZmu_EUbw@mail.gmail.com>
Subject: [GIT PULL] ACPI fix for final v5.17
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
 acpi-5.17-rc9

with top-most commit 462ccc35a750f335c8456cde9120b8b593fff60f

 Revert "ACPI: scan: Do not add device IDs from _CID if _HID is not valid"

on top of commit 09688c0166e76ce2fb85e86b9d99be8b0084cdf9

 Linux 5.17-rc8

to receive an ACPI fix for final 5.17.

This reverts recent commit that caused multiple systems to misbehave
due to firmware issues.

Thanks!


---------------

Rafael J. Wysocki (1):
      Revert "ACPI: scan: Do not add device IDs from _CID if _HID is not valid"

---------------

 drivers/acpi/scan.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)
