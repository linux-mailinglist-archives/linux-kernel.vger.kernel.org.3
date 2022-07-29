Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C530E585229
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 17:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236700AbiG2PO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 11:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbiG2PO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 11:14:26 -0400
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0649DF69;
        Fri, 29 Jul 2022 08:14:25 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id 141so8653981ybn.4;
        Fri, 29 Jul 2022 08:14:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=/QL5+pAGoJTVkIc1JlAfzpkNJEewyBqE+JMkFocGLnU=;
        b=IhTgHObsOOl0N6yyk+clVl37SDoIJ+qIMu7gzAmpPevWbXtMAuKVe+UrP4VpO+u/Pp
         yka0hUQrRrOMwgSBwxe6pkSCRtIrw3NqrT5OFEppl1GWd2ZJ1tq5BvJNtjqWtwoLFYnf
         bH1Rmw7pP/ciyFKNqJ0zGovQnh2y89MKzKByz0DOpoCxPwUCrkU8pC3Ub2XxCXBnVzRg
         lSuobuDgTId087MkfSO97XBssGUyGOHX/gygptEUIogj07QPdyOiBNX231nni1lZfBc4
         y37/Z5Itp8356d5YCJe8t5jao4ujBmpF4x987i54gl6KJ84vhOYvdbBVEtfWan0LYTdU
         FQAA==
X-Gm-Message-State: ACgBeo2VOtc1C3IWVbQ2sYMO/EEdPohglcRiTewYYOht49BmX8CfmltO
        9G9+5X79vD2fgSPQJWEI1UwMa8hc5R+iGUNxn6V9/xwBqTjWjw==
X-Google-Smtp-Source: AA6agR7B8jbwE/kwU4Jkz5MnFAYcjyg3Ngioc4FsgoC5hEzRd5tbR8tdn6OsyMyXO6idWo2fPKbUuQzLtulW4gy3BLA=
X-Received: by 2002:a25:664f:0:b0:66c:d0f4:36cc with SMTP id
 z15-20020a25664f000000b0066cd0f436ccmr2881455ybm.482.1659107665140; Fri, 29
 Jul 2022 08:14:25 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 29 Jul 2022 17:14:14 +0200
Message-ID: <CAJZ5v0gRQ=DmY-nOO6ZEMF6hX_cSVVL=QX_0Kvo9wtVjwtQh2g@mail.gmail.com>
Subject: [GIT PULL] Last-minute power management fix for v5.19
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-5.19-rc9

with top-most commit d295ad34f236c3518634fb6403d4c0160456e470

 intel_idle: Fix false positive RCU splats due to incorrect hardirqs state

on top of commit e0dccc3b76fb35bb257b4118367a883073d7390e

 Linux 5.19-rc8

to receive a last-minute power management fix for 5.19.

This makes some false positive RCU splats resulting from a recent
intel_idle driver change go away (Waiman Long).

Thanks!


---------------

Waiman Long (1):
      intel_idle: Fix false positive RCU splats due to incorrect hardirqs state

---------------

 drivers/idle/intel_idle.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)
