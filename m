Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F25CC4E9EB6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 20:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245124AbiC1SKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 14:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245107AbiC1SKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 14:10:19 -0400
Received: from stuerz.xyz (unknown [45.77.206.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD0A2654;
        Mon, 28 Mar 2022 11:08:35 -0700 (PDT)
Received: by stuerz.xyz (Postfix, from userid 114)
        id E648FFA6F0; Mon, 28 Mar 2022 18:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=stuerz.xyz; s=mail;
        t=1648490914; bh=Mo89WsPmAmNkENS1V/5+L2XYSNZHz0ZlO7xnljOOGR8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=cW4vWq7WpVeGPTlw9gHjw9aSUlduH2QqBj+XQ10ckcOO+ragnCi+57aP2P+rJ6MlG
         192p/mlT420PXeRMdqcIraPSM1Qran92Wq7ufFMCkvIPj+j3IpmyzOmNZI9jf1bZV7
         SlfftaOXCI3q/MFMTI+q1OxJ0BYPIo/6byu9J9qjIcKXsw3RSqXRBmrUOVZD3s/ODA
         9YaPdIlMCVsrAOScLYh8pEvv784kwRVVdCGl/JaDsaJgfh68DLFmc4p8ZkGZqbIswS
         5D+NtnsSycy8rHVKLR7GrX4+pxV4f5mTTpPSuai4jikUcP32H51IXNWutbNgw03sTn
         Zz1jLYnqNgacQ==
Received: from [IPV6:2a02:8109:a100:1a48:ff0:ef2f:d4da:17d8] (unknown [IPv6:2a02:8109:a100:1a48:ff0:ef2f:d4da:17d8])
        by stuerz.xyz (Postfix) with ESMTPSA id 123F4FA6E1;
        Mon, 28 Mar 2022 18:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=stuerz.xyz; s=mail;
        t=1648490912; bh=Mo89WsPmAmNkENS1V/5+L2XYSNZHz0ZlO7xnljOOGR8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=gnK3Hfi6JYaEUKSesb2Qhkw4OwnDnKgxLCkMdXyADJSWK/rXLFmXnaM6dpg+3IomV
         ocG0LtCYLlKqXMl0oWgGongtdsZ/IH6xcCCBeba2mE/tb8cA+P9EWw4s7me3aOGgpg
         iPLPLjncUJIp90N1sdlmD/vPT+hUgdeTy69SqFt+/MnGLEqmp7C2LuJsgHaw0+JD03
         N/OQEEuyFcq+8DtWKA6aBoXFS5ItNArtMlVSq+D9/g38iHTsWQdkyGkycjH4YXOlMw
         GZcsxEUfxy99sLpJGsm8/ZKxZXU7TGT73oWGyNhPVKVyKjsgIC6UfE6Wsjdj0hDSfw
         yGD3L+HYv6nSg==
Message-ID: <66a2f60d-a23b-b62f-d91a-64538388ae65@stuerz.xyz>
Date:   Mon, 28 Mar 2022 20:08:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: [PATCH 16/22 v3] dvb-usb: Replace comments with C99 initializers
Content-Language: en-US
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
References: <20220326165909.506926-1-benni@stuerz.xyz>
 <20220326165909.506926-16-benni@stuerz.xyz>
 <20220326192454.14115baa@coco.lan> <20220326192720.0fddd6dd@coco.lan>
 <63a5e3143e904d1391490f27cc106be894b52ca2.camel@perches.com>
 <bc2d4f83-0674-ccae-71c8-14427de59f96@lwfinger.net>
 <20220326220832.12b4e91b@coco.lan>
From:   =?UTF-8?Q?Benjamin_St=c3=bcrz?= <benni@stuerz.xyz>
In-Reply-To: <20220326220832.12b4e91b@coco.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,RDNS_DYNAMIC,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75 autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace comments telling the index with explicit designators and make
the array entries more compact to aid in better readability.

It was suggested to make the arrays const, but that didn't compile.

Signed-off-by: Benjamin Stürz <benni@stuerz.xyz>
---
 drivers/media/usb/dvb-usb/dibusb-mb.c | 69 ++++++++++++++-------------
 drivers/media/usb/dvb-usb/dibusb-mc.c | 39 ++++++++-------
 2 files changed, 59 insertions(+), 49 deletions(-)

diff --git a/drivers/media/usb/dvb-usb/dibusb-mb.c
b/drivers/media/usb/dvb-usb/dibusb-mb.c
index e9dc27f73970..ec1fb30c5665 100644
--- a/drivers/media/usb/dvb-usb/dibusb-mb.c
+++ b/drivers/media/usb/dvb-usb/dibusb-mb.c
@@ -120,42 +120,45 @@ static int dibusb_probe(struct usb_interface *intf,
 	return -EINVAL;
 }

+#define DIB_DEVICE(vid, pid)	\
+	{ USB_DEVICE(USB_VID_##vid, USB_PID_##pid) }
+
 /* do not change the order of the ID table */
 static struct usb_device_id dibusb_dib3000mb_table [] = {
-/* 00 */	{ USB_DEVICE(USB_VID_WIDEVIEW,	
USB_PID_AVERMEDIA_DVBT_USB_COLD) },
-/* 01 */	{ USB_DEVICE(USB_VID_WIDEVIEW,	
USB_PID_AVERMEDIA_DVBT_USB_WARM) },
-/* 02 */	{ USB_DEVICE(USB_VID_COMPRO,		USB_PID_COMPRO_DVBU2000_COLD) },
-/* 03 */	{ USB_DEVICE(USB_VID_COMPRO,		USB_PID_COMPRO_DVBU2000_WARM) },
-/* 04 */	{ USB_DEVICE(USB_VID_COMPRO_UNK,
USB_PID_COMPRO_DVBU2000_UNK_COLD) },
-/* 05 */	{ USB_DEVICE(USB_VID_DIBCOM,		USB_PID_DIBCOM_MOD3000_COLD) },
-/* 06 */	{ USB_DEVICE(USB_VID_DIBCOM,		USB_PID_DIBCOM_MOD3000_WARM) },
-/* 07 */	{ USB_DEVICE(USB_VID_EMPIA,		USB_PID_KWORLD_VSTREAM_COLD) },
-/* 08 */	{ USB_DEVICE(USB_VID_EMPIA,		USB_PID_KWORLD_VSTREAM_WARM) },
-/* 09 */	{ USB_DEVICE(USB_VID_GRANDTEC,		USB_PID_GRANDTEC_DVBT_USB_COLD) },
-/* 10 */	{ USB_DEVICE(USB_VID_GRANDTEC,		USB_PID_GRANDTEC_DVBT_USB_WARM) },
-/* 11 */	{ USB_DEVICE(USB_VID_GRANDTEC,		USB_PID_DIBCOM_MOD3000_COLD) },
-/* 12 */	{ USB_DEVICE(USB_VID_GRANDTEC,		USB_PID_DIBCOM_MOD3000_WARM) },
-/* 13 */	{ USB_DEVICE(USB_VID_HYPER_PALTEK,
USB_PID_UNK_HYPER_PALTEK_COLD) },
-/* 14 */	{ USB_DEVICE(USB_VID_HYPER_PALTEK,
USB_PID_UNK_HYPER_PALTEK_WARM) },
-/* 15 */	{ USB_DEVICE(USB_VID_VISIONPLUS,	USB_PID_TWINHAN_VP7041_COLD) },
-/* 16 */	{ USB_DEVICE(USB_VID_VISIONPLUS,	USB_PID_TWINHAN_VP7041_WARM) },
-/* 17 */	{ USB_DEVICE(USB_VID_TWINHAN,		USB_PID_TWINHAN_VP7041_COLD) },
-/* 18 */	{ USB_DEVICE(USB_VID_TWINHAN,		USB_PID_TWINHAN_VP7041_WARM) },
-/* 19 */	{ USB_DEVICE(USB_VID_ULTIMA_ELECTRONIC,
USB_PID_ULTIMA_TVBOX_COLD) },
-/* 20 */	{ USB_DEVICE(USB_VID_ULTIMA_ELECTRONIC,
USB_PID_ULTIMA_TVBOX_WARM) },
-/* 21 */	{ USB_DEVICE(USB_VID_ULTIMA_ELECTRONIC,
USB_PID_ULTIMA_TVBOX_AN2235_COLD) },
-/* 22 */	{ USB_DEVICE(USB_VID_ULTIMA_ELECTRONIC,
USB_PID_ULTIMA_TVBOX_AN2235_WARM) },
-/* 23 */	{ USB_DEVICE(USB_VID_ADSTECH,		USB_PID_ADSTECH_USB2_COLD) },
+	[0]  = DIB_DEVICE(WIDEVIEW,		AVERMEDIA_DVBT_USB_COLD),
+	[1]  = DIB_DEVICE(WIDEVIEW,		AVERMEDIA_DVBT_USB_WARM),
+	[2]  = DIB_DEVICE(COMPRO,		COMPRO_DVBU2000_COLD),
+	[3]  = DIB_DEVICE(COMPRO,		COMPRO_DVBU2000_WARM),
+	[4]  = DIB_DEVICE(COMPRO_UNK,		COMPRO_DVBU2000_UNK_COLD),
+	[5]  = DIB_DEVICE(DIBCOM,		DIBCOM_MOD3000_COLD),
+	[6]  = DIB_DEVICE(DIBCOM,		DIBCOM_MOD3000_WARM),
+	[7]  = DIB_DEVICE(EMPIA,		KWORLD_VSTREAM_COLD),
+	[8]  = DIB_DEVICE(EMPIA,		KWORLD_VSTREAM_WARM),
+	[9]  = DIB_DEVICE(GRANDTEC,		GRANDTEC_DVBT_USB_COLD),
+	[10] = DIB_DEVICE(GRANDTEC,		GRANDTEC_DVBT_USB_WARM),
+	[11] = DIB_DEVICE(GRANDTEC,		DIBCOM_MOD3000_COLD),
+	[12] = DIB_DEVICE(GRANDTEC,		DIBCOM_MOD3000_WARM),
+	[13] = DIB_DEVICE(HYPER_PALTEK,		UNK_HYPER_PALTEK_COLD),
+	[14] = DIB_DEVICE(HYPER_PALTEK,		UNK_HYPER_PALTEK_WARM),
+	[15] = DIB_DEVICE(VISIONPLUS,		TWINHAN_VP7041_COLD),
+	[16] = DIB_DEVICE(VISIONPLUS,		TWINHAN_VP7041_WARM),
+	[17] = DIB_DEVICE(TWINHAN,		TWINHAN_VP7041_COLD),
+	[18] = DIB_DEVICE(TWINHAN,		TWINHAN_VP7041_WARM),
+	[19] = DIB_DEVICE(ULTIMA_ELECTRONIC,	ULTIMA_TVBOX_COLD),
+	[20] = DIB_DEVICE(ULTIMA_ELECTRONIC,	ULTIMA_TVBOX_WARM),
+	[21] = DIB_DEVICE(ULTIMA_ELECTRONIC,	ULTIMA_TVBOX_AN2235_COLD),
+	[22] = DIB_DEVICE(ULTIMA_ELECTRONIC,	ULTIMA_TVBOX_AN2235_WARM),
+	[23] = DIB_DEVICE(ADSTECH,		ADSTECH_USB2_COLD),

 /* device ID with default DIBUSB2_0-firmware and with the hacked
firmware */
-/* 24 */	{ USB_DEVICE(USB_VID_ADSTECH,		USB_PID_ADSTECH_USB2_WARM) },
-/* 25 */	{ USB_DEVICE(USB_VID_KYE,		USB_PID_KYE_DVB_T_COLD) },
-/* 26 */	{ USB_DEVICE(USB_VID_KYE,		USB_PID_KYE_DVB_T_WARM) },
+	[24] = DIB_DEVICE(ADSTECH,		ADSTECH_USB2_WARM),
+	[25] = DIB_DEVICE(KYE,			KYE_DVB_T_COLD),
+	[26] = DIB_DEVICE(KYE,			KYE_DVB_T_WARM),

-/* 27 */	{ USB_DEVICE(USB_VID_KWORLD,		USB_PID_KWORLD_VSTREAM_COLD) },
+	[27] = DIB_DEVICE(KWORLD,		KWORLD_VSTREAM_COLD),

-/* 28 */	{ USB_DEVICE(USB_VID_ULTIMA_ELECTRONIC,
USB_PID_ULTIMA_TVBOX_USB2_COLD) },
-/* 29 */	{ USB_DEVICE(USB_VID_ULTIMA_ELECTRONIC,
USB_PID_ULTIMA_TVBOX_USB2_WARM) },
+	[28] = DIB_DEVICE(ULTIMA_ELECTRONIC,	ULTIMA_TVBOX_USB2_COLD),
+	[29] = DIB_DEVICE(ULTIMA_ELECTRONIC,	ULTIMA_TVBOX_USB2_WARM),

 /*
  * XXX: As Artec just 'forgot' to program the EEPROM on some Artec T1
devices
@@ -166,13 +169,15 @@ static struct usb_device_id dibusb_dib3000mb_table
[] = {
  */

 #ifdef CONFIG_DVB_USB_DIBUSB_MB_FAULTY
-/* 30 */	{ USB_DEVICE(USB_VID_ANCHOR,		USB_PID_ULTIMA_TVBOX_ANCHOR_COLD) },
+	[30] = DIB_DEVICE(ANCHOR,		ULTIMA_TVBOX_ANCHOR_COLD),
 #endif

-			{ }		/* Terminating entry */
+	{ }		/* Terminating entry */
 };
 MODULE_DEVICE_TABLE (usb, dibusb_dib3000mb_table);

+#undef DIB_DEVICE
+
 static struct dvb_usb_device_properties dibusb1_1_properties = {
 	.caps =  DVB_USB_IS_AN_I2C_ADAPTER,

diff --git a/drivers/media/usb/dvb-usb/dibusb-mc.c
b/drivers/media/usb/dvb-usb/dibusb-mc.c
index e2689977c8c8..703c2a7df369 100644
--- a/drivers/media/usb/dvb-usb/dibusb-mc.c
+++ b/drivers/media/usb/dvb-usb/dibusb-mc.c
@@ -23,28 +23,33 @@ static int dibusb_mc_probe(struct usb_interface *intf,
 				   NULL, adapter_nr);
 }

+#define DIB_DEVICE(vid, pid)	\
+	{ USB_DEVICE(USB_VID_##vid, USB_PID_##pid) }
+
 /* do not change the order of the ID table */
 static struct usb_device_id dibusb_dib3000mc_table [] = {
-/* 00 */	{ USB_DEVICE(USB_VID_DIBCOM,		USB_PID_DIBCOM_MOD3001_COLD) },
-/* 01 */	{ USB_DEVICE(USB_VID_DIBCOM,		USB_PID_DIBCOM_MOD3001_WARM) },
-/* 02 */	{ USB_DEVICE(USB_VID_ULTIMA_ELECTRONIC,
USB_PID_ULTIMA_TVBOX_USB2_COLD) },
-/* 03 */	{ USB_DEVICE(USB_VID_ULTIMA_ELECTRONIC,
USB_PID_ULTIMA_TVBOX_USB2_WARM) }, // ( ? )
-/* 04 */	{ USB_DEVICE(USB_VID_LITEON,		USB_PID_LITEON_DVB_T_COLD) },
-/* 05 */	{ USB_DEVICE(USB_VID_LITEON,		USB_PID_LITEON_DVB_T_WARM) },
-/* 06 */	{ USB_DEVICE(USB_VID_EMPIA,		USB_PID_DIGIVOX_MINI_SL_COLD) },
-/* 07 */	{ USB_DEVICE(USB_VID_EMPIA,		USB_PID_DIGIVOX_MINI_SL_WARM) },
-/* 08 */	{ USB_DEVICE(USB_VID_GRANDTEC,
USB_PID_GRANDTEC_DVBT_USB2_COLD) },
-/* 09 */	{ USB_DEVICE(USB_VID_GRANDTEC,
USB_PID_GRANDTEC_DVBT_USB2_WARM) },
-/* 10 */	{ USB_DEVICE(USB_VID_ULTIMA_ELECTRONIC,	USB_PID_ARTEC_T14_COLD) },
-/* 11 */	{ USB_DEVICE(USB_VID_ULTIMA_ELECTRONIC,	USB_PID_ARTEC_T14_WARM) },
-/* 12 */	{ USB_DEVICE(USB_VID_LEADTEK,		USB_PID_WINFAST_DTV_DONGLE_COLD) },
-/* 13 */	{ USB_DEVICE(USB_VID_LEADTEK,		USB_PID_WINFAST_DTV_DONGLE_WARM) },
-/* 14 */	{ USB_DEVICE(USB_VID_HUMAX_COEX,
USB_PID_DVB_T_USB_STICK_HIGH_SPEED_COLD) },
-/* 15 */	{ USB_DEVICE(USB_VID_HUMAX_COEX,
USB_PID_DVB_T_USB_STICK_HIGH_SPEED_WARM) },
-			{ }		/* Terminating entry */
+	[0]  = DIB_DEVICE(DIBCOM,		DIBCOM_MOD3001_COLD),
+	[1]  = DIB_DEVICE(DIBCOM,		DIBCOM_MOD3001_WARM),
+	[2]  = DIB_DEVICE(ULTIMA_ELECTRONIC,	ULTIMA_TVBOX_USB2_COLD),
+	[3]  = DIB_DEVICE(ULTIMA_ELECTRONIC,	ULTIMA_TVBOX_USB2_WARM), // ( ? )
+	[4]  = DIB_DEVICE(LITEON,		LITEON_DVB_T_COLD),
+	[5]  = DIB_DEVICE(LITEON,		LITEON_DVB_T_WARM),
+	[6]  = DIB_DEVICE(EMPIA,		DIGIVOX_MINI_SL_COLD),
+	[7]  = DIB_DEVICE(EMPIA,		DIGIVOX_MINI_SL_WARM),
+	[8]  = DIB_DEVICE(GRANDTEC,		GRANDTEC_DVBT_USB2_COLD),
+	[9]  = DIB_DEVICE(GRANDTEC,		GRANDTEC_DVBT_USB2_WARM),
+	[10] = DIB_DEVICE(ULTIMA_ELECTRONIC,	ARTEC_T14_COLD),
+	[11] = DIB_DEVICE(ULTIMA_ELECTRONIC,	ARTEC_T14_WARM),
+	[12] = DIB_DEVICE(LEADTEK,		WINFAST_DTV_DONGLE_COLD),
+	[13] = DIB_DEVICE(LEADTEK,		WINFAST_DTV_DONGLE_WARM),
+	[14] = DIB_DEVICE(HUMAX_COEX,		DVB_T_USB_STICK_HIGH_SPEED_COLD),
+	[15] = DIB_DEVICE(HUMAX_COEX,		DVB_T_USB_STICK_HIGH_SPEED_WARM),
+	{ }					/* Terminating entry */
 };
 MODULE_DEVICE_TABLE (usb, dibusb_dib3000mc_table);

+#undef DIB_DEVICE
+
 static struct dvb_usb_device_properties dibusb_mc_properties = {
 	.caps = DVB_USB_IS_AN_I2C_ADAPTER,

-- 
2.35.1
