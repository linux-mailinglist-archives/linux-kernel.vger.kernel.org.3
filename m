Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 271F1529897
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 06:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237563AbiEQENV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 00:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237006AbiEQENH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 00:13:07 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B864553B;
        Mon, 16 May 2022 21:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652760786; x=1684296786;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=78wrMaG8jrHoR7fnjuqzN+c2ZFFhMbe9WXVz3O742AI=;
  b=b38FA7Dc1lyolAslD3wthsDK6Rtc3IGDWgG+2cFUrdEkmftzbHCLOo0g
   vJLw43qo+t9KWveLwyaDTDg0VE/nioKRexCl3SloAn5H5Jau2QB+XcwJX
   TIZ7oX9KNU1bSKsU0mcr6FKQtX/E4kVCE/9J4CM9UReFofl+UxjmmR9EE
   YuQYxijXdVItkQmDfxWSMdUqqhXZ15PQ2ybmdFAVE5j7x/DhVTtkXcBB1
   IWuVhOC3j68SXrdxAT9/qBR3gYMVMn7xasJgzA/rELK7nvysAGxps6j+H
   spjzPpdNP+HpdX+MBnyp9XGTDtEtCxnMiBflJ2NPUGMCoVt7HVXeSYg1y
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10349"; a="271174565"
X-IronPort-AV: E=Sophos;i="5.91,231,1647327600"; 
   d="scan'208";a="271174565"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2022 21:13:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,231,1647327600"; 
   d="scan'208";a="626275341"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 16 May 2022 21:13:03 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nqoZz-0000am-7F;
        Tue, 17 May 2022 04:13:03 +0000
Date:   Tue, 17 May 2022 12:12:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>,
        jikos@kernel.org
Cc:     kbuild-all@lists.01.org, benjamin.tissoires@redhat.com,
        spbnick@gmail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, stefanberzl@gmail.com,
        =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
Subject: Re: [PATCH for-5.19/uclogic 4/4] HID: uclogic: Add support for
 XP-PEN Deco L
Message-ID: <202205171208.uAUnAkVJ-lkp@intel.com>
References: <20220516181323.59554-5-jose.exposito89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220516181323.59554-5-jose.exposito89@gmail.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi "José,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on f7d8e387d9aeff963e6691c0166269b8042b4ff9]

url:    https://github.com/intel-lab-lkp/linux/commits/Jos-Exp-sito/Add-support-for-XP-PEN-Deco-L/20220517-021641
base:   f7d8e387d9aeff963e6691c0166269b8042b4ff9
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20220517/202205171208.uAUnAkVJ-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/f117e735d50f52f57bdabb589453959d60ae3ce6
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jos-Exp-sito/Add-support-for-XP-PEN-Deco-L/20220517-021641
        git checkout f117e735d50f52f57bdabb589453959d60ae3ce6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash drivers/hid/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/hid/hid-uclogic-params.c: In function 'uclogic_params_ugee_v2_init':
>> drivers/hid/hid-uclogic-params.c:1078:28: warning: variable 'udev' set but not used [-Wunused-but-set-variable]
    1078 |         struct usb_device *udev;
         |                            ^~~~


