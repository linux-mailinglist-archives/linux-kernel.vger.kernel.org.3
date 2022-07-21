Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8A857C4E1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 09:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbiGUHDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 03:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiGUHDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 03:03:16 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2095.outbound.protection.outlook.com [40.107.215.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22FB07AC08;
        Thu, 21 Jul 2022 00:03:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KQ5MI9zoYFRWBusbzajgcOOpWjTY3nt77iGiKFwOjjgvjF4hjXzGI3TsY+8w4Kvm234Y4eRlHwqOVVMvfijD2GBRAAh0yaqJEwezzyNXmxZ/F/grZq9f8aH3q9mK7sSMSApuWAseUnPIo3t1d/M43lA4E2txSNh+gzP07UhAtV7u2bwLruDj7LWIOgsO6N4mhI+m7Ewhvt26/Ybu+ugjWDy9oVSfHhWO6y4xCsvA8zpoKqoI7nqWBc35U5M9XFt9o6c/Mwm5WxgY79BOFaMVAoowb/tgkwrFNgh0iDGYN7wr7qJsFDOE3KS1J308J2pV7oFUHUGkrjlYBWC9T/78qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e4BaaSv4HYc1IirKAC/Szctsqqx1UdcOB+f1fn9+lh4=;
 b=BkSutsiuGgh7dx7vJDJQui2AordVpQ0YsZLqBznTyY+a/2JTJ//ti3dquRyLF0o1WSJeUIyaF85H9aVoB8jYbYe01MJK3UmEc43KBHQd8PZ19WIshIcB5M8/r2+meC9KZPPr3Q4DxPEyPkZDyWjuTPaw+gtOxJLl8HUO5fByoN7UT1jpgOUCxpLqFAsl6dxUq3grjI0R5TNlRlWphhqvbNamAEIPF98nbCDnHCeovXiTwzcyzuwplQpuVNav6bC5sepdl9nok0u35HY9d9WzpVB2gDYQcUd74+mspB/LZc0k953s9zmo4RhUpRco9HhorNii67YPcEBWbzpWevpZkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ftdichip.com; dmarc=pass action=none header.from=ftdichip.com;
 dkim=pass header.d=ftdichip.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ftdichip.com;
Received: from SG2PR01MB2886.apcprd01.prod.exchangelabs.com (20.177.168.18) by
 SG2PR01MB1966.apcprd01.prod.exchangelabs.com (10.170.141.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.25; Thu, 21 Jul 2022 07:03:08 +0000
Received: from SG2PR01MB2886.apcprd01.prod.exchangelabs.com
 ([fe80::d8f1:a698:2729:7cb7]) by SG2PR01MB2886.apcprd01.prod.exchangelabs.com
 ([fe80::d8f1:a698:2729:7cb7%6]) with mapi id 15.20.5458.019; Thu, 21 Jul 2022
 07:03:07 +0000
From:   Amireddy mallikarjuna reddy <mallikarjuna.reddy@ftdichip.com>
To:     linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, johan@kernel.org,
        gregkh@linuxfoundation.org, Mallikarjuna.reddy@ftdichip.com,
        malliamireddy009@gmail.com, arun.pappan@ftdichip.com,
        sowjanya.reddy@ftdichip.com,
        Amireddy mallikarjuna reddy <mallikarjuna.reddy@ftdichip.com>
Subject: [PATCH v1] USB: serial: ftdi_sio: add IDs for NEW FTDI Products
Date:   Thu, 21 Jul 2022 15:02:44 +0800
Message-Id: <ac28f2c5eba23a645b3b9299c224f2755a233eef.1658385786.git.mallikarjuna.reddy@ftdichip.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: LO2P265CA0332.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a4::32) To SG2PR01MB2886.apcprd01.prod.exchangelabs.com
 (2603:1096:4:30::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ab61b57-6bde-4b3b-58a0-08da6ae7109f
X-MS-TrafficTypeDiagnostic: SG2PR01MB1966:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7jNfbfpbseAt/YIj+ipHAde+xMlkp1ar2gLw3tznhhY64HEhnjiOR3I+kLU2LuVGihITlPE9D9Is6umDsYChVl+QmNjayD47WoLj2NMIMRZrmlUBTOFXF3gcKtQE6iXQL1tqZLotHc6bV2JslhMUo38ObA2fGTEhD3p8LL4HFo+E8S777Vl+SWq7GwJyAo2wdrWzTWqCdv+RlQL/MaiUttwmNI7XD/htg66kUw48C26k3i8HDOabnk24X4OBDFO09G2vW8O0qyxcdxDYe6dhu9e7yBPbAWOan2MlT1ZL1hCLiuqtJ6Mpw/pdChfMhdbl/OFsI+2JrbQ7+ocT6KU9kt0YFlM2blNft+j71bPIutni3phChq/zwu+vWFo8PxMVGWdfkKv+ufpIWWHq+VidSrFyub2WFDhNsYkDwh8rHzihzkJa9H5jY9rYLAR+1EQF8I7AMgkP59dknPcsa0N+7cub2OkuBuNns7pSDF226EMjygQ2b4DsAg3/gIR+cO5zxROUhvhDP1Bo1sY4MV9xD/RwAdIGTTndqVTY1Eu4burUgUjbxACNSnLP4Hxt4hxB5NV99A+9rB0orcdGaawCszqDZn7LZYTctvCsdkTsdvcdMDstDsltGceA9KPfSsfBQAuLcxTj5EpbA9gvjf79As0G09JTMS4+O8NFnzh0bwRQSWJa9ZeNKg0w4w+1oqE3KpkXyz2UjUFopl0dng+AIMASuPystPwz9Gk1oksYWrOtZmPhlB3vC8nCB+2+FnE12Jx94wiL2EHHGspj2Z8WNvzuzpYYjyB2MzMYPpKKYnGgrdMlM1oACXWbxrOFsytHyF5vmMiItrlMbQhY+Q9DLw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR01MB2886.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(39850400004)(136003)(346002)(376002)(8936002)(478600001)(5660300002)(83380400001)(52116002)(107886003)(2616005)(86362001)(6512007)(6506007)(26005)(6486002)(8676002)(6666004)(186003)(2906002)(66476007)(41300700001)(36756003)(38350700002)(4326008)(66556008)(66946007)(6916009)(316002)(38100700002)(231253002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NC1t6yL9wssLyTNaQCM0EBubpjt7EEOOclTnki5IrMk9/3sWWFRFn7KELo0p?=
 =?us-ascii?Q?/eoACMi3AlMZrTBkziPXshbUaTTphN+O70bBRLoJfGcTQH3R1U0r6EsOhG9Z?=
 =?us-ascii?Q?mxZ1ZKynOkwtBCkTKFiW08kqGiPSAT7LuB4w/tz1PbL85Oo2Y+YDxuP83Ge1?=
 =?us-ascii?Q?aZOfFGRkrJf05I0+3OTNrtlVCNToMmwSn9yK6T5TwZ/lU1zZfcQD9IDtKmIJ?=
 =?us-ascii?Q?Bqt7cHGOIFycai0dlMt2MivE0+JzOms5dnuiTGxqNA0A3Plh1yYuAvZUyYhT?=
 =?us-ascii?Q?HlEUnNK6aeFaE5J2CRVYsZPDA3L8NI+xuBnj5sP9ffp5KqvFtCA1cOdIwFtO?=
 =?us-ascii?Q?4Fzm0iolGr8CFnYqYPxtEin2D/FEwFOhgXTtrDq+/imfX850pFj9znSb7Uhv?=
 =?us-ascii?Q?scN4R1MQ/nyCyU8oMQeAZem7GLpdc3c/2Sfji2Doi2kvyB+YRFZQ/9M+ec/z?=
 =?us-ascii?Q?2NuiBUDQuI35e9O1ZZ30xgI0ZN1i+tfXs39NsP1uImIZVur21O4Q3olRY+Ej?=
 =?us-ascii?Q?2QLvjPpDL/z79AxIUMQ+A5tS25RdyIHqUdu1Bhqn6H01KFqSlXVnq1Omy14p?=
 =?us-ascii?Q?AFIa7ho6xpYiOb/HuabLHxJOdjsarRC/f1G6Vn0DWXBFDs8WDQsyU0jHgXDr?=
 =?us-ascii?Q?Fev4SA2h5C0hGUwJBQVnoSGPvhZ9jz+0z7lVbOpSuSoRcT8/gCeHb2413baJ?=
 =?us-ascii?Q?aZi7lnH6SoBvtEBI71Jc4OrBc6IzHovamdAIiAxbfwSqeOIxxZ9EUEzsNTUG?=
 =?us-ascii?Q?yTFraE9x1wkZIn80FaWUCg0H6czYUsYgo4xdvVREYLqvAXNNbqH3EUt6pDq1?=
 =?us-ascii?Q?bz2Jbmj0ylczaVfecrX6m5zWWEBfKSYYJDedtrWlpj9UNViKAKbIp4TB1UZl?=
 =?us-ascii?Q?ZOlSRdoGr/E51hqhFqUW0p1JiP6kLTwYNMPwu1PPlRZkn8aqiS4Qh7ksRRqy?=
 =?us-ascii?Q?b+YBqZ4P7q3lyYiLHTlRd8pDgZxgtuNBkTwECXKxnee96F6hPnrCEWjt2aUR?=
 =?us-ascii?Q?lm2/YBRTtwKpklX/dFwMJhUZCr5hCmkBldrrV8PcaQY6VePAbz4Go6m0t3R8?=
 =?us-ascii?Q?3tjn5XTkwX22iEzkNXWTpJ8BKoIs9I+MXgYjiaKGWtcPKZLOPgTXC/IcTjgk?=
 =?us-ascii?Q?7O8H5+EXRM9TMWcrADu0gT2NGQ2ff1NYv6mSRq80+VZ3c/pKEJv5aW8tq4WT?=
 =?us-ascii?Q?3ys6GLaaKcRbQU6f6mipMH2yKgq/Ls/guhZHAZPbt1Us47EuzZOI6q48+g0q?=
 =?us-ascii?Q?GBwtkgYf6R7l37797zBe031w5km3Xb3DhM3zvs9wfzib8Tr8Pj7pFRNJMIzg?=
 =?us-ascii?Q?eiyTqVgs5eFMMmlz5Xu7wDz+yBcTQdZlqm6Fc/s/fuMbA2RncDLQBBz3evfJ?=
 =?us-ascii?Q?GXqRdIOm7ObnPi3urg3P9i68Ib10I3w530KerwSLHRctnjuYYR/vwLMqRTk5?=
 =?us-ascii?Q?NgHp52F8qlGcHU9e2fDOvKbyGRZQ6+Y37R4nl8VGbKyryww2Fz+7nNC5/+EQ?=
 =?us-ascii?Q?hzVhJC9CYzoA+imCgedQ0upMmX/t1dFd9HiNb9OtwUjgq3oawdweWEn7t4Gs?=
 =?us-ascii?Q?UZKaat/RwCv0zkB3fNK5znGUeM84bjqUbkj0QqvJ6yMKtq65YmAaCGs0Z1f9?=
 =?us-ascii?Q?MGZDObtG+R2glOM6WttttAw=3D?=
X-OriginatorOrg: ftdichip.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ab61b57-6bde-4b3b-58a0-08da6ae7109f
X-MS-Exchange-CrossTenant-AuthSource: SG2PR01MB2886.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 07:03:07.8651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c2456335-1328-47c5-82f2-1fe6783d7182
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QHzwfTmeDSGe8geSLkg/bWYqv0WtF4R6E33LMkQAqwzEj4siRBQGtYr+4tiP510MNtlTHF1zXTByGLmwgpnDdRO78gGPJAmYuvC42FRqJ4M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR01MB1966
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the product IDs for the USB-to-Serial devices FT2233HP, FT2233HP,
FT4233HP, FT4232HP, FT233HP, FT232HP, and FT4232HAQ.
Also include BCD values so that the chiptype can be determined.

Signed-off-by: Amireddy mallikarjuna reddy <mallikarjuna.reddy@ftdichip.com>
---
v1:
- Initial version.
---
 drivers/usb/serial/ftdi_sio.c     | 74 +++++++++++++++++++++++++++++--
 drivers/usb/serial/ftdi_sio.h     |  9 +++-
 drivers/usb/serial/ftdi_sio_ids.h |  7 +++
 3 files changed, 86 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index b440d338a895..01417f20a106 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -178,6 +178,13 @@ static const struct usb_device_id id_table_combined[] = {
 	{ USB_DEVICE(FTDI_VID, FTDI_8U2232C_PID) ,
 		.driver_info = (kernel_ulong_t)&ftdi_8u2232c_quirk },
 	{ USB_DEVICE(FTDI_VID, FTDI_4232H_PID) },
+	{ USB_DEVICE(FTDI_VID, FTDI_FT2233HP_PID) },
+	{ USB_DEVICE(FTDI_VID, FTDI_FT4233HP_PID) },
+	{ USB_DEVICE(FTDI_VID, FTDI_FT2232HP_PID) },
+	{ USB_DEVICE(FTDI_VID, FTDI_FT4232HP_PID) },
+	{ USB_DEVICE(FTDI_VID, FTDI_FT233HP_PID) },
+	{ USB_DEVICE(FTDI_VID, FTDI_FT232HP_PID) },
+	{ USB_DEVICE(FTDI_VID, FTDI_4232HAQ_PID) },
 	{ USB_DEVICE(FTDI_VID, FTDI_232H_PID) },
 	{ USB_DEVICE(FTDI_VID, FTDI_FTX_PID) },
 	{ USB_DEVICE(FTDI_VID, FTDI_MICRO_CHAMELEON_PID) },
@@ -1064,6 +1071,13 @@ static const char *ftdi_chip_name[] = {
 	[FT2232H] = "FT2232H",
 	[FT4232H] = "FT4232H",
 	[FT232H]  = "FT232H",
+	[FT4232HAQ] = "FT4232HAQ",
+	[FT2233HP] = "FT2233HP",
+	[FT4233HP] = "FT4233HP",
+	[FT2232HP] = "FT2232HP",
+	[FT4232HP] = "FT4232HP",
+	[FT233HP] = "FT233HP",
+	[FT232HP] = "FT232HP",
 	[FTX]     = "FT-X"
 };
 
@@ -1357,6 +1371,13 @@ static u32 get_ftdi_divisor(struct tty_struct *tty,
 		}
 		break;
 	case FT2232H: /* FT2232H chip */
+	case FT232HP:  /* FT232HP chip */
+	case FT2232HP: /* FT2232HP chip */
+	case FT4232HP: /* FT4232HP chip */
+	case FT233HP:  /* FT233HP chip */
+	case FT2233HP: /* FT2233HP chip */
+	case FT4233HP: /* FT4233HP chip */
+	case FT4232HAQ: /* FT4232HAQ chip */
 	case FT4232H: /* FT4232H chip */
 	case FT232H:  /* FT232H chip */
 		if ((baud <= 12000000) && (baud >= 1200)) {
@@ -1395,7 +1416,10 @@ static int change_speed(struct tty_struct *tty, struct usb_serial_port *port)
 	index = (u16)(index_value >> 16);
 	if (priv->chip_type == FT2232C || priv->chip_type == FT2232H ||
 			priv->chip_type == FT4232H || priv->chip_type == FT232H ||
-			priv->chip_type == FTX) {
+			priv->chip_type == FT232HP || priv->chip_type == FT2232HP ||
+			priv->chip_type == FT4232HP || priv->chip_type == FT233HP ||
+			priv->chip_type == FT2233HP || priv->chip_type == FT4233HP ||
+			priv->chip_type == FT4232HAQ || priv->chip_type == FTX) {
 		/* Probably the BM type needs the MSB of the encoded fractional
 		 * divider also moved like for the chips above. Any infos? */
 		index = (u16)((index << 8) | priv->interface);
@@ -1555,7 +1579,25 @@ static void ftdi_determine_type(struct usb_serial_port *port)
 		int ifnum = intf->cur_altsetting->desc.bInterfaceNumber;
 
 		/* Multiple interfaces.*/
-		if (version == 0x0800) {
+		if (version == 0x3600) {
+			priv->chip_type = FT4232HAQ;
+		} else if (version == 0x3100) {
+			priv->chip_type = FT4232HP;
+			/* Hi-speed - baud clock runs at 120MHz */
+			priv->baud_base = 120000000 / 2;
+		} else if (version == 0x3000) {
+			priv->chip_type = FT2232HP;
+			/* Hi-speed - baud clock runs at 120MHz */
+			priv->baud_base = 120000000 / 2;
+		} else if (version == 0x2900) {
+			priv->chip_type = FT4233HP;
+			/* Hi-speed - baud clock runs at 120MHz */
+			priv->baud_base = 120000000 / 2;
+		} else if (version == 0x2800) {
+			priv->chip_type = FT2233HP;
+			/* Hi-speed - baud clock runs at 120MHz */
+			priv->baud_base = 120000000 / 2;
+		} else if (version == 0x0800) {
 			priv->chip_type = FT4232H;
 			/* Hi-speed - baud clock runs at 120MHz */
 			priv->baud_base = 120000000 / 2;
@@ -1611,6 +1653,12 @@ static void ftdi_determine_type(struct usb_serial_port *port)
 	} else if (version < 0x1000) {
 		/* Assume it's an FT232H */
 		priv->chip_type = FT232H;
+	} else if (version == 0x3200) {
+		/* Assume it's an FT233HP */
+		priv->chip_type = FT233HP;
+	} else if (version == 0x3300) {
+		/* Assume it's an FT232HP */
+		priv->chip_type = FT232HP;
 	} else {
 		/* Assume it's an FT-X series device */
 		priv->chip_type = FTX;
@@ -1743,6 +1791,13 @@ static int create_sysfs_attrs(struct usb_serial_port *port)
 		     priv->chip_type == FT2232H ||
 		     priv->chip_type == FT4232H ||
 		     priv->chip_type == FT232H ||
+		     priv->chip_type == FT232HP ||
+		     priv->chip_type == FT2232HP ||
+		     priv->chip_type == FT4232HP ||
+		     priv->chip_type == FT4232HAQ ||
+		     priv->chip_type == FT233HP ||
+		     priv->chip_type == FT2233HP ||
+		     priv->chip_type == FT4233HP ||
 		     priv->chip_type == FTX)) {
 			retval = device_create_file(&port->dev,
 						    &dev_attr_latency_timer);
@@ -1764,11 +1819,17 @@ static void remove_sysfs_attrs(struct usb_serial_port *port)
 		    priv->chip_type == FT2232H ||
 		    priv->chip_type == FT4232H ||
 		    priv->chip_type == FT232H ||
+		    priv->chip_type == FT232HP ||
+		    priv->chip_type == FT2232HP ||
+		    priv->chip_type == FT4232HP ||
+		    priv->chip_type == FT4232HAQ ||
+		    priv->chip_type == FT233HP ||
+		    priv->chip_type == FT2233HP ||
+		    priv->chip_type == FT4233HP ||
 		    priv->chip_type == FTX) {
 			device_remove_file(&port->dev, &dev_attr_latency_timer);
 		}
 	}
-
 }
 
 #ifdef CONFIG_GPIOLIB
@@ -2830,6 +2891,13 @@ static int ftdi_get_modem_status(struct usb_serial_port *port,
 	case FT2232H:
 	case FT4232H:
 	case FT232H:
+	case FT232HP:  /* FT232HP chip */
+	case FT2232HP: /* FT2232HP chip */
+	case FT4232HP: /* FT4232HP chip */
+	case FT233HP:  /* FT233HP chip */
+	case FT2233HP: /* FT2233HP chip */
+	case FT4233HP: /* FT4233HP chip */
+	case FT4232HAQ: /* FT4232HAQ chip */
 	case FTX:
 		len = 2;
 		break;
diff --git a/drivers/usb/serial/ftdi_sio.h b/drivers/usb/serial/ftdi_sio.h
index be1641e0408b..fdc108da030f 100644
--- a/drivers/usb/serial/ftdi_sio.h
+++ b/drivers/usb/serial/ftdi_sio.h
@@ -162,7 +162,14 @@ enum ftdi_chip_type {
 	FT2232H = 6,
 	FT4232H = 7,
 	FT232H  = 8,
-	FTX     = 9,
+	FT4232HAQ = 9,
+	FT2233HP = 10,
+	FT4233HP = 11,
+	FT2232HP = 12,
+	FT4232HP = 13,
+	FT233HP = 14,
+	FT232HP = 15,
+	FTX     = 16,
 };
 
 enum ftdi_sio_baudrate {
diff --git a/drivers/usb/serial/ftdi_sio_ids.h b/drivers/usb/serial/ftdi_sio_ids.h
index d1a9564697a4..f6547935f923 100644
--- a/drivers/usb/serial/ftdi_sio_ids.h
+++ b/drivers/usb/serial/ftdi_sio_ids.h
@@ -25,6 +25,13 @@
 #define FTDI_4232H_PID 0x6011 /* Quad channel hi-speed device */
 #define FTDI_232H_PID  0x6014 /* Single channel hi-speed device */
 #define FTDI_FTX_PID   0x6015 /* FT-X series (FT201X, FT230X, FT231X, etc) */
+#define FTDI_FT2233HP_PID 0x6040 /* Dual Channel Hi-Speed device with PD */
+#define FTDI_FT4233HP_PID 0x6041 /* Quad channel hi-speed device with PD */
+#define FTDI_FT2232HP_PID 0x6042 /* Dual Channel Hi-Speed device with PD */
+#define FTDI_FT4232HP_PID 0x6043 /* Quad channel hi-speed device with PD */
+#define FTDI_FT233HP_PID 0x6044 /* Dual Channel Hi-Speed device with PD */
+#define FTDI_FT232HP_PID 0x6045 /* Dual Channel Hi-Speed device with PD */
+#define FTDI_4232HAQ_PID 0x6048 /* Automotive grade Hi-Speed device */
 #define FTDI_SIO_PID	0x8372	/* Product Id SIO application of 8U100AX */
 #define FTDI_232RL_PID  0xFBFA  /* Product ID for FT232RL */
 
-- 
2.25.1

