Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8E1484B2D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 00:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236456AbiADXaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 18:30:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234152AbiADXaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 18:30:23 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 874EDC061761;
        Tue,  4 Jan 2022 15:30:23 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id m20so103338wmi.0;
        Tue, 04 Jan 2022 15:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject
         :content-language:to:cc:content-transfer-encoding;
        bh=h7G/5X2QIlVNIJuOayORE2ZhbFCF8S0DRHDEddBlr7k=;
        b=GJeRdNK3LXMnTATNKBM7FpBK9jT/4IN4vfVBBkoZYlNAtFpu+j925n84jhcmfIh4Ea
         tIsVaUMf/EhosszVv2nhGHw52FT//Eo5RUiPaTWHOH809ca3qfr+qFWPO6uRE4m7xtvl
         Y/788zTpJOVBirQTS2ObqbileG+0sFyTLvM9NmUrXbCmWgEB+LY5Dt+p7ufCez/8w+sz
         4FsGRtUS2CoxyB6t+NAtuco6xr2yOPWtj8e3SanDWMChyU6qjuV0mGDip82EJCYqoqGI
         /18j498w9bmSOPGnC8AGuuSo4gqMOfC/Q1/dAy3Kqk1O1FedOBDq7TyX94mUTvSdDl4N
         8hew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:content-language:to:cc:content-transfer-encoding;
        bh=h7G/5X2QIlVNIJuOayORE2ZhbFCF8S0DRHDEddBlr7k=;
        b=Wfdm9iwwQwIfn/E9Wk5lqjIVPLIP9RQ5ydWM3MTCXvTm5OUUqW4Npr54r7Co8mKjvK
         dplRjPLEjF1LQQb9sveyeKA0/wjs7BEU9Mg0Nmomahk9aVTTXxTSLBNS+sIrYUc4mpYY
         uE5Ix4BJYiQsjCjZMHSTu48kYK+YEONirQbVa6iK7T79cYtPei+OqnweEBewm+3WtBqa
         qdpWg7sGjCnjWI12HkCf+UgmlMpgliu30X4xuuuiSmMBNFe8Wzj7gi0rMBlml4LgbMW3
         rVp3oFFPy3z6Hwx30PDHcm4paCO5IWFja05g0Ku9Z40M7aH3pyq0b+7yLUHRMxdnWpSP
         TvJg==
X-Gm-Message-State: AOAM533d/buCDcoPj4KDypAdfs2dRKVIzfuTXqm++zoLa2Cc1Kn22qQW
        /OSXLeH26v3E965XnZS+vAS1psVzwLEmxhgT
X-Google-Smtp-Source: ABdhPJyTsy4Ea3yqT7d+FehJupz6Q8fg3+ve13UcRv+nkFzjDScTvToS19F27QzM9dbEadJ0gw60zg==
X-Received: by 2002:a1c:7903:: with SMTP id l3mr501132wme.103.1641339022118;
        Tue, 04 Jan 2022 15:30:22 -0800 (PST)
Received: from 168.52.45.77 (201.ip-51-68-45.eu. [51.68.45.201])
        by smtp.gmail.com with ESMTPSA id z5sm38286171wru.87.2022.01.04.15.30.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jan 2022 15:30:21 -0800 (PST)
Message-ID: <401b1d94-1348-15fd-b48f-a80e8885c7a4@gmail.com>
Date:   Wed, 5 Jan 2022 00:30:20 +0100
MIME-Version: 1.0
User-Agent: nano 6.4
From:   Ismael Ferreras Morezuelas <swyterzone@gmail.com>
Subject: [PATCH v2] xpad: Spelling fixes for "Xbox", improve and proofread the
 listed xpad device names
Content-Language: en-US
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-input@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Cameron Gutman <aicommander@gmail.com>, swyterzone@gmail.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Linux kernel is notorious for misspelling X-Box, X-box, XBox or XBOX;
the official spelling is actually just Xbox. Plain and simple.

Tried to respect the existing notes but still following the style guide.
No functional changes intended. This only affects ancillary parts.

Sounds trivial, but this makes it easier to search the correct
entries in xmenu by name. It has always been a pet peeve of mine.

Signed-off-by: Ismael Ferreras Morezuelas <swyterzone@gmail.com>
---

This is sort of a re-send from July 30, 2020: https://patchwork.kernel.org/project/linux-input/patch/e864b39b-27e0-c6f2-76e8-db465916f310@gmail.com/

