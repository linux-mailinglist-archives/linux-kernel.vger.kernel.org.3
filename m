Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73F2A47FB9B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 10:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236075AbhL0Jqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 04:46:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235906AbhL0Jpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 04:45:52 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBEE8C06173E
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 01:45:51 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n1mZU-0006Yh-Vm; Mon, 27 Dec 2021 10:45:37 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1n1mZU-006u9K-Fo; Mon, 27 Dec 2021 10:45:35 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n1mZT-0005W0-42; Mon, 27 Dec 2021 10:45:35 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Subject: [PATCH v2 14/23] counter: Update documentation for new counter registration functions
Date:   Mon, 27 Dec 2021 10:45:17 +0100
Message-Id: <20211227094526.698714-15-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211227094526.698714-1-u.kleine-koenig@pengutronix.de>
References: <20211227094526.698714-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=JwWwP4Kk92DMBkc2853YlVwW2GZtVpOmi4eNbrbAqOM=; m=8xa0ztoxbc8pXTZ+bVJ9UNVwXDTniwv8lnzxq3YKbKo=; p=hdEi+4ZXao9qa6MHkZ3aC+8cHDmJEmeKboRh2kfI+gM=; g=136907a6200880612a96065c1ff90c379cd4bf57
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmHJiqkACgkQwfwUeK3K7AkAMAf/SPk xZfzTMX6KWduTlujhhRpkOZhBEujXfw/GtdWR0Q1Y0SQhXLaG5lgTj40vKV3dV3U87AVfvoiUZyZR tUHbpC5/aHEfnkAQHUJzvBMRLbEeMwlolkSXYby9mvIlqJ7xmNOxb5+RZ7fLI8nhco5KZqvGaDtO0 K6aHhYEQ37z/JKQ5MozEnd8NJAaAkFQ2Oir+cSxpT+/a9+cHqaWXg+84CA5Wrtqan6TeS74Uafuej Wm10gKemtWw5TcoUXbGfghAP1YUUqjYynwfAAEB0ltC09csB0J4m/mGQ/GDsPezJXGnEeKyUfv4nP hfr6r907JwjgyBV32vkXA47niinFsqA==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to replace the counter registration API also update the
documentation to the new way.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 Documentation/driver-api/generic-counter.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/driver-api/generic-counter.rst b/Documentation/driver-api/generic-counter.rst
index 1b487a331467..991b180c7b47 100644
--- a/Documentation/driver-api/generic-counter.rst
+++ b/Documentation/driver-api/generic-counter.rst
@@ -262,11 +262,11 @@ order to communicate with the device: to read and write various Signals
 and Counts, and to set and get the "action mode" and "function mode" for
 various Synapses and Counts respectively.
 
-A defined counter_device structure may be registered to the system by
-passing it to the counter_register function, and unregistered by passing
-it to the counter_unregister function. Similarly, the
-devm_counter_register function may be used if device memory-managed
-registration is desired.
+A counter_device structure is supposed to be allocated using counter_alloc()
+and may be registered to the system by passing it to the counter_add()
+function, and unregistered by passing it to the counter_unregister function.
+There are device managed variants of these functions: devm_counter_alloc() and
+devm_counter_add().
 
 The struct counter_comp structure is used to define counter extensions
 for Signals, Synapses, and Counts.
-- 
2.33.0

