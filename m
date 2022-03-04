Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF954CDCB3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 19:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241763AbiCDSiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 13:38:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241811AbiCDSiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 13:38:11 -0500
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F6171D63BA;
        Fri,  4 Mar 2022 10:37:23 -0800 (PST)
Received: by mail-yb1-f176.google.com with SMTP id z30so5747034ybi.2;
        Fri, 04 Mar 2022 10:37:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=kH85gqnn6HKN2yIx6qKbPhDt5W+hZrK5z7A40e9h+C8=;
        b=H/u4Sb47ZTquQp5iolWgYh+OxyBIhSEsVJExjBbeHAQyv8PWLL9dLhRuTCdCoIo+wR
         daRDdPJO93I9SMlA39wo2NdaYNaneKqKmHAE+isg/6aZbhdYGlSzheRRcNSNhC8Tu5nt
         SZNAKDsWSrGJ7mDrW5owaXp9iKRxdx6FbCbng83OaoaW21EhjNlWdbUTP5j9DQ6rM54z
         AsB2JWvwcAaM8RZOxX9kWe5cPy63ll+YIEvPMg+ok1Y1Q+w+zi+O8NlDEuY/WJ3nlsEz
         A/2k0CdUSL1Gum3Qp6ZWCjUV5bq2zexI7nVUQbBtR/4WNsH4r0nRLcjdsoSJTKxAZ0Gt
         GzwQ==
X-Gm-Message-State: AOAM5329SasLSlCwijnYCvyHt0x9On/yP2F0POlkOnjkJ+PV9DljfaC7
        g1grCMuExh2MWpO36jGoyyD5dR+eDh+UYY4/ajgtSHMx/nw=
X-Google-Smtp-Source: ABdhPJxQInzwSF0JiR9eI8sJfFgNTuPaKTJPH5khW1t4YcbsVKYHyjZUWxi3jdzBM85ycntIsYdfCTcnr5bQXCqrL4c=
X-Received: by 2002:a25:d7c2:0:b0:628:9d06:457b with SMTP id
 o185-20020a25d7c2000000b006289d06457bmr14103994ybg.137.1646419042000; Fri, 04
 Mar 2022 10:37:22 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 4 Mar 2022 19:37:11 +0100
Message-ID: <CAJZ5v0i=5YYvBQcMDb7-gRpC0f_R6KMegyQonN6=ca1ndYauxw@mail.gmail.com>
Subject: [GIT PULL] Thermal control fix for v5.17-rc7
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
 thermal-5.17-rc7

with top-most commit 5838a14832d447990827d85e90afe17e6fb9c175

 thermal: core: Fix TZ_GET_TRIP NULL pointer dereference

on top of commit 7e57714cd0ad2d5bb90e50b5096a0e671dec1ef3

 Linux 5.17-rc6

to receive a thermal control fix for 5.17-rc7.

This fixes a NULL pointer dereference in the thermal netlink
interface (Nicolas Cavallari).

Thanks!


---------------

Nicolas Cavallari (1):
      thermal: core: Fix TZ_GET_TRIP NULL pointer dereference

---------------

 drivers/thermal/thermal_netlink.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)
