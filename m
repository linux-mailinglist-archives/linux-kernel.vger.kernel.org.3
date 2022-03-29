Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24BE14EA547
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 04:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbiC2Ci3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 22:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbiC2Ci2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 22:38:28 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C522467CE;
        Mon, 28 Mar 2022 19:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648521405; x=1680057405;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hKt6d2gb7C5Xj7sEPjiRMEby7aQRFsTCoe/7eiQAtkk=;
  b=DMBIVzeCZZQ4AWsTkwDssJn2hSahdEq7mK1D7YKMJJJQFdRZtyuZZvBz
   PDR+rcDWyKhW606sh3jNTGA4FinWP9PPuviCheSyWHCMQPKxe3C+q0Ox+
   7Nz0mTMaJjh6CrUpGEaVFqpJdPz6sRLqZ2uAHTtytCiflIa6odTqBAAXP
   ZTqahN7jZYvI9XixJcfIUWXZ6hnsKQXV98NdilJlYPr9nJrZaXGTKiyTV
   B4zf23NFyW3VwaBSDZFEcoxIykjAR5utkwdAXRNORnaeFyAvU0qBGRr+/
   pktFSzQiboDhpA5OuTgp/DBRv6U6K1paley7+6K7X+AIGyNWkM6TkqSns
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10300"; a="284040264"
X-IronPort-AV: E=Sophos;i="5.90,219,1643702400"; 
   d="scan'208";a="284040264"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 19:36:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,219,1643702400"; 
   d="scan'208";a="833078951"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 28 Mar 2022 19:36:43 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nZ1is-0002Xz-GX; Tue, 29 Mar 2022 02:36:42 +0000
Date:   Tue, 29 Mar 2022 10:35:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Pablo Ceballos <pceballos@google.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Pablo Ceballos <pceballos@google.com>
Subject: Re: [PATCH] HID: Add driver for Google Hangouts Meet Speakermic
Message-ID: <202203291010.fiuSQRtm-lkp@intel.com>
References: <20220328185704.1.I7a855580ce9f43fc2f598bdccf088c978d4af822@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220328185704.1.I7a855580ce9f43fc2f598bdccf088c978d4af822@changeid>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pablo,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on hid/for-next]
[also build test ERROR on jikos-trivial/for-next v5.17]
[cannot apply to jikos-hid/for-next next-20220328]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Pablo-Ceballos/HID-Add-driver-for-Google-Hangouts-Meet-Speakermic/20220329-070802
base:   https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-next
config: hexagon-randconfig-r035-20220327
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0f6d9501cf49ce02937099350d08f20c4af86f3d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/6a3e0c4274593e5033b3698b8e45011e52b1fa69
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Pablo-Ceballos/HID-Add-driver-for-Google-Hangouts-Meet-Speakermic/20220329-070802
        git checkout 6a3e0c4274593e5033b3698b8e45011e52b1fa69
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=hexagon  randconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=hexagon 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/hid/Kconfig:412: syntax error
   drivers/hid/Kconfig:411: unknown statement "---help---"
   drivers/hid/Kconfig:412:warning: ignoring unsupported character '.'
   drivers/hid/Kconfig:412: unknown statement "This"
   drivers/hid/Kconfig:414: unknown statement "This"
   drivers/hid/Kconfig:415:warning: ignoring unsupported character '.'
   drivers/hid/Kconfig:415: unknown statement "device"
   drivers/hid/Kconfig:416:warning: ignoring unsupported character '.'
   drivers/hid/Kconfig:416: unknown statement "for"
   drivers/hid/Kconfig:418:warning: ignoring unsupported character '.'
   drivers/hid/Kconfig:418: unknown statement "Say"
   make[2]: *** [scripts/kconfig/Makefile:77: oldconfig] Error 1
   make[1]: *** [Makefile:619: oldconfig] Error 2
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'oldconfig' not remade because of errors.
--
>> drivers/hid/Kconfig:412: syntax error
   drivers/hid/Kconfig:411: unknown statement "---help---"
   drivers/hid/Kconfig:412:warning: ignoring unsupported character '.'
   drivers/hid/Kconfig:412: unknown statement "This"
   drivers/hid/Kconfig:414: unknown statement "This"
   drivers/hid/Kconfig:415:warning: ignoring unsupported character '.'
   drivers/hid/Kconfig:415: unknown statement "device"
   drivers/hid/Kconfig:416:warning: ignoring unsupported character '.'
   drivers/hid/Kconfig:416: unknown statement "for"
   drivers/hid/Kconfig:418:warning: ignoring unsupported character '.'
   drivers/hid/Kconfig:418: unknown statement "Say"
   make[2]: *** [scripts/kconfig/Makefile:77: olddefconfig] Error 1
   make[1]: *** [Makefile:619: olddefconfig] Error 2
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'olddefconfig' not remade because of errors.


