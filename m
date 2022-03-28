Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D578C4EA1CA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 22:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236931AbiC1Uqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 16:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345662AbiC1Un0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 16:43:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D6566AD3;
        Mon, 28 Mar 2022 13:41:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A690A614CE;
        Mon, 28 Mar 2022 20:41:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C961BC34116;
        Mon, 28 Mar 2022 20:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648500103;
        bh=mua64LMxEhrXEnEbRhoDJw4ZtjP9VPW/gcbp0QDHqxs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AgxR8xq9icu3S3gHL46voGOR1MtaoSaxR/XkMUj4cjbE25lKuAhB9IP7jObGbH4mG
         4yIC7i2uQv+2isMxNgftmi493961e7zdLEBmTy/zIWWBjel9R+2DxAwahSlsyH6PrZ
         SZe3MfQFmW6wzseLRD9FUsq5UoinO+0oV6q2byBdPuuwoCq6SkSYBWj+3bjWj1gMnH
         2dBAVZQDI3iEi4ciQ6CwnFyLFcpq0sEKQxGmYTTQP9mf5b7TNSQ92Mm9HaxXkPa47k
         mKgL/kX09q+kKfdJ5tgU9xTMrr5uNzAr7HT7wiNEb9RsYNtvaVKIHFb/iI80PgGodW
         sKLLL54vnspCQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nYwBH-000lbv-W9; Mon, 28 Mar 2022 22:41:40 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Anton Vasilyev <vasilyev@ispras.ru>,
        Dongliang Mu <mudongliangabcd@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Johan Hovold <johan@kernel.org>, Sean Young <sean@mess.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH 02/26] media: dvb-usb: move USB IDs to dvb-usb-ids.h
Date:   Mon, 28 Mar 2022 22:41:14 +0200
Message-Id: <7b32d5383169d23082758a7b69edef2f099202f3.1648499509.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1648499509.git.mchehab@kernel.org>
References: <cover.1648499509.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Almost all drivers based on dvb-usb place their USB IDs
at dvb-usb-ids.h. In order to make it more standard, place
the remaining ones also there.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 00/26] at: https://lore.kernel.org/all/cover.1648499509.git.mchehab@kernel.org/

 drivers/media/usb/dvb-usb/cinergyT2-core.c |  2 +-
 drivers/media/usb/dvb-usb/dtv5100.c        |  2 +-
 drivers/media/usb/dvb-usb/dw2102.c         | 38 +++++++++++-----------
 include/media/dvb-usb-ids.h                | 16 +++++++++
 4 files changed, 37 insertions(+), 21 deletions(-)

diff --git a/drivers/media/usb/dvb-usb/cinergyT2-core.c b/drivers/media/usb/dvb-usb/cinergyT2-core.c
index 23f1093d28f8..405b0c9a792c 100644
--- a/drivers/media/usb/dvb-usb/cinergyT2-core.c
+++ b/drivers/media/usb/dvb-usb/cinergyT2-core.c
@@ -194,7 +194,7 @@ static int cinergyt2_usb_probe(struct usb_interface *intf,
 }
 
 static struct usb_device_id cinergyt2_usb_table[] = {
-	{ USB_DEVICE(USB_VID_TERRATEC, 0x0038) },
+	{ USB_DEVICE(USB_VID_TERRATEC, USB_PID_TERRATEC_CINERGY_T2) },
 	{ 0 }
 };
 
diff --git a/drivers/media/usb/dvb-usb/dtv5100.c b/drivers/media/usb/dvb-usb/dtv5100.c
index 1c13e493322c..b644c1302c84 100644
--- a/drivers/media/usb/dvb-usb/dtv5100.c
+++ b/drivers/media/usb/dvb-usb/dtv5100.c
@@ -163,7 +163,7 @@ static int dtv5100_probe(struct usb_interface *intf,
 }
 
 static struct usb_device_id dtv5100_table[] = {
-	{ USB_DEVICE(0x06be, 0xa232) },
+	{ USB_DEVICE(USB_VID_AME, USB_PID_AME_DTV5100) },
 	{ }		/* Terminating entry */
 };
 MODULE_DEVICE_TABLE(usb, dtv5100_table);
