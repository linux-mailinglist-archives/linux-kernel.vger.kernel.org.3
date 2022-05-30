Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F239353732B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 02:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbiE3AyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 20:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbiE3AyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 20:54:14 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8513C4D9D1
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 17:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653872052; x=1685408052;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=x5rPnAhvnz76J2i/zujGnWinjxbTDJg2HAqHDLCmf5A=;
  b=Y1M8dscuvlTquY7lAnDCCsqwX1vCXJK12ohFgwzrQinvoBVU+Gjz8oIp
   nVTWJnDKZTItxnI0yMLyHaQWSXWjB3Vqol73WAzTvmPf5FZfGKtk0Feej
   HXqgnxMmEJYIh3Mf52UKnYIKtJRcxMt61EbD74JVTTyVHi0VGAwa2v43u
   EwpbzokoJOpFfWmaDXfKiNJpglo+jFYEDIsVbrmUnrgnfYdJZ+V764g4r
   8AY7Y3Lv2UgmS5YqNOgBiOvQHmYn1uvt9fdgoCDD9ueyyD1vNo6NdgLnG
   tcKff+ERQTOXzxDKJTnPVgTBhaP0Kaygap4a6hufOsYlbrDrVABOUfLZy
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10362"; a="255348332"
X-IronPort-AV: E=Sophos;i="5.91,261,1647327600"; 
   d="scan'208";a="255348332"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2022 17:54:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,261,1647327600"; 
   d="scan'208";a="611227893"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 29 May 2022 17:54:09 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nvTfd-0001LU-7n;
        Mon, 30 May 2022 00:54:09 +0000
Date:   Mon, 30 May 2022 08:53:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, 0day robot <lkp@intel.com>
Subject: drivers/hid/hid-uclogic-rdesc.c:950:2: error: use of undeclared
 identifier 'UCLOGIC_RDESC_FRAME_PH_BTN'
Message-ID: <202205300827.m1U6Pl9L-lkp@intel.com>
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

