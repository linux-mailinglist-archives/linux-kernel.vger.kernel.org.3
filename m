Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEE4849831E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 16:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239088AbiAXPIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 10:08:39 -0500
Received: from mail-ma1ind01olkn0188.outbound.protection.outlook.com ([104.47.100.188]:59273
        "EHLO IND01-MA1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235650AbiAXPIc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 10:08:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RwRn2RXKCdXkLUiV5+GesUCAloxWqgKloufF2Yi6CiGpLYYnTmA1g1i+TaI+VszSVBzPcE/5/SLv/03aS2n3eeis4e5esbImbsnhf/rBtERTfC44aK70v4OuOZXSRpbppGlqlvRmQzgZg6EmbOC34Q+VroQek8BXL87KMJKh4O5wE95JVG4gg0RZF0pMBKQMDee/5Ffz1tk+OsbjyNBEKQCLLfLlQ3nX9pVcO5Xv9uTlCHAUQukyt3bpCUL6hxrTclO/96TzM2BJH8hoapxW/Uda2H7RF1ESGQkWYH8/WQpsXtDm3TttWiGaj41hmyYecdTVBL1W7vpLL2Gf5b6fnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v2xEJg5lAvRAf9MnaHNNG/43w0bTMk7LDhCTq6RGs0M=;
 b=RqZYvTOZ8xlHSwEHyRIee+fsZftb9i/5Af/iAUw47h4YpMeiyenHQWne130kLANapFckZxXsxkgI9rjdb6kYrxHirhyAf36N7wxpRdxYFYlYTSds0HkmIXriw7f/XrJqYMXgg/U8JBaJk+baNUNenhF+OSsM+ei5uiTS7uXeWAuDEoYjDw4WWccKeGYOJrwMP9SEVafvZeEmVuhA2IxlWgwR0ikrn0zrfpQV0c0Il5nipnad7jP8yuK+3QOaaVmdkuyW8kUbeAK3CmXhmlYF12RpSI0WPIsXePDNKuGIu2RJ3oVbg/bHQohA3+ue1BCFBZ1mMXWeJqAc7U77K0kS7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v2xEJg5lAvRAf9MnaHNNG/43w0bTMk7LDhCTq6RGs0M=;
 b=PuQqZU4wC6DfVB8tnZXesniVud3SctFU+1ejIpbg2ecsufclJqt1xSRsKF1tGag6kMdQO8CZaMEifFBerGElcjpH7SG79AM5/ldXKQHnOtpnod/S5ujv0rIcC5YbvOJh+cz0ZG63ppet2ztJsK7GdmYL+7CUIpCv4KRxCowWlUNIOhdZa2BQtPIJ/5vj/7fyCAVi07Syqgzi8QTF2CVC+r7eadkOXkUrBZ+44uPxdmuOgAIYSjv8GH1HcqDWsXIeIi86MZUhL4GjMSRmQa8TG849GeoABvgFaivCeJ2ZTU8MeQwHMduezt9uPUfZvd2AWD2aQjXt5e+tLunOrTntGA==
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:1b::13)
 by BM1PR01MB3937.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:6b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Mon, 24 Jan
 2022 15:08:24 +0000
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::d19b:7cd1:3760:b055]) by PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::d19b:7cd1:3760:b055%6]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 15:08:24 +0000
From:   Aditya Garg <gargaditya08@live.com>
To:     "jkosina@suse.cz" <jkosina@suse.cz>,
        "jikos@kernel.org" <jikos@kernel.org>,
        "alexhenrie24@gmail.com" <alexhenrie24@gmail.com>,
        "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC:     "paul@mrarm.io" <paul@mrarm.io>, Aun-Ali Zaidi <admin@kodeit.net>,
        Orlando Chamberlain <redecorating@protonmail.com>
Subject: [PATCH v2 1/3] HID: apple: Add support for keyboard backlight on
 certain T2 Macs.
Thread-Topic: [PATCH v2 1/3] HID: apple: Add support for keyboard backlight on
 certain T2 Macs.
