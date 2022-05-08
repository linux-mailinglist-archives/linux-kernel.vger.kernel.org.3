Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B294E51ED54
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 14:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232458AbiEHMJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 08:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232311AbiEHMJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 08:09:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62870DE80
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 05:05:26 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652011524;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=KnAlC1aJoY/gUYbLasvDUc78I2ecIbpR5jBo0r8ZhAU=;
        b=D4/yMlJCIItZWjeMdmzrmUnJ3Fse7XLGwG/+SL5YeQQ+V1h3SL5Q44yELGbXIf6rXMwRGJ
        hW41dJbAy47/dk/W1ySH9JrYbR6iK0TmXRQ/sn8D1IobKHpQQfZiHZmmUKbUHPr/Wn3viA
        56Xnme6wU3ARa+DsvWKlxni8uzywoWAv5SpaqomodhhDZObFkH0qJm72Kn/MCjZq2LUPDF
        mb5N/zCZORL7gVC7F4ty6Q34zqGO1pzWx0ZZ/b8BQmp8D4uVUIl9HqNg9jHanDAe7ziEQw
        RUWKcZxx7Ym/1nbdSAQqAo4OasKUn6YMgiL8+E+jaTqQ/ambSFjEXebXmwWKtA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652011524;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=KnAlC1aJoY/gUYbLasvDUc78I2ecIbpR5jBo0r8ZhAU=;
        b=CM2yyFn2wzsCuJxpbHw9U1KJmS0W/D5ghLIS8IgMsk62oGGrnQ2RZPSK8XHKVer1WprknH
        Z99dKj8kP3ZqiqCQ==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] timers/urgent for v5.18-rc6
References: <165201148069.536527.1960632033331546251.tglx@xen13>
Message-ID: <165201148510.536527.10163841261763309889.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Sun,  8 May 2022 14:05:24 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest timers/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-20=
22-05-08

up to:  2c33d775ef4c: timekeeping: Mark NMI safe time accessors as notrace


A fix and an email address update:

  - Mark the NMI safe time accessors notrace to prevent tracer recursion
    when they are selected as trace clocks.

  - John Stultz has a new email address

Thanks,

	tglx

------------------>
John Stultz (1):
      MAINTAINERS: Update email address for John Stultz

Kurt Kanzenbach (1):
      timekeeping: Mark NMI safe time accessors as notrace


 MAINTAINERS               | 8 ++++----
 kernel/time/timekeeping.c | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 40fa1955ca3f..c2e1b7202449 100644
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
=20
 HIKEY960 ONBOARD USB GPIO HUB DRIVER
-M:	John Stultz <john.stultz@linaro.org>
+M:	John Stultz <jstultz@google.com>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	drivers/misc/hisi_hikey_usb.c
@@ -19784,7 +19784,7 @@ F:	drivers/net/wireless/ti/
 F:	include/linux/wl12xx.h
=20
 TIMEKEEPING, CLOCKSOURCE CORE, NTP, ALARMTIMER
-M:	John Stultz <john.stultz@linaro.org>
+M:	John Stultz <jstultz@google.com>
 M:	Thomas Gleixner <tglx@linutronix.de>
 R:	Stephen Boyd <sboyd@kernel.org>
 L:	linux-kernel@vger.kernel.org
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index dcdcb85121e4..3b1398fbddaf 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -482,7 +482,7 @@ static __always_inline u64 __ktime_get_fast_ns(struct tk_=
fast *tkf)
  * of the following timestamps. Callers need to be aware of that and
  * deal with it.
  */
-u64 ktime_get_mono_fast_ns(void)
+u64 notrace ktime_get_mono_fast_ns(void)
 {
 	return __ktime_get_fast_ns(&tk_fast_mono);
 }
@@ -494,7 +494,7 @@ EXPORT_SYMBOL_GPL(ktime_get_mono_fast_ns);
  * Contrary to ktime_get_mono_fast_ns() this is always correct because the
  * conversion factor is not affected by NTP/PTP correction.
  */
-u64 ktime_get_raw_fast_ns(void)
+u64 notrace ktime_get_raw_fast_ns(void)
 {
 	return __ktime_get_fast_ns(&tk_fast_raw);
 }

