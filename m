Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1B07470AFA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 20:53:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242776AbhLJT4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 14:56:40 -0500
Received: from mail-ot1-f52.google.com ([209.85.210.52]:41834 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242657AbhLJT4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 14:56:39 -0500
Received: by mail-ot1-f52.google.com with SMTP id n17-20020a9d64d1000000b00579cf677301so10690469otl.8;
        Fri, 10 Dec 2021 11:53:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=yfQjMxJJT1QBabEu6iswQYFzGAQ6s/guX4L6/3PtXec=;
        b=OQg5c6Dk1Vu8MWysdBsPeMw9N4SH7n93/0f8kgmXbavWoy7v0DX0nleAfLxnF3MpUa
         GHXkWmKixV5il1An98xDDwnT0dpdjP+O6VNOk7dwNqDNqcbkfdfGyctrviYpNwoc3nMa
         odgvcH23ojUXstwyEyVm3A1Q0d0QKqPL6HuT3Qz00xTghSyA8K3cBGFRSdLEXVFNzNih
         AJcQo3QHIn4SGkCl/aG++V4VcWkdEd8HDNn5HnMkLlBIMHUHYLHg1DvvCbhZIxGcY0aV
         tklB2TbmeUx0+qzvHQwd9BV8q0LeJS8IZN4YbIqd6pVpS8C3R4hQggQRUbzZOEd/lwgV
         zTYA==
X-Gm-Message-State: AOAM532Zq3tiurrbWHZJQvqZvqXyR2q7Zz8SVqIWSZ/9ckUzeY/Q/Gh8
        +39VUP4loms5x3qUtbJLxqkKM6s1BU9aTioFadrXAniM5Es=
X-Google-Smtp-Source: ABdhPJzXmxG4FPRgwOyp2QTXJeRXLAz+DlxItZpQWAekIw02vR8QYK/dXFuonlQHB/9hb/0CaFOBrMfXorHE7S6SBMk=
X-Received: by 2002:a05:6830:1e57:: with SMTP id e23mr12709737otj.16.1639165983616;
 Fri, 10 Dec 2021 11:53:03 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 10 Dec 2021 20:52:52 +0100
Message-ID: <CAJZ5v0iTCeLF1gzf+W-ugvTex4PYiNeQOE-EO654oeuzqj1TOQ@mail.gmail.com>
Subject: [GIT PULL] ACPI fix for v5.16-rc5
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-5.16-rc5

with top-most commit 11f8cb8903ba4e8ba900fa4e4ab29d0fb4c9ef5d

 ACPI: tools: Fix compilation when output directory is not present

on top of commit 0fcfb00b28c0b7884635dacf38e46d60bf3d4eb1

 Linux 5.16-rc4

to receive an ACPI fix for 5.16-rc5.

This causes the output directory for the ACPI tools to be created
during build if it has not been present before and prevents the
compilation from failing in that case (Chen Yu).

Thanks!


---------------

Chen Yu (1):
      ACPI: tools: Fix compilation when output directory is not present

---------------

 tools/power/acpi/Makefile.config | 1 +
 tools/power/acpi/Makefile.rules  | 1 +
 2 files changed, 2 insertions(+)