Changes in v2:
* I have gotten rid of/split off the actual gamepad name cleanup
  for easier merging and now this only covers comments and other
  miscellaneous tags in the build system.

  Cameron Gutman wasn't sure if changing the existing pad names
  would affect userland applications. So now it's simpler.

  Maybe I'll resubmit the rest in the future, if I have more time.

 Documentation/input/devices/xpad.rst | 10 ++---
 Documentation/input/gamepad.rst      |  2 +-
 drivers/input/joystick/Kconfig       | 14 +++---
 drivers/input/joystick/xpad.c        | 64 ++++++++++++++--------------
 4 files changed, 45 insertions(+), 45 deletions(-)

diff --git a/Documentation/input/devices/xpad.rst b/Documentation/input/devices/xpad.rst
index 173c2acda..a480bc781 100644
--- a/Documentation/input/devices/xpad.rst
+++ b/Documentation/input/devices/xpad.rst
@@ -4,16 +4,16 @@ xpad - Linux USB driver for Xbox compatible controllers
 
 This driver exposes all first-party and third-party Xbox compatible
 controllers. It has a long history and has enjoyed considerable usage
-as Window's xinput library caused most PC games to focus on Xbox
+as Windows' xinput library caused most PC games to focus on Xbox
 controller compatibility.
 
 Due to backwards compatibility all buttons are reported as digital.
-This only effects Original Xbox controllers. All later controller models
+This only affects Original Xbox controllers. All later controller models
 have only digital face buttons.
 
 Rumble is supported on some models of Xbox 360 controllers but not of
 Original Xbox controllers nor on Xbox One controllers. As of writing
-the Xbox One's rumble protocol has not been reverse engineered but in
+the Xbox One's rumble protocol has not been reverse-engineered but in
 the future could be supported.
 
 
@@ -82,7 +82,7 @@ I've tested this with Stepmania, and it works quite well.
 Unknown Controllers
 -------------------
 
-If you have an unknown xbox controller, it should work just fine with
+If you have an unknown Xbox controller, it should work just fine with
 the default settings.
 
 HOWEVER if you have an unknown dance pad not listed below, it will not
@@ -123,7 +123,7 @@ can be found on the net ([1]_, [2]_, [3]_).
 
 Thanks to the trip splitter found on the cable you don't even need to cut the
 original one. You can buy an extension cable and cut that instead. That way,
-you can still use the controller with your X-Box, if you have one ;)
+you can still use the controller with your Xbox, if you have one ;)
 
 
 
diff --git a/Documentation/input/gamepad.rst b/Documentation/input/gamepad.rst
index 4d5e7fb80..968e07056 100644
--- a/Documentation/input/gamepad.rst
+++ b/Documentation/input/gamepad.rst
@@ -184,7 +184,7 @@ Gamepads report the following events:
 
   Many pads also have a third button which is branded or has a special symbol
   and meaning. Such buttons are mapped as BTN_MODE. Examples are the Nintendo
-  "HOME" button, the XBox "X"-button or Sony "PS" button.
+  "HOME" button, the Xbox "X" button or the Sony PlayStation "PS" button.
 
 - Rumble:
 
diff --git a/drivers/input/joystick/Kconfig b/drivers/input/joystick/Kconfig
index 3b23078bc..99947b4ce 100644
--- a/drivers/input/joystick/Kconfig
+++ b/drivers/input/joystick/Kconfig
@@ -291,33 +291,33 @@ config JOYSTICK_JOYDUMP
 	  module will be called joydump.
 
 config JOYSTICK_XPAD
-	tristate "X-Box gamepad support"
+	tristate "Xbox gamepad support"
 	depends on USB_ARCH_HAS_HCD
 	select USB
 	help
-	  Say Y here if you want to use the X-Box pad with your computer.
+	  Say Y here if you want to use Xbox pads with your computer.
 	  Make sure to say Y to "Joystick support" (CONFIG_INPUT_JOYDEV)
 	  and/or "Event interface support" (CONFIG_INPUT_EVDEV) as well.
 
-	  For information about how to connect the X-Box pad to USB, see
+	  For information about how to connect the Xbox pad to USB, see
 	  <file:Documentation/input/devices/xpad.rst>.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called xpad.
 
 config JOYSTICK_XPAD_FF
-	bool "X-Box gamepad rumble support"
+	bool "Xbox gamepad rumble support"
 	depends on JOYSTICK_XPAD && INPUT
 	select INPUT_FF_MEMLESS
 	help
-	  Say Y here if you want to take advantage of xbox 360 rumble features.
+	  Say Y here if you want to take advantage of Xbox 360 rumble features.
 
 config JOYSTICK_XPAD_LEDS
-	bool "LED Support for Xbox360 controller 'BigX' LED"
+	bool "LED Support for the Xbox 360 controller Guide button"
 	depends on JOYSTICK_XPAD && (LEDS_CLASS=y || LEDS_CLASS=JOYSTICK_XPAD)
 	help
 	  This option enables support for the LED which surrounds the Big X on