diff --git a/drivers/media/usb/dvb-usb/dw2102.c b/drivers/media/usb/dvb-usb/dw2102.c
index ca75ebdc10b3..33643fb88265 100644
--- a/drivers/media/usb/dvb-usb/dw2102.c
+++ b/drivers/media/usb/dvb-usb/dw2102.c
@@ -1793,23 +1793,23 @@ enum dw2102_table_entry {
 
 static struct usb_device_id dw2102_table[] = {
 	[CYPRESS_DW2102] = {USB_DEVICE(USB_VID_CYPRESS, USB_PID_DW2102)},
-	[CYPRESS_DW2101] = {USB_DEVICE(USB_VID_CYPRESS, 0x2101)},
+	[CYPRESS_DW2101] = {USB_DEVICE(USB_VID_CYPRESS, USB_PID_DW2101)},
 	[CYPRESS_DW2104] = {USB_DEVICE(USB_VID_CYPRESS, USB_PID_DW2104)},
-	[TEVII_S650] = {USB_DEVICE(0x9022, USB_PID_TEVII_S650)},
+	[TEVII_S650] = {USB_DEVICE(USB_VID_TEVII, USB_PID_TEVII_S650)},
 	[TERRATEC_CINERGY_S] = {USB_DEVICE(USB_VID_TERRATEC, USB_PID_TERRATEC_CINERGY_S)},
 	[CYPRESS_DW3101] = {USB_DEVICE(USB_VID_CYPRESS, USB_PID_DW3101)},
-	[TEVII_S630] = {USB_DEVICE(0x9022, USB_PID_TEVII_S630)},
-	[PROF_1100] = {USB_DEVICE(0x3011, USB_PID_PROF_1100)},
-	[TEVII_S660] = {USB_DEVICE(0x9022, USB_PID_TEVII_S660)},
-	[PROF_7500] = {USB_DEVICE(0x3034, 0x7500)},
-	[GENIATECH_SU3000] = {USB_DEVICE(0x1f4d, 0x3000)},
-	[HAUPPAUGE_MAX_S2] = {USB_DEVICE(0x2040, 0xd900)},
+	[TEVII_S630] = {USB_DEVICE(USB_VID_TEVII, USB_PID_TEVII_S630)},
+	[PROF_1100] = {USB_DEVICE(USB_VID_PROF_1, USB_PID_PROF_1100)},
+	[TEVII_S660] = {USB_DEVICE(USB_VID_TEVII, USB_PID_TEVII_S660)},
+	[PROF_7500] = {USB_DEVICE(USB_VID_PROF_2, USB_PID_PROF_7500)},
+	[GENIATECH_SU3000] = {USB_DEVICE(USB_VID_GTEK, USB_PID_GENIATECH_SU3000)},
+	[HAUPPAUGE_MAX_S2] = {USB_DEVICE(USB_VID_HAUPPAUGE, USB_PID_HAUPPAUGE_MAX_S2)},
 	[TERRATEC_CINERGY_S2] = {USB_DEVICE(USB_VID_TERRATEC, USB_PID_TERRATEC_CINERGY_S2_R1)},
-	[TEVII_S480_1] = {USB_DEVICE(0x9022, USB_PID_TEVII_S480_1)},
-	[TEVII_S480_2] = {USB_DEVICE(0x9022, USB_PID_TEVII_S480_2)},
-	[X3M_SPC1400HD] = {USB_DEVICE(0x1f4d, 0x3100)},
-	[TEVII_S421] = {USB_DEVICE(0x9022, USB_PID_TEVII_S421)},
-	[TEVII_S632] = {USB_DEVICE(0x9022, USB_PID_TEVII_S632)},
+	[TEVII_S480_1] = {USB_DEVICE(USB_VID_TEVII, USB_PID_TEVII_S480_1)},
+	[TEVII_S480_2] = {USB_DEVICE(USB_VID_TEVII, USB_PID_TEVII_S480_2)},
+	[X3M_SPC1400HD] = {USB_DEVICE(USB_VID_GTEK, USB_PID_GENIATECH_X3M_SPC1400HD)},
+	[TEVII_S421] = {USB_DEVICE(USB_VID_TEVII, USB_PID_TEVII_S421)},
+	[TEVII_S632] = {USB_DEVICE(USB_VID_TEVII, USB_PID_TEVII_S632)},
 	[TERRATEC_CINERGY_S2_R2] = {USB_DEVICE(USB_VID_TERRATEC,
 				    USB_PID_TERRATEC_CINERGY_S2_R2)},
 	[TERRATEC_CINERGY_S2_R3] = {USB_DEVICE(USB_VID_TERRATEC,
@@ -1820,14 +1820,14 @@ static struct usb_device_id dw2102_table[] = {
 				   USB_PID_TERRATEC_CINERGY_S2_1)},
 	[TERRATEC_CINERGY_S2_2] = {USB_DEVICE(USB_VID_TERRATEC_2,
 				   USB_PID_TERRATEC_CINERGY_S2_2)},
-	[GOTVIEW_SAT_HD] = {USB_DEVICE(0x1FE1, USB_PID_GOTVIEW_SAT_HD)},
-	[GENIATECH_T220] = {USB_DEVICE(0x1f4d, 0xD220)},
+	[GOTVIEW_SAT_HD] = {USB_DEVICE(USB_VID_GOTVIEW, USB_PID_GOTVIEW_SAT_HD)},
+	[GENIATECH_T220] = {USB_DEVICE(USB_VID_GTEK, USB_PID_GENIATECH_T220)},
 	[TECHNOTREND_S2_4600] = {USB_DEVICE(USB_VID_TECHNOTREND,
 		USB_PID_TECHNOTREND_CONNECT_S2_4600)},
-	[TEVII_S482_1] = {USB_DEVICE(0x9022, 0xd483)},
-	[TEVII_S482_2] = {USB_DEVICE(0x9022, 0xd484)},
-	[TERRATEC_CINERGY_S2_BOX] = {USB_DEVICE(USB_VID_TERRATEC, 0x0105)},
-	[TEVII_S662] = {USB_DEVICE(0x9022, USB_PID_TEVII_S662)},
+	[TEVII_S482_1] = {USB_DEVICE(USB_VID_TEVII, USB_PID_TTEVII_S482_1)},
+	[TEVII_S482_2] = {USB_DEVICE(USB_VID_TEVII, USB_PID_TTEVII_S482_2)},
+	[TERRATEC_CINERGY_S2_BOX] = {USB_DEVICE(USB_VID_TERRATEC, USB_PID_TERRATEC_CINERGY_S2_BOX)},
+	[TEVII_S662] = {USB_DEVICE(USB_VID_TEVII, USB_PID_TEVII_S662)},
 	{ }
 };
 
diff --git a/include/media/dvb-usb-ids.h b/include/media/dvb-usb-ids.h
index dcf5772c84a0..9577cae8c73b 100644
--- a/include/media/dvb-usb-ids.h
+++ b/include/media/dvb-usb-ids.h
@@ -17,6 +17,7 @@
 #define USB_VID_AFATECH 			0x15a4
 #define USB_VID_ALCOR_MICRO			0x058f
 #define USB_VID_ALINK				0x05e3
+#define USB_VID_AME				0x06be
 #define USB_VID_AMT				0x1c73
 #define USB_VID_ANCHOR				0x0547
 #define USB_VID_ANSONIC 			0x10b9
@@ -38,6 +39,7 @@
 #define USB_VID_EVOLUTEPC			0x1e59
 #define USB_VID_GENPIX				0x09c0
 #define USB_VID_GIGABYTE			0x1044
+#define USB_VID_GOTVIEW 			0x1fe1
 #define USB_VID_GRANDTEC			0x5032
 #define USB_VID_GTEK				0x1f4d
 #define USB_VID_HAMA				0x147f
@@ -61,6 +63,8 @@
 #define USB_VID_PCTV				0x2013
 #define USB_VID_PINNACLE			0x2304
 #define USB_VID_PIXELVIEW			0x1554
+#define USB_VID_PROF_1				0x3011
+#define USB_VID_PROF_2				0x3034
 #define USB_VID_REALTEK 			0x0bda
 #define USB_VID_SONY				0x1415
 #define USB_VID_TECHNISAT			0x14f7
@@ -68,6 +72,7 @@
 #define USB_VID_TELESTAR			0x10b9
 #define USB_VID_TERRATEC			0x0ccd
 #define USB_VID_TERRATEC_2			0x153b
+#define USB_VID_TEVII				0x9022
 #define USB_VID_TWINHAN 			0x1822
 #define USB_VID_ULTIMA_ELECTRONIC		0x05d8
 #define USB_VID_UNIWILL 			0x1584
@@ -90,6 +95,7 @@
 #define USB_PID_AFATECH_AF9035_1003			0x1003
 #define USB_PID_AFATECH_AF9035_9035			0x9035
 #define USB_PID_ALINK_DTU				0xf170
+#define USB_PID_AME_DTV5100				0xa232
 #define USB_PID_ANSONIC_DVBT_USB			0x6000
 #define USB_PID_ANYSEE					0x861f
 #define USB_PID_ARTEC_T14BR				0x810f
@@ -198,6 +204,7 @@
 #define USB_PID_DVICO_BLUEBIRD_LGZ201_WARM		0xdb01
 #define USB_PID_DVICO_BLUEBIRD_TH7579_COLD		0xdb10
 #define USB_PID_DVICO_BLUEBIRD_TH7579_WARM		0xdb11
+#define USB_PID_DW2101					0x2101
 #define USB_PID_DW2102					0x2102
 #define USB_PID_DW2104					0x2104
 #define USB_PID_DW3101					0x3101
@@ -217,6 +224,9 @@
 #define USB_PID_FREECOM_DVBT				0x0160
 #define USB_PID_FREECOM_DVBT_2				0x0161
 #define USB_PID_FRIIO_WHITE				0x0001
+#define USB_PID_GENIATECH_SU3000			0x3000
+#define USB_PID_GENIATECH_T220				0xd220
+#define USB_PID_GENIATECH_X3M_SPC1400HD 		0x3100
 #define USB_PID_GENIUS_TVGO_DVB_T03			0x4012
 #define USB_PID_GENPIX_8PSK_REV_1_COLD			0x0200
 #define USB_PID_GENPIX_8PSK_REV_1_WARM			0x0201
@@ -234,6 +244,7 @@
 #define USB_PID_HAMA_DVBT_HYBRID			0x2758
 #define USB_PID_HANFTEK_UMT_010_COLD			0x0001
 #define USB_PID_HANFTEK_UMT_010_WARM			0x0015
+#define USB_PID_HAUPPAUGE_MAX_S2			0xd900
 #define USB_PID_HAUPPAUGE_MYTV_T			0x7080
 #define USB_PID_HAUPPAUGE_NOVA_TD_STICK 		0x9580
 #define USB_PID_HAUPPAUGE_NOVA_TD_STICK_52009		0x5200
@@ -314,6 +325,7 @@
 #define USB_PID_PINNACLE_PCTV_DVB_T_FLASH		0x0228
 #define USB_PID_PIXELVIEW_SBTVD 			0x5010
 #define USB_PID_PROF_1100				0xb012
+#define USB_PID_PROF_7500				0x7500
 #define USB_PID_PROLECTRIX_DV107669			0xd803
 #define USB_PID_REALTEK_RTL2831U			0x2831
 #define USB_PID_REALTEK_RTL2832U			0x2832
@@ -348,10 +360,12 @@
 #define USB_PID_TERRATEC_CINERGY_S			0x0064
 #define USB_PID_TERRATEC_CINERGY_S2_1			0x1181
 #define USB_PID_TERRATEC_CINERGY_S2_2			0x1182
+#define USB_PID_TERRATEC_CINERGY_S2_BOX 		0x0105
 #define USB_PID_TERRATEC_CINERGY_S2_R1			0x00a8
 #define USB_PID_TERRATEC_CINERGY_S2_R2			0x00b0
 #define USB_PID_TERRATEC_CINERGY_S2_R3			0x0102
 #define USB_PID_TERRATEC_CINERGY_S2_R4			0x0105
+#define USB_PID_TERRATEC_CINERGY_T2			0x0038
 #define USB_PID_TERRATEC_CINERGY_TC2_STICK		0x10b2
 #define USB_PID_TERRATEC_CINERGY_T_EXPRESS		0x0062
 #define USB_PID_TERRATEC_CINERGY_T_STICK		0x0093
@@ -383,6 +397,8 @@
 #define USB_PID_TINYTWIN_3				0x9016
 #define USB_PID_TREKSTOR_DVBT				0x901b
 #define USB_PID_TREKSTOR_TERRES_2_0			0xC803
+#define USB_PID_TTEVII_S482_1				0xd483
+#define USB_PID_TTEVII_S482_2				0xd484
 #define USB_PID_TURBOX_DTT_2000 			0xd3a4
 #define USB_PID_TVWAY_PLUS				0x0002
 #define USB_PID_TWINHAN_VP7020_COLD			0x3203
-- 
2.35.1