Thread-Index: AQHYETQ7OrzbolVjskCI2e3S4xhz6Q==
Date:   Mon, 24 Jan 2022 15:08:24 +0000
Message-ID: <67E7EA8B-CF21-4794-B7B4-96873EE70EF6@live.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [J3Hm8srR8x8QQyKpgj+K4dR7F9Hg9Wb2eiIDBHINiHtKeXIOo12pNYcFxzYnPZX0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e35474c6-d514-438e-5883-08d9df4b5e3a
x-ms-traffictypediagnostic: BM1PR01MB3937:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MjjY3yLYCvembAekc89PUz5aND1+CShOodtf2F9TmIa5Xs6174pAuY2b95Q+5OU21LIr2mMCxsQS3PujLlOw+PK9JMgLhlgu92tKkUtYen0tY61wpUT5v4TU65CfmFWLq/5qFGott+3B5NMmOgpYHQvA2x/pTRepogURWN0gMA8h1PYbfSjp19Lbowdk3/6OD465k5b5VRPLXjg5g27TxXMBbmO0Hus8EAKRiewfra6rpn9w2gG0KTBNU6n/L6fO/VLSeQC41H6F4Gt/SJqpXAti46rAgjQpqde0qoGOPpSYfPNJfZE66xWjgGq9cKaxuJ5sbstReLixh9TzDRmrJrWE7wAmOnG2MkaD7z0sjhlghMx3b9nqY9yvbtS56YCS/pn/DntltEWSInyEg6fojN6mW5N5HjnvfpNGcW2FX14TTn7iajTS7qfMr+KbV/nB6HL7oKYAgziGeFDfhjKc4w1fFITKRyY0691NzwuCcUG+kff2Og8GWCzvcEePQKJbJWhdDo0kcWzworvN/rKwJSfYmMQ6beQAaVz+u+2wvZfS1IxI64qxvZrxb4SA9LWA/f/hqlq9fPiM/tXEnoC9qw==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Fj4ikm80S6evuUyAHNu+AnyT5KNJLuGdgTuz3Pjif2XibeCQd8QP54c8rWRa?=
 =?us-ascii?Q?I06SFh5AlPw4JYKuxS/hB3n08SPiFSrS+FljOrLsoFnR6mOUfAIXSzFQEhHv?=
 =?us-ascii?Q?UY7cXCY+GU0EEZiEfSlTMxMXWkqmmxaif8+fkIqhzyL4FWViwaovLjsL2Pts?=
 =?us-ascii?Q?Lr96uPw/or/4g2/5PfgofDQYWdL1ZNL5pBFXxJFPqNSMhgdnqOhoAC5hXlvp?=
 =?us-ascii?Q?iGm+N/VvcCWoE5ZJnwUrktENOTsOAxK6h0iNt7PwGwd4FGVRFiBwg4gcNsnt?=
 =?us-ascii?Q?Nut6btGwyfPxYoS6BocCh87zlJnqD+dbKpgjg5piVBNG0oZU5+Frgak37zGK?=
 =?us-ascii?Q?7AomEuY/W03gTfDwTnr2P3TzXVY9rNOEYlDXiLpTj82NDt2jSgxwUMJz3g0B?=
 =?us-ascii?Q?k+XYCWHk5EwKYS5W9/BQsAvM+lWSBHFoCkcGyBhPXjinO3VyImtDEigUmPQI?=
 =?us-ascii?Q?M5nILtA7DOuS9bl3ZCmoviPnQ6X7j+YT6pM0w1j2pE8Yn0qnu6J2oG4mvr7B?=
 =?us-ascii?Q?dmplng6vcV142duJNY14SiuwLC6RJC3/eyErcyE1A9OQsk8RngoUME1uytM/?=
 =?us-ascii?Q?jogsu4eFnjr6SwU6IytJnaHrpkFZUbK4kCTxBj9Xov5EV1HQ4bziJ/oYzlLk?=
 =?us-ascii?Q?5q6ZthlRuHhoB1C+6mv+1fM/s9QiEQAqeE8ahIf1eIoW5iXXwQSgS84X6HrC?=
 =?us-ascii?Q?MABfw58NasAMGKJbq6ThYDt5uSLzm4bVS5P8IzaPbbsA/J8AFrwUe39ibCfD?=
 =?us-ascii?Q?q924CD3iNqHDM4TuzNLRCol+Pmp18oOqOt4wWEtHD3wVR7LBMp+1fcr8Ghiw?=
 =?us-ascii?Q?J/U9UE4XmEvTMgdu6QDOtga8lp01K1/So8eXLNXGZQK2V4TGZ4zc5TeiB6uY?=
 =?us-ascii?Q?OoXPUkPijyyxA/H6Pi06tfnJxl2IPDKjNSeoSyy21ABQXImenJnxsQlyz2Nx?=
 =?us-ascii?Q?cd8SwNKAbZoUA5JLj6JMBoXuOGRKkVh+YAcvT91STd3a7CpJP80xcAmOee6h?=
 =?us-ascii?Q?w80JOr/AxxE2+KqeDQPBeKe04w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0FCD9593E385C246AD9DB070084CAA85@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-42ed3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: e35474c6-d514-438e-5883-08d9df4b5e3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2022 15:08:24.5590
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BM1PR01MB3937
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Pawlowski <paul@mrarm.io>

This patch introduces the requisite plumbing for supporting keyboard
backlight on T2-attached, USB exposed models. The quirk mechanism was
used to reuse the existing hid-apple driver.

Signed-off-by: Paul Pawlowski <paul@mrarm.io>
Signed-off-by: Aun-Ali Zaidi <admin@kodeit.net>
Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 drivers/hid/hid-apple.c | 125 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 125 insertions(+)

diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
index 24802a4a6..c22d445a9 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -7,6 +7,7 @@
  *  Copyright (c) 2005 Michael Haboustak <mike-@cinci.rr.com> for Concept2=
, Inc
  *  Copyright (c) 2006-2007 Jiri Kosina
  *  Copyright (c) 2008 Jiri Slaby <jirislaby@gmail.com>
+ *  Copyright (c) 2019 Paul Pawlowski <paul@mrarm.io>
  */
=20
 /*
@@ -33,6 +34,7 @@
 /* BIT(7) reserved, was: APPLE_IGNORE_HIDINPUT */
 #define APPLE_NUMLOCK_EMULATION	BIT(8)
 #define APPLE_RDESC_BATTERY	BIT(9)
+#define APPLE_BACKLIGHT_CTL	0x0200
=20
 #define APPLE_FLAG_FKEY		0x01
=20
@@ -61,6 +63,12 @@ MODULE_PARM_DESC(swap_fn_leftctrl, "Swap the Fn and left=
 Control keys. "
 		"(For people who want to keep PC keyboard muscle memory. "
 		"[0] =3D as-is, Mac layout, 1 =3D swapped, PC layout)");
=20
+struct apple_sc_backlight {
+	struct led_classdev cdev;
+	struct hid_device *hdev;
+	unsigned short backlight_off, backlight_on_min, backlight_on_max;
+};
+
 struct apple_sc {
 	struct hid_device *hdev;
 	unsigned long quirks;
@@ -68,6 +76,7 @@ struct apple_sc {
 	unsigned int fn_found;
 	DECLARE_BITMAP(pressed_numlock, KEY_CNT);
 	struct timer_list battery_timer;
+	struct apple_sc_backlight *backlight;
 };
=20
 struct apple_key_translation {
@@ -76,6 +85,20 @@ struct apple_key_translation {
 	u8 flags;
 };
=20
+struct apple_backlight_config_report {
+	u8 report_id;
+	u8 version;
+	u16 backlight_off, backlight_on_min, backlight_on_max;
+};
+
+struct apple_backlight_set_report {
+	u8 report_id;
+	u8 version;
+	u16 backlight;
+	u16 rate;
+};
+
+
 static const struct apple_key_translation apple2021_fn_keys[] =3D {
 	{ KEY_BACKSPACE, KEY_DELETE },
 	{ KEY_ENTER,	KEY_INSERT },
@@ -530,6 +553,105 @@ static int apple_input_configured(struct hid_device *=
hdev,
 	return 0;
 }
=20
+static bool apple_backlight_check_support(struct hid_device *hdev)
+{
+	int i;
+	unsigned int hid;
+	struct hid_report *report;
+
+	list_for_each_entry(report, &hdev->report_enum[HID_INPUT_REPORT].report_l=
ist, list) {
+		for (i =3D 0; i < report->maxfield; i++) {
+			hid =3D report->field[i]->usage->hid;
+			if ((hid & HID_USAGE_PAGE) =3D=3D HID_UP_MSVENDOR && (hid & HID_USAGE) =
=3D=3D 0xf)
+				return true;
+		}
+	}
+
+	return false;
+}
+
+static int apple_backlight_set(struct hid_device *hdev, u16 value, u16 rat=
e)
+{
+	int ret =3D 0;
+	struct apple_backlight_set_report *rep;
+
+	rep =3D kmalloc(sizeof(*rep), GFP_KERNEL);
+	if (rep =3D=3D NULL)
+		return -ENOMEM;
+
+	rep->report_id =3D 0xB0;
+	rep->version =3D 1;
+	rep->backlight =3D value;
+	rep->rate =3D rate;
+
+	ret =3D hid_hw_raw_request(hdev, 0xB0u, (u8 *) rep, sizeof(*rep),
+				 HID_OUTPUT_REPORT, HID_REQ_SET_REPORT);
+
+	kfree(rep);
+	return ret;
+}
+
+static int apple_backlight_led_set(struct led_classdev *led_cdev,
+	enum led_brightness brightness)
+{
+	struct apple_sc_backlight *backlight =3D container_of(led_cdev,
+							    struct apple_sc_backlight, cdev);
+
+	return apple_backlight_set(backlight->hdev, brightness, 0);
+}
+
+static int apple_backlight_init(struct hid_device *hdev)
+{
+	int ret;
+	struct apple_sc *asc =3D hid_get_drvdata(hdev);
+	struct apple_backlight_config_report *rep;
+
+	if (!apple_backlight_check_support(hdev))
+		return -EINVAL;
+
+	rep =3D kmalloc(0x200, GFP_KERNEL);
+	if (rep =3D=3D NULL)
+		return -ENOMEM;
+
+	ret =3D hid_hw_raw_request(hdev, 0xBFu, (u8 *) rep, sizeof(*rep),
+				 HID_FEATURE_REPORT, HID_REQ_GET_REPORT);
+	if (ret < 0) {
+		hid_err(hdev, "backlight request failed: %d\n", ret);
+		goto cleanup_and_exit;
+	}
+	if (ret < 8 || rep->version !=3D 1) {
+		hid_err(hdev, "backlight config struct: bad version %i\n", rep->version)=
;
+		ret =3D -EINVAL;
+		goto cleanup_and_exit;
+	}
+
+	hid_dbg(hdev, "backlight config: off=3D%u, on_min=3D%u, on_max=3D%u\n",
+		rep->backlight_off, rep->backlight_on_min, rep->backlight_on_max);
+
+	asc->backlight =3D devm_kzalloc(&hdev->dev, sizeof(*asc->backlight), GFP_=
KERNEL);
+	if (!asc->backlight) {
+		ret =3D -ENOMEM;
+		goto cleanup_and_exit;
+	}
+
+	asc->backlight->hdev =3D hdev;
+	asc->backlight->cdev.name =3D "apple::kbd_backlight";
+	asc->backlight->cdev.max_brightness =3D rep->backlight_on_max;
+	asc->backlight->cdev.brightness_set_blocking =3D apple_backlight_led_set;
+
+	ret =3D apple_backlight_set(hdev, 0, 0);
+	if (ret < 0) {
+		hid_err(hdev, "backlight set request failed: %d\n", ret);
+		goto cleanup_and_exit;
+	}
+
+	ret =3D devm_led_classdev_register(&hdev->dev, &asc->backlight->cdev);
+
+cleanup_and_exit:
+	kfree(rep);
+	return ret;
+}
+
 static int apple_probe(struct hid_device *hdev,
 		const struct hid_device_id *id)
 {
@@ -565,6 +687,9 @@ static int apple_probe(struct hid_device *hdev,
 		  jiffies + msecs_to_jiffies(APPLE_BATTERY_TIMEOUT_MS));
 	apple_fetch_battery(hdev);
=20
+	if (quirks & APPLE_BACKLIGHT_CTL)
+		apple_backlight_init(hdev);
+
 	return 0;
 }
=20
--=20
2.25.1


