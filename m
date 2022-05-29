Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82F435370C1
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 13:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbiE2Lbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 07:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiE2Lbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 07:31:46 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A57B9A99E
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 04:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653823903; x=1685359903;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sVcoKiQjA6ONa6dstbRv1aAElIYVcSowUpyItKn3dLs=;
  b=TnlQzkhU/aiVN48VAKzBBe83fFE+QGRxFWVipisLhiDsfPWKWeOWdquh
   psgwAm+X6kVj2KipzGO75uxEDffWZxU9EwcfEG+zJ1LWnHx7I+YbC/SE/
   qmpKbcwZ/ErMXtxc12qaV5m+Rn5CTB5fXjjntQU99GjouSTekByN9gKAy
   Y7TmXsaiy6RrxC0cPC3QJjkcpSzVtPLCRwtNn/NU145YkWOSbHs2thZSY
   QHiOE38er3K3oYYyqGjVJeTIqANtRvvsPqGIdZccLMmXQGda3dtKKv92+
   995wpXTTdWqJX2bQj3BdVKW5d+KW5/W5zDx2B7kTn6eMUGRRNCzFwFy/g
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10361"; a="255277017"
X-IronPort-AV: E=Sophos;i="5.91,260,1647327600"; 
   d="scan'208";a="255277017"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2022 04:31:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,260,1647327600"; 
   d="scan'208";a="528813509"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 29 May 2022 04:31:39 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nvH90-0000zY-Vl;
        Sun, 29 May 2022 11:31:39 +0000
Date:   Sun, 29 May 2022 19:31:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sven Schnelle <svens@stackframe.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Helge Deller <deller@gmx.de>
Subject: [deller-fbdev:hp-visualize-fx-fbdev 1/1]
 drivers/video/fbdev/Kconfig:582: syntax error
Message-ID: <202205291919.xDFhtL3M-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git hp-visualize-fx-fbdev
head:   00d1742e8793d99494006ba3546191f1b8993a8e
commit: 00d1742e8793d99494006ba3546191f1b8993a8e [1/1] video: fbdev: add HP Visualize FX driver
config: riscv-randconfig-r042-20220529
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0fbe3f3f486e01448121f7931a4ca29fac1504ab)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git/commit/?id=00d1742e8793d99494006ba3546191f1b8993a8e
        git remote add deller-fbdev git://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git
        git fetch --no-tags deller-fbdev hp-visualize-fx-fbdev
        git checkout 00d1742e8793d99494006ba3546191f1b8993a8e
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=riscv  randconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=riscv 

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/video/fbdev/Kconfig:582: syntax error
   drivers/video/fbdev/Kconfig:581:warning: ignoring unsupported character '.'
   drivers/video/fbdev/Kconfig:581: unknown statement "Say"
   make[2]: *** [scripts/kconfig/Makefile:77: oldconfig] Error 1
   make[1]: *** [Makefile:628: oldconfig] Error 2
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'oldconfig' not remade because of errors.
--
>> drivers/video/fbdev/Kconfig:582: syntax error
   drivers/video/fbdev/Kconfig:581:warning: ignoring unsupported character '.'
   drivers/video/fbdev/Kconfig:581: unknown statement "Say"
   make[2]: *** [scripts/kconfig/Makefile:77: olddefconfig] Error 1
   make[1]: *** [Makefile:628: olddefconfig] Error 2
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'olddefconfig' not remade because of errors.


