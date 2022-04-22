Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B79A950B31C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 10:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233684AbiDVIoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 04:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbiDVIog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 04:44:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3EC52E65;
        Fri, 22 Apr 2022 01:41:43 -0700 (PDT)
Date:   Fri, 22 Apr 2022 08:41:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650616901;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j6cLxZ4kdjoHceVBuCa9zNiwaAJ9SgeXfp0i0CpsUqc=;
        b=QJFs0v0fwlkYp0+0MPHFE5lzok5I0aGywAcbKL08LNA7b6SRtKOUINwOy0ipwt/ETEPt/D
        kUlGkeEf0I0xC305FLH0Yp76zQEbp40beaK5+cfIkZRgX5tzG/D4vZHiz7iP009j4Rwffr
        qqhTnlOwQIwJDqZp6rrK4LRd63h3tUh/iggBKNy2xXLPD1e8FBUFl9F6JNHdpKtuTxiNzk
        IAhoyXRxEIbUTBY00KAyYeSZalrsV2mVeOkDtoMdiNwDF+6qGYKmEGxvWQrRHcyRbi+kqY
        BCFtihesnDKMSPzEX660PeGfhijG5HsUEK9rK0bLbJpauOvRaDpiMJJ4ZtMpiw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650616901;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j6cLxZ4kdjoHceVBuCa9zNiwaAJ9SgeXfp0i0CpsUqc=;
        b=NWfMiudubAWkljK4kGIJANN1qJ47qcyRivTKmkzys3TlNBQ5z7wU1WuLmjd2G2KWLtcJKb
        nMakoRAb8dx0f4CQ==
From:   "tip-bot2 for John Stultz" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] MAINTAINERS: Update email address for John Stultz
Cc:     John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sumit Semwal <sumit.semwal@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220418212016.2669086-1-jstultz@google.com>
References: <20220418212016.2669086-1-jstultz@google.com>
MIME-Version: 1.0
Message-ID: <165061690058.4207.9583814082499524209.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     214cab6f8020a9ad4a5e9862a4e68088d5a79f08
Gitweb:        https://git.kernel.org/tip/214cab6f8020a9ad4a5e9862a4e68088d5a79f08
Author:        John Stultz <jstultz@google.com>
AuthorDate:    Mon, 18 Apr 2022 21:20:16 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 22 Apr 2022 10:33:16 +02:00

MAINTAINERS: Update email address for John Stultz

I've switched jobs, so update my email address in MAINTAINERS

Signed-off-by: John Stultz <jstultz@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Sumit Semwal <sumit.semwal@linaro.org>
Link: https://lore.kernel.org/r/20220418212016.2669086-1-jstultz@google.com

---
 MAINTAINERS | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 40fa195..c2e1b72 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5914,7 +5914,7 @@ R:	Benjamin Gaignard <benjamin.gaignard@collabora.com>
 R:	Liam Mark <lmark@codeaurora.org>
 R:	Laura Abbott <labbott@redhat.com>
 R:	Brian Starkey <Brian.Starkey@arm.com>
-R:	John Stultz <john.stultz@linaro.org>
+R:	John Stultz <jstultz@google.com>
 L:	linux-media@vger.kernel.org
 L:	dri-devel@lists.freedesktop.org
 L:	linaro-mm-sig@lists.linaro.org (moderated for non-subscribers)
@@ -6584,7 +6584,7 @@ F:	drivers/gpu/drm/gma500/
 DRM DRIVERS FOR HISILICON
 M:	Xinliang Liu <xinliang.liu@linaro.org>
 M:	Tian Tao  <tiantao6@hisilicon.com>
-R:	John Stultz <john.stultz@linaro.org>
+R:	John Stultz <jstultz@google.com>
 R:	Xinwei Kong <kong.kongxinwei@hisilicon.com>
 R:	Chen Feng <puck.chen@hisilicon.com>
 L:	dri-devel@lists.freedesktop.org
@@ -8845,7 +8845,7 @@ F:	Documentation/devicetree/bindings/net/hisilicon*.txt
 F:	drivers/net/ethernet/hisilicon/
 
 HIKEY960 ONBOARD USB GPIO HUB DRIVER
-M:	John Stultz <john.stultz@linaro.org>
+M:	John Stultz <jstultz@google.com>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	drivers/misc/hisi_hikey_usb.c
@@ -19784,7 +19784,7 @@ F:	drivers/net/wireless/ti/
 F:	include/linux/wl12xx.h
 
 TIMEKEEPING, CLOCKSOURCE CORE, NTP, ALARMTIMER
-M:	John Stultz <john.stultz@linaro.org>
+M:	John Stultz <jstultz@google.com>
 M:	Thomas Gleixner <tglx@linutronix.de>
 R:	Stephen Boyd <sboyd@kernel.org>
 L:	linux-kernel@vger.kernel.org