-	  XBox 360 controller.
+	  Xbox 360 controllers.
 
 config JOYSTICK_WALKERA0701
 	tristate "Walkera WK-0701 RC transmitter"
diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 4c914f75a..813b3863e 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * X-Box gamepad driver
+ * Xbox gamepad driver
  *
  * Copyright (c) 2002 Marko Friedemann <mfr@bmx-chemnitz.de>
  *               2004 Oliver Schwartz <Oliver.Schwartz@gmx.de>,
@@ -23,8 +23,8 @@
  *  - ITO Takayuki for providing essential xpad information on his website
  *  - Vojtech Pavlik     - iforce driver / input subsystem
  *  - Greg Kroah-Hartman - usb-skeleton driver
- *  - XBOX Linux project - extra USB id's
- *  - Pekka Pöyry (quantus) - Xbox One controller reverse engineering
+ *  - Xbox Linux project - extra USB IDs
+ *  - Pekka Pöyry (quantus) - Xbox One controller reverse-engineering
  *
  * TODO:
  *  - fine tune axes (especially trigger axes)
@@ -52,7 +52,7 @@
  * 2002-07-17 - 0.0.5 : simplified d-pad handling
  *
  * 2004-10-02 - 0.0.6 : DDR pad support
- *  - borrowed from the XBOX linux kernel
+ *  - borrowed from the Xbox Linux kernel
  *  - USB id's for commonly used dance pads are present
  *  - dance pads will map D-PAD to buttons, not axes
  *  - pass the module paramater 'dpad_to_buttons' to force
