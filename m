Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 120AE496592
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 20:25:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbiAUTZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 14:25:47 -0500
Received: from mail-qt1-f169.google.com ([209.85.160.169]:42826 "EHLO
        mail-qt1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbiAUTZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 14:25:46 -0500
Received: by mail-qt1-f169.google.com with SMTP id y17so11032567qtx.9;
        Fri, 21 Jan 2022 11:25:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=835wb8PvGkfb7ud+f2X01SW6BIvDUM3t8aBQZSH9wAY=;
        b=W0J1VyV16pt3uNkTZuMKExrlfmAxUE6JizUxdTEzYkdxVGv60GHfMegscFY8QDBO42
         6xuRy3M1c3dsApvXUgWvYhJaLzvUYP+g7CqFJpdob8I0/6Z2aLLvtk5PhRX9AER0Vmuw
         TYFFE9YoDiD7SK8IplEak1VudeyFD0CPhrx9/f6pI4z489x5Nb4u4AVnCdrLnCWdit/O
         IBVtq0/bgU6BjogQfXoCKk5pLz8gcLy8lvks3ut6i/mI7JR3/vYgrEQyYGSw7IZDKgga
         piabqqluI5yqnWZT9F28/qE0GjUktYSyROocubsoubPhedXinuEu4o31oNxYJfT6bzKT
         l/kQ==
X-Gm-Message-State: AOAM5314KhRKRXlhb9S1NZeCx9oCY9ZYdV2ec2qocg8OLxYkMthVrXFe
        OF0r1Bs01NyEPI98RQ2v6LIknl5dDGyfvOTptoy3aJUsyyE=
X-Google-Smtp-Source: ABdhPJxgPi/AbJJEAfuS4FdmMZk1mRkGMxkPNj+Je2N2CgmXi95xeK/iJvwAK+U5LQIpCH4BiE8NQziknmHPzCquElk=
X-Received: by 2002:ac8:7d46:: with SMTP id h6mr4591324qtb.344.1642793145562;
 Fri, 21 Jan 2022 11:25:45 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 21 Jan 2022 20:25:34 +0100
Message-ID: <CAJZ5v0gJkT+WwEe0=73HKek+B1Ko0XFtkFYbwxb3NBzjR-1=ng@mail.gmail.com>
Subject: [GIT PULL] Extra ACPI updates for v5.17-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-5.17-rc1-3

with top-most commit f6f02040e0ca7cb2e82d8aeb8f7daf5d89acc04c

 Merge branches 'acpi-cppc' and 'acpi-dptf'

on top of commit 6a8d7fbf1c65034b85e7676b42449a56e4206bd3

 Merge tag 'acpi-5.17-rc1-2' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive extra ACPI updates for 5.17-rc1.

These fix and clean up the ACPI CPPC driver on top of the recent
changes in it merged previously and add some new device IDs to
the ACPI DPTF driver.

Specifics:

 - Fix a recently introduced endianness-related issue in the ACPI
   CPPC library and clean it up on top of that (Rafael Wysocki).

 - Add new device IDs for the Raptor Lake SoC to the ACPI DPTF
   driver (Srinivas Pandruvada).

Thanks!


---------------

Rafael J. Wysocki (2):
      ACPI: CPPC: Fix up I/O port access in cpc_read()
      ACPI: CPPC: Drop redundant local variable from cpc_read()

Srinivas Pandruvada (1):
      ACPI: DPTF: Support Raptor Lake

---------------

 drivers/acpi/cppc_acpi.c            | 11 ++++++-----
 drivers/acpi/dptf/dptf_pch_fivr.c   |  1 +
 drivers/acpi/dptf/dptf_power.c      |  2 ++
 drivers/acpi/dptf/int340x_thermal.c |  6 ++++++
 drivers/acpi/fan.h                  |  1 +
 5 files changed, 16 insertions(+), 5 deletions(-)