vim +582 drivers/video/fbdev/Kconfig

   162	
   163	config FB_SYS_FOPS
   164		tristate
   165		depends on FB
   166	
   167	config FB_DEFERRED_IO
   168		bool
   169		depends on FB
   170	
   171	config FB_HECUBA
   172		tristate
   173		depends on FB
   174		depends on FB_DEFERRED_IO
   175	
   176	config FB_SVGALIB
   177		tristate
   178		depends on FB
   179		help
   180		  Common utility functions useful to fbdev drivers of VGA-based
   181		  cards.
   182	
   183	config FB_MACMODES
   184		tristate
   185		depends on FB
   186	
   187	config FB_BACKLIGHT
   188		tristate
   189		depends on FB
   190		select BACKLIGHT_CLASS_DEVICE
   191	
   192	config FB_MODE_HELPERS
   193		bool "Enable Video Mode Handling Helpers"
   194		depends on FB
   195		help
   196		  This enables functions for handling video modes using the
   197		  Generalized Timing Formula and the EDID parser. A few drivers rely
   198		  on this feature such as the radeonfb, rivafb, and the i810fb. If
   199		  your driver does not take advantage of this feature, choosing Y will
   200		  just increase the kernel size by about 5K.
   201	
   202	config FB_TILEBLITTING
   203		bool "Enable Tile Blitting Support"
   204		depends on FB
   205		help
   206		  This enables tile blitting.  Tile blitting is a drawing technique
   207		  where the screen is divided into rectangular sections (tiles), whereas
   208		  the standard blitting divides the screen into pixels. Because the
   209		  default drawing element is a tile, drawing functions will be passed
   210		  parameters in terms of number of tiles instead of number of pixels.
   211		  For example, to draw a single character, instead of using bitmaps,
   212		  an index to an array of bitmaps will be used.  To clear or move a
   213		  rectangular section of a screen, the rectangle will be described in
   214		  terms of number of tiles in the x- and y-axis.
   215	
   216		  This is particularly important to one driver, matroxfb.  If
   217		  unsure, say N.
   218	
   219	comment "Frame buffer hardware drivers"
   220		depends on FB
   221	
   222	config FB_GRVGA
   223		tristate "Aeroflex Gaisler framebuffer support"
   224		depends on FB && SPARC
   225		select FB_CFB_FILLRECT
   226		select FB_CFB_COPYAREA
   227		select FB_CFB_IMAGEBLIT
   228		help
   229		  This enables support for the SVGACTRL framebuffer in the GRLIB IP library from Aeroflex Gaisler.
   230	
   231	config FB_CIRRUS
   232		tristate "Cirrus Logic support"
   233		depends on FB && (ZORRO || PCI)
   234		select FB_CFB_FILLRECT
   235		select FB_CFB_COPYAREA
   236		select FB_CFB_IMAGEBLIT
   237		help
   238		  This enables support for Cirrus Logic GD542x/543x based boards on
   239		  Amiga: SD64, Piccolo, Picasso II/II+, Picasso IV, or EGS Spectrum.
   240	
   241		  If you have a PCI-based system, this enables support for these
   242		  chips: GD-543x, GD-544x, GD-5480.
   243	
   244		  Please read the file <file:Documentation/fb/cirrusfb.rst>.
   245	
   246		  Say N unless you have such a graphics board or plan to get one
   247		  before you next recompile the kernel.
   248	
   249	config FB_PM2
   250		tristate "Permedia2 support"
   251		depends on FB && ((AMIGA && BROKEN) || PCI)
   252		select FB_CFB_FILLRECT
   253		select FB_CFB_COPYAREA
   254		select FB_CFB_IMAGEBLIT
   255		help
   256		  This is the frame buffer device driver for cards based on
   257		  the 3D Labs Permedia, Permedia 2 and Permedia 2V chips.
   258		  The driver was tested on the following cards:
   259			Diamond FireGL 1000 PRO AGP
   260			ELSA Gloria Synergy PCI
   261			Appian Jeronimo PRO (both heads) PCI
   262			3DLabs Oxygen ACX aka EONtronics Picasso P2 PCI
   263			Techsource Raptor GFX-8P (aka Sun PGX-32) on SPARC
   264			ASK Graphic Blaster Exxtreme AGP
   265	
   266		  To compile this driver as a module, choose M here: the
   267		  module will be called pm2fb.
   268	
   269	config FB_PM2_FIFO_DISCONNECT
   270		bool "enable FIFO disconnect feature"
   271		depends on FB_PM2 && PCI
   272		help
   273		  Support the Permedia2 FIFO disconnect feature.
   274	
   275	config FB_ARMCLCD
   276		tristate "ARM PrimeCell PL110 support"
   277		depends on ARM || ARM64 || COMPILE_TEST
   278		depends on FB && ARM_AMBA && HAS_IOMEM
   279		select FB_CFB_FILLRECT
   280		select FB_CFB_COPYAREA
   281		select FB_CFB_IMAGEBLIT
   282		select FB_MODE_HELPERS if OF
   283		select VIDEOMODE_HELPERS if OF
   284		select BACKLIGHT_CLASS_DEVICE if OF
   285		help
   286		  This framebuffer device driver is for the ARM PrimeCell PL110
   287		  Colour LCD controller.  ARM PrimeCells provide the building
   288		  blocks for System on a Chip devices.
   289	
   290		  If you want to compile this as a module (=code which can be
   291		  inserted into and removed from the running kernel), say M
   292		  here and read <file:Documentation/kbuild/modules.rst>.  The module
   293		  will be called amba-clcd.
   294	
   295	config FB_ACORN
   296		bool "Acorn VIDC support"
   297		depends on (FB = y) && ARM && ARCH_ACORN
   298		select FB_CFB_FILLRECT
   299		select FB_CFB_COPYAREA
   300		select FB_CFB_IMAGEBLIT
   301		help
   302		  This is the frame buffer device driver for the Acorn VIDC graphics
   303		  hardware found in Acorn RISC PCs and other ARM-based machines.  If
   304		  unsure, say N.
   305	
   306	config FB_CLPS711X
   307		tristate "CLPS711X LCD support"
   308		depends on FB && (ARCH_CLPS711X || COMPILE_TEST)
   309		select FB_MODE_HELPERS
   310		select FB_SYS_FILLRECT
   311		select FB_SYS_COPYAREA
   312		select FB_SYS_IMAGEBLIT
   313		select LCD_CLASS_DEVICE
   314		select VIDEOMODE_HELPERS
   315		help
   316		  Say Y to enable the Framebuffer driver for the Cirrus Logic
   317		  CLPS711X CPUs.
   318	
   319	config FB_SA1100
   320		bool "SA-1100 LCD support"
   321		depends on (FB = y) && ARM && ARCH_SA1100
   322		select FB_CFB_FILLRECT
   323		select FB_CFB_COPYAREA
   324		select FB_CFB_IMAGEBLIT
   325		help
   326		  This is a framebuffer device for the SA-1100 LCD Controller.
   327		  See <http://www.linux-fbdev.org/> for information on framebuffer
   328		  devices.
   329	
   330		  If you plan to use the LCD display with your SA-1100 system, say
   331		  Y here.
   332	
   333	config FB_IMX
   334		tristate "Freescale i.MX1/21/25/27 LCD support"
   335		depends on FB && HAVE_CLK && HAS_IOMEM
   336		depends on ARCH_MXC || COMPILE_TEST
   337		select LCD_CLASS_DEVICE
   338		select FB_CFB_FILLRECT
   339		select FB_CFB_COPYAREA
   340		select FB_CFB_IMAGEBLIT
   341		select FB_MODE_HELPERS
   342		select VIDEOMODE_HELPERS
   343	
   344	config FB_CYBER2000
   345		tristate "CyberPro 2000/2010/5000 support"
   346		depends on FB && PCI && (BROKEN || !SPARC64)
   347		select FB_CFB_FILLRECT
   348		select FB_CFB_COPYAREA
   349		select FB_CFB_IMAGEBLIT
   350		help
   351		  This enables support for the Integraphics CyberPro 20x0 and 5000
   352		  VGA chips used in the Rebel.com Netwinder and other machines.
   353		  Say Y if you have a NetWinder or a graphics card containing this
   354		  device, otherwise say N.
   355	
   356	config FB_CYBER2000_DDC
   357		bool "DDC for CyberPro support"
   358		depends on FB_CYBER2000
   359		select FB_DDC
   360		default y
   361		help
   362		  Say Y here if you want DDC support for your CyberPro graphics
   363		  card. This is only I2C bus support, driver does not use EDID.
   364	
   365	config FB_CYBER2000_I2C
   366		bool "CyberPro 2000/2010/5000 I2C support"
   367		depends on FB_CYBER2000 && I2C && ARCH_NETWINDER
   368		depends on I2C=y || FB_CYBER2000=m
   369		select I2C_ALGOBIT
   370		help
   371		  Enable support for the I2C video decoder interface on the
   372		  Integraphics CyberPro 20x0 and 5000 VGA chips.  This is used
   373		  on the Netwinder machines for the SAA7111 video capture.
   374	
   375	config FB_APOLLO
   376		bool
   377		depends on (FB = y) && APOLLO
   378		default y
   379		select FB_CFB_FILLRECT
   380		select FB_CFB_IMAGEBLIT
   381	
   382	config FB_Q40
   383		bool
   384		depends on (FB = y) && Q40
   385		default y
   386		select FB_CFB_FILLRECT
   387		select FB_CFB_COPYAREA
   388		select FB_CFB_IMAGEBLIT
   389	
   390	config FB_AMIGA
   391		tristate "Amiga native chipset support"
   392		depends on FB && AMIGA
   393		help
   394		  This is the frame buffer device driver for the builtin graphics
   395		  chipset found in Amigas.
   396	
   397		  To compile this driver as a module, choose M here: the
   398		  module will be called amifb.
   399	
   400	config FB_AMIGA_OCS
   401		bool "Amiga OCS chipset support"
   402		depends on FB_AMIGA
   403		help
   404		  This enables support for the original Agnus and Denise video chips,
   405		  found in the Amiga 1000 and most A500's and A2000's. If you intend
   406		  to run Linux on any of these systems, say Y; otherwise say N.
   407	
   408	config FB_AMIGA_ECS
   409		bool "Amiga ECS chipset support"
   410		depends on FB_AMIGA
   411		help
   412		  This enables support for the Enhanced Chip Set, found in later
   413		  A500's, later A2000's, the A600, the A3000, the A3000T and CDTV. If
   414		  you intend to run Linux on any of these systems, say Y; otherwise
   415		  say N.
   416	
   417	config FB_AMIGA_AGA
   418		bool "Amiga AGA chipset support"
   419		depends on FB_AMIGA
   420		help
   421		  This enables support for the Advanced Graphics Architecture (also
   422		  known as the AGA or AA) Chip Set, found in the A1200, A4000, A4000T
   423		  and CD32. If you intend to run Linux on any of these systems, say Y;
   424		  otherwise say N.
   425	
   426	config FB_FM2
   427		bool "Amiga FrameMaster II/Rainbow II support"
   428		depends on (FB = y) && ZORRO
   429		select FB_CFB_FILLRECT
   430		select FB_CFB_COPYAREA
   431		select FB_CFB_IMAGEBLIT
   432		help
   433		  This is the frame buffer device driver for the Amiga FrameMaster
   434		  card from BSC (exhibited 1992 but not shipped as a CBM product).
   435	
   436	config FB_ARC
   437		tristate "Arc Monochrome LCD board support"
   438		depends on FB && (X86 || COMPILE_TEST)
   439		select FB_SYS_FILLRECT
   440		select FB_SYS_COPYAREA
   441		select FB_SYS_IMAGEBLIT
   442		select FB_SYS_FOPS
   443		help
   444		  This enables support for the Arc Monochrome LCD board. The board
   445		  is based on the KS-108 lcd controller and is typically a matrix
   446		  of 2*n chips. This driver was tested with a 128x64 panel. This
   447		  driver supports it for use with x86 SBCs through a 16 bit GPIO
   448		  interface (8 bit data, 8 bit control). If you anticipate using
   449		  this driver, say Y or M; otherwise say N. You must specify the
   450		  GPIO IO address to be used for setting control and data.
   451	
   452	config FB_ATARI
   453		bool "Atari native chipset support"
   454		depends on (FB = y) && ATARI
   455		select FB_CFB_FILLRECT
   456		select FB_CFB_COPYAREA
   457		select FB_CFB_IMAGEBLIT
   458		help
   459		  This is the frame buffer device driver for the builtin graphics
   460		  chipset found in Ataris.
   461	
   462	config FB_OF
   463		bool "Open Firmware frame buffer device support"
   464		depends on (FB = y) && PPC && (!PPC_PSERIES || PCI)
   465		select FB_CFB_FILLRECT
   466		select FB_CFB_COPYAREA
   467		select FB_CFB_IMAGEBLIT
   468		select FB_MACMODES
   469		help
   470		  Say Y if you want support with Open Firmware for your graphics
   471		  board.
   472	
   473	config FB_CONTROL
   474		bool "Apple \"control\" display support"
   475		depends on (FB = y) && ((PPC_PMAC && PPC32) || COMPILE_TEST)
   476		select FB_CFB_FILLRECT
   477		select FB_CFB_COPYAREA
   478		select FB_CFB_IMAGEBLIT
   479		select FB_MACMODES
   480		help
   481		  This driver supports a frame buffer for the graphics adapter in the
   482		  Power Macintosh 7300 and others.
   483	
   484	config FB_PLATINUM
   485		bool "Apple \"platinum\" display support"
   486		depends on (FB = y) && PPC_PMAC && PPC32
   487		select FB_CFB_FILLRECT
   488		select FB_CFB_COPYAREA
   489		select FB_CFB_IMAGEBLIT
   490		select FB_MACMODES
   491		help
   492		  This driver supports a frame buffer for the "platinum" graphics
   493		  adapter in some Power Macintoshes.
   494	
   495	config FB_VALKYRIE
   496		bool "Apple \"valkyrie\" display support"
   497		depends on (FB = y) && (MAC || (PPC_PMAC && PPC32))
   498		select FB_CFB_FILLRECT
   499		select FB_CFB_COPYAREA
   500		select FB_CFB_IMAGEBLIT
   501		select FB_MACMODES
   502		help
   503		  This driver supports a frame buffer for the "valkyrie" graphics
   504		  adapter in some Power Macintoshes.
   505	
   506	config FB_CT65550
   507		bool "Chips 65550 display support"
   508		depends on (FB = y) && PPC32 && PCI
   509		select FB_CFB_FILLRECT
   510		select FB_CFB_COPYAREA
   511		select FB_CFB_IMAGEBLIT
   512		help
   513		  This is the frame buffer device driver for the Chips & Technologies
   514		  65550 graphics chip in PowerBooks.
   515	
   516	config FB_ASILIANT
   517		bool "Asiliant (Chips) 69000 display support"
   518		depends on (FB = y) && PCI
   519		select FB_CFB_FILLRECT
   520		select FB_CFB_COPYAREA
   521		select FB_CFB_IMAGEBLIT
   522		help
   523		  This is the frame buffer device driver for the Asiliant 69030 chipset
   524	
   525	config FB_IMSTT
   526		bool "IMS Twin Turbo display support"
   527		depends on (FB = y) && PCI
   528		select FB_CFB_IMAGEBLIT
   529		select FB_MACMODES if PPC_PMAC
   530		help
   531		  The IMS Twin Turbo is a PCI-based frame buffer card bundled with
   532		  many Macintosh and compatible computers.
   533	
   534	config FB_VGA16
   535		tristate "VGA 16-color graphics support"
   536		depends on FB && (X86 || PPC)
   537		select FB_CFB_FILLRECT
   538		select FB_CFB_COPYAREA
   539		select FB_CFB_IMAGEBLIT
   540		select VGASTATE
   541		select FONT_8x16 if FRAMEBUFFER_CONSOLE
   542		help
   543		  This is the frame buffer device driver for VGA 16 color graphic
   544		  cards. Say Y if you have such a card.
   545	
   546		  To compile this driver as a module, choose M here: the
   547		  module will be called vga16fb.
   548	
   549	config FB_STI
   550		tristate "HP STI frame buffer device support"
   551		depends on FB && PARISC
   552		select FB_CFB_FILLRECT
   553		select FB_CFB_COPYAREA
   554		select FB_CFB_IMAGEBLIT
   555		default y
   556		help
   557		  STI refers to the HP "Standard Text Interface" which is a set of
   558		  BIOS routines contained in a ROM chip in HP PA-RISC based machines.
   559		  Enabling this option will implement the linux framebuffer device
   560		  using calls to the STI BIOS routines for initialisation.
   561		
   562		  If you enable this option, you will get a planar framebuffer device
   563		  /dev/fb which will work on the most common HP graphic cards of the
   564		  NGLE family, including the artist chips (in the 7xx and Bxxx series),
   565		  HCRX, HCRX24, CRX, CRX24 and VisEG series.
   566	
   567		  It is safe to enable this option, so you should probably say "Y".
   568	
   569	config FB_VISUALIZEFX
   570		tristate "HP Visualize FX support"
   571		depends on FB && PCI && PARISC
   572		select FB_CFB_FILLRECT
   573		select FB_CFB_COPYAREA
   574		select FB_CFB_IMAGEBLIT
   575		select RATIONAL
   576		  help
   577		    Frame buffer driver for the HP Visualize FX cards. These cards are
   578		    commonly found in PA-RISC workstations. Currently only FX5 has been
   579		    tested.
   580	
   581		Say Y if you have such a card.
 > 582	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