@@ -417,41 +417,41 @@ static const signed short xpad_abs_triggers[] = {
 	{ XPAD_XBOXONE_VENDOR_PROTOCOL((vend), 208) }
 
 static const struct usb_device_id xpad_table[] = {
-	{ USB_INTERFACE_INFO('X', 'B', 0) },	/* X-Box USB-IF not approved class */
-	XPAD_XBOX360_VENDOR(0x0079),		/* GPD Win 2 Controller */
-	XPAD_XBOX360_VENDOR(0x044f),		/* Thrustmaster X-Box 360 controllers */
-	XPAD_XBOX360_VENDOR(0x045e),		/* Microsoft X-Box 360 controllers */
-	XPAD_XBOXONE_VENDOR(0x045e),		/* Microsoft X-Box One controllers */
-	XPAD_XBOX360_VENDOR(0x046d),		/* Logitech X-Box 360 style controllers */
+	{ USB_INTERFACE_INFO('X', 'B', 0) },	/* Xbox USB-IF not-approved class */
+	XPAD_XBOX360_VENDOR(0x0079),		/* GPD Win 2 controller */
+	XPAD_XBOX360_VENDOR(0x044f),		/* Thrustmaster Xbox 360 controllers */
+	XPAD_XBOX360_VENDOR(0x045e),		/* Microsoft Xbox 360 controllers */
+	XPAD_XBOXONE_VENDOR(0x045e),		/* Microsoft Xbox One controllers */
+	XPAD_XBOX360_VENDOR(0x046d),		/* Logitech Xbox 360-style controllers */
 	XPAD_XBOX360_VENDOR(0x056e),		/* Elecom JC-U3613M */
 	XPAD_XBOX360_VENDOR(0x06a3),		/* Saitek P3600 */
-	XPAD_XBOX360_VENDOR(0x0738),		/* Mad Catz X-Box 360 controllers */
+	XPAD_XBOX360_VENDOR(0x0738),		/* Mad Catz Xbox 360 controllers */
 	{ USB_DEVICE(0x0738, 0x4540) },		/* Mad Catz Beat Pad */
 	XPAD_XBOXONE_VENDOR(0x0738),		/* Mad Catz FightStick TE 2 */
-	XPAD_XBOX360_VENDOR(0x07ff),		/* Mad Catz GamePad */
-	XPAD_XBOX360_VENDOR(0x0e6f),		/* 0x0e6f X-Box 360 controllers */
-	XPAD_XBOXONE_VENDOR(0x0e6f),		/* 0x0e6f X-Box One controllers */
-	XPAD_XBOX360_VENDOR(0x0f0d),		/* Hori Controllers */
-	XPAD_XBOXONE_VENDOR(0x0f0d),		/* Hori Controllers */
-	XPAD_XBOX360_VENDOR(0x1038),		/* SteelSeries Controllers */
+	XPAD_XBOX360_VENDOR(0x07ff),		/* Mad Catz Gamepad */
+	XPAD_XBOX360_VENDOR(0x0e6f),		/* 0x0e6f Xbox 360 controllers */
+	XPAD_XBOXONE_VENDOR(0x0e6f),		/* 0x0e6f Xbox One controllers */
+	XPAD_XBOX360_VENDOR(0x0f0d),		/* Hori controllers */
+	XPAD_XBOXONE_VENDOR(0x0f0d),		/* Hori controllers */
+	XPAD_XBOX360_VENDOR(0x1038),		/* SteelSeries controllers */
 	XPAD_XBOX360_VENDOR(0x11c9),		/* Nacon GC100XF */
 	XPAD_XBOX360_VENDOR(0x1209),		/* Ardwiino Controllers */
-	XPAD_XBOX360_VENDOR(0x12ab),		/* X-Box 360 dance pads */
-	XPAD_XBOX360_VENDOR(0x1430),		/* RedOctane X-Box 360 controllers */
-	XPAD_XBOX360_VENDOR(0x146b),		/* BigBen Interactive Controllers */
+	XPAD_XBOX360_VENDOR(0x12ab),		/* Xbox 360 dance pads */
+	XPAD_XBOX360_VENDOR(0x1430),		/* RedOctane Xbox 360 controllers */
+	XPAD_XBOX360_VENDOR(0x146b),		/* Bigben Interactive controllers */
 	XPAD_XBOX360_VENDOR(0x1532),		/* Razer Sabertooth */
 	XPAD_XBOXONE_VENDOR(0x1532),		/* Razer Wildcat */
-	XPAD_XBOX360_VENDOR(0x15e4),		/* Numark X-Box 360 controllers */
-	XPAD_XBOX360_VENDOR(0x162e),		/* Joytech X-Box 360 controllers */
+	XPAD_XBOX360_VENDOR(0x15e4),		/* Numark Xbox 360 controllers */
+	XPAD_XBOX360_VENDOR(0x162e),		/* Joytech Xbox 360 controllers */
 	XPAD_XBOX360_VENDOR(0x1689),		/* Razer Onza */
 	XPAD_XBOX360_VENDOR(0x1949),		/* Amazon controllers */
-	XPAD_XBOX360_VENDOR(0x1bad),		/* Harminix Rock Band Guitar and Drums */
-	XPAD_XBOX360_VENDOR(0x20d6),		/* PowerA Controllers */
-	XPAD_XBOXONE_VENDOR(0x20d6),		/* PowerA Controllers */
-	XPAD_XBOX360_VENDOR(0x24c6),		/* PowerA Controllers */
-	XPAD_XBOXONE_VENDOR(0x24c6),		/* PowerA Controllers */
-	XPAD_XBOXONE_VENDOR(0x2e24),		/* Hyperkin Duke X-Box One pad */
-	XPAD_XBOX360_VENDOR(0x2f24),		/* GameSir Controllers */
+	XPAD_XBOX360_VENDOR(0x1bad),		/* Harmonix Rock Band guitar and drums */
+	XPAD_XBOX360_VENDOR(0x20d6),		/* PowerA controllers */
+	XPAD_XBOXONE_VENDOR(0x20d6),		/* PowerA controllers */
+	XPAD_XBOX360_VENDOR(0x24c6),		/* PowerA controllers */
+	XPAD_XBOXONE_VENDOR(0x24c6),		/* PowerA controllers */
+	XPAD_XBOXONE_VENDOR(0x2e24),		/* Hyperkin Duke Xbox One pad */
+	XPAD_XBOX360_VENDOR(0x2f24),		/* GameSir controllers */
 	XPAD_XBOX360_VENDOR(0x3285),		/* Nacon GC-100 */
 	{ }
 };
@@ -623,7 +623,7 @@ static void xpadone_ack_mode_report(struct usb_xpad *xpad, u8 seq_num);
  *	Completes a request by converting the data into events for the
  *	input subsystem.
  *
- *	The used report descriptor was taken from ITO Takayukis website:
+ *	The used report descriptor was taken from ITO Takayuki's website:
  *	 http://euc.jp/periphs/xbox-controller.ja.html
  */
 static void xpad_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char *data)
@@ -1364,7 +1364,7 @@ struct xpad_led {
 };
 
 /*
- * set the LEDs on Xbox360 / Wireless Controllers
+ * set the LEDs on Xbox 360 / Wireless Controllers
  * @param command
  *  0: off
  *  1: all blink, then previous setting
@@ -1979,5 +1979,5 @@ static struct usb_driver xpad_driver = {
 module_usb_driver(xpad_driver);
 
 MODULE_AUTHOR("Marko Friedemann <mfr@bmx-chemnitz.de>");
-MODULE_DESCRIPTION("X-Box pad driver");
+MODULE_DESCRIPTION("Xbox pad driver");
 MODULE_LICENSE("GPL");
-- 
2.34.1

