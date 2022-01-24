Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9210B498322
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 16:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240159AbiAXPJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 10:09:53 -0500
Received: from mail-bo1ind01olkn0188.outbound.protection.outlook.com ([104.47.101.188]:6121
        "EHLO IND01-BO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240451AbiAXPJc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 10:09:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RXi1m06ailTtlCx6jS1XWQeO2/y32t8CG/n+dona5DOp3NVrjSR1tzAnK8CEYUKI24qh/hD42EKM3t2Bmb+OztTLH1qt27l3ZcGJwkCq7Rl14seCE1VtLtwYHyxURkVMZtNWGZ24uN1JnhaCXxVumW6HWCUVcq5v4iopV1ICpemMn4rwM7vd2Fq1F6sAlzrXABTuTGvLaHtyZOEE3vcHCM4Bd4iENR/+zxLmtKTGAsM/Zh48/GlyvtLHNbuGHHugaJPogxJSK636IyDlzSMJW372edkPFUmlQzl7jYtbseDBqFni4KHiQPcFm9ZkxnHOsEPmrbiYnV4Mf7b9g4cF5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=krma4VHb9sJrmprJ5mShOQ73B5oR6gD1pgrE1j02stg=;
 b=lPD7uGHUgcf0EUkxgjxZMBx41USKDo/o5aCJ14/QsbSr/xP7gLzGc1Hj3SUEYk4sgl2NAWjwR6aIhS5rp0fQOTa1w9rbVi9FhA3ILIhzAtIZOpC8I6etEYyi5VfmZ4ZPbyOL/4SQcCo72c9gdttZUurKUoKMhcEO0NnHQ2rZRiPMSA6sSDPqEex7MeKnSnkhpO8uQ8DEKPeqdxJRxuezJvVJ0Bc1Oj1T3x1qv17IAdIR1up/VUlrY70wJxM4y8jrGiIl/6lDDW4uSMYXSCYn+FvZarWrXqTWarK6colh2cfePYU5UJZp/so0OxXkGXrrucEX+CkHM29Ak7ajsFLBxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=krma4VHb9sJrmprJ5mShOQ73B5oR6gD1pgrE1j02stg=;
 b=vH6eSUowFnyDfMFZv5VrZs7Vqfg29lvVbCW7UVS4r5kJ8IHb7NXw6Zuc3IOp3Ptl5ZF2a9V7zph6tXFCuQlUwLVzTS3F44VHJdTko5/8vCPraD0f/3YZfkW9OpjsBeyV1gjkq45bBSZuHjumTqFEWNmJQtUKWxSnT7P8iuRN2/WQvvdfGYf89hHYIdu2aGasHPDvv7qLRBFjFsXsyIHzDES9sblWLtZgsgQnOa1HpSj0F8VC93y0lBMazzOoGwQomBBVq3x6l1TgZLmnR5+1tbDJRQkWD3qOfincXmnlL3L8G36ngdNu8Ni4me2KzJdXp7WoueOltUTfpDr/keXccg==
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:1b::13)
 by PN3PR01MB5602.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:79::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.11; Mon, 24 Jan
 2022 15:09:26 +0000
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::d19b:7cd1:3760:b055]) by PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::d19b:7cd1:3760:b055%6]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 15:09:26 +0000
From:   Aditya Garg <gargaditya08@live.com>
To:     "jkosina@suse.cz" <jkosina@suse.cz>,
        "jikos@kernel.org" <jikos@kernel.org>,
        "alexhenrie24@gmail.com" <alexhenrie24@gmail.com>,
        "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC:     "paul@mrarm.io" <paul@mrarm.io>, Aun-Ali Zaidi <admin@kodeit.net>,
        Orlando Chamberlain <redecorating@protonmail.com>
Subject: [PATCH v2 2/3] HID: apple: Add necessary IDs and configuration for T2
 Macs.
Thread-Topic: [PATCH v2 2/3] HID: apple: Add necessary IDs and configuration
 for T2 Macs.