tree:   https://github.com/intel-lab-lkp/linux/commits/UPDATE-20220530-055140/Jos-Exp-sito/Add-support-for-XP-PEN-Deco-L/20220519-065024
head:   25ca549ae188f6dcbd3ddadebd64f2f6777002f5
commit: 25ca549ae188f6dcbd3ddadebd64f2f6777002f5 HID: uclogic: Add support for XP-PEN Deco L
date:   3 hours ago
config: x86_64-randconfig-a003 (https://download.01.org/0day-ci/archive/20220530/202205300827.m1U6Pl9L-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0fbe3f3f486e01448121f7931a4ca29fac1504ab)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/25ca549ae188f6dcbd3ddadebd64f2f6777002f5
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review UPDATE-20220530-055140/Jos-Exp-sito/Add-support-for-XP-PEN-Deco-L/20220519-065024
        git checkout 25ca549ae188f6dcbd3ddadebd64f2f6777002f5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/hid/hid-uclogic-rdesc.c:950:2: error: use of undeclared identifier 'UCLOGIC_RDESC_FRAME_PH_BTN'
           UCLOGIC_RDESC_FRAME_PH_BTN,
           ^
>> drivers/hid/hid-uclogic-rdesc.c:962:10: error: invalid application of 'sizeof' to an incomplete type 'const __u8[]' (aka 'const unsigned char[]')
                           sizeof(uclogic_rdesc_ugee_v2_frame_btn_template_arr);
                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   2 errors generated.
--
>> drivers/hid/hid-uclogic-params.c:1131:14: error: use of undeclared identifier 'UCLOGIC_RDESC_FRAME_PH_ID_UM'; did you mean 'UCLOGIC_RDESC_PH_ID_NUM'?
           desc_params[UCLOGIC_RDESC_FRAME_PH_ID_UM] = str_desc[6];
                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
                       UCLOGIC_RDESC_PH_ID_NUM
   drivers/hid/hid-uclogic-rdesc.h:99:2: note: 'UCLOGIC_RDESC_PH_ID_NUM' declared here
           UCLOGIC_RDESC_PH_ID_NUM
           ^
   1 error generated.


vim +/UCLOGIC_RDESC_FRAME_PH_BTN +950 drivers/hid/hid-uclogic-rdesc.c

   650	
   651	const size_t uclogic_rdesc_v2_pen_template_size =
   652				sizeof(uclogic_rdesc_v2_pen_template_arr);
   653	
   654	/*
   655	 * Expand to the contents of a generic frame buttons report descriptor.
   656	 *
   657	 * @_id:	The report ID to use.
   658	 * @_size:	Size of the report to pad to, including report ID, bytes.
   659	 */
   660	#define UCLOGIC_RDESC_FRAME_BUTTONS_BYTES(_id, _size) \
   661		0x05, 0x01,     /*  Usage Page (Desktop),               */ \
   662		0x09, 0x07,     /*  Usage (Keypad),                     */ \
   663		0xA1, 0x01,     /*  Collection (Application),           */ \
   664		0x85, (_id),    /*      Report ID (_id),                */ \
   665		0x14,           /*      Logical Minimum (0),            */ \
   666		0x25, 0x01,     /*      Logical Maximum (1),            */ \
   667		0x75, 0x01,     /*      Report Size (1),                */ \
   668		0x05, 0x0D,     /*      Usage Page (Digitizer),         */ \
   669		0x09, 0x39,     /*      Usage (Tablet Function Keys),   */ \
   670		0xA0,           /*      Collection (Physical),          */ \
   671		0x09, 0x44,     /*          Usage (Barrel Switch),      */ \
   672		0x95, 0x01,     /*          Report Count (1),           */ \
   673		0x81, 0x02,     /*          Input (Variable),           */ \
   674		0x05, 0x01,     /*          Usage Page (Desktop),       */ \
   675		0x09, 0x30,     /*          Usage (X),                  */ \
   676		0x09, 0x31,     /*          Usage (Y),                  */ \
   677		0x95, 0x02,     /*          Report Count (2),           */ \
   678		0x81, 0x02,     /*          Input (Variable),           */ \
   679		0x95, 0x15,     /*          Report Count (21),          */ \
   680		0x81, 0x01,     /*          Input (Constant),           */ \
   681		0x05, 0x09,     /*          Usage Page (Button),        */ \
   682		0x19, 0x01,     /*          Usage Minimum (01h),        */ \
   683		0x29, 0x0A,     /*          Usage Maximum (0Ah),        */ \
   684		0x95, 0x0A,     /*          Report Count (10),          */ \
   685		0x81, 0x02,     /*          Input (Variable),           */ \
   686		0xC0,           /*      End Collection,                 */ \
   687		0x05, 0x01,     /*      Usage Page (Desktop),           */ \
   688		0x09, 0x05,     /*      Usage (Gamepad),                */ \
   689		0xA0,           /*      Collection (Physical),          */ \
   690		0x05, 0x09,     /*          Usage Page (Button),        */ \
   691		0x19, 0x01,     /*          Usage Minimum (01h),        */ \
   692		0x29, 0x03,     /*          Usage Maximum (03h),        */ \
   693		0x95, 0x03,     /*          Report Count (3),           */ \
   694		0x81, 0x02,     /*          Input (Variable),           */ \
   695		0x95, ((_size) * 8 - 45),                                  \
   696				/*          Report Count (padding),     */ \
   697		0x81, 0x01,     /*          Input (Constant),           */ \
   698		0xC0,           /*      End Collection,                 */ \
   699		0xC0            /*  End Collection                      */
   700	
   701	/* Fixed report descriptor for (tweaked) v1 frame reports */
   702	const __u8 uclogic_rdesc_v1_frame_arr[] = {
   703		UCLOGIC_RDESC_FRAME_BUTTONS_BYTES(UCLOGIC_RDESC_V1_FRAME_ID, 8)
   704	};
   705	const size_t uclogic_rdesc_v1_frame_size =
   706				sizeof(uclogic_rdesc_v1_frame_arr);
   707	
   708	/* Fixed report descriptor for (tweaked) v2 frame button reports */
   709	const __u8 uclogic_rdesc_v2_frame_buttons_arr[] = {
   710		UCLOGIC_RDESC_FRAME_BUTTONS_BYTES(UCLOGIC_RDESC_V2_FRAME_BUTTONS_ID,
   711						  12)
   712	};
   713	const size_t uclogic_rdesc_v2_frame_buttons_size =
   714				sizeof(uclogic_rdesc_v2_frame_buttons_arr);
   715	
   716	/* Fixed report descriptor for (tweaked) v2 frame touch ring reports */
   717	const __u8 uclogic_rdesc_v2_frame_touch_ring_arr[] = {
   718		0x05, 0x01,         /*  Usage Page (Desktop),               */
   719		0x09, 0x07,         /*  Usage (Keypad),                     */
   720		0xA1, 0x01,         /*  Collection (Application),           */
   721		0x85, UCLOGIC_RDESC_V2_FRAME_TOUCH_ID,
   722				    /*      Report ID (TOUCH_ID),           */
   723		0x14,               /*      Logical Minimum (0),            */
   724		0x05, 0x0D,         /*      Usage Page (Digitizer),         */
   725		0x09, 0x39,         /*      Usage (Tablet Function Keys),   */
   726		0xA0,               /*      Collection (Physical),          */
   727		0x25, 0x01,         /*          Logical Maximum (1),        */
   728		0x75, 0x01,         /*          Report Size (1),            */
   729		0x05, 0x09,         /*          Usage Page (Button),        */
   730		0x09, 0x01,         /*          Usage (01h),                */
   731		0x95, 0x01,         /*          Report Count (1),           */
   732		0x81, 0x02,         /*          Input (Variable),           */
   733		0x95, 0x07,         /*          Report Count (7),           */
   734		0x81, 0x01,         /*          Input (Constant),           */
   735		0x75, 0x08,         /*          Report Size (8),            */
   736		0x95, 0x02,         /*          Report Count (2),           */
   737		0x81, 0x01,         /*          Input (Constant),           */
   738		0x05, 0x0D,         /*          Usage Page (Digitizer),     */
   739		0x0A, 0xFF, 0xFF,   /*          Usage (FFFFh),              */
   740		0x26, 0xFF, 0x00,   /*          Logical Maximum (255),      */
   741		0x95, 0x01,         /*          Report Count (1),           */
   742		0x81, 0x02,         /*          Input (Variable),           */
   743		0x05, 0x01,         /*          Usage Page (Desktop),       */
   744		0x09, 0x38,         /*          Usage (Wheel),              */
   745		0x95, 0x01,         /*          Report Count (1),           */
   746		0x15, 0x00,         /*          Logical Minimum (0),        */
   747		0x25, 0x0B,         /*          Logical Maximum (11),       */
   748		0x81, 0x02,         /*          Input (Variable),           */
   749		0x09, 0x30,         /*          Usage (X),                  */
   750		0x09, 0x31,         /*          Usage (Y),                  */
   751		0x14,               /*          Logical Minimum (0),        */
   752		0x25, 0x01,         /*          Logical Maximum (1),        */
   753		0x75, 0x01,         /*          Report Size (1),            */
   754		0x95, 0x02,         /*          Report Count (2),           */
   755		0x81, 0x02,         /*          Input (Variable),           */
   756		0x95, 0x2E,         /*          Report Count (46),          */
   757		0x81, 0x01,         /*          Input (Constant),           */
   758		0xC0,               /*      End Collection,                 */
   759		0xC0                /*  End Collection                      */
   760	};
   761	const size_t uclogic_rdesc_v2_frame_touch_ring_size =
   762				sizeof(uclogic_rdesc_v2_frame_touch_ring_arr);
   763	
   764	/* Fixed report descriptor for (tweaked) v2 frame touch strip reports */
   765	const __u8 uclogic_rdesc_v2_frame_touch_strip_arr[] = {
   766		0x05, 0x01,         /*  Usage Page (Desktop),               */
   767		0x09, 0x07,         /*  Usage (Keypad),                     */
   768		0xA1, 0x01,         /*  Collection (Application),           */
   769		0x85, UCLOGIC_RDESC_V2_FRAME_TOUCH_ID,
   770				    /*      Report ID (TOUCH_ID),           */
   771		0x14,               /*      Logical Minimum (0),            */
   772		0x05, 0x0D,         /*      Usage Page (Digitizer),         */
   773		0x09, 0x39,         /*      Usage (Tablet Function Keys),   */
   774		0xA0,               /*      Collection (Physical),          */
   775		0x25, 0x01,         /*          Logical Maximum (1),        */
   776		0x75, 0x01,         /*          Report Size (1),            */
   777		0x05, 0x09,         /*          Usage Page (Button),        */
   778		0x09, 0x01,         /*          Usage (01h),                */
   779		0x95, 0x01,         /*          Report Count (1),           */
   780		0x81, 0x02,         /*          Input (Variable),           */
   781		0x95, 0x07,         /*          Report Count (7),           */
   782		0x81, 0x01,         /*          Input (Constant),           */
   783		0x75, 0x08,         /*          Report Size (8),            */
   784		0x95, 0x02,         /*          Report Count (2),           */
   785		0x81, 0x01,         /*          Input (Constant),           */
   786		0x05, 0x0D,         /*          Usage Page (Digitizer),     */
   787		0x0A, 0xFF, 0xFF,   /*          Usage (FFFFh),              */
   788		0x26, 0xFF, 0x00,   /*          Logical Maximum (255),      */
   789		0x95, 0x01,         /*          Report Count (1),           */
   790		0x81, 0x02,         /*          Input (Variable),           */
   791		0x05, 0x01,         /*          Usage Page (Desktop),       */
   792		0x09, 0x38,         /*          Usage (Wheel),              */
   793		0x95, 0x01,         /*          Report Count (1),           */
   794		0x15, 0x00,         /*          Logical Minimum (0),        */
   795		0x25, 0x07,         /*          Logical Maximum (7),        */
   796		0x81, 0x02,         /*          Input (Variable),           */
   797		0x09, 0x30,         /*          Usage (X),                  */
   798		0x09, 0x31,         /*          Usage (Y),                  */
   799		0x14,               /*          Logical Minimum (0),        */
   800		0x25, 0x01,         /*          Logical Maximum (1),        */
   801		0x75, 0x01,         /*          Report Size (1),            */
   802		0x95, 0x02,         /*          Report Count (2),           */
   803		0x81, 0x02,         /*          Input (Variable),           */
   804		0x95, 0x2E,         /*          Report Count (46),          */
   805		0x81, 0x01,         /*          Input (Constant),           */
   806		0xC0,               /*      End Collection,                 */
   807		0xC0                /*  End Collection                      */
   808	};
   809	const size_t uclogic_rdesc_v2_frame_touch_strip_size =
   810				sizeof(uclogic_rdesc_v2_frame_touch_strip_arr);
   811	
   812	/* Fixed report descriptor for (tweaked) v2 frame dial reports */
   813	const __u8 uclogic_rdesc_v2_frame_dial_arr[] = {
   814		0x05, 0x01,         /*  Usage Page (Desktop),               */
   815		0x09, 0x07,         /*  Usage (Keypad),                     */
   816		0xA1, 0x01,         /*  Collection (Application),           */
   817		0x85, UCLOGIC_RDESC_V2_FRAME_DIAL_ID,
   818				    /*      Report ID (DIAL_ID),            */
   819		0x14,               /*      Logical Minimum (0),            */
   820		0x05, 0x0D,         /*      Usage Page (Digitizer),         */
   821		0x09, 0x39,         /*      Usage (Tablet Function Keys),   */
   822		0xA0,               /*      Collection (Physical),          */
   823		0x25, 0x01,         /*          Logical Maximum (1),        */
   824		0x75, 0x01,         /*          Report Size (1),            */
   825		0x95, 0x01,         /*          Report Count (1),           */
   826		0x81, 0x01,         /*          Input (Constant),           */
   827		0x05, 0x09,         /*          Usage Page (Button),        */
   828		0x09, 0x01,         /*          Usage (01h),                */
   829		0x95, 0x01,         /*          Report Count (1),           */
   830		0x81, 0x02,         /*          Input (Variable),           */
   831		0x95, 0x06,         /*          Report Count (6),           */
   832		0x81, 0x01,         /*          Input (Constant),           */
   833		0x75, 0x08,         /*          Report Size (8),            */
   834		0x95, 0x02,         /*          Report Count (2),           */
   835		0x81, 0x01,         /*          Input (Constant),           */
   836		0x05, 0x0D,         /*          Usage Page (Digitizer),     */
   837		0x0A, 0xFF, 0xFF,   /*          Usage (FFFFh),              */
   838		0x26, 0xFF, 0x00,   /*          Logical Maximum (255),      */
   839		0x95, 0x01,         /*          Report Count (1),           */
   840		0x81, 0x02,         /*          Input (Variable),           */
   841		0x05, 0x01,         /*          Usage Page (Desktop),       */
   842		0x09, 0x38,         /*          Usage (Wheel),              */
   843		0x95, 0x01,         /*          Report Count (1),           */
   844		0x15, 0xFF,         /*          Logical Minimum (-1),       */
   845		0x25, 0x01,         /*          Logical Maximum (1),        */
   846		0x81, 0x06,         /*          Input (Variable, Relative), */
   847		0x09, 0x30,         /*          Usage (X),                  */
   848		0x09, 0x31,         /*          Usage (Y),                  */
   849		0x14,               /*          Logical Minimum (0),        */
   850		0x25, 0x01,         /*          Logical Maximum (1),        */
   851		0x75, 0x01,         /*          Report Size (1),            */
   852		0x95, 0x02,         /*          Report Count (2),           */
   853		0x81, 0x02,         /*          Input (Variable),           */
   854		0x95, 0x2E,         /*          Report Count (46),          */
   855		0x81, 0x01,         /*          Input (Constant),           */
   856		0xC0,               /*      End Collection,                 */
   857		0xC0                /*  End Collection                      */
   858	};
   859	const size_t uclogic_rdesc_v2_frame_dial_size =
   860				sizeof(uclogic_rdesc_v2_frame_dial_arr);
   861	
   862	/* Fixed report descriptor template for UGEE v2 pen reports */
   863	const __u8 uclogic_rdesc_ugee_v2_pen_template_arr[] = {
   864		0x05, 0x0d,         /*  Usage Page (Digitizers),                */
   865		0x09, 0x01,         /*  Usage (Digitizer),                      */
   866		0xa1, 0x01,         /*  Collection (Application),               */
   867		0x85, 0x02,         /*      Report ID (2),                      */
   868		0x09, 0x20,         /*      Usage (Stylus),                     */
   869		0xa1, 0x00,         /*      Collection (Physical),              */
   870		0x09, 0x42,         /*          Usage (Tip Switch),             */
   871		0x09, 0x44,         /*          Usage (Barrel Switch),          */
   872		0x09, 0x46,         /*          Usage (Tablet Pick),            */
   873		0x75, 0x01,         /*          Report Size (1),                */
   874		0x95, 0x03,         /*          Report Count (3),               */
   875		0x14,               /*          Logical Minimum (0),            */
   876		0x25, 0x01,         /*          Logical Maximum (1),            */
   877		0x81, 0x02,         /*          Input (Variable),               */
   878		0x95, 0x02,         /*          Report Count (2),               */
   879		0x81, 0x03,         /*          Input (Constant, Variable),     */
   880		0x09, 0x32,         /*          Usage (In Range),               */
   881		0x95, 0x01,         /*          Report Count (1),               */
   882		0x81, 0x02,         /*          Input (Variable),               */
   883		0x95, 0x02,         /*          Report Count (2),               */
   884		0x81, 0x03,         /*          Input (Constant, Variable),     */
   885		0x75, 0x10,         /*          Report Size (16),               */
   886		0x95, 0x01,         /*          Report Count (1),               */
   887		0x35, 0x00,         /*          Physical Minimum (0),           */
   888		0xa4,               /*          Push,                           */
   889		0x05, 0x01,         /*          Usage Page (Desktop),           */
   890		0x09, 0x30,         /*          Usage (X),                      */
   891		0x65, 0x13,         /*          Unit (Inch),                    */
   892		0x55, 0x0d,         /*          Unit Exponent (-3),             */
   893		0x27, UCLOGIC_RDESC_PEN_PH(X_LM),
   894				    /*          Logical Maximum (PLACEHOLDER),  */
   895		0x47, UCLOGIC_RDESC_PEN_PH(X_PM),
   896				    /*          Physical Maximum (PLACEHOLDER), */
   897		0x81, 0x02,         /*          Input (Variable),               */
   898		0x09, 0x31,         /*          Usage (Y),                      */
   899		0x27, UCLOGIC_RDESC_PEN_PH(Y_LM),
   900				    /*          Logical Maximum (PLACEHOLDER),  */
   901		0x47, UCLOGIC_RDESC_PEN_PH(Y_PM),
   902				    /*          Physical Maximum (PLACEHOLDER), */
   903		0x81, 0x02,         /*          Input (Variable),               */
   904		0xb4,               /*          Pop,                            */
   905		0x09, 0x30,         /*          Usage (Tip Pressure),           */
   906		0x45, 0x00,         /*          Physical Maximum (0),           */
   907		0x27, UCLOGIC_RDESC_PEN_PH(PRESSURE_LM),
   908				    /*          Logical Maximum (PLACEHOLDER),  */
   909		0x75, 0x0D,         /*          Report Size (13),               */
   910		0x95, 0x01,         /*          Report Count (1),               */
   911		0x81, 0x02,         /*          Input (Variable),               */
   912		0x75, 0x01,         /*          Report Size (1),                */
   913		0x95, 0x03,         /*          Report Count (3),               */
   914		0x81, 0x01,         /*          Input (Constant),               */
   915		0x09, 0x3d,         /*          Usage (X Tilt),                 */
   916		0x35, 0xC3,         /*          Physical Minimum (-61),         */
   917		0x45, 0x3C,         /*          Physical Maximum (60),          */
   918		0x15, 0xC3,         /*          Logical Minimum (-61),          */
   919		0x25, 0x3C,         /*          Logical Maximum (60),           */
   920		0x75, 0x08,         /*          Report Size (8),                */
   921		0x95, 0x01,         /*          Report Count (1),               */
   922		0x81, 0x02,         /*          Input (Variable),               */
   923		0x09, 0x3e,         /*          Usage (Y Tilt),                 */
   924		0x35, 0xC3,         /*          Physical Minimum (-61),         */
   925		0x45, 0x3C,         /*          Physical Maximum (60),          */
   926		0x15, 0xC3,         /*          Logical Minimum (-61),          */
   927		0x25, 0x3C,         /*          Logical Maximum (60),           */
   928		0x81, 0x02,         /*          Input (Variable),               */
   929		0xc0,               /*      End Collection,                     */
   930		0xc0,               /*  End Collection                          */
   931	};
   932	const size_t uclogic_rdesc_ugee_v2_pen_template_size =
   933				sizeof(uclogic_rdesc_ugee_v2_pen_template_arr);
   934	
   935	/* Fixed report descriptor template for UGEE v2 frame reports (buttons only) */
   936	const __u8 uclogic_rdesc_ugee_v2_frame_btn_template_arr[] = {
   937		0x05, 0x01,         /*  Usage Page (Desktop),                   */
   938		0x09, 0x07,         /*  Usage (Keypad),                         */
   939		0xA1, 0x01,         /*  Collection (Application),               */
   940		0x85, UCLOGIC_RDESC_V1_FRAME_ID,
   941				    /*      Report ID,                          */
   942		0x05, 0x0D,         /*      Usage Page (Digitizer),             */
   943		0x09, 0x39,         /*      Usage (Tablet Function Keys),       */
   944		0xA0,               /*      Collection (Physical),              */
   945		0x75, 0x01,         /*          Report Size (1),                */
   946		0x95, 0x08,         /*          Report Count (8),               */
   947		0x81, 0x01,         /*          Input (Constant),               */
   948		0x05, 0x09,         /*          Usage Page (Button),            */
   949		0x19, 0x01,         /*          Usage Minimum (01h),            */
 > 950		UCLOGIC_RDESC_FRAME_PH_BTN,
   951				    /*          Usage Maximum (PLACEHOLDER),    */
   952		0x95, 0x0A,         /*          Report Count (10),              */
   953		0x14,               /*          Logical Minimum (0),            */
   954		0x25, 0x01,         /*          Logical Maximum (1),            */
   955		0x81, 0x02,         /*          Input (Variable),               */
   956		0x95, 0x46,         /*          Report Count (70),              */
   957		0x81, 0x01,         /*          Input (Constant),               */
   958		0xC0,               /*      End Collection,                     */
   959		0xC0                /*  End Collection                          */
   960	};
   961	const size_t uclogic_rdesc_ugee_v2_frame_btn_template_size =
 > 962				sizeof(uclogic_rdesc_ugee_v2_frame_btn_template_arr);
   963	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
