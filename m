Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCB904A3F4E
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 10:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238802AbiAaJew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 04:34:52 -0500
Received: from mout.gmx.net ([212.227.17.22]:46683 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238306AbiAaJer (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 04:34:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643621671;
        bh=M8VxZrM69T8fzVT7HtYVnghJWaulQqQeYn5dd1DXrAA=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=lEPzbHz/o6n9tqfgBJgHAdn74JEvwX7zqbLGl5KFxWcK9GZKo+Aa1x11WW2W4k1cJ
         8y347rda+r0xigkXYDFfKpmR4WA4s71fJeXYho7nHd2XtELDYSWgNYNB2yl5wLpp0P
         C0AynlwZHOB3r/hodTHLW67056SVrfcV7/31A8ug=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.fritz.box ([91.137.126.34]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1M1Ygt-1nFprJ3Ab5-0039OH; Mon, 31 Jan 2022 10:34:30 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] hwmon: sch56xx-common: Replace WDOG_ACTIVE with WDOG_HW_RUNNING
Date:   Mon, 31 Jan 2022 10:33:55 +0100
Message-Id: <20220131093355.4151-5-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220131093355.4151-1-W_Armin@gmx.de>
References: <20220131093355.4151-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+wxF5tjDBrr6qZXjNNdOEl1gozLgystT2l6LjfZz6OaXZZIYQYi
 U9mzwcLVs3B0qKhBNm6zCg88jL4hyY6bYU/KpNW0xk1RyrFQbLb4XfViR9O7gNyPrm3yem1
 a8bDe0Z4HFz2jWcYGDhQXWhuf0A/UnGF6m9Mmz0x4WEtwZ6shHd9NZAD0x6APsDVf7zl+Es
 de8yE2CZaDa5qMm29m4VQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:o8A+Fx8g6Qc=:EJvih/3LwWOK+A8e+rtd3q
 ePGpG54K5mm/f4QqWco6oMoTmCorFG7G/LSep6kc1WQXBQektuHBPHyw7FfrR6s3BGn91HD4D
 B5n59ik0z6nuUg0O5ZxEpiYjVdB5FDEjKxv554lTvji+1Xb/hZYXadBK/dFxQQSHr41XjMvXg
 B1y3i4E2VHahlRtelK70POGPaGwzmfkgu+IOlQPhkEHeGAL63yeSSlMjuqKEfuH+n/WXNRMnM
 dcPCCKvD/Gso+2nI9jXz0hI3ACRQf9mVd7wm4/boh8FgiKQ9SQkYjyzSAghadWcn2f+QO9aaC
 xg1p6R9vL5C4UvbsgW46JNiIgdLkfxnhpPbGahsAR5IM9xAgVKEA/cLOgkTcdUQxcLbhc8FU0
 a9454CN90ULrMvHZ8O+ZXtYQR3DcVOB022TQMHfPicmqQGtujP4BWsKLmdmHVnqN4O5q51Yuz
 aV/xnrQkCOJANi31PFZ0pLLWxRF6aOC9XFl4lkN2G955ZaBKHhCC/sAFYPFbwSn5l210j3zMS
 iz475P0Zz0YEygDYeAnqMXfRWZI/nqhb97BYJLxsgH/eaqaJlLBSQB823gq1Pu9KO31dDxvFc
 F7uVw0K1liPktTxmFLhWejNtoWrGcoGU5cHq5Imj4Y3O3esjHAYXHEwpr8YDStnMHNW2WlBV2
 AZ5od7WClKBYpnthe6cX5T1kgC7GbqGedAIVfdWJ8ZzFV80kT1GMASR42F7MEFg2L6cR61B9P
 ACfGc9QUR76rzW0y8T0gKSib+KsQMcjgrkDYXltn1RlM7gE4DRzAYhMvKgnp9mbhIwljMnLJv
 QLA1z7sy5r8lJLOMixTy3XOonOqMEYMS70apwrDbpVqvmSaQ9SuRXCcIxzlPoIeSReCsy5Prt
 rtBs6pIJBTUE+OdTTzYy6v+GXX4H9c9/Q/k5EdtfjEQzTybU9d06+4wfNz1jrL/IT2zud1hi9
 147vbnJy8QN7jkg/KUg5rAHbOeX0WkrWUW0bZluO39xqV5cdfQ5XFHYxSkcGOtN9o+Sp+K8ps
 esHZm02Kw46Fdk5n25/SZHDTNO4pWQuEIwfPd/4zyFJZblqlZkNhWRhCYyxpvMiSFsu2yEu22
 dnF7FG5eEeNDEg=
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
index f66e1ed4b1aa..2cd146fd0562 100644
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

