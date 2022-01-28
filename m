Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C844D49FA46
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 14:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238482AbiA1NDf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 28 Jan 2022 08:03:35 -0500
Received: from mail-yb1-f172.google.com ([209.85.219.172]:44967 "EHLO
        mail-yb1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238248AbiA1NDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 08:03:34 -0500
Received: by mail-yb1-f172.google.com with SMTP id r65so18142264ybc.11;
        Fri, 28 Jan 2022 05:03:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=ie2PuXYR3t0je7Ft2W8pd/QgIdnvwwoLONXZlKTVxhw=;
        b=xLbLsn8wjojfHTctMrf0fP7NWECUqo9rQw1IayRZY3wo0X9vqwTEsaeSnxfgpakhxy
         jxL4FY3bcWGSs89HUYaTCx4H5jIfvgigAiq4wP0pfEml011O1/fSOjMpUNcXazocSpTR
         zymIWC3hkH5dZc7rc2DwQ7VQU2aHnXcD5BFiwpsBRovlU2W8ELo67zKwo9A0G5iJxRuq
         B2vyF+deOP4z8YP8lu5rOprmPHs5JHF22ZSnvQV7WYd27RreXaGZAMYfGilc1VZipxkX
         t1vtnKnBQzfHU+NLaj/m7keb0mY/ZL/XGBmWbza6nDc95dXE4I6oBHM58YnhONvz35ZI
         LDYA==
X-Gm-Message-State: AOAM533ge73A7tlkq+cCqwDFKELCTK7BxK9ULGHnxc3pbbdZfjMLqO9b
        CpiKf+Azb2+aJ0na4EAMPCp63oWDAX9cyfpuVM0=
X-Google-Smtp-Source: ABdhPJwKNeNoyVVRaUCPNDa1Ss6YHQDL+VZ+zRojzAROUl2MYovBBeh+LN2SvnhfkbeqKpR0/hc1lbWGVZuuQnkpBLI=
X-Received: by 2002:a25:2ac3:: with SMTP id q186mr12803067ybq.272.1643375013552;
 Fri, 28 Jan 2022 05:03:33 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 28 Jan 2022 14:03:22 +0100
Message-ID: <CAJZ5v0jeB_WPnOJBzTk-VeOtdbwWFE4tLvVQzZH+Bhe3Q1pSdQ@mail.gmail.com>
Subject: [GIT PULL] Power management updates for v5.17-rc2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-5.17-rc2

with top-most commit 33569ef3c754a82010f266b7b938a66a3ccf90a4

 PM: hibernate: Remove register_nosave_region_late()

on top of commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07

 Linux 5.17-rc1

to receive power management updates for 5.17-rc2.

These make the buffer handling in pm_show_wakelocks() more robust
and drop an unused hibernation-related function.

Specifics:

 - Make the buffer handling in pm_show_wakelocks() more robust by
   using sysfs_emit_at() in it to generate output (Greg Kroah-Hartman).

 - Drop register_nosave_region_late() which is not used (Amadeusz
   Sławiński).

Thanks!


---------------

Amadeusz Sławiński (1):
      PM: hibernate: Remove register_nosave_region_late()

Greg Kroah-Hartman (1):
      PM: wakeup: simplify the output logic of pm_show_wakelocks()

---------------

 include/linux/suspend.h | 11 +----------
 kernel/power/snapshot.c | 21 +++++++--------------
 kernel/power/wakelock.c | 11 ++++-------
 3 files changed, 12 insertions(+), 31 deletions(-)
