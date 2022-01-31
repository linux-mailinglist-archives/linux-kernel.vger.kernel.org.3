Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 776EE4A3F5F
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 10:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240974AbiAaJih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 04:38:37 -0500
Received: from mout.gmx.net ([212.227.17.21]:44793 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240686AbiAaJia (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 04:38:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643621893;
        bh=M8VxZrM69T8fzVT7HtYVnghJWaulQqQeYn5dd1DXrAA=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=CwMBW/ysfcJWiL+ER3SYZ17Eknj9kDFRU98lseUJd7akCMQZq9t6t3gSNYS+azKp+
         sKZHexUhCMyV6QUZMdgtGGoCtcEd6StwA7hikEwNNB5ILAyrz9Jqfrlo5KeJhucyXh
         KWE3sl7RitsxNtc1te/R+eS6RsCIsZmizzBF530Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.fritz.box ([91.137.126.34]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1N4hzj-1mCqAc24vP-011gXw; Mon, 31 Jan 2022 10:38:13 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 4/4] hwmon: (sch56xx-common) Replace WDOG_ACTIVE with WDOG_HW_RUNNING
Date:   Mon, 31 Jan 2022 10:37:56 +0100
Message-Id: <20220131093756.8075-5-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220131093756.8075-1-W_Armin@gmx.de>
References: <20220131093756.8075-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9QBdxLpwQraj2RF0DjGnbPUr64KV/UJiV0ngLb/rPcGIGhUtmZY
 aOgreswTTk/TemZzQEUZPuN6ImKxtTkRFQf1G+/iBzdb/iL8dfUbrmN6VA67l+hutHAcCl4
 htrWaSDwRm102+DqcHVdqBTsjVL4E7v08tDrXFJ/uelCqGXAUPu8JfDBSsdPmsoKeHP2CPW
 2NZNlBoP+QBJdGHZymrxw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:wruDPY0hL/E=:FSYCl1tY/CCeoaGaTWlljW
 d6efG0vEpOG5Carnk4rXdjqAvWslHAi7FiqN9cL4EvaQhzxVvXz32aJmmW8GikZurQP4OjS0f
 Bul/BaDtHFojGcLrW5/MdFEIw0Dv3HsgXAadLRkU1gN1jlKKDwTryfipmNo4b3GoC1lOz3UZ9
 lwnVNfNAHL6HRN4pbyVmuUWYl+5b655jOl0xhTFDx5MoIMaIx0KsL0xmqnBdi7LIc99yCviDN
 4OX7lLzRlfNOUeIMCo3NGiv3G7pZcn050o2GW7DhDidfyNzfj49rtq/c3n5QQOGgDCG+4glj7
 iXaDLFzPuANANK2Gbg8XgyJqNOZxyo9G67yMWmU1Lgf5ygbMGI1xeWwQ3+11wXwipEeV6NFEq
 H2som6psHeh7GZhW99V9+ex+NG3DCFUFC29wJ5E/KjRVVRqECbel1bH9yijKcO+tNeZ+UMWFJ
 ai/77bgFbxyL86vK9FDre8xAVfn4RPvNAncirWoo7xMyL9eZvCUpdx5YTj0/9Uvay5fkqqaMD
 sfge8efI+JbfAhoQiKxiotd8XmGrBsw2bE+NYQxuyZ1sUKseFK1OZT8PG/0/c+2EW5JOX3Wag
 b0jYkC8fH9LDenmNkJD9TLUigRoOxf4chUQEWINqgOTInT06Y9p0kPluYzPUekRnJknQZ45if
 sYP+jYdGgnjEGAUdUhLu5GsgkTDC1vi5j8nW9+1jwnFvVAWF1VHTGQ1uoDC8hyF3rfo00TilH
 xxk876pKFRIjnWfXlp2Vu0W5EODwqBifXKkRDYhzKcMIG9RC6JUHO/aKDvb7ZSi78n/abuCWw
 P/n5Lm4bZrGVZNW/EpE1yF/wWTbVDMhkI/O1yhYYZ6ZivAGKWZBJ9OY31GZ7z8DZ8qvXYDHPS
 z6E2b9bbBQILHFY48hsKlpCistgTQaE9k3P/yho8UiSPK/Hx1wIOsf9v4bReJ36cXFddRNV3w
 hxlQfBzHZvN1qPZ/C4PlTqNwVD6SH9/ovTymnk6GYBOix+JXqUfvXV0CDCTaeu/YnwOdylvHa
 42TbVG8VWHnGS6Zwle9LCciMTc6ix9QoUkbbwOjWjaeBdd9nAhXZqJgS4a7R6kIB80wCIBk3s
 v3VSX5/b3DLaNY=
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

