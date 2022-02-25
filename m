Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BBFF4C4912
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 16:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242148AbiBYPdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 10:33:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242145AbiBYPdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 10:33:52 -0500
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE194181E77;
        Fri, 25 Feb 2022 07:33:19 -0800 (PST)
Received: by mail-yb1-f182.google.com with SMTP id u3so6590446ybh.5;
        Fri, 25 Feb 2022 07:33:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=eABu8QHBsdfkHA3w12JWmBEc2OZCUV76ZExfQivismc=;
        b=ouie04PEWm6L1v9RlxcJAHW2NzEliePn7ocN1YUHFrRzlyNdcJpmX0BD/yOn8y3Mbh
         sk8XVGjlAP5+TrK88b2K8zMt0+bTOW0jP5g0AZGwkl7WpjY1kQ5mGdeEStHGYR71MFqY
         puWslGh60nf5r+rMUfmFF4V1HRhiAdmkb+5nZV/1bwc+WNI0fE7nhKJldcmBEOFgL6Jw
         W/F86lrKbzNeUTMNKVR7zzzKXTgYPgy6VXAEXURGN8JRmpcUvQ+psk8Tv37sOzoIJLsx
         qYRkHj7gWW0luaisppWwo1nkPranaisZSmZ4uo1FNE0gNoyYalHqYpublUqApoxBhdMN
         1A2Q==
X-Gm-Message-State: AOAM532yQ/dhkUf1NMMkcuNB/kSsM8w+NYcEgFCmWDrMm7Zms9VvW/0R
        7J/wY4Rud1lQjRInoFC9p9HPfALc4wCcnorsW3SAWXmb/b4=
X-Google-Smtp-Source: ABdhPJxsDqyFM8lHB1ww0LkZcf1spz1fbcJhFO7+5DEGzYZRLP8MjQ2NSomKv4l9/DlSpZ0uBgm2k0FloTFi7cxK+xM=
X-Received: by 2002:a25:7785:0:b0:614:c283:2a3d with SMTP id
 s127-20020a257785000000b00614c2832a3dmr7913179ybc.137.1645803199100; Fri, 25
 Feb 2022 07:33:19 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 25 Feb 2022 16:33:08 +0100
Message-ID: <CAJZ5v0hhiuXu=rKp8=gfMh6Xm5cT4-EK2QduofM2bUgY7jMqCw@mail.gmail.com>
Subject: [GIT PULL] Thermal control fix for v5.17-rc6
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
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
 thermal-5.17-rc6

with top-most commit 3abea10e6a8f0e7804ed4c124bea2d15aca977c8

 thermal: int340x: fix memory leak in int3400_notify()

on top of commit cfb92440ee71adcc2105b0890bb01ac3cddb8507

 Linux 5.17-rc5

to receive a thermal control fix for 5.17-rc6.

This fixes a memory leak in the int340x thermal driver's ACPI notify
handler (Chuansheng Liu).

Thanks!


---------------

Chuansheng Liu (1):
      thermal: int340x: fix memory leak in int3400_notify()

---------------

 drivers/thermal/intel/int340x_thermal/int3400_thermal.c | 4 ++++
 1 file changed, 4 insertions(+)