vim +/udev +1078 drivers/hid/hid-uclogic-params.c

  1054	
  1055	/**
  1056	 * uclogic_params_ugee_v2_init() - initialize a UGEE graphics tablets by
  1057	 * discovering their parameters.
  1058	 *
  1059	 * These tables, internally designed as v2 to differentiate them from older
  1060	 * models, expect a payload of magic data in orther to be switched to the fully
  1061	 * functional mode and expose their parameters in a similar way to the
  1062	 * information present in uclogic_params_pen_init_v1() but with some
  1063	 * differences.
  1064	 *
  1065	 * @params:	Parameters to fill in (to be cleaned with
  1066	 *		uclogic_params_cleanup()). Not modified in case of error.
  1067	 *		Cannot be NULL.
  1068	 * @hdev:	The HID device of the tablet interface to initialize and get
  1069	 *		parameters from. Cannot be NULL.
  1070	 *
  1071	 * Returns:
  1072	 *	Zero, if successful. A negative errno code on error.
  1073	 */
  1074	static int uclogic_params_ugee_v2_init(struct uclogic_params *params,
  1075					       struct hid_device *hdev)
  1076	{
  1077		int rc = 0;
> 1078		struct usb_device *udev;
  1079		struct usb_interface *iface;
  1080		__u8 bInterfaceNumber;
  1081		const int str_desc_len = 12;
  1082		__u8 *str_desc = NULL;
  1083		__u8 *rdesc_pen = NULL;
  1084		__u8 *rdesc_frame = NULL;
  1085		s32 desc_params[UCLOGIC_RDESC_PH_ID_NUM];
  1086		s32 resolution;
  1087		__u8 magic_arr[] = {
  1088			0x02, 0xb0, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
  1089		};
  1090		/* The resulting parameters (noop) */
  1091		struct uclogic_params p = {0, };
  1092	
  1093		if (!params || !hdev) {
  1094			rc = -EINVAL;
  1095			goto cleanup;
  1096		}
  1097	
  1098		udev = hid_to_usb_dev(hdev);
  1099		iface = to_usb_interface(hdev->dev.parent);
  1100		bInterfaceNumber = iface->cur_altsetting->desc.bInterfaceNumber;
  1101		if (bInterfaceNumber != 2) {
  1102			uclogic_params_init_invalid(&p);
  1103			goto output;
  1104		}
  1105	
  1106		/*
  1107		 * Initialize the interface by sending magic data.
  1108		 * The specific data was discovered by sniffing the Windows driver
  1109		 * traffic.
  1110		 */
  1111		rc = uclogic_probe_interface(hdev, magic_arr, sizeof(magic_arr), 0x03);
  1112		if (rc) {
  1113			uclogic_params_init_invalid(&p);
  1114			goto output;
  1115		}
  1116	
  1117		/*
  1118		 * Read the string descriptor containing pen and frame parameters.
  1119		 * The specific string descriptor and data were discovered by sniffing
  1120		 * the Windows driver traffic.
  1121		 */
  1122		rc = uclogic_params_get_str_desc(&str_desc, hdev, 100, str_desc_len);
  1123		if (rc != str_desc_len) {
  1124			hid_err(hdev, "failed retrieving pen and frame parameters: %d\n", rc);
  1125			uclogic_params_init_invalid(&p);
  1126			goto output;
  1127		}
  1128	
  1129		desc_params[UCLOGIC_RDESC_PEN_PH_ID_X_LM] =
  1130			get_unaligned_le16(str_desc + 2);
  1131		desc_params[UCLOGIC_RDESC_PEN_PH_ID_Y_LM] =
  1132			get_unaligned_le16(str_desc + 4);
  1133		desc_params[UCLOGIC_RDESC_FRAME_PH_ID_UM] = str_desc[6];
  1134		desc_params[UCLOGIC_RDESC_PEN_PH_ID_PRESSURE_LM] =
  1135			get_unaligned_le16(str_desc + 8);
  1136		resolution = get_unaligned_le16(str_desc + 10);
  1137		if (resolution == 0) {
  1138			desc_params[UCLOGIC_RDESC_PEN_PH_ID_X_PM] = 0;
  1139			desc_params[UCLOGIC_RDESC_PEN_PH_ID_Y_PM] = 0;
  1140		} else {
  1141			desc_params[UCLOGIC_RDESC_PEN_PH_ID_X_PM] =
  1142				desc_params[UCLOGIC_RDESC_PEN_PH_ID_X_LM] * 1000 /
  1143				resolution;
  1144			desc_params[UCLOGIC_RDESC_PEN_PH_ID_Y_PM] =
  1145				desc_params[UCLOGIC_RDESC_PEN_PH_ID_Y_LM] * 1000 /
  1146				resolution;
  1147		}
  1148		kfree(str_desc);
  1149		str_desc = NULL;
  1150	
  1151		/* Initialize the pen interface */
  1152		rdesc_pen = uclogic_rdesc_template_apply(
  1153					uclogic_rdesc_ugee_v2_pen_template_arr,
  1154					uclogic_rdesc_ugee_v2_pen_template_size,
  1155					desc_params, ARRAY_SIZE(desc_params));
  1156		if (!rdesc_pen) {
  1157			rc = -ENOMEM;
  1158			goto cleanup;
  1159		}
  1160	
  1161		p.pen.desc_ptr = rdesc_pen;
  1162		p.pen.desc_size = uclogic_rdesc_ugee_v2_pen_template_size;
  1163		p.pen.id = 0x02;
  1164		p.pen.subreport_list[0].value = 0xf0;
  1165		p.pen.subreport_list[0].id = UCLOGIC_RDESC_V1_FRAME_ID;
  1166	
  1167		/* Initialize the frame interface */
  1168		rdesc_frame = uclogic_rdesc_template_apply(
  1169					uclogic_rdesc_ugee_v2_frame_btn_template_arr,
  1170					uclogic_rdesc_ugee_v2_frame_btn_template_size,
  1171					desc_params, ARRAY_SIZE(desc_params));
  1172		if (!rdesc_frame) {
  1173			rc = -ENOMEM;
  1174			goto cleanup;
  1175		}
  1176	
  1177		rc = uclogic_params_frame_init_with_desc(&p.frame_list[0],
  1178							 rdesc_frame,
  1179							 uclogic_rdesc_ugee_v2_frame_btn_template_size,
  1180							 UCLOGIC_RDESC_V1_FRAME_ID);
  1181		kfree(rdesc_frame);
  1182		if (rc) {
  1183			uclogic_params_init_invalid(&p);
  1184			goto output;
  1185		}
  1186	
  1187	output:
  1188		/* Output parameters */
  1189		memcpy(params, &p, sizeof(*params));
  1190		memset(&p, 0, sizeof(p));
  1191		rc = 0;
  1192	cleanup:
  1193		kfree(str_desc);
  1194		uclogic_params_cleanup(&p);
  1195		return rc;
  1196	}
  1197	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