Thread-Index: AQHYETRgOOoNCnOlSkm/7/gwoQwsJg==
Date:   Mon, 24 Jan 2022 15:09:26 +0000
Message-ID: <4016C218-BF0B-484E-BDFD-A88FB7510E3E@live.com>
References: <67E7EA8B-CF21-4794-B7B4-96873EE70EF6@live.com>
In-Reply-To: <67E7EA8B-CF21-4794-B7B4-96873EE70EF6@live.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [cUDEZEmPH04O5OuJXardPieL0Y2uMQZCTw1U4EbJW7K0Bg4U56iuzCxHcUrLzCQL]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 85de07f2-9c0b-4b6d-e8dc-08d9df4b835e
x-ms-traffictypediagnostic: PN3PR01MB5602:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HMdfOrrLh8ixcZXWc1t9PidJ1194RvM35uCp2sZJo2ifnDHHR5LK0eJmt/6bXl4vIixwYTTnOzhEou3SeR19keriQo2ycHeQESMDVtgpFBvzfuNKbhOIO2ds9hal4hYIzFtLphMSBnrYCn82tU2ayz5iPO96DvgVU7jjdXMmRo45c9BVKWMzQ662Jer0p+Jq8YIvCDKnpmh5WTTj3OQwFbnxACAiGbI0+GE6Z6mHotgDTgvPTpboORCJau006qLiPaS+VjSmUn8xx6GRZw/P9U++pNA8NdsxFTDf3uTW+A2hb/cFYqH+U6L6CclkWQUIqtiRvhodT52nkRexVKgpRhJ+V5Ci2jkdV9dUmk9AMY4XOFlebdDz1ArfRhZZYrPtD5CMlwSM2AWYBtOKcA7+gMFL7ANW7BCyQuxrcdg3Pgwinr/TXlCmyBh6QbihLHKWPoXu0zAzeFbpkVVQThBvF/dV55j2hLNYGS4S3QJXLotHcqYpYPZbyKbNKfVQP6cMqhpRAMHdDeBuR7Rn2q63pWbSeQlFlQr/FAAhSQ6xwSBxM2MR88rU2xsYzlhoVIovz/oFty9X/YSJukJqqZTyNA==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HREGBBI5y809FrbXyjHIdsALVxJX1xyAKBg0hEhCbSJuO42i8FR/iWcXdmxb?=
 =?us-ascii?Q?cYxotzP961W9l3fwZx7PuwEc++1ZvuzX03AKMoImABxokRWRv1R/fsY4+Kbm?=
 =?us-ascii?Q?3eXGlBYnj3UV8ryGuSORYiWnpqHAYzAJWdGGg2KHM77xDN9iEuC7PWMxTjaZ?=
 =?us-ascii?Q?6QqrVqtBAiJD2ZKKpznZLkQMHyN11IicV+Ev98t0XEhn/GoVPQ81Zb0j4jwQ?=
 =?us-ascii?Q?QkK84TBK/qA5oLX6On/+JfXv69gHLFSIwWYM8qB2rWzeqACCmSfSHQQkNLWG?=
 =?us-ascii?Q?I1eMv6FfGi8T15im9uGgDmHvoS30FZ6ODo/BPhWXoLKvRxV7TLpGo4uML1FH?=
 =?us-ascii?Q?NGFdAwIDusO7DLTR4dkQ77zQnH8qI8uI6tAtcD4QykgGYnF53HUrKvz7tflK?=
 =?us-ascii?Q?V881YG9N+4tjiuuwzT66L1kbAaB+GdWLNcHgc+QmTnBTDry7bym5uT/73+4W?=
 =?us-ascii?Q?WgpY9YWNSXa7kvMxKAymiUsWMQaR4z/3BuJtSTLaOKu07C5ZGq9gzdLcbgEp?=
 =?us-ascii?Q?b3zGAFLxIv+uN/o8k3d4VHUda9QK72PefjMq6fFjlGDrLHTMQEFoCg8oL04U?=
 =?us-ascii?Q?KjBJcR0Y1dNow8IHuAN8zLJqWwau5n/FflTn+A5y1dYrGxmxU8sRavAQWi0e?=
 =?us-ascii?Q?rB97239GPSTABXo8/Hmf+v2c72zMKi45Yd4hHzJJnWA7+5KsP9u02uyaByB3?=
 =?us-ascii?Q?yoHHF1MPETVHQJonEFzwvwSkYdXX5pY/IUropI9+ddwtjZljZZ2ghS1RlkiS?=
 =?us-ascii?Q?RED1wW3ijyfBBk3TS2XpAzQYWkNLkYykndVlnh6Ox3jAiVltZHqYG9Ij6HSx?=
 =?us-ascii?Q?BPRm2BkVxjaCKp67WMv38DDUgCT+8JCwOBOkFpasR1AUxzrDFUMkYIzvRmer?=
 =?us-ascii?Q?TAhpiBEPpsMg23GtovfdAYXPboGjQ5tUmu0W9qDaMK/Y+V2UgVfLyjBKn/mB?=
 =?us-ascii?Q?t/K6QRXX9ScyCgK+net0mrxAQW+GI/JKbti3/z0KuAYmk53MGqhR0dMQ66Qx?=
 =?us-ascii?Q?32MxO78bdSo+P0TrMOujSKlTCQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <84531C822ACD7844B3902304950043B8@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-42ed3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 85de07f2-9c0b-4b6d-e8dc-08d9df4b835e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2022 15:09:26.8587
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB5602
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aun-Ali Zaidi <admin@kodeit.net>

