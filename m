Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7794953865A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 18:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241924AbiE3QvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 12:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241537AbiE3QvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 12:51:16 -0400
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB50590CF2;
        Mon, 30 May 2022 09:51:10 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id a64so9615832ybg.11;
        Mon, 30 May 2022 09:51:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=hcEdIePsFuf8OKsD7Sm6MXVtIWYNRmaD617n3GR2MSk=;
        b=dxajvM7POuffPo2skVaaKQT+S1tEujld+gIMARwQwxaI5WGFgMwuwkhkdQZ4g/07Ph
         7TWHWbvdp3HvFWM6lhZWqQ+RqSlyh9Ll9h3+vTkqMaVljf7l0lIaGq320Z7sfJlWVOOT
         ZXjSmDHlP/P7Du9XmA6CICwegEt/V2Q3RihkDh6luiGXYdwNhveC3TGYfy+YdzPk/o0B
         p3FWxazePcKhbtBWGZm1DNeJas7sLLhNgF/4TgqSkYDaMNOm69RqQFNBtE5YYQoh9xTE
         NKoeD5tUoAQ39OPggXnEoM20H+Yvc7Nj9DbtEz+guyT6Vftfn4cOxBh7rVm8s12fTUVo
         UNlw==
X-Gm-Message-State: AOAM533I/95cUNQdejUB79+4neaU2LMqWQE5ULGKzTaY+oW+cMh2mHkA
        k/ttAJxRhGSGHh2GFa8ruvk6sOAVdyY0fiy4aqk=
X-Google-Smtp-Source: ABdhPJyw4dJL0w0zdNU8RqmppEa0hBVivtqv0P2PxouTqXxqH6mcxV3TzOcNvY+ZRqLjRjOFlWxAhzhRmQ6GKuuNtO8=
X-Received: by 2002:a25:2004:0:b0:650:740:f31d with SMTP id
 g4-20020a252004000000b006500740f31dmr33950199ybg.81.1653929469885; Mon, 30
 May 2022 09:51:09 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 30 May 2022 18:50:59 +0200
Message-ID: <CAJZ5v0gxN7KxWYmTfc-o0HPD0XxEb+U7Hwjg8ZcNLp_z962YHQ@mail.gmail.com>
Subject: [GIT PULL] Additional thermal control update for v5.19-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
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
 thermal-5.19-rc1-2

with top-most commit 3c1d004bdb4e12b4b1dfbdd6a9167ea5003e48cd

 thermal: int340x: Add Meteor Lake PCI device ID

on top of commit 268db333b561c77dee3feb6831806412293b4a7e

 Merge tag 'devprop-5.19-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive an additional thermal control update for 5.19-rc1.

This adds Meteor Lake PCI device ID to the int340x thermal control
driver (Sumeet Pawnikar).

Thanks!


---------------

Sumeet Pawnikar (1):
      thermal: int340x: Add Meteor Lake PCI device ID

---------------

 drivers/thermal/intel/int340x_thermal/processor_thermal_device.h     | 1 +
 drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c | 1 +
 2 files changed, 2 insertions(+)
