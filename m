Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6268470B9C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 21:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344125AbhLJUPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 15:15:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237391AbhLJUPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 15:15:21 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 368DBC061746;
        Fri, 10 Dec 2021 12:11:46 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id be32so14677411oib.11;
        Fri, 10 Dec 2021 12:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=y8dMmkuyWBxEw+uQhTxZh8vd7mO4Vqr5QSAk8M5BMAA=;
        b=CjOoay5crVqV1vxxDfK3lnWac3+Y1ui+hgrbOZFRtP6hWKRZgHhRAssqYB1nju3Bu9
         xTuCQ75C9s5Yrt4Qxv2E46VoE4Uamekznbe8wRzghL/OAbWWod7k/0rguBN8gRik3YPP
         QXNAi7iBXrJ5WXoA7GtfoWY/zm9rSThCV0erYqK6pqevxwjDNVuQ4c0lBfvX0ke1MvjI
         YowkgFXqE3ANMwe1X6ctya7BVAsp3AxWfQ3nCFRFY5FoStwKM1sM8fYe+FdB8AXAJWXt
         NOs7ElELrubZSZSujpLuKpVCn8+7MfwJFebOectp/vSX1dUrwW+SrpTsvLlkkc4r4snf
         NhZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=y8dMmkuyWBxEw+uQhTxZh8vd7mO4Vqr5QSAk8M5BMAA=;
        b=yJP84CYQDR5VYWjfFV02KA8ZTccSIJe7YfJB5VcFcKK10eli5Vms8iiH3rbGaK3w+u
         Z4P+RtKTXy176eOUj33emNogRWkjkItCVxwcA/AOfAI2xFb1PprjUYk9NfpuVTMsBmLb
         awzqV7iMGS4p7Gs1c2n9F+BLCKTgj9+T1pI2bBuox3qjSUjtrUei/4aXchPAbry4pgJb
         Nx5881rGmfJ0jRUyDqWAlMqMr4OgFStjTpS8YeV8/dJyYT1dB+bXyucrdEt7DbsMxn/1
         AWuFA20QaWi++dZIC07iczSZiYgZeYkqjSdcCZZL/CwXkSkvuG9pGzC8xr3HDxoffrLn
         nBWw==
X-Gm-Message-State: AOAM530SC/vXVQ/h5oliBGgiV8YJRjC2d0ahQiMtWw2zdJicZOViItGz
        voRfkkj16LCsbQ9P/ckk0UmaYURNJCrfKBD01K5HId1g7fA=
X-Google-Smtp-Source: ABdhPJztF744mwWdIFiEKqgTD0jWuQ1T/Vuck5Bxl6AgZf6KDTPmubHA9sOWQUDrMuZvT/zgzzvd10lz0D5OXk/Wu3M=
X-Received: by 2002:a05:6808:1454:: with SMTP id x20mr14186735oiv.166.1639167105651;
 Fri, 10 Dec 2021 12:11:45 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?Q?Rafa=C5=82_Wysocki?= <rjwysocki@gmail.com>
Date:   Fri, 10 Dec 2021 21:11:34 +0100
Message-ID: <CAJZ5v0hpgZ76wUgAuuzcjCdxjpBWAEtruTtXN6eqsDdYdpS8Hw@mail.gmail.com>
Subject: [GIT PULL] Thermal control fix for v5.16-rc5
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 thermal-5.16-rc5

with top-most commit f872f73601b92c86f3da8bdf3e19abd0f1780eb9

 thermal: int340x: Fix VCoRefLow MMIO bit offset for TGL

on top of commit 0fcfb00b28c0b7884635dacf38e46d60bf3d4eb1

 Linux 5.16-rc4

to receive a thermal control fix for 5.16-rc5.

This fixes the definition of one of the Tiger Lake MMIO registers
in the int340x thermal driver (Sumeet Pawnikar).

Thanks!


---------------

Sumeet Pawnikar (1):
      thermal: int340x: Fix VCoRefLow MMIO bit offset for TGL

---------------

 drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
