Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29272505F41
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 23:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbiDRVXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 17:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiDRVXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 17:23:32 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D4F29CAB
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 14:20:52 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2ec06f77db8so129284587b3.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 14:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=J6/W309fFUN0SbAEN8sj6wkMmgTBWzu7Yd5xYN0Qrgs=;
        b=behSZFCaXwvZj7YO3q2pjl4Sc/hvkvJyMNVT7Iqu504nf4jXrSDgNlsEHQB8O8wzws
         ljJ12rw31TuJinkVGZlla6M1UTjD+Yo5/W39mMd6F6up4i6GeRVxFXDfwhxYzNC+gxPI
         UKwzJ6nnem/HrNcbOJenwcXf3tU61ItA2pJtpUHa1QCoEF5/mSmpncKvSztxL/NUQFKe
         16tOh8E4gc6v4D7RI4azEt5Th7ocZz7x15YSlOSlJNjvZdE0RPXdij/Pt4CRveU3/HCh
         fDMle+t4f+Nne86D2Ftu2WszamGodT1SS518Nvodw2xen4ipGp+gLduyEr36LxwJpHC3
         un9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=J6/W309fFUN0SbAEN8sj6wkMmgTBWzu7Yd5xYN0Qrgs=;
        b=WQPwrecvrVXoJbUP55yf36nuZ59AZEwIadsnOghn85oPM2eBBvHSCo36RmgwJyQkBm
         /UfvV4qm5yAD4pl497iPZEKBpVMfvrYneCKuPL9+B6BLIPC0JH7K4mYJA8pFpYAJJXOl
         TE6viyjBgulqe9M5yA5jCy7S+/BInGoWyPH7H7xCn6skmocTVF25sqYWCo/qyzBbKxkX
         OHO7PKf7vN4W3L7FRFhRsf94HOkwgsHEelDvvuZOml/z5oFZNC7gPep9e2UeqyHxGkPs
         rVX9I7ooaaXDIrMdR1+0Du9WBcpc8/V2iBfU2/uigEamnFi+7eGwO74WvLlvobmciUUu
         BTxw==
X-Gm-Message-State: AOAM5304BH40uP8UdHFrWOW3okvS6E1qQHn0Bbp1AyRJpR9aMbYOngrg
        XN6U0HxDN9zydh50JtRSo+nxV6aWfqJq2AwF+NNoBPhcYuHQA5loguo3CqMHpehDhaXLklEEePQ
        C6jxOBvk2q8CeHAmGr2C3G0s18O1tenbSKKS0IireZghHvWti5fEm7/5j2PCUbIN2UniJdpc=
X-Google-Smtp-Source: ABdhPJyyvQau85VvzjTCPWMc0o9mnc206oPHRIdkl5aVolXd+JNgpfcUmjNIB2hvEaTpaqHcrxejr3dno6jS
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a25:3003:0:b0:63d:8b32:2241 with SMTP id
 w3-20020a253003000000b0063d8b322241mr11586817ybw.65.1650316851173; Mon, 18
 Apr 2022 14:20:51 -0700 (PDT)
Date:   Mon, 18 Apr 2022 21:20:16 +0000
Message-Id: <20220418212016.2669086-1-jstultz@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
Subject: [PATCH] MAINTAINERS: Update email address for John Stultz
From:   John Stultz <jstultz@google.com>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Xinliang Liu <xinliang.liu@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've switched jobs, so update my email address in MAINTAINERS

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Xinliang Liu <xinliang.liu@linaro.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Signed-off-by: John Stultz <jstultz@google.com>
---
 MAINTAINERS | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 61d9f114c37f..adb35fee2294 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5913,7 +5913,7 @@ R:	Benjamin Gaignard <benjamin.gaignard@collabora.com>
 R:	Liam Mark <lmark@codeaurora.org>
 R:	Laura Abbott <labbott@redhat.com>
 R:	Brian Starkey <Brian.Starkey@arm.com>
-R:	John Stultz <john.stultz@linaro.org>
+R:	John Stultz <jstultz@google.com>
 L:	linux-media@vger.kernel.org
 L:	dri-devel@lists.freedesktop.org
 L:	linaro-mm-sig@lists.linaro.org (moderated for non-subscribers)
@@ -6583,7 +6583,7 @@ F:	drivers/gpu/drm/gma500/
 DRM DRIVERS FOR HISILICON
 M:	Xinliang Liu <xinliang.liu@linaro.org>
 M:	Tian Tao  <tiantao6@hisilicon.com>
-R:	John Stultz <john.stultz@linaro.org>
+R:	John Stultz <jstultz@google.com>
 R:	Xinwei Kong <kong.kongxinwei@hisilicon.com>
 R:	Chen Feng <puck.chen@hisilicon.com>
 L:	dri-devel@lists.freedesktop.org
@@ -8844,7 +8844,7 @@ F:	Documentation/devicetree/bindings/net/hisilicon*.txt
 F:	drivers/net/ethernet/hisilicon/
 
 HIKEY960 ONBOARD USB GPIO HUB DRIVER
-M:	John Stultz <john.stultz@linaro.org>
+M:	John Stultz <jstultz@google.com>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	drivers/misc/hisi_hikey_usb.c
@@ -19782,7 +19782,7 @@ F:	drivers/net/wireless/ti/
 F:	include/linux/wl12xx.h
 
 TIMEKEEPING, CLOCKSOURCE CORE, NTP, ALARMTIMER
-M:	John Stultz <john.stultz@linaro.org>
+M:	John Stultz <jstultz@google.com>
 M:	Thomas Gleixner <tglx@linutronix.de>
 R:	Stephen Boyd <sboyd@kernel.org>
 L:	linux-kernel@vger.kernel.org
-- 
2.36.0.rc0.470.gd361397f0d-goog