vim +412 drivers/hid/Kconfig

    28	
    29	config HID_BATTERY_STRENGTH
    30		bool "Battery level reporting for HID devices"
    31		depends on HID
    32		select POWER_SUPPLY
    33		default n
    34		help
    35		This option adds support of reporting battery strength (for HID devices
    36		that support this feature) through power_supply class so that userspace
    37		tools, such as upower, can display it.
    38	
    39	config HIDRAW
    40		bool "/dev/hidraw raw HID device support"
    41		depends on HID
    42		help
    43		Say Y here if you want to support HID devices (from the USB
    44		specification standpoint) that aren't strictly user interface
    45		devices, like monitor controls and Uninterruptible Power Supplies.
    46	
    47		This module supports these devices separately using a separate
    48		event interface on /dev/hidraw.
    49	
    50		There is also a /dev/hiddev configuration option in the USB HID
    51		configuration menu. In comparison to hiddev, this device does not process
    52		the hid events at all (no parsing, no lookups). This lets applications
    53		to work on raw hid events when they want to, and avoid using transport-specific
    54		userspace libhid/libusb libraries.
    55	
    56		If unsure, say Y.
    57	
    58	config UHID
    59		tristate "User-space I/O driver support for HID subsystem"
    60		depends on HID
    61		default n
    62		help
    63		Say Y here if you want to provide HID I/O Drivers from user-space.
    64		This allows to write I/O drivers in user-space and feed the data from
    65		the device into the kernel. The kernel parses the HID reports, loads the
    66		corresponding HID Device Driver or provides input devices on top of your
    67		user-space device.
    68	
    69		This driver cannot be used to parse HID-reports in user-space and write
    70		special HID-drivers. You should use hidraw for that.
    71		Instead, this driver allows to write the transport-layer driver in
    72		user-space like USB-HID and Bluetooth-HID do in kernel-space.
    73	
    74		If unsure, say N.
    75	
    76		To compile this driver as a module, choose M here: the
    77		module will be called uhid.
    78	
    79	config HID_GENERIC
    80		tristate "Generic HID driver"
    81		depends on HID
    82		default HID
    83		help
    84		Support for generic devices on the HID bus. This includes most
    85		keyboards and mice, joysticks, tablets and digitizers.
    86	
    87		To compile this driver as a module, choose M here: the module
    88		will be called hid-generic.
    89	
    90		If unsure, say Y.
    91	
    92	menu "Special HID drivers"
    93		depends on HID
    94	
    95	config HID_A4TECH
    96		tristate "A4TECH mice"
    97		depends on HID
    98		default !EXPERT
    99		help
   100		Support for some A4TECH mice with two scroll wheels.
   101	
   102	config HID_ACCUTOUCH
   103		tristate "Accutouch touch device"
   104		depends on USB_HID
   105		help
   106		  This selects a driver for the Accutouch 2216 touch controller.
   107	
   108		  The driver works around a problem in the reported device capabilities
   109		  which causes userspace to detect the device as a mouse rather than
   110	          a touchscreen.
   111	
   112		  Say Y here if you have a Accutouch 2216 touch controller.
   113	
   114	config HID_ACRUX
   115		tristate "ACRUX game controller support"
   116		depends on HID
   117		help
   118		Say Y here if you want to enable support for ACRUX game controllers.
   119	
   120	config HID_ACRUX_FF
   121		bool "ACRUX force feedback support"
   122		depends on HID_ACRUX
   123		select INPUT_FF_MEMLESS
   124		help
   125		Say Y here if you want to enable force feedback support for ACRUX
   126		game controllers.
   127	
   128	config HID_APPLE
   129		tristate "Apple {i,Power,Mac}Books"
   130		depends on HID
   131		depends on LEDS_CLASS
   132		depends on NEW_LEDS
   133		default !EXPERT
   134		help
   135		Support for some Apple devices which less or more break
   136		HID specification.
   137	
   138		Say Y here if you want support for keyboards of	Apple iBooks, PowerBooks,
   139		MacBooks, MacBook Pros and Apple Aluminum.
   140	
   141	config HID_APPLEIR
   142		tristate "Apple infrared receiver"
   143		depends on (USB_HID)
   144		help
   145		Support for Apple infrared remote control. All the Apple computers from
   146		  2005 onwards include such a port, except the unibody Macbook (2009),
   147		  and Mac Pros. This receiver is also used in the Apple TV set-top box
   148		  prior to the 2010 model.
   149	
   150		Say Y here if you want support for Apple infrared remote control.
   151	
   152	config HID_ASUS
   153		tristate "Asus"
   154		depends on USB_HID
   155		depends on LEDS_CLASS
   156		depends on ASUS_WMI || ASUS_WMI=n
   157		select POWER_SUPPLY
   158		help
   159		Support for Asus notebook built-in keyboard and touchpad via i2c, and
   160		the Asus Republic of Gamers laptop keyboard special keys.
   161	
   162		Supported devices:
   163		- EeeBook X205TA
   164		- VivoBook E200HA
   165		- GL553V series
   166		- GL753V series
   167	
   168	config HID_AUREAL
   169		tristate "Aureal"
   170		depends on HID
   171		help
   172		Support for Aureal Cy se W-01RN Remote Controller and other Aureal derived remotes.
   173	
   174	config HID_BELKIN
   175		tristate "Belkin Flip KVM and Wireless keyboard"
   176		depends on HID
   177		default !EXPERT
   178		help
   179		Support for Belkin Flip KVM and Wireless keyboard.
   180	
   181	config HID_BETOP_FF
   182		tristate "Betop Production Inc. force feedback support"
   183		depends on USB_HID
   184		select INPUT_FF_MEMLESS
   185		help
   186		Say Y here if you want to enable force feedback support for devices by
   187		BETOP Production Ltd.
   188		Currently the following devices are known to be supported:
   189		 - BETOP 2185 PC & BFM MODE
   190	
   191	config HID_BIGBEN_FF
   192		tristate "BigBen Interactive Kids' gamepad support"
   193		depends on USB_HID
   194		depends on NEW_LEDS
   195		depends on LEDS_CLASS
   196		select INPUT_FF_MEMLESS
   197		help
   198		  Support for the "Kid-friendly Wired Controller" PS3OFMINIPAD
   199		  gamepad made by BigBen Interactive, originally sold as a PS3
   200		  accessory. This driver fixes input mapping and adds support for
   201		  force feedback effects and LEDs on the device.
   202	
   203	config HID_CHERRY
   204		tristate "Cherry Cymotion keyboard"
   205		depends on HID
   206		default !EXPERT
   207		help
   208		Support for Cherry Cymotion keyboard.
   209	
   210	config HID_CHICONY
   211		tristate "Chicony devices"
   212		depends on USB_HID
   213		default !EXPERT
   214		help
   215		Support for Chicony Tactical pad and special keys on Chicony keyboards.
   216	
   217	config HID_CORSAIR
   218		tristate "Corsair devices"
   219		depends on USB_HID && LEDS_CLASS
   220		help
   221		Support for Corsair devices that are not fully compliant with the
   222		HID standard.
   223	
   224		Supported devices:
   225		- Vengeance K90
   226		- Scimitar PRO RGB
   227	
   228	config HID_COUGAR
   229		tristate "Cougar devices"
   230		depends on HID
   231		help
   232		Support for Cougar devices that are not fully compliant with the
   233		HID standard.
   234	
   235		Supported devices:
   236		- Cougar 500k Gaming Keyboard
   237	
   238	config HID_MACALLY
   239		tristate "Macally devices"
   240		depends on HID
   241		help
   242		Support for Macally devices that are not fully compliant with the
   243		HID standard.
   244	
   245		supported devices:
   246		- Macally ikey keyboard
   247	
   248	config HID_PRODIKEYS
   249		tristate "Prodikeys PC-MIDI Keyboard support"
   250		depends on USB_HID && SND
   251		select SND_RAWMIDI
   252		help
   253		Support for Prodikeys PC-MIDI Keyboard device support.
   254		Say Y here to enable support for this device.
   255		- Prodikeys PC-MIDI keyboard.
   256		  The Prodikeys PC-MIDI acts as a USB Audio device, with one MIDI
   257		  input and one MIDI output. These MIDI jacks appear as
   258		  a sound "card" in the ALSA sound system.
   259		  Note: if you say N here, this device will still function as a basic
   260		  multimedia keyboard, but will lack support for the musical keyboard
   261		  and some additional multimedia keys.
   262	
   263	config HID_CMEDIA
   264		tristate "CMedia audio chips"
   265		depends on HID
   266		help
   267		Support for CMedia CM6533 HID audio jack controls
   268	        and HS100B mute buttons.
   269	
   270	config HID_CP2112
   271		tristate "Silicon Labs CP2112 HID USB-to-SMBus Bridge support"
   272		depends on USB_HID && HIDRAW && I2C && GPIOLIB
   273		select GPIOLIB_IRQCHIP
   274		help
   275		Support for Silicon Labs CP2112 HID USB to SMBus Master Bridge.
   276		This is a HID device driver which registers as an i2c adapter
   277		and gpiochip to expose these functions of the CP2112. The
   278		customizable USB descriptor fields are exposed as sysfs attributes.
   279	
   280	config HID_CREATIVE_SB0540
   281		tristate "Creative SB0540 infrared receiver"
   282		depends on USB_HID
   283		help
   284		Support for Creative infrared SB0540-compatible remote controls, such
   285		as the RM-1500 and RM-1800 remotes.
   286	
   287		Say Y here if you want support for Creative SB0540 infrared receiver.
   288	
   289	config HID_CYPRESS
   290		tristate "Cypress mouse and barcode readers"
   291		depends on HID
   292		default !EXPERT
   293		help
   294		Support for cypress mouse and barcode readers.
   295	
   296	config HID_DRAGONRISE
   297		tristate "DragonRise Inc. game controller"
   298		depends on HID
   299		help
   300		Say Y here if you have DragonRise Inc. game controllers.
   301		These might be branded as:
   302		- Tesun USB-703
   303		- Media-tech MT1504 "Rogue"
   304		- DVTech JS19 "Gear"
   305		- Defender Game Master
   306	
   307	config DRAGONRISE_FF
   308		bool "DragonRise Inc. force feedback"
   309		depends on HID_DRAGONRISE
   310		select INPUT_FF_MEMLESS
   311		help
   312		Say Y here if you want to enable force feedback support for DragonRise Inc.
   313		game controllers.
   314	
   315	config HID_EMS_FF
   316		tristate "EMS Production Inc. force feedback support"
   317		depends on HID
   318		select INPUT_FF_MEMLESS
   319		help
   320		Say Y here if you want to enable force feedback support for devices by
   321		EMS Production Ltd.
   322		Currently the following devices are known to be supported:
   323		 - Trio Linker Plus II
   324	
   325	config HID_ELAN
   326		tristate "ELAN USB Touchpad Support"
   327		depends on LEDS_CLASS && USB_HID
   328		help
   329		Say Y to enable support for the USB ELAN touchpad
   330		Currently the following devices are known to be supported:
   331		 - HP Pavilion X2 10-p0XX.
   332	
   333	config HID_ELECOM
   334		tristate "ELECOM HID devices"
   335		depends on HID
   336		help
   337		Support for ELECOM devices:
   338		  - BM084 Bluetooth Mouse
   339		  - EX-G Trackballs (M-XT3DRBK, M-XT3URBK)
   340		  - DEFT Trackballs (M-DT1DRBK, M-DT1URBK, M-DT2DRBK, M-DT2URBK)
   341		  - HUGE Trackballs (M-HT1DRBK, M-HT1URBK)
   342	
   343	config HID_ELO
   344		tristate "ELO USB 4000/4500 touchscreen"
   345		depends on USB_HID
   346		help
   347		Support for the ELO USB 4000/4500 touchscreens. Note that this is for
   348		different devices than those handled by CONFIG_TOUCHSCREEN_USB_ELO.
   349	
   350	config HID_EZKEY
   351		tristate "Ezkey BTC 8193 keyboard"
   352		depends on HID
   353		default !EXPERT
   354		help
   355		Support for Ezkey BTC 8193 keyboard.
   356	
   357	config HID_FT260
   358		tristate "FTDI FT260 USB HID to I2C host support"
   359		depends on USB_HID && HIDRAW && I2C
   360		help
   361		  Provides I2C host adapter functionality over USB-HID through FT260
   362		  device. The customizable USB descriptor fields are exposed as sysfs
   363		  attributes.
   364	
   365		  To compile this driver as a module, choose M here: the module
   366		  will be called hid-ft260.
   367	
   368	config HID_GEMBIRD
   369		tristate "Gembird Joypad"
   370		depends on HID
   371		help
   372		Support for Gembird JPD-DualForce 2.
   373	
   374	config HID_GFRM
   375		tristate "Google Fiber TV Box remote control support"
   376		depends on HID
   377		help
   378		Support for Google Fiber TV Box remote controls
   379	
   380	config HID_GLORIOUS
   381		tristate "Glorious PC Gaming Race mice"
   382		depends on HID
   383		help
   384		  Support for Glorious PC Gaming Race mice such as
   385		  the Glorious Model O, O- and D.
   386	
   387	config HID_HOLTEK
   388		tristate "Holtek HID devices"
   389		depends on USB_HID
   390		help
   391		Support for Holtek based devices:
   392		  - Holtek On Line Grip based game controller
   393		  - Trust GXT 18 Gaming Keyboard
   394		  - Sharkoon Drakonia / Perixx MX-2000 gaming mice
   395		  - Tracer Sniper TRM-503 / NOVA Gaming Slider X200 /
   396		    Zalman ZM-GM1
   397		  - SHARKOON DarkGlider Gaming mouse
   398		  - LEETGION Hellion Gaming Mouse
   399	
   400	config HOLTEK_FF
   401		bool "Holtek On Line Grip force feedback support"
   402		depends on HID_HOLTEK
   403		select INPUT_FF_MEMLESS
   404		help
   405		  Say Y here if you have a Holtek On Line Grip based game controller
   406		  and want to have force feedback support for it.
   407	
   408	config HID_GOOGLE_ATRUS
   409		tristate "Google Hangouts Meet Speakermic"
   410		depends on USB_HID
   411		---help---
 > 412		This selects a driver for the Google Hangouts Meet Speakermic.
   413	
   414		This driver works around a problem with the HID usage sent by this
   415		device for the mute button. It prevents key events from being generated
   416		for that HID usage since they would be incorrect.
   417	
   418		Say Y here if you have a Google Hangouts Meet Speakermic.
   419	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
