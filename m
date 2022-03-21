Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EDEE4E2E71
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 17:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351372AbiCUQrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 12:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351367AbiCUQrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 12:47:05 -0400
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C9848E55;
        Mon, 21 Mar 2022 09:45:40 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-2e5e31c34bfso83132517b3.10;
        Mon, 21 Mar 2022 09:45:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=G/RmBmvXCX7UWPosPlJvTOO7yfk/o7wWsgtXFUkgp3g=;
        b=aghf15A1G4D/exJJp58YUHCqQo0yYVt/QW8JN2xjgL09C1QTwbZTK1Eut4SEAgv7qj
         pdwVBwp+mXLe1TFseL5LHf/8mbxNHTauTyH6+jmbGuV9OlVgRaeRmsX41G5/aQMPBvBM
         6FfLRY2PlcKMJjtGP89QDOctPQFp6Ed7DhyU5ISJjs8mR2Pzm9fQIaJQbm497xND57S+
         oxo+TcbG5KOHzXrHK8Xx1Rwj53cWN3d6qzFIO7/dhXOxPaDZqqSB2lOtxpTRb3xJN+lV
         U2bVqzmRkNYy4QyjjphAkgt4MGLIstpgVSg4Nc+ZrpM3ick66qYdR0Zz/Cz/c9U9dUO3
         3x7g==
X-Gm-Message-State: AOAM533d1wOaCIn026WfDd7lAzpNuJwJCAYUmIAk0AAw1KSFG0tbeNXF
        2OeN+sCEwgvuvNQ/o2QFyvIP0fSi1Pmv0C/NcnEX8yYEk5s=
X-Google-Smtp-Source: ABdhPJyBXRFtmr2Wotf+2dUmQ+QkYU1PjvcMAGYCTC54+abJvOwOnM8tmrKEactBVIJASzmqmt5aIIPEOaXmNzcEdQ8=
X-Received: by 2002:a81:f20e:0:b0:2dc:56e1:918e with SMTP id
 i14-20020a81f20e000000b002dc56e1918emr25656787ywm.19.1647881139507; Mon, 21
 Mar 2022 09:45:39 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 21 Mar 2022 17:45:28 +0100
Message-ID: <CAJZ5v0gAGJuDF0uZTB+_JGT_5svr1xZDJLYoxLFRGCcbEF0v+Q@mail.gmail.com>
Subject: [GIT PULL] PNP update for v5.18-rc1
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
 pnp-5.18-rc1

with top-most commit ed945296bb90ce79a7ff331885dd37eafa38b551

 PNP: Replace acpi_bus_get_device()

on top of commit 26291c54e111ff6ba87a164d85d4a4e134b7315c

 Linux 5.17-rc2

to receive a PNP update for 5.18-rc1.

This replaces acpi_bus_get_device() in the PNP code with
acpi_fetch_acpi_dev() which is better.

Thanks!


---------------

Rafael J. Wysocki (1):
      PNP: Replace acpi_bus_get_device()

---------------

 drivers/pnp/pnpacpi/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
