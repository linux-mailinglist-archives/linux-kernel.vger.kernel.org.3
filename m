Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5B74A515C
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 22:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380954AbiAaVUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 16:20:12 -0500
Received: from mout.gmx.net ([212.227.17.20]:42841 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1380419AbiAaVUA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 16:20:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643663983;
        bh=KFKNxulkFsQgbVrro+Hj9vsIrT+XYodV/8shEDASERA=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=CaHSLl+fUeZrrbURLZM/mbFhNzhjg15xgb6ACDWbpMvMPcfzHOOexA4tvvctmTtF9
         FCCInpc0Ujk5SLcr7crmfoxtdWGtDUH/QoGHjIBKoz/BnNC71Lz0jtlfF42bQJOQmH
         s34lD5GxkLmYoBMyjos4WnHXXTF3RzBd+SbmIfpY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.fritz.box ([91.137.126.34]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1M4b1y-1nGIVl2CSU-001fc2; Mon, 31 Jan 2022 22:19:43 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/4] hwmon: (sch56xx-common) Replace WDOG_ACTIVE with WDOG_HW_RUNNING
Date:   Mon, 31 Jan 2022 22:19:35 +0100
Message-Id: <20220131211935.3656-5-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220131211935.3656-1-W_Armin@gmx.de>
References: <20220131211935.3656-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:t4tk4mQCSQWmqlSfMaZpny3UuhF4SikNlxrTsxlWeo50KS3qfgk
 VU709XbR4elpVs7J2iFGcFBBBbfOT025ZuV1k+h4oLZG10l6nZMyZmHbdG7J1qtbGGCronO
 geXsmhKlI/Gy5fEUrlX/H6XeDZfNDrdqIVR/9l7+pjdUyMjrjCEXPmIXc2IgzjzAOCx0PeI
 Em+7G0Z0NZc2g8sKnhczw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:PvxdLDpb9p8=:dA3fqGSf9bIg5nhbPlamM8
 35goMEbfqGI/1QGDt+Tu4xyzyB0d8zfS2MhManGqCPFTTVGwbM1x75JZ4JYp6MS0KxeeuWGex
 NIBpLdKDNE45Zz+QpLxzsP+RFlw4qvEIi4dnCzCS7WXIMdJypr+QQdQY34P/3aD6ZgqL0JOXU
 Q3XAo3LihLetxOR8Gf4i2wKTnF819HPWa32BCTccZ+tvyYic9xeF1EnkJ7c57Jdp3GcxVDael
 i4/eRNMsKivIaf6MKHuxN8jnxQn7u6J7e2gjkxMRjryakJXuCyEZoI+g1mRcvXh5EAZGd3crC
 rbkawmeapyQM3LK9w+2gJ0L3U3dg+ogZ1EQyH6INU6TjW/OrDAtaUZrfAIqsKBVd05/OXh+21
 uJgtW6c7CxcEeuGL+aYvaiR7VpncqGonJrcG77TKC+F+9PrFd9Zl//RLkE2qB2eePLOFr/PTu
 TsGIj5Xi6kcCxoxbpjizCvDfwr0fCBE5iGurk+EaPXJHGEJEWNC5AUrY3jNyWS8O/Qm4LlAcG
 9V6zvhjnxshFFSlhpQT4v265RwEGp0UcU5Li0EjbhT5mwKc7job34CzbtUTM5hCKjLJBBr+/6
 iMEQTY+jnKNq0pP028jrvHIv4je2x6gh6llDYT/GSCsm2H5iPoqXUZzsJWS4BpQEQ/qfkAsdQ
 gNpz98l8yhQqVoOof+A73PiqfHkPrKHhYfpdg/vARI9agWwp+8o4bhc/4Hetqa3WEyKCtoZI9
 nwef40ekr18KHqhuHbygmfQvuzuicQxpTuI0vVDHZtpF9uOrlGUq0TyPXsH/tZgu7JVpVvXkF
 sD689BTO16Ehip4NLP4TrmpKYDM0V+ODCFTliagIF0U5KcwSbtF22tSKLCOyRlnHBVtyWNOLI
 OanEX/RVWgSNypFSRzRVRPi6ZnDhIc0Mtf3dEmBXRdMrsVx9pE0fZ0C8K6kGUmI/xZK9U7A73
 kZ+PgZV5nUmgotDOLVB2ldrT/9OCHVDgsKvFBLPBUfRoFUgZ5nj65sdEapuQa+cEKASg5BJAR
 lMwqasr0G1ma81Z3RTLqQIt2g1ye6cb3EmZFJFNiO+kmVHJLpApjrm/soV0iLaPU6cyNBijvG
 iaUgp687H//qhU=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the watchdog was already enabled by the BIOS after booting, the
watchdog infrastructure needs to regularly send keepalives to
prevent a unexpected reset.
WDOG_ACTIVE only serves as an status indicator for userspace,
we want to use WDOG_HW_RUNNING instead.

Since my Fujitsu Esprimo P720 does not support the watchdog,
this change is compile-tested only.

Suggested-by: Guenter Roeck <linux@roeck-us.net>
Fixes: fb551405c0f8 (watchdog: sch56xx: Use watchdog core)
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/hwmon/sch56xx-common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/sch56xx-common.c b/drivers/hwmon/sch56xx-common=
.c
index 82602b74c7ed..3ece53adabd6 100644
=2D-- a/drivers/hwmon/sch56xx-common.c
+++ b/drivers/hwmon/sch56xx-common.c
@@ -427,7 +427,7 @@ void sch56xx_watchdog_register(struct device *parent, =
u16 addr, u32 revision,
 	data->wddev.max_timeout =3D 255 * 60;
 	watchdog_set_nowayout(&data->wddev, nowayout);
 	if (output_enable & SCH56XX_WDOG_OUTPUT_ENABLE)
-		set_bit(WDOG_ACTIVE, &data->wddev.status);
+		set_bit(WDOG_HW_RUNNING, &data->wddev.status);

 	/* Since the watchdog uses a downcounter there is no register to read
 	   the BIOS set timeout from (if any was set at all) ->
=2D-
2.30.2

