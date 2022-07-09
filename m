Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D03B56C5E1
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 03:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiGIB6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 21:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiGIB6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 21:58:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07BEAC7;
        Fri,  8 Jul 2022 18:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=axixuHdhNPC8PLU+MtwLWuxcy7tj0nJV9eaiEYW+1x0=; b=VtaN+pjuBmL5p96mNCI/c6E/ce
        8rfzM2NMb3BiW/rvm0M7x0MZ+0smnTwkRnPWqWfGPVKy4kCGpK6Basoo+rVszgc3dSU+LFN3vkWvy
        pWyb3RdFZ3y0mtVi2ihZgKlD1nejQC8JI0EDJiKblHG2O4qAuEadnC8Walf8da51rudq3QyWL2ESm
        1I4B6w7Ulw7cwpidAaqeDpa/mo8TM/8ZBeKcNaztrxON+S1230QgAte/3unTHKAnhawFxFQ+mBWed
        gewGVkm9x7RXJyxd+VTNIcnrCgz9JLNmu4/qs7rzal7h/0F8IPAxgogVvLku92qMm9sH//HIMcRUp
        yrqyGjYA==;
Received: from [2601:1c0:6280:3f0::a6b3] (helo=casper.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o9zjQ-0041pK-ES; Sat, 09 Jul 2022 01:58:05 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org
Subject: [PATCH] HID: Kconfig: remove redundant "depends on HID" lines
Date:   Fri,  8 Jul 2022 18:57:59 -0700
Message-Id: <20220709015759.6396-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove all occurrences of "depends on HID" that are inside the
"if HID" / "endif" block since they are redundant.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org
---
 drivers/hid/Kconfig |   73 ------------------------------------------
 1 file changed, 1 insertion(+), 72 deletions(-)

--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -28,7 +28,6 @@ if HID
 
 config HID_BATTERY_STRENGTH
 	bool "Battery level reporting for HID devices"
-	depends on HID
 	select POWER_SUPPLY
 	default n
 	help
@@ -38,7 +37,6 @@ config HID_BATTERY_STRENGTH
 
 config HIDRAW
 	bool "/dev/hidraw raw HID device support"
-	depends on HID
 	help
 	Say Y here if you want to support HID devices (from the USB
 	specification standpoint) that aren't strictly user interface
@@ -57,7 +55,6 @@ config HIDRAW
 
 config UHID
 	tristate "User-space I/O driver support for HID subsystem"
-	depends on HID
 	default n
 	help
 	Say Y here if you want to provide HID I/O Drivers from user-space.
@@ -78,7 +75,6 @@ config UHID
 
 config HID_GENERIC
 	tristate "Generic HID driver"
-	depends on HID
 	default HID
 	help
 	Support for generic devices on the HID bus. This includes most
@@ -90,11 +86,9 @@ config HID_GENERIC
 	If unsure, say Y.
 
 menu "Special HID drivers"
-	depends on HID
 
 config HID_A4TECH
 	tristate "A4TECH mice"
-	depends on HID
 	default !EXPERT
 	help
 	Support for some A4TECH mice with two scroll wheels.
@@ -113,7 +107,6 @@ config HID_ACCUTOUCH
 
 config HID_ACRUX
 	tristate "ACRUX game controller support"
-	depends on HID
 	help
 	Say Y here if you want to enable support for ACRUX game controllers.
 
@@ -127,7 +120,6 @@ config HID_ACRUX_FF
 
 config HID_APPLE
 	tristate "Apple {i,Power,Mac}Books"
-	depends on HID
 	depends on LEDS_CLASS
 	depends on NEW_LEDS
 	default !EXPERT
@@ -167,13 +159,11 @@ config HID_ASUS
 
 config HID_AUREAL
 	tristate "Aureal"
-	depends on HID
 	help
 	Support for Aureal Cy se W-01RN Remote Controller and other Aureal derived remotes.
 
 config HID_BELKIN
 	tristate "Belkin Flip KVM and Wireless keyboard"
-	depends on HID
 	default !EXPERT
 	help
 	Support for Belkin Flip KVM and Wireless keyboard.
@@ -202,7 +192,6 @@ config HID_BIGBEN_FF
 
 config HID_CHERRY
 	tristate "Cherry Cymotion keyboard"
-	depends on HID
 	default !EXPERT
 	help
 	Support for Cherry Cymotion keyboard.
@@ -227,7 +216,6 @@ config HID_CORSAIR
 
 config HID_COUGAR
 	tristate "Cougar devices"
-	depends on HID
 	help
 	Support for Cougar devices that are not fully compliant with the
 	HID standard.
@@ -237,7 +225,6 @@ config HID_COUGAR
 
 config HID_MACALLY
 	tristate "Macally devices"
-	depends on HID
 	help
 	Support for Macally devices that are not fully compliant with the
 	HID standard.
@@ -262,7 +249,6 @@ config HID_PRODIKEYS
 
 config HID_CMEDIA
 	tristate "CMedia audio chips"
-	depends on HID
 	help
 	Support for CMedia CM6533 HID audio jack controls
         and HS100B mute buttons.
@@ -288,14 +274,12 @@ config HID_CREATIVE_SB0540
 
 config HID_CYPRESS
 	tristate "Cypress mouse and barcode readers"
-	depends on HID
 	default !EXPERT
 	help
 	Support for cypress mouse and barcode readers.
 
 config HID_DRAGONRISE
 	tristate "DragonRise Inc. game controller"
-	depends on HID
 	help
 	Say Y here if you have DragonRise Inc. game controllers.
 	These might be branded as:
@@ -314,7 +298,6 @@ config DRAGONRISE_FF
 
 config HID_EMS_FF
 	tristate "EMS Production Inc. force feedback support"
-	depends on HID
 	select INPUT_FF_MEMLESS
 	help
 	Say Y here if you want to enable force feedback support for devices by
@@ -332,7 +315,6 @@ config HID_ELAN
 
 config HID_ELECOM
 	tristate "ELECOM HID devices"
-	depends on HID
 	help
 	Support for ELECOM devices:
 	  - BM084 Bluetooth Mouse
@@ -349,7 +331,6 @@ config HID_ELO
 
 config HID_EZKEY
 	tristate "Ezkey BTC 8193 keyboard"
-	depends on HID
 	default !EXPERT
 	help
 	Support for Ezkey BTC 8193 keyboard.
@@ -367,19 +348,16 @@ config HID_FT260
 
 config HID_GEMBIRD
 	tristate "Gembird Joypad"
-	depends on HID
 	help
 	Support for Gembird JPD-DualForce 2.
 
 config HID_GFRM
 	tristate "Google Fiber TV Box remote control support"
-	depends on HID
 	help
 	Support for Google Fiber TV Box remote controls
 
 config HID_GLORIOUS
 	tristate "Glorious PC Gaming Race mice"
-	depends on HID
 	help
 	  Support for Glorious PC Gaming Race mice such as
 	  the Glorious Model O, O- and D.
@@ -424,7 +402,6 @@ config HID_VIVALDI
 	tristate "Vivaldi Keyboard"
 	select HID_VIVALDI_COMMON
 	select INPUT_VIVALDIFMAP
-	depends on HID
 	help
 	  Say Y here if you want to enable support for Vivaldi keyboards.
 
@@ -447,7 +424,6 @@ config HID_GT683R
 
 config HID_KEYTOUCH
 	tristate "Keytouch HID devices"
-	depends on HID
 	help
 	Support for Keytouch HID devices not fully compliant with
 	the specification. Currently supported:
@@ -455,7 +431,6 @@ config HID_KEYTOUCH
 
 config HID_KYE
 	tristate "KYE/Genius devices"
-	depends on HID
 	help
 	Support for KYE/Genius devices not fully compliant with HID standard:
 	- Ergo Mouse
@@ -471,32 +446,27 @@ config HID_UCLOGIC
 
 config HID_WALTOP
 	tristate "Waltop"
-	depends on HID
 	help
 	Support for Waltop tablets.
 
 config HID_VIEWSONIC
 	tristate "ViewSonic/Signotec"
-	depends on HID
 	help
 	  Support for ViewSonic/Signotec PD1011 signature pad.
 
 config HID_XIAOMI
 	tristate "Xiaomi"
-	depends on HID
 	help
 	  Adds support for side buttons of Xiaomi Mi Dual Mode Wireless
 	  Mouse Silent Edition.
 
 config HID_GYRATION
 	tristate "Gyration remote control"
-	depends on HID
 	help
 	Support for Gyration remote control.
 
 config HID_ICADE
 	tristate "ION iCade arcade controller"
-	depends on HID
 	help
 	Support for the ION iCade arcade controller to work as a joystick.
 
@@ -505,14 +475,12 @@ config HID_ICADE
 
 config HID_ITE
 	tristate "ITE devices"
-	depends on HID
 	default !EXPERT
 	help
 	Support for ITE devices not fully compliant with HID standard.
 
 config HID_JABRA
 	tristate "Jabra USB HID Driver"
-	depends on HID
 	help
 	Support for Jabra USB HID devices.
 
@@ -523,26 +491,22 @@ config HID_JABRA
 
 config HID_TWINHAN
 	tristate "Twinhan IR remote control"
-	depends on HID
 	help
 	Support for Twinhan IR remote control.
 
 config HID_KENSINGTON
 	tristate "Kensington Slimblade Trackball"
-	depends on HID
 	default !EXPERT
 	help
 	Support for Kensington Slimblade Trackball.
 
 config HID_LCPOWER
 	tristate "LC-Power"
-	depends on HID
 	help
 	Support for LC-Power RC1000MCE RF remote control.
 
 config HID_LED
 	tristate "Simple RGB LED support"
-	depends on HID
 	depends on LEDS_CLASS
 	help
 	Support for simple RGB LED devices. Currently supported are:
@@ -557,7 +521,6 @@ config HID_LED
 
 config HID_LENOVO
 	tristate "Lenovo / Thinkpad devices"
-	depends on HID
 	select NEW_LEDS
 	select LEDS_CLASS
 	help
@@ -675,7 +638,6 @@ config LOGIWHEELS_FF
 
 config HID_MAGICMOUSE
 	tristate "Apple Magic Mouse/Trackpad multi-touch support"
-	depends on HID
 	help
 	Support for the Apple Magic Mouse/Trackpad multi-touch.
 
@@ -684,14 +646,12 @@ config HID_MAGICMOUSE
 
 config HID_MALTRON
 	tristate "Maltron L90 keyboard"
-	depends on HID
 	help
 	Adds support for the volume up, volume down, mute, and play/pause buttons
 	of the Maltron L90 keyboard.
 
 config HID_MAYFLASH
 	tristate "Mayflash game controller adapter force feedback"
-	depends on HID
 	select INPUT_FF_MEMLESS
 	help
 	Say Y here if you have HJZ Mayflash PS3 game controller adapters
@@ -707,14 +667,12 @@ config HID_MEGAWORLD_FF
 
 config HID_REDRAGON
 	tristate "Redragon keyboards"
-	depends on HID
 	default !EXPERT
 	help
     Support for Redragon keyboards that need fix-ups to work properly.
 
 config HID_MICROSOFT
 	tristate "Microsoft non-fully HID-compliant devices"
-	depends on HID
 	default !EXPERT
 	select INPUT_FF_MEMLESS
 	help
@@ -722,14 +680,12 @@ config HID_MICROSOFT
 
 config HID_MONTEREY
 	tristate "Monterey Genius KB29E keyboard"
-	depends on HID
 	default !EXPERT
 	help
 	Support for Monterey Genius KB29E.
 
 config HID_MULTITOUCH
 	tristate "HID Multitouch panels"
-	depends on HID
 	help
 	  Generic support for HID multitouch panels.
 
@@ -775,7 +731,6 @@ config HID_MULTITOUCH
 
 config HID_NINTENDO
 	tristate "Nintendo Joy-Con and Pro Controller support"
-	depends on HID
 	depends on NEW_LEDS
 	depends on LEDS_CLASS
 	select POWER_SUPPLY
@@ -811,7 +766,6 @@ config HID_NTRIG
 
 config HID_ORTEK
 	tristate "Ortek PKB-1700/WKB-2000/Skycable wireless keyboard and mouse trackpad"
-	depends on HID
 	help
 	There are certain devices which have LogicalMaximum wrong in the keyboard
 	usage page of their report descriptor. The most prevailing ones so far
@@ -824,7 +778,6 @@ config HID_ORTEK
 
 config HID_PANTHERLORD
 	tristate "Pantherlord/GreenAsia game controller"
-	depends on HID
 	help
 	  Say Y here if you have a PantherLord/GreenAsia based game controller
 	  or adapter.
@@ -850,13 +803,11 @@ config HID_PENMOUNT
 
 config HID_PETALYNX
 	tristate "Petalynx Maxter remote control"
-	depends on HID
 	help
 	Support for Petalynx Maxter remote control.
 
 config HID_PICOLCD
 	tristate "PicoLCD (graphic version)"
-	depends on HID
 	help
 	  This provides support for Minibox PicoLCD devices, currently
 	  only the graphical ones are supported.
@@ -922,7 +873,6 @@ config HID_PICOLCD_CIR
 
 config HID_PLANTRONICS
 	tristate "Plantronics USB HID Driver"
-	depends on HID
 	help
 	  Provides HID support for Plantronics USB audio devices.
 	  Correctly maps vendor unique volume up/down HID usages to
@@ -933,7 +883,6 @@ config HID_PLANTRONICS
 
 config HID_PLAYSTATION
 	tristate "PlayStation HID Driver"
-	depends on HID
 	depends on LEDS_CLASS_MULTICOLOR
 	select CRC32
 	select POWER_SUPPLY
@@ -952,14 +901,12 @@ config PLAYSTATION_FF
 
 config HID_RAZER
 	tristate "Razer non-fully HID-compliant devices"
-	depends on HID
 	help
 	Support for Razer devices that are not fully compliant with the
 	HID standard.
 
 config HID_PRIMAX
 	tristate "Primax non-fully HID-compliant devices"
-	depends on HID
 	help
 	Support for Primax devices that are not fully compliant with the
 	HID standard.
@@ -981,7 +928,6 @@ config HID_ROCCAT
 
 config HID_SAITEK
 	tristate "Saitek (Mad Catz) non-fully HID-compliant devices"
-	depends on HID
 	help
 	Support for Saitek devices that are not fully compliant with the
 	HID standard.
@@ -999,7 +945,6 @@ config HID_SAMSUNG
 
 config HID_SEMITEK
 	tristate "Semitek USB keyboards"
-	depends on HID
 	help
 	Support for Semitek USB keyboards that are not fully compliant
 	with the HID standard.
@@ -1050,13 +995,11 @@ config SONY_FF
 
 config HID_SPEEDLINK
 	tristate "Speedlink VAD Cezanne mouse support"
-	depends on HID
 	help
 	Support for Speedlink Vicious and Divine Cezanne mouse.
 
 config HID_STEAM
 	tristate "Steam Controller support"
-	depends on HID
 	select POWER_SUPPLY
 	help
 	Say Y here if you have a Steam Controller if you want to use it
@@ -1065,19 +1008,16 @@ config HID_STEAM
 
 config HID_STEELSERIES
 	tristate "Steelseries SRW-S1 steering wheel support"
-	depends on HID
 	help
 	Support for Steelseries SRW-S1 steering wheel
 
 config HID_SUNPLUS
 	tristate "Sunplus wireless desktop"
-	depends on HID
 	help
 	Support for Sunplus wireless desktop.
 
 config HID_RMI
 	tristate "Synaptics RMI4 device support"
-	depends on HID
 	select RMI4_CORE
 	select RMI4_F03
 	select RMI4_F11
@@ -1090,7 +1030,6 @@ config HID_RMI
 
 config HID_GREENASIA
 	tristate "GreenAsia (Product ID 0x12) game controller support"
-	depends on HID
 	help
 	  Say Y here if you have a GreenAsia (Product ID 0x12) based game
 	  controller or adapter.
@@ -1112,7 +1051,6 @@ config HID_HYPERV_MOUSE
 
 config HID_SMARTJOYPLUS
 	tristate "SmartJoy PLUS PS2/USB adapter support"
-	depends on HID
 	help
 	Support for SmartJoy PLUS PS2/USB adapter, Super Dual Box,
 	Super Joy Box 3 Pro, Super Dual Box Pro, and Super Joy Box 5 Pro.
@@ -1130,20 +1068,17 @@ config SMARTJOYPLUS_FF
 
 config HID_TIVO
 	tristate "TiVo Slide Bluetooth remote control support"
-	depends on HID
 	help
 	Say Y if you have a TiVo Slide Bluetooth remote control.
 
 config HID_TOPSEED
 	tristate "TopSeed Cyberlink, BTC Emprex, Conceptronic remote control support"
-	depends on HID
 	help
 	Say Y if you have a TopSeed Cyberlink or BTC Emprex or Conceptronic
 	CLLRCMCE remote control.
 
 config HID_THINGM
 	tristate "ThingM blink(1) USB RGB LED"
-	depends on HID
 	depends on LEDS_CLASS
 	select HID_LED
 	help
@@ -1170,7 +1105,6 @@ config THRUSTMASTER_FF
 
 config HID_UDRAW_PS3
 	tristate "THQ PS3 uDraw tablet"
-	depends on HID
 	help
 	  Say Y here if you want to use the THQ uDraw gaming tablet for
 	  the PS3.
@@ -1207,7 +1141,6 @@ config HID_WACOM
 
 config HID_WIIMOTE
 	tristate "Nintendo Wii / Wii U peripherals"
-	depends on HID
 	depends on LEDS_CLASS
 	select POWER_SUPPLY
 	select INPUT_FF_MEMLESS
@@ -1232,7 +1165,6 @@ config HID_WIIMOTE
 
 config HID_XINMO
 	tristate "Xin-Mo non-fully compliant devices"
-	depends on HID
 	help
 	Support for Xin-Mo devices that are not fully compliant with the HID
 	standard. Currently only supports the Xin-Mo Dual Arcade. Say Y here
@@ -1240,7 +1172,6 @@ config HID_XINMO
 
 config HID_ZEROPLUS
 	tristate "Zeroplus based game controller support"
-	depends on HID
 	help
 	  Say Y here if you have a Zeroplus based game controller.
 
@@ -1254,13 +1185,12 @@ config ZEROPLUS_FF
 
 config HID_ZYDACRON
 	tristate "Zydacron remote control support"
-	depends on HID
 	help
 	Support for Zydacron remote control.
 
 config HID_SENSOR_HUB
 	tristate "HID Sensors framework support"
-	depends on HID && HAS_IOMEM
+	depends on HAS_IOMEM
 	select MFD_CORE
 	default n
 	help
@@ -1289,7 +1219,6 @@ config HID_SENSOR_CUSTOM_SENSOR
 
 config HID_ALPS
 	tristate "Alps HID device support"
-	depends on HID
 	help
 	Support for Alps I2C HID touchpads and StickPointer.
 	Say Y here if you have a Alps touchpads over i2c-hid or usbhid