This patch adds the necessary IDs and configuration for Macs with
the T2 Security chip.

Signed-off-by: Aun-Ali Zaidi <admin@kodeit.net>
Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 drivers/hid/hid-apple.c  | 16 ++++++++++++++++
 drivers/hid/hid-ids.h    |  8 ++++++++
 drivers/hid/hid-quirks.c | 16 ++++++++++++++++
 3 files changed, 40 insertions(+)

diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
index c22d445a9..823021c24 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -861,6 +861,22 @@ static const struct hid_device_id apple_devices[] =3D =
{
 		.driver_data =3D APPLE_HAS_FN },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING9_JIS=
),
 		.driver_data =3D APPLE_HAS_FN | APPLE_RDESC_JIS },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRINGT2_J1=
40K),
+		.driver_data =3D APPLE_HAS_FN | APPLE_BACKLIGHT_CTL },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRINGT2_J1=
32),
+		.driver_data =3D APPLE_HAS_FN | APPLE_BACKLIGHT_CTL },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRINGT2_J6=
80),
+		.driver_data =3D APPLE_HAS_FN | APPLE_BACKLIGHT_CTL },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRINGT2_J2=
13),
+		.driver_data =3D APPLE_HAS_FN | APPLE_BACKLIGHT_CTL },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRINGT2_J2=
14K),
+		.driver_data =3D APPLE_HAS_FN },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRINGT2_J2=
23),
+		.driver_data =3D APPLE_HAS_FN },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRINGT2_J2=
30K),
+		.driver_data =3D APPLE_HAS_FN },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRINGT2_J1=
52F),
+		.driver_data =3D APPLE_HAS_FN },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_WIREL=
ESS_2009_ANSI),
 		.driver_data =3D APPLE_NUMLOCK_EMULATION | APPLE_HAS_FN },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_WIREL=
ESS_2009_ISO),
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 26cee452e..8ad26c20f 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -167,6 +167,14 @@
 #define USB_DEVICE_ID_APPLE_WELLSPRING9_ANSI	0x0272
 #define USB_DEVICE_ID_APPLE_WELLSPRING9_ISO		0x0273
 #define USB_DEVICE_ID_APPLE_WELLSPRING9_JIS		0x0274
+#define USB_DEVICE_ID_APPLE_WELLSPRINGT2_J140K	0x027a
+#define USB_DEVICE_ID_APPLE_WELLSPRINGT2_J132	0x027b
+#define USB_DEVICE_ID_APPLE_WELLSPRINGT2_J680	0x027c
+#define USB_DEVICE_ID_APPLE_WELLSPRINGT2_J213	0x027d
+#define USB_DEVICE_ID_APPLE_WELLSPRINGT2_J214K	0x027e
+#define USB_DEVICE_ID_APPLE_WELLSPRINGT2_J223	0x027f
+#define USB_DEVICE_ID_APPLE_WELLSPRINGT2_J230K	0x0280
+#define USB_DEVICE_ID_APPLE_WELLSPRINGT2_J152F	0x0340
 #define USB_DEVICE_ID_APPLE_FOUNTAIN_TP_ONLY	0x030a
 #define USB_DEVICE_ID_APPLE_GEYSER1_TP_ONLY	0x030b
 #define USB_DEVICE_ID_APPLE_IRCONTROL	0x8240
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 9af1dc8ae..963cf2a2e 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -294,6 +294,14 @@ static const struct hid_device_id hid_have_special_dri=
ver[] =3D {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING9_ANS=
I) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING9_ISO=
) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING9_JIS=
) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRINGT2_J1=
40K) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRINGT2_J1=
32) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRINGT2_J6=
80) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRINGT2_J2=
13) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRINGT2_J2=
14K) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRINGT2_J2=
23) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRINGT2_J2=
30K) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRINGT2_J1=
52F) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_WIREL=
ESS_2009_ANSI) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_WIREL=
ESS_2009_ISO) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_WIREL=
ESS_2009_JIS) },
@@ -929,6 +937,14 @@ static const struct hid_device_id hid_mouse_ignore_lis=
t[] =3D {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING9_ANS=
I) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING9_ISO=
) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING9_JIS=
) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRINGT2_J1=
40K) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRINGT2_J1=
32) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRINGT2_J6=
80) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRINGT2_J2=
13) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRINGT2_J2=
14K) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRINGT2_J2=
23) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRINGT2_J2=
30K) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRINGT2_J1=
52F) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_FOUNTAIN_TP_ONL=
Y) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER1_TP_ONLY=
) },
 	{ }
--=20
2.25.1


