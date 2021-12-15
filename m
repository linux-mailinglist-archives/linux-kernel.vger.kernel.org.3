Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 370F5475774
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 12:12:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241967AbhLOLKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 06:10:46 -0500
Received: from mail-shaop0212.outbound.protection.partner.outlook.cn ([42.159.161.212]:32267
        "EHLO CN01-SHA-obe.outbound.protection.partner.outlook.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236845AbhLOLKo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 06:10:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ImS8LIRjE/kBznTxnRs+G0xYOGdVzN3kOOM6OZLuFCBhSaBiZvXPK9gworz69xWbSnVNSMSdY5V/xTaNPEpnQdjychWFHckROx8EhXTq2VL0+hUGMzZAJb2CmlI0MLCxvAZEunOHV61hTuU0SddTkcCj0WTYNfOpx8uWb4yamH1pkNpzSPZ+DdvC9KqIW4apCe7zzJbOJNRUmK+dhtJ4Ap0bObKgjhKZpDZ95zQXc73Q3DuXmSMpsUjpAzAnel5Kbk6OCdpvQsJP4MkI3SiKdlDVafytiXfaVzPpWBsdQt1c6LwwqoxKZVJ9oGPsg1Fkiie2fvBLrZIX9vqQ3iCSHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0gcdPGiBlPJALmyChvu4q5cRixPI0346mJD0kGtVRaM=;
 b=CFw7hrfOw+Gnve6wjbAyGrZQDNyIsJ4ExDq5zDr61eyBeelffQC83cKReVCtFRtPan7/oSSJRsHRq8cUgMAtUmoW3Rjd1w+TpTRE9neOSrRIW7Ev4xMA9kBBDYKYwTsNgdF762dbtFcTXej7jL7PynEhbqncha3npGWNHE6pdKa3kvxT8X1MUgc+UptKRFsA14IqNc//f51F4KMTHLvFAhm1vT7Wew8Qefhqtn/NktNd6pth96FMsXn6czC9G1W0y1iGDA1+Kg0mHIBgnuRnmT2eApBlXttS7+r7+ymJJuhmgE9JT+XRH+LIeGKJJ0GutUecCvLhl5QmJhiQ1en70g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=armchina.com; dmarc=pass action=none header.from=armchina.com;
 dkim=pass header.d=armchina.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=armchina.partner.onmschina.cn; s=selector1-armchina-partner-onmschina-cn;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0gcdPGiBlPJALmyChvu4q5cRixPI0346mJD0kGtVRaM=;
 b=tkeBaWG+R1LkRj43njIO2qNEu4//6vpvGH7Setrxx4ubK/umyaVIbV/Yz3I0nF3yOiUHdcTEWzt71SSw/Kqy3cYFpIVhaKkUB1u9oLtWom6b2U3mNvWIqrPNfEc52ShHaDiaFsCKqPI35guz4G1L/yxtqVExUrH1vSBGXKC8Btg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=armchina.com;
Received: from SH0PR01MB0634.CHNPR01.prod.partner.outlook.cn (10.43.108.74) by
 SH0PR01MB0827.CHNPR01.prod.partner.outlook.cn (10.43.106.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.13; Wed, 15 Dec 2021 10:36:21 +0000
Received: from SH0PR01MB0634.CHNPR01.prod.partner.outlook.cn ([10.43.108.74])
 by SH0PR01MB0634.CHNPR01.prod.partner.outlook.cn ([10.43.108.74]) with mapi
 id 15.20.4778.018; Wed, 15 Dec 2021 10:36:20 +0000
From:   Dejia Shang <dejia.shang@armchina.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Cc:     dejia.shang@armchina.com, toby.shang@armchina.com
Subject: [PATCH 2/4] Documentation: add sysfs entries for Zhouyi NPU
Date:   Wed, 15 Dec 2021 18:36:07 +0800
Message-Id: <20211215103609.9268-3-dejia.shang@armchina.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211215103609.9268-1-dejia.shang@armchina.com>
References: <20211215103609.9268-1-dejia.shang@armchina.com>
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: SHXPR01CA0021.CHNPR01.prod.partner.outlook.cn
 (10.43.110.222) To SH0PR01MB0634.CHNPR01.prod.partner.outlook.cn
 (10.43.108.74)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3dfa70e7-f1c6-4a0b-db75-08d9bfb6bbe9
X-MS-TrafficTypeDiagnostic: SH0PR01MB0827:
X-Microsoft-Antispam-PRVS: <SH0PR01MB082716F79168577191F211A798769@SH0PR01MB0827.CHNPR01.prod.partner.outlook.cn>
Content-Transfer-Encoding: quoted-printable
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EQqUFuWgAk1hey1xVhcYHV2UXaQiGyRmQsHdQdtcORiz68zooDGSaXnDkf53I2mtwSHLyJL8AYl9u5fNANx+SNx6E4KocELckhBWKFMxempX5sTk7+w2S8p1yFEzKwO23pJ12ta4/YGDn8CWTiMOpygF/3gAEXTJGaqOqJORzcB9EakUlOAecv52wFrbE7T8pwb1Zf4bbTn4scUH2YTZVQd7EF7SfZJ2SqJc0hTcmrVS9ixTZJucf1Z+bzGh+bbsZe8xPFwZT0GhJ7e0AOCitfQYX9XbI9orwtcL1rWEzOXSpBL1M28UNxmVi4Yw4s4cNv0DwFcnDCXWz7qAxOGJVyQOVsH5S3kzwLQwV2bK4RFkweLsZnkTmTVDzvzBQtClMdzUNtI8qR+r4SS/q7/89T5cHY3VrL6XsgyZSvMXnJA/sJIIJs7TeQLDPOunpf8hll/uwv0DgEUsdvKRbXGDc4f3PzAZBQEjl61hjPuLrITFL7lGsdvnyIWYoNUgBJv59g+Ckz3+iDldwJw7rI3YZLjwfSFwn6REpm2kbahZ3o9kzX9Of4VXlfLqnh0twqB+DtgY5e2GYIoXutWPX6vPrgQ9+HtgR26MqmnJsO1HPZK524kL+hcq2YsfpJqEd9ITx3BnG2LjBJ3mAypTb0GzmdGKnQoXpVjNGxEoWOne0PA5DQE++fpSd3QJU0Dvm7++
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SH0PR01MB0634.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230001)(366004)(1076003)(6666004)(508600001)(66476007)(186003)(86362001)(52116002)(2616005)(26005)(8676002)(40180700001)(107886003)(4326008)(38350700002)(38100700002)(8936002)(44832011)(40160700002)(36756003)(66556008)(5660300002)(2906002)(66946007)(83380400001)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uY/jdLmywe7LEVYqK92fI1t7NaRQYG+PP71xzb115jSGW/gKyUzil7DjUsDK?=
 =?us-ascii?Q?9PLirIQyFBoXIfOf5ZQYEpBKrXHW6zpFYXosypv414cV85JPr1rp+TsIDdRo?=
 =?us-ascii?Q?Ht7hpJz5xZokWIlV7rgn9/01F2Q8uATm0q20ryMLzPZFyhQYuq+Hgnaf3Dq2?=
 =?us-ascii?Q?jwvFRkji0dyTMmzInxSKKyzKJ76iSFeuQOM+1ns5zLBFBNRyU9DjfR2yle6e?=
 =?us-ascii?Q?p5YVfZWqA9hchkT3WmRG0f8kgwSsIH7nbLuoFwvv9mcsZrIRymDEomfmgq0N?=
 =?us-ascii?Q?lz5WIaxLOoUtDNpazdbkfMt42bGJRXSQzko1I8grm3GCi4NMworRof9BDW7v?=
 =?us-ascii?Q?/PwkjVvtGamGlBgh/HYLXIB1j0cbACNaoZDB41tyuG/biKvN3HNUAA36hMcF?=
 =?us-ascii?Q?lbKW7JZQ8q9I7op0rnutIlwqEQedL+C1C0xVcFjIbr2FjYwcLuiWNA5wvaL5?=
 =?us-ascii?Q?ozmljswW7djlhjh7nZOdBwMB0C0qv5kvJFwESEV+wrHh/qh2wh7hYkaOk0PH?=
 =?us-ascii?Q?oG0FAPkOTm2GORowwnSguteiSdr2IqzMm/Ks1a1uKk/ef3ESHGQlZnkSOAnL?=
 =?us-ascii?Q?h+w8MZFy1LCoyIWkz5qem0/eygEup5v4twOPBIx/xIsie2b0S5Tpi4BQBlQ3?=
 =?us-ascii?Q?WMJh5uOoV2HC0k3UDKt17Jw1AY+U4T7mMwYmOHn/zlupbBNOAkgLuZPiiOYD?=
 =?us-ascii?Q?s6goBV2C5IumdxWmFOwfaqGOXBziHJIp5VYnW6ERWKUJRWV/XnXoz+DNTtsZ?=
 =?us-ascii?Q?xto01gMTNMbEd+uI11QvbB8rx2YnFLApEwl4CALR/E4sJ754wsz1KO5fSrVG?=
 =?us-ascii?Q?0O3qFHRdUVDKJT8jyJMQy9BfOVylIsbkGYkFiAjAsc6EThyV69HL5A0yZ3eS?=
 =?us-ascii?Q?ssfdp8rXX2S0qJhXSi5MYHLYvI2ITSpHv7MS2Nyz7lci+AavwoGzHiygcOCk?=
 =?us-ascii?Q?fsqF9lMBMZhrj2rmwhipIZZQLe1vhuSvuio4TWvjZaqYiNTpf5R4wFPm6lra?=
 =?us-ascii?Q?2mHPxACRUfTghnS6YKzJbnXcBLWGtKxRMWB1rAQe9evkxQGLL7wjGZvu8xiw?=
 =?us-ascii?Q?WQALCRd27jgFl85TL/qvMC9nJA8zOExKLDC59MaewarncfA2C0QkwB8Dm92M?=
 =?us-ascii?Q?c98goSHGO0MGYmp9jDgwjYURJSW/4KJjLSRFSCJK56ujziwKQhFrThuR5IV3?=
 =?us-ascii?Q?6+f/106Fgqw98qQMmTliuJ83S9BrJdIPlfYfgKMITw1Q/sqPRbkImrp/OH/0?=
 =?us-ascii?Q?YsTRKLpv8NOXe/0XMSvkJYbMFYt6CMzG/RFtr7fT4X68FlQU4qGj0VfapHgY?=
 =?us-ascii?Q?hsFuXsavf4xO9llu+SigyLU8VB95v6CYAssv3mtUrB4Kia7P9dQgGcDpfE1G?=
 =?us-ascii?Q?+nmSlQ0IrBu99HhtNjQ4DEQLFcBxi80IImx3F4E1vkUhNExf9oVX9+OWYl3x?=
 =?us-ascii?Q?s/gFruONiqYwyWf0ly8OrGGdDdERgBgODIPlqOGdQ3NF1t4+hOuayEtlhAUX?=
 =?us-ascii?Q?SUyXfEMZRNbLq3r/F8jr2EacfAq0k+z26cfrRLbMMjaxUrsNUa6EwDG0Xr7L?=
 =?us-ascii?Q?LgjiHLM2MzOmD89ESnzvIU63aKmHg0amieKRdi7BpcwuuWZltMCVh/JykB2N?=
 =?us-ascii?Q?6Q=3D=3D?=
X-OriginatorOrg: armchina.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dfa70e7-f1c6-4a0b-db75-08d9bfb6bbe9
X-MS-Exchange-CrossTenant-AuthSource: SH0PR01MB0634.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2021 10:36:20.8286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 58b271af-432f-4dad-9dee-571f404bc6a0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e0CAHek2iewuHd8Ffvraq4oEnRBKxpJnjgfpwUGxpw80sNy8/rWF1W0W/jdt+rKJFpGTQtgaa1VoahjcHYJP4pUlncrfprqaY2GuFCsP0Dc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SH0PR01MB0827
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zhouyi NPU driver provides sysfs interfaces for userspace to
check the status of NPU cores.

Signed-off-by: Dejia Shang <dejia.shang@armchina.com>
---
 .../ABI/testing/sysfs-devices-platform-armchina-npu | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-platform-armchi=
na-npu

diff --git a/Documentation/ABI/testing/sysfs-devices-platform-armchina-npu =
b/Documentation/ABI/testing/sysfs-devices-platform-armchina-npu
new file mode 100644
index 000000000000..185819e0010c
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-devices-platform-armchina-npu
@@ -0,0 +1,13 @@
+What:           /sys/devices/platform/aipu<n>/disable
+Date:           December 2021
+KernelVersion:  5.16
+Contact:        Dejia Shang <dejia.shang@armchina.com>
+Description:
+                (RW) Read/Set the enable/disable status of the current Zho=
uyi NPU core
+
+What:           /sys/devices/platform/aipu<n>/ext_registers
+Date:           December 2021
+KernelVersion:  5.16
+Contact:        Dejia Shang <dejia.shang@armchina.com>
+Description:
+                (RO) List of Zhouyi NPU external registers and current val=
ues inside
--
2.17.1

IMPORTANT NOTICE: The contents of this email and any attachments may be pri=
vileged and confidential. If you are not the intended recipient, please del=
ete the email immediately. It is strictly prohibited to disclose the conten=
ts to any other person, use it for any purpose, or store or copy the inform=
ation in any medium. Thank you. =C2=A9Arm Technology (China) Co., Ltd copyr=
ight and reserve all rights. =E9=87=8D=E8=A6=81=E6=8F=90=E7=A4=BA=EF=BC=9A=
=E6=9C=AC=E9=82=AE=E4=BB=B6=EF=BC=88=E5=8C=85=E6=8B=AC=E4=BB=BB=E4=BD=95=E9=
=99=84=E4=BB=B6=EF=BC=89=E5=8F=AF=E8=83=BD=E5=90=AB=E6=9C=89=E4=B8=93=E4=BE=
=9B=E6=98=8E=E7=A1=AE=E7=9A=84=E4=B8=AA=E4=BA=BA=E6=88=96=E7=9B=AE=E7=9A=84=
=E4=BD=BF=E7=94=A8=E7=9A=84=E6=9C=BA=E5=AF=86=E4=BF=A1=E6=81=AF=EF=BC=8C=E5=
=B9=B6=E5=8F=97=E6=B3=95=E5=BE=8B=E4=BF=9D=E6=8A=A4=E3=80=82=E5=A6=82=E6=9E=
=9C=E6=82=A8=E5=B9=B6=E9=9D=9E=E8=AF=A5=E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=8C=
=E8=AF=B7=E7=AB=8B=E5=8D=B3=E5=88=A0=E9=99=A4=E6=AD=A4=E9=82=AE=E4=BB=B6=E3=
=80=82=E4=B8=A5=E7=A6=81=E9=80=9A=E8=BF=87=E4=BB=BB=E4=BD=95=E6=B8=A0=E9=81=
=93=EF=BC=8C=E4=BB=A5=E4=BB=BB=E4=BD=95=E7=9B=AE=E7=9A=84=EF=BC=8C=E5=90=91=
=E4=BB=BB=E4=BD=95=E4=BA=BA=E6=8A=AB=E9=9C=B2=E3=80=81=E5=82=A8=E5=AD=98=E6=
=88=96=E5=A4=8D=E5=88=B6=E9=82=AE=E4=BB=B6=E4=BF=A1=E6=81=AF=E6=88=96=E8=80=
=85=E6=8D=AE=E6=AD=A4=E9=87=87=E5=8F=96=E4=BB=BB=E4=BD=95=E8=A1=8C=E5=8A=A8=
=E3=80=82=E6=84=9F=E8=B0=A2=E6=82=A8=E7=9A=84=E9=85=8D=E5=90=88=E3=80=82 =
=C2=A9=E5=AE=89=E8=B0=8B=E7=A7=91=E6=8A=80=EF=BC=88=E4=B8=AD=E5=9B=BD=EF=BC=
=89=E6=9C=89=E9=99=90=E5=85=AC=E5=8F=B8 =E7=89=88=E6=9D=83=E6=89=80=E6=9C=
=89=E5=B9=B6=E4=BF=9D=E7=95=99=E4=B8=80=E5=88=87=E6=9D=83=E5=88=A9=E3=80=82
