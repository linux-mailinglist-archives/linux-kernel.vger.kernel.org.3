Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D37A5766D8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 20:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbiGOSku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 14:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiGOSks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 14:40:48 -0400
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0DB7747B7;
        Fri, 15 Jul 2022 11:40:47 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-31c89653790so54897177b3.13;
        Fri, 15 Jul 2022 11:40:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=EMw9QHnrLufeGtbJ9V3vzrZj5smnCF2Fpz3xrJ6YNUw=;
        b=LFPmfcYPhuOYA/fuez5ue5GtUt6xWWjslQnrcF/JABbcT/U7TuOJBNrybZQX9DbEz8
         4sAh9WmyYRwTDpAtCU/BS+YiikOkgCP8kVZ/YhvF/q/EIVRIbmaHVaKPifSQ8OyXiiab
         OLo+cEOl8jEGbH/z9qhLF/8OHLL3FFvzoHaUg4WUNWXQMCdPy8FMYblkRK/r5kB98WEJ
         fyxwEYjMGRBnia3Q4YGtnGGl92eiziJjq7IK9ShpaZwcka+uaXIVnQhPMgA2puHwKSJE
         fb0VkJhO9sV43E9b7jOmH8pJSJ/QqB3QHd6xgq2nYlaQQAJclGVtoU5KJ9ll4Fh8RSGb
         jpkg==
X-Gm-Message-State: AJIora8UuSUTUpn1X46QTNnjUJdzajD2UhWNUDtxIvSEcfpuayW38YG8
        6TLKYrXKMuPhS2zPsx7Lti6vq6D83VZfjNIuMlJU+/VUaBU=
X-Google-Smtp-Source: AGRyM1ucLZ5sqx4zJwaUrwo8fh/KpupWF4k8qUwo7imzY8bvgahPMkTXqW8lU8Oq0fDA3Tnu90bZcF9vjL/uE/8En7o=
X-Received: by 2002:a0d:d952:0:b0:31d:789d:221c with SMTP id
 b79-20020a0dd952000000b0031d789d221cmr17063299ywe.515.1657910447123; Fri, 15
 Jul 2022 11:40:47 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 15 Jul 2022 20:40:36 +0200
Message-ID: <CAJZ5v0iVmVvMK3iv0gcTeWQzbfCWrNhRw+j+-YSPtbQcNMH52g@mail.gmail.com>
Subject: [GIT PULL] Power management fix for v5.19-rc7
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-5.19-rc7

with top-most commit 5a5adb1528e59e8a4b23ffa7dda4849b61e97cf8

 Merge tag 'cpufreq-arm-fixes-5.19-rc7' of
git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm

on top of commit 32346491ddf24599decca06190ebca03ff9de7f8

 Linux 5.19-rc6

to receive a power management fix for 5.19-rc7.

This fixes a recent regression in the cpufreq mediatek driver
related to incorrect handling of regulator_get_optional() return
value (AngeloGioacchino Del Regno).

Thanks!


---------------

AngeloGioacchino Del Regno (1):
      cpufreq: mediatek: Handle sram regulator probe deferral

---------------

 drivers/cpufreq/mediatek-cpufreq.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)
