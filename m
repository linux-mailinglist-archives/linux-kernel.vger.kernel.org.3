Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 576A54E87E3
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 15:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235339AbiC0Nev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 09:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiC0Net (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 09:34:49 -0400
Received: from stuerz.xyz (unknown [45.77.206.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3EF235;
        Sun, 27 Mar 2022 06:33:09 -0700 (PDT)
Received: by stuerz.xyz (Postfix, from userid 114)
        id 43A35FBBC4; Sun, 27 Mar 2022 13:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=stuerz.xyz; s=mail;
        t=1648387988; bh=GZ4Tx4yH8N7XSi50tqppPJxzHbxJizBOLMLjcm52De4=;
        h=Date:Subject:To:References:Cc:From:In-Reply-To:From;
        b=FxDZ7rm4F1fdI4FeqWnTjIt3iD9KH0zzN2Ifymt+IKiV4gqbUSSFeupTOebfL2JJl
         56/48pd3DSebqEVY1dcuWyLfbsuNq2bHIX7GWPfSJqI+cRZvwtCE/A09XGscEmVGlQ
         3vgccoOGnMoYYGst2rt49raLEu8rkcOA8Y9gqvL8MToWs6VVmBbxhbievQSvR9hvAR
         xoScGPyM/RbSw6OQBnisiBb+c8mmOyUQtZQSe7ohUnISJWbgB2SxcDH9z6nYRrTqNM
         GMHI7AJt/lJuDiQuWAS53yXf4MjyaFfWTxsKs27LBmNjsLdZ+fdaUP9kHOEG9fGW93
         la2RgE91NX4MQ==
Received: from [IPV6:2a02:8109:a100:1a48:ff0:ef2f:d4da:17d8] (unknown [IPv6:2a02:8109:a100:1a48:ff0:ef2f:d4da:17d8])
        by stuerz.xyz (Postfix) with ESMTPSA id CE929FBBB5;
        Sun, 27 Mar 2022 13:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=stuerz.xyz; s=mail;
        t=1648387986; bh=GZ4Tx4yH8N7XSi50tqppPJxzHbxJizBOLMLjcm52De4=;
        h=Date:Subject:To:References:Cc:From:In-Reply-To:From;
        b=CQvZL5wCLS8L2iyQc1jInZVu9DVnGSuqhKiuUjvKrxN80IKKHLfcg/acNSL9oxoUE
         ZTyifKPNow678YldvvrgkYPuY89flt865sTDsO2ViagNiwDlc3ARcA6Q4JF0+ulvjd
         3YS8zqWj4+Okna/M2U4UJo6rIOkYL0DqJ7/PcfTBPH8kKgUlvmFv8iWbriUve98WA8
         lmGlVTCcwCUdzzlhSqx/ZEDwdbrMHQaDMbvDpZ4uYYt5o/aobjwK9NwHc6KohguVpi
         vnals2IPBfLq+R/InfjziyjbjLXRglJyldhntjXLumUJGo6ZEeox4rYIiCcXxIfCH9
         sNhFHTmYd2jSQ==
Message-ID: <511162f4-aa03-8526-3ea6-0f9d2edeae10@stuerz.xyz>
Date:   Sun, 27 Mar 2022 15:33:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: [PATCH 16/22 v2] dvb-usb: Replace comments with C99 initializers
Content-Language: en-US
To:     =?UTF-8?Q?Benjamin_St=c3=bcrz?= <benni@stuerz.xyz>
References: <20220326165909.506926-1-benni@stuerz.xyz>
 <20220326165909.506926-16-benni@stuerz.xyz>
Cc:     "linux-kernel@vger.kernel.org linux-media@vger.kernel.org mchehab"@kernel.org
From:   =?UTF-8?Q?Benjamin_St=c3=bcrz?= <benni@stuerz.xyz>
In-Reply-To: <20220326165909.506926-16-benni@stuerz.xyz>
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

Changes since v1:
 * Reformatted both tables
 * Respecting 80-column line limit

Signed-off-by: Benjamin Stürz <benni@stuerz.xyz>
---
 drivers/media/usb/dvb-usb/dibusb-mb.c | 148 ++++++++++++++++++--------
 drivers/media/usb/dvb-usb/dibusb-mc.c |  67 +++++++++---
 2 files changed, 154 insertions(+), 61 deletions(-)

diff --git a/drivers/media/usb/dvb-usb/dibusb-mb.c
b/drivers/media/usb/dvb-usb/dibusb-mb.c
index e9dc27f73970..ffc27318f823 100644
--- a/drivers/media/usb/dvb-usb/dibusb-mb.c
+++ b/drivers/media/usb/dvb-usb/dibusb-mb.c
@@ -122,54 +122,114 @@ static int dibusb_probe(struct usb_interface *intf,

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
-
-/* device ID with default DIBUSB2_0-firmware and with the hacked
firmware */
-/* 24 */	{ USB_DEVICE(USB_VID_ADSTECH,		USB_PID_ADSTECH_USB2_WARM) },
-/* 25 */	{ USB_DEVICE(USB_VID_KYE,		USB_PID_KYE_DVB_T_COLD) },
-/* 26 */	{ USB_DEVICE(USB_VID_KYE,		USB_PID_KYE_DVB_T_WARM) },
-
-/* 27 */	{ USB_DEVICE(USB_VID_KWORLD,		USB_PID_KWORLD_VSTREAM_COLD) },
-
-/* 28 */	{ USB_DEVICE(USB_VID_ULTIMA_ELECTRONIC,
USB_PID_ULTIMA_TVBOX_USB2_COLD) },
-/* 29 */	{ USB_DEVICE(USB_VID_ULTIMA_ELECTRONIC,
USB_PID_ULTIMA_TVBOX_USB2_WARM) },
-
-/*
- * XXX: As Artec just 'forgot' to program the EEPROM on some Artec T1
devices
- *      we don't catch these faulty IDs (namely 'Cypress FX1 USB
controller') that
- *      have been left on the device. If you don't have such a device
but an Artec
- *      device that's supposed to work with this driver but is not
detected by it,
- *      free to enable CONFIG_DVB_USB_DIBUSB_MB_FAULTY via your kernel
config.
- */
+	[0]  = { USB_DEVICE(USB_VID_WIDEVIEW,
+			    USB_PID_AVERMEDIA_DVBT_USB_COLD)
+	},
+	[1]  = { USB_DEVICE(USB_VID_WIDEVIEW,
+			    USB_PID_AVERMEDIA_DVBT_USB_WARM)
+	},
+	[2]  = { USB_DEVICE(USB_VID_COMPRO,
+			    USB_PID_COMPRO_DVBU2000_COLD)
+	},
+	[3]  = { USB_DEVICE(USB_VID_COMPRO,
+			    USB_PID_COMPRO_DVBU2000_WARM)
+	},
+	[4]  = { USB_DEVICE(USB_VID_COMPRO_UNK,
+			    USB_PID_COMPRO_DVBU2000_UNK_COLD)
+	},
+	[5]  = { USB_DEVICE(USB_VID_DIBCOM,
+			    USB_PID_DIBCOM_MOD3000_COLD)
+	},
+	[6]  = { USB_DEVICE(USB_VID_DIBCOM,
+			    USB_PID_DIBCOM_MOD3000_WARM)
+	},
+	[7]  = { USB_DEVICE(USB_VID_EMPIA,
+			    USB_PID_KWORLD_VSTREAM_COLD)
+	},
+	[8]  = { USB_DEVICE(USB_VID_EMPIA,
+			    USB_PID_KWORLD_VSTREAM_WARM)
+	},
+	[9]  = { USB_DEVICE(USB_VID_GRANDTEC,
+			    USB_PID_GRANDTEC_DVBT_USB_COLD)
+	},
+	[10] = { USB_DEVICE(USB_VID_GRANDTEC,
+			    USB_PID_GRANDTEC_DVBT_USB_WARM)
+	},
+	[11] = { USB_DEVICE(USB_VID_GRANDTEC,
+			    USB_PID_DIBCOM_MOD3000_COLD)
+	},
+	[12] = { USB_DEVICE(USB_VID_GRANDTEC,
+			    USB_PID_DIBCOM_MOD3000_WARM)
+	},
+	[13] = { USB_DEVICE(USB_VID_HYPER_PALTEK,
+			    USB_PID_UNK_HYPER_PALTEK_COLD)
+	},
+	[14] = { USB_DEVICE(USB_VID_HYPER_PALTEK,
+			    USB_PID_UNK_HYPER_PALTEK_WARM)
+	},
+	[15] = { USB_DEVICE(USB_VID_VISIONPLUS,
+			    USB_PID_TWINHAN_VP7041_COLD)
+	},
+	[16] = { USB_DEVICE(USB_VID_VISIONPLUS,
+			    USB_PID_TWINHAN_VP7041_WARM)
+	},
+	[17] = { USB_DEVICE(USB_VID_TWINHAN,
+			    USB_PID_TWINHAN_VP7041_COLD)
+	},
+	[18] = { USB_DEVICE(USB_VID_TWINHAN,
+			    USB_PID_TWINHAN_VP7041_WARM)
+	},
+	[19] = { USB_DEVICE(USB_VID_ULTIMA_ELECTRONIC,
+			    USB_PID_ULTIMA_TVBOX_COLD)
+	},
+	[20] = { USB_DEVICE(USB_VID_ULTIMA_ELECTRONIC,
+			    USB_PID_ULTIMA_TVBOX_WARM)
+	},
+	[21] = { USB_DEVICE(USB_VID_ULTIMA_ELECTRONIC,
+			    USB_PID_ULTIMA_TVBOX_AN2235_COLD)
+	},
+	[22] = { USB_DEVICE(USB_VID_ULTIMA_ELECTRONIC,
+			    USB_PID_ULTIMA_TVBOX_AN2235_WARM)
+	},
+	[23] = { USB_DEVICE(USB_VID_ADSTECH,
+			    USB_PID_ADSTECH_USB2_COLD)
+	},
+
+	/* device ID with default DIBUSB2_0-firmware and with the hacked
firmware */
+	[24] = { USB_DEVICE(USB_VID_ADSTECH,
+			    USB_PID_ADSTECH_USB2_WARM)
+	},
+	[25] = { USB_DEVICE(USB_VID_KYE,
+			    USB_PID_KYE_DVB_T_COLD)
+	},
+	[26] = { USB_DEVICE(USB_VID_KYE,
+			    USB_PID_KYE_DVB_T_WARM)
+	},
+	[27] = { USB_DEVICE(USB_VID_KWORLD,
+			    USB_PID_KWORLD_VSTREAM_COLD)
+	},
+	[28] = { USB_DEVICE(USB_VID_ULTIMA_ELECTRONIC,
+			    USB_PID_ULTIMA_TVBOX_USB2_COLD)
+	},
+	[29] = { USB_DEVICE(USB_VID_ULTIMA_ELECTRONIC,
+			    USB_PID_ULTIMA_TVBOX_USB2_WARM)
+	},
+
+	/*
+	 * XXX: As Artec just 'forgot' to program the EEPROM on some Artec T1
devices
+	 *      we don't catch these faulty IDs (namely 'Cypress FX1 USB
controller') that
+	 *      have been left on the device. If you don't have such a device
but an Artec
+	 *      device that's supposed to work with this driver but is not
detected by it,
+	 *      free to enable CONFIG_DVB_USB_DIBUSB_MB_FAULTY via your kernel
config.
+	 */

 #ifdef CONFIG_DVB_USB_DIBUSB_MB_FAULTY
-/* 30 */	{ USB_DEVICE(USB_VID_ANCHOR,		USB_PID_ULTIMA_TVBOX_ANCHOR_COLD) },
+	[30] = { USB_DEVICE(USB_VID_ANCHOR,
+			    USB_PID_ULTIMA_TVBOX_ANCHOR_COLD)
+	},
 #endif

-			{ }		/* Terminating entry */
+	{ }		/* Terminating entry */
 };
 MODULE_DEVICE_TABLE (usb, dibusb_dib3000mb_table);

diff --git a/drivers/media/usb/dvb-usb/dibusb-mc.c
b/drivers/media/usb/dvb-usb/dibusb-mc.c
index e2689977c8c8..57805013f3ac 100644
--- a/drivers/media/usb/dvb-usb/dibusb-mc.c
+++ b/drivers/media/usb/dvb-usb/dibusb-mc.c
@@ -25,23 +25,56 @@ static int dibusb_mc_probe(struct usb_interface *intf,

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
+	[0]  = { USB_DEVICE(USB_VID_DIBCOM,
+			    USB_PID_DIBCOM_MOD3001_COLD)
+	},
+	[1]  = { USB_DEVICE(USB_VID_DIBCOM,
+			    USB_PID_DIBCOM_MOD3001_WARM)
+	},
+	[2]  = { USB_DEVICE(USB_VID_ULTIMA_ELECTRONIC,
+			    USB_PID_ULTIMA_TVBOX_USB2_COLD)
+	},
+	[3]  = { USB_DEVICE(USB_VID_ULTIMA_ELECTRONIC,
+			    // ( ? )
+			    USB_PID_ULTIMA_TVBOX_USB2_WARM)
+	},
+	[4]  = { USB_DEVICE(USB_VID_LITEON,
+			    USB_PID_LITEON_DVB_T_COLD)
+	},
+	[5]  = { USB_DEVICE(USB_VID_LITEON,
+			    USB_PID_LITEON_DVB_T_WARM)
+	},
+	[6]  = { USB_DEVICE(USB_VID_EMPIA,
+			    USB_PID_DIGIVOX_MINI_SL_COLD)
+	},
+	[7]  = { USB_DEVICE(USB_VID_EMPIA,
+			    USB_PID_DIGIVOX_MINI_SL_WARM)
+	},
+	[8]  = { USB_DEVICE(USB_VID_GRANDTEC,
+			    USB_PID_GRANDTEC_DVBT_USB2_COLD)
+	},
+	[9]  = { USB_DEVICE(USB_VID_GRANDTEC,
+			    USB_PID_GRANDTEC_DVBT_USB2_WARM)
+	},
+	[10] = { USB_DEVICE(USB_VID_ULTIMA_ELECTRONIC,
+			    USB_PID_ARTEC_T14_COLD)
+	},
+	[11] = { USB_DEVICE(USB_VID_ULTIMA_ELECTRONIC,
+			    USB_PID_ARTEC_T14_WARM)
+	},
+	[12] = { USB_DEVICE(USB_VID_LEADTEK,
+			    USB_PID_WINFAST_DTV_DONGLE_COLD)
+	},
+	[13] = { USB_DEVICE(USB_VID_LEADTEK,
+			    USB_PID_WINFAST_DTV_DONGLE_WARM)
+	},
+	[14] = { USB_DEVICE(USB_VID_HUMAX_COEX,
+			    USB_PID_DVB_T_USB_STICK_HIGH_SPEED_COLD)
+	},
+	[15] = { USB_DEVICE(USB_VID_HUMAX_COEX,
+			    USB_PID_DVB_T_USB_STICK_HIGH_SPEED_WARM)
+	},
+	{ }		/* Terminating entry */
 };
 MODULE_DEVICE_TABLE (usb, dibusb_dib3000mc_table);

-- 
2.35.1
