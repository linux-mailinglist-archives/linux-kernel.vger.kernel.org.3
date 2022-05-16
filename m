Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C09BF528683
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 16:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244340AbiEPOJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 10:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244324AbiEPOJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 10:09:36 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610D03A718
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 07:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652710173; x=1684246173;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=kjm9SpWtykMOly2nPeBu0qcxckOJ5BmlrOF9E2EUamA=;
  b=P5zTt1muWH05HpZBAehhBUQj3IIcbz8PfRiKuas2W7AOV1WHZdfs48HN
   v9rARM/Vp5+6K1vG0+A3LELHrZcUr1/QQRFQPp8r53p/3RVVTPOXCwW2P
   TMwjPFksMX5+Ohi6hj8awYLo6bcftsky04QFS6IOLceSXiq6EBcml4VLG
   Bofz7Ztdbn9R1WxcU2G3c+5g4tze6h01OFODw1URPXcvpndbm/ugtWtAr
   bQhtM8wg/SSJvA/R24GFGV12DZtKm2sLCTkhx9l9ol6d49a5rx3xjylF6
   KBno324rzXuwwgvtmJaZlm7Zum0N/v6JpeO0ubm8hWxu2D7mvrcPY880E
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10348"; a="270789750"
X-IronPort-AV: E=Sophos;i="5.91,230,1647327600"; 
   d="scan'208";a="270789750"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2022 07:09:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,230,1647327600"; 
   d="scan'208";a="699550650"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 16 May 2022 07:09:31 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nqbPe-00004f-H6;
        Mon, 16 May 2022 14:09:30 +0000
Date:   Mon, 16 May 2022 22:09:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [hverkuil-media-tree:extron 2/2]
 drivers/media/cec/usb/extron/extron-cec-drv.c:1096: undefined reference to
 `video_unregister_device'
Message-ID: <202205162242.xeBqRi2Y-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://linuxtv.org/hverkuil/media_tree.git extron
head:   d25c7a9925ea4a748782ad0b1f951716be89d672
commit: d25c7a9925ea4a748782ad0b1f951716be89d672 [2/2] cec/extron: add the Extron CEC driver
config: openrisc-randconfig-r021-20220516 (https://download.01.org/0day-ci/archive/20220516/202205162242.xeBqRi2Y-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add hverkuil-media-tree git://linuxtv.org/hverkuil/media_tree.git
        git fetch --no-tags hverkuil-media-tree extron
        git checkout d25c7a9925ea4a748782ad0b1f951716be89d672
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=openrisc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   or1k-linux-ld: drivers/media/cec/usb/extron/extron-cec-drv.o: in function `extron_disconnect':
>> drivers/media/cec/usb/extron/extron-cec-drv.c:1096: undefined reference to `video_unregister_device'
   drivers/media/cec/usb/extron/extron-cec-drv.c:1096:(.text+0x15c): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `video_unregister_device'
>> or1k-linux-ld: drivers/media/cec/usb/extron/extron-cec-drv.c:1106: undefined reference to `v4l2_ctrl_handler_free'
   drivers/media/cec/usb/extron/extron-cec-drv.c:1106:(.text+0x1b0): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `v4l2_ctrl_handler_free'
   or1k-linux-ld: drivers/media/cec/usb/extron/extron-cec-drv.o: in function `video_drvdata':
>> include/media/v4l2-dev.h:516: undefined reference to `video_devdata'
   include/media/v4l2-dev.h:516:(.text+0x308): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `video_devdata'
>> or1k-linux-ld: include/media/v4l2-dev.h:516: undefined reference to `video_devdata'
   include/media/v4l2-dev.h:516:(.text+0x3a4): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `video_devdata'
>> or1k-linux-ld: include/media/v4l2-dev.h:516: undefined reference to `video_devdata'
   include/media/v4l2-dev.h:516:(.text+0x89c): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `video_devdata'
   or1k-linux-ld: drivers/media/cec/usb/extron/extron-cec-drv.o: in function `extron_enum_input':
>> drivers/media/cec/usb/extron/extron-cec-drv.c:957: undefined reference to `v4l2_ctrl_g_ctrl'
   drivers/media/cec/usb/extron/extron-cec-drv.c:957:(.text+0x8d8): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `v4l2_ctrl_g_ctrl'
   or1k-linux-ld: drivers/media/cec/usb/extron/extron-cec-drv.o: in function `extron_connect':
>> drivers/media/cec/usb/extron/extron-cec-drv.c:1413: undefined reference to `v4l2_device_register'
   drivers/media/cec/usb/extron/extron-cec-drv.c:1413:(.text+0x1e28): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `v4l2_device_register'
>> or1k-linux-ld: drivers/media/cec/usb/extron/extron-cec-drv.c:1436: undefined reference to `v4l2_device_unregister'
   drivers/media/cec/usb/extron/extron-cec-drv.c:1436:(.text+0x1ec4): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `v4l2_device_unregister'
   or1k-linux-ld: drivers/media/cec/usb/extron/extron-cec-drv.o: in function `extron_setup':
>> drivers/media/cec/usb/extron/extron-cec-drv.c:1208: undefined reference to `video_device_release_empty'
>> or1k-linux-ld: drivers/media/cec/usb/extron/extron-cec-drv.c:1208: undefined reference to `video_device_release_empty'
>> or1k-linux-ld: drivers/media/cec/usb/extron/extron-cec-drv.c:1214: undefined reference to `v4l2_ctrl_handler_init_class'
   drivers/media/cec/usb/extron/extron-cec-drv.c:1214:(.text+0x2668): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `v4l2_ctrl_handler_init_class'
>> or1k-linux-ld: drivers/media/cec/usb/extron/extron-cec-drv.c:1222: undefined reference to `v4l2_ctrl_new_std'
   drivers/media/cec/usb/extron/extron-cec-drv.c:1222:(.text+0x26e0): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `v4l2_ctrl_new_std'
   or1k-linux-ld: drivers/media/cec/usb/extron/extron-cec-drv.c:1297: undefined reference to `v4l2_ctrl_handler_free'
   drivers/media/cec/usb/extron/extron-cec-drv.c:1297:(.text+0x27b4): additional relocation overflows omitted from the output
   or1k-linux-ld: drivers/media/cec/usb/extron/extron-cec-drv.c:1233: undefined reference to `v4l2_ctrl_new_std'
   or1k-linux-ld: drivers/media/cec/usb/extron/extron-cec-drv.c:1237: undefined reference to `v4l2_ctrl_new_std'
   or1k-linux-ld: drivers/media/cec/usb/extron/extron-cec-drv.o: in function `v4l2_ctrl_s_ctrl':
>> include/media/v4l2-ctrls.h:1032: undefined reference to `__v4l2_ctrl_s_ctrl'
   or1k-linux-ld: drivers/media/cec/usb/extron/extron-cec-drv.o: in function `video_drvdata':
>> include/media/v4l2-dev.h:516: undefined reference to `video_devdata'
   or1k-linux-ld: drivers/media/cec/usb/extron/extron-cec-drv.o: in function `video_register_device':
>> include/media/v4l2-dev.h:383: undefined reference to `__video_register_device'
   or1k-linux-ld: drivers/media/cec/usb/extron/extron-cec-drv.o: in function `extron_setup_thread':
   drivers/media/cec/usb/extron/extron-cec-drv.c:1374: undefined reference to `video_unregister_device'
>> or1k-linux-ld: drivers/media/cec/usb/extron/extron-cec-drv.c:1384: undefined reference to `video_unregister_device'
   or1k-linux-ld: drivers/media/cec/usb/extron/extron-cec-drv.o: in function `v4l2_ctrl_s_ctrl':
>> include/media/v4l2-ctrls.h:1032: undefined reference to `__v4l2_ctrl_s_ctrl'
>> or1k-linux-ld: include/media/v4l2-ctrls.h:1032: undefined reference to `__v4l2_ctrl_s_ctrl'
>> or1k-linux-ld: include/media/v4l2-ctrls.h:1032: undefined reference to `__v4l2_ctrl_s_ctrl'
   or1k-linux-ld: drivers/media/cec/usb/extron/extron-cec-drv.o: in function `video_drvdata':
>> include/media/v4l2-dev.h:516: undefined reference to `video_devdata'
   or1k-linux-ld: drivers/media/cec/usb/extron/extron-cec-drv.o: in function `extron_s_edid':
   drivers/media/cec/usb/extron/extron-cec-drv.c:1039: undefined reference to `v4l2_set_edid_phys_addr'
   or1k-linux-ld: drivers/media/cec/usb/extron/extron-cec-drv.o:(.rodata+0x348): undefined reference to `v4l2_ctrl_poll'
   or1k-linux-ld: drivers/media/cec/usb/extron/extron-cec-drv.o:(.rodata+0x34c): undefined reference to `video_ioctl2'
   or1k-linux-ld: drivers/media/cec/usb/extron/extron-cec-drv.o:(.rodata+0x358): undefined reference to `v4l2_fh_open'
   or1k-linux-ld: drivers/media/cec/usb/extron/extron-cec-drv.o:(.rodata+0x35c): undefined reference to `v4l2_fh_release'
   or1k-linux-ld: drivers/media/cec/usb/extron/extron-cec-drv.o:(.rodata+0x55c): undefined reference to `v4l2_ctrl_subscribe_event'
   or1k-linux-ld: drivers/media/cec/usb/extron/extron-cec-drv.o:(.rodata+0x560): undefined reference to `v4l2_event_unsubscribe'


vim +1096 drivers/media/cec/usb/extron/extron-cec-drv.c

   948	
   949	static int extron_enum_input(struct file *file, void *priv, struct v4l2_input *inp)
   950	{
   951		struct extron_port *port = video_drvdata(file);
   952	
   953		if (inp->index)
   954			return -EINVAL;
   955		inp->type = V4L2_INPUT_TYPE_CAMERA;
   956		snprintf(inp->name, sizeof(inp->name), "HDMI IN %u", port->port.port);
 > 957		inp->status = v4l2_ctrl_g_ctrl(port->ctrl_rx_power_present) ?
   958			0 : V4L2_IN_ST_NO_SIGNAL;
   959		return 0;
   960	}
   961	
   962	static int extron_g_input(struct file *file, void *priv, unsigned int *i)
   963	{
   964		*i = 0;
   965		return 0;
   966	}
   967	
   968	static int extron_s_input(struct file *file, void *priv, unsigned int i)
   969	{
   970		return i ? -EINVAL : 0;
   971	}
   972	
   973	static int extron_enum_output(struct file *file, void *priv, struct v4l2_output *out)
   974	{
   975		struct extron_port *port = video_drvdata(file);
   976	
   977		if (out->index)
   978			return -EINVAL;
   979		out->type = V4L2_OUTPUT_TYPE_ANALOG;
   980		snprintf(out->name, sizeof(out->name), "HDMI OUT %u", port->port.port);
   981		return 0;
   982	}
   983	
   984	static int extron_g_output(struct file *file, void *priv, unsigned int *o)
   985	{
   986		*o = 0;
   987		return 0;
   988	}
   989	
   990	static int extron_s_output(struct file *file, void *priv, unsigned int o)
   991	{
   992		return o ? -EINVAL : 0;
   993	}
   994	
   995	static int extron_g_edid(struct file *file, void *_fh,
   996				 struct v4l2_edid *edid)
   997	{
   998		struct extron_port *port = video_drvdata(file);
   999	
  1000		memset(edid->reserved, 0, sizeof(edid->reserved));
  1001		if (edid->pad)
  1002			return -EINVAL;
  1003		if (!port->has_edid)
  1004			return -ENODATA;
  1005		if (!port->read_edid)
  1006			extron_read_edid(port);
  1007		if (!port->read_edid)
  1008			return -ENODATA;
  1009		if (edid->start_block == 0 && edid->blocks == 0) {
  1010			edid->blocks = port->edid_blocks;
  1011			return 0;
  1012		}
  1013		if (edid->start_block >= port->edid_blocks)
  1014			return -EINVAL;
  1015		if (edid->blocks > port->edid_blocks - edid->start_block)
  1016			edid->blocks = port->edid_blocks - edid->start_block;
  1017		memcpy(edid->edid, port->edid + edid->start_block * 128, edid->blocks * 128);
  1018		return 0;
  1019	}
  1020	
  1021	static int extron_s_edid(struct file *file, void *_fh, struct v4l2_edid *edid)
  1022	{
  1023		struct extron_port *port = video_drvdata(file);
  1024	
  1025		memset(edid->reserved, 0, sizeof(edid->reserved));
  1026		if (edid->pad)
  1027			return -EINVAL;
  1028	
  1029		/* Unfortunately it is not possible to clear the EDID */
  1030		if (edid->blocks == 0)
  1031			return -EINVAL;
  1032	
  1033		if (edid->blocks > MAX_EDID_BLOCKS) {
  1034			edid->blocks = MAX_EDID_BLOCKS;
  1035			return -E2BIG;
  1036		}
  1037	
  1038		if (cec_get_edid_spa_location(edid->edid, edid->blocks * 128))
> 1039			v4l2_set_edid_phys_addr(edid->edid, edid->blocks * 128, 0);
  1040		return extron_write_edid(port, edid->edid, edid->blocks);
  1041	}
  1042	
  1043	static const struct v4l2_ioctl_ops extron_ioctl_ops = {
  1044		.vidioc_querycap		= extron_querycap,
  1045		.vidioc_enum_input		= extron_enum_input,
  1046		.vidioc_g_input			= extron_g_input,
  1047		.vidioc_s_input			= extron_s_input,
  1048		.vidioc_enum_output		= extron_enum_output,
  1049		.vidioc_g_output		= extron_g_output,
  1050		.vidioc_s_output		= extron_s_output,
  1051		.vidioc_g_edid			= extron_g_edid,
  1052		.vidioc_s_edid			= extron_s_edid,
  1053		.vidioc_subscribe_event		= v4l2_ctrl_subscribe_event,
  1054		.vidioc_unsubscribe_event	= v4l2_event_unsubscribe,
  1055	};
  1056	
  1057	static const struct v4l2_file_operations extron_fops = {
  1058		.owner		= THIS_MODULE,
  1059		.open		= v4l2_fh_open,
  1060		.release	= v4l2_fh_release,
  1061		.poll		= v4l2_ctrl_poll,
  1062		.unlocked_ioctl	= video_ioctl2,
  1063	};
  1064	
  1065	static const struct video_device extron_videodev = {
  1066		.name		= "extron-cec",
  1067		.vfl_dir	= VFL_DIR_RX,
  1068		.fops		= &extron_fops,
  1069		.ioctl_ops	= &extron_ioctl_ops,
  1070		.minor		= -1,
  1071		.release	= video_device_release_empty,
  1072	};
  1073	
  1074	static void extron_disconnect(struct serio *serio)
  1075	{
  1076		struct extron *extron = serio_get_drvdata(serio);
  1077		unsigned int p;
  1078	
  1079		kthread_stop(extron->kthread_setup);
  1080	
  1081		for (p = 0; p < extron->num_ports; p++) {
  1082			struct extron_port *port = extron->ports[p];
  1083	
  1084			if (!port)
  1085				continue;
  1086			port->disconnected = true;
  1087			cancel_work_sync(&port->irq_work);
  1088		}
  1089		cancel_delayed_work_sync(&extron->work_update_edid);
  1090		for (p = 0; p < extron->num_ports; p++) {
  1091			struct extron_port *port = extron->ports[p];
  1092	
  1093			if (!port)
  1094				continue;
  1095			cec_unregister_adapter(port->adap);
> 1096			video_unregister_device(&port->vdev);
  1097		}
  1098	
  1099		complete(&extron->edid_completion);
  1100	
  1101		for (p = 0; p < extron->num_ports; p++) {
  1102			struct extron_port *port = extron->ports[p];
  1103	
  1104			if (!port)
  1105				continue;
> 1106			v4l2_ctrl_handler_free(&port->hdl);
  1107			mutex_destroy(&port->video_lock);
  1108			kfree(port);
  1109		}
  1110		mutex_destroy(&extron->edid_lock);
  1111		mutex_destroy(&extron->serio_lock);
  1112		extron->serio = NULL;
  1113		serio_set_drvdata(serio, NULL);
  1114		serio_close(serio);
  1115	}
  1116	
  1117	static int extron_setup(struct extron *extron)
  1118	{
  1119		struct serio *serio = extron->serio;
  1120		struct extron_port *port;
  1121		u8 *data = extron->data;
  1122		unsigned int p;
  1123		int err;
  1124	
  1125		/* Obtain unit part number */
  1126		err = extron_send_and_wait(extron, NULL, "N", "Pno");
  1127		if (err)
  1128			return err;
  1129		dev_info(extron->dev, "Unit part number: %s\n", data + 3);
  1130		if (strcmp(data + 3, "60-1607-01") &&
  1131		    strcmp(data + 3, "60-1608-01") &&
  1132		    strcmp(data + 3, "60-1609-01")) {
  1133			dev_err(extron->dev, "Unsupported model\n");
  1134			return -ENODEV;
  1135		}
  1136		/* Up to 6 output ports and one input port */
  1137		extron->num_out_ports = 2 * (data[9] - '6');
  1138		extron->splitter.num_out_ports = extron->num_out_ports;
  1139		extron->splitter.ports = extron->splitter_ports;
  1140		extron->splitter.dev = extron->dev;
  1141		extron->num_in_ports = 1;
  1142		extron->num_ports = extron->num_out_ports + extron->num_in_ports;
  1143		dev_info(extron->dev, "Unit output ports: %d\n", extron->num_out_ports);
  1144		dev_info(extron->dev, "Unit input ports: %d\n", extron->num_in_ports);
  1145	
  1146		err = extron_send_and_wait(extron, NULL, "W CN", "Ipn ");
  1147		if (err)
  1148			return err;
  1149		dev_info(extron->dev, "Unit name: %s\n", data + 4);
  1150	
  1151		err = extron_send_and_wait(extron, NULL, "Q", "Ver");
  1152		if (err)
  1153			return err;
  1154		dev_info(extron->dev, "Unit FW Version: %s\n", data + 6);
  1155	
  1156		err = extron_send_and_wait(extron, NULL, "2i", "Inf02*");
  1157		if (err)
  1158			return err;
  1159		dev_info(extron->dev, "Unit Type: %s\n", data + 6);
  1160	
  1161		err = extron_send_and_wait(extron, NULL, "39Q", "Ver39*");
  1162		if (err)
  1163			return err;
  1164		dev_info(extron->dev, "CEC Engine Version: %s\n", data + 6);
  1165	
  1166		/* Pull input port HPD low if all output ports also have a low HPD */
  1167		err = extron_send_and_wait(extron, NULL, "W1ihpd", "HplgI");
  1168		if (err)
  1169			return err;
  1170	
  1171		/* Disable CEC */
  1172		err = extron_send_and_wait(extron, NULL, "WI1*0CCEC", "CcecI1*");
  1173		if (err)
  1174			return err;
  1175		err = extron_send_and_wait(extron, NULL, "WO0*CCEC", "CcecO0");
  1176		if (err)
  1177			return err;
  1178	
  1179		for (p = 0; p < extron->num_ports; p++) {
  1180			u32 caps = CEC_CAP_DEFAULTS | CEC_CAP_MONITOR_ALL;
  1181	
  1182			if (vendor_id)
  1183				caps &= ~CEC_CAP_LOG_ADDRS;
  1184			port = kzalloc(sizeof(*port), GFP_KERNEL);
  1185			if (!port) {
  1186				err = -ENOMEM;
  1187				goto free_ports;
  1188			}
  1189			INIT_WORK(&port->irq_work, extron_irq_work_handler);
  1190			spin_lock_init(&port->msg_lock);
  1191			port->extron = extron;
  1192			port->is_input = p >= extron->num_out_ports;
  1193			port->direction = port->is_input ? 'I' : 'O';
  1194			port->port.port = 1 + (port->is_input ? p - extron->num_out_ports : p);
  1195			port->port.splitter = &extron->splitter;
  1196			port->phys_addr = CEC_PHYS_ADDR_INVALID;
  1197			snprintf(port->name, sizeof(port->name), "%s-%s-%u",
  1198				 dev_name(&serio->dev), port->is_input ? "in" : "out",
  1199				 port->port.port);
  1200	
  1201			port->dev = extron->dev;
  1202			port->adap = cec_allocate_adapter(&extron_cec_adap_ops, port,
  1203							  port->name, caps, 1);
  1204	
  1205			port->adap->xfer_timeout_ms = 6000;
  1206			port->port.adap = port->adap;
  1207			mutex_init(&port->video_lock);
> 1208			port->vdev = extron_videodev;
  1209			port->vdev.lock = &port->video_lock;
  1210			port->vdev.v4l2_dev = &extron->v4l2_dev;
  1211			port->vdev.ctrl_handler = &port->hdl;
  1212			video_set_drvdata(&port->vdev, port);
  1213	
> 1214			v4l2_ctrl_handler_init(&port->hdl, 2);
  1215	
  1216			if (port->is_input) {
  1217				port->vdev.vfl_dir = VFL_DIR_RX;
  1218				v4l2_disable_ioctl(&port->vdev, VIDIOC_ENUMOUTPUT);
  1219				v4l2_disable_ioctl(&port->vdev, VIDIOC_G_OUTPUT);
  1220				v4l2_disable_ioctl(&port->vdev, VIDIOC_S_OUTPUT);
  1221				port->ctrl_rx_power_present =
> 1222					v4l2_ctrl_new_std(&port->hdl, NULL,
  1223							  V4L2_CID_DV_RX_POWER_PRESENT,
  1224							  0, 1, 0, 0);
  1225				port->has_edid = true;
  1226			} else {
  1227				port->vdev.vfl_dir = VFL_DIR_TX;
  1228				v4l2_disable_ioctl(&port->vdev, VIDIOC_ENUMINPUT);
  1229				v4l2_disable_ioctl(&port->vdev, VIDIOC_G_INPUT);
  1230				v4l2_disable_ioctl(&port->vdev, VIDIOC_S_INPUT);
  1231				v4l2_disable_ioctl(&port->vdev, VIDIOC_S_EDID);
  1232				port->ctrl_tx_hotplug =
  1233					v4l2_ctrl_new_std(&port->hdl, NULL,
  1234							  V4L2_CID_DV_TX_HOTPLUG,
  1235							  0, 1, 0, 0);
  1236				port->ctrl_tx_edid_present =
  1237					v4l2_ctrl_new_std(&port->hdl, NULL,
  1238							  V4L2_CID_DV_TX_EDID_PRESENT,
  1239							  0, 1, 0, 0);
  1240			}
  1241	
  1242			extron->ports[p] = port;
  1243			extron->splitter_ports[p] = &port->port;
  1244			err = PTR_ERR_OR_ZERO(port->adap);
  1245			if (err < 0)
  1246				goto free_ports;
  1247			err = port->hdl.error;
  1248			if (err < 0)
  1249				goto free_ports;
  1250		}
  1251	
  1252		/* Enable CEC (manual mode, i.e. controlled by the driver) */
  1253		err = extron_send_and_wait(extron, NULL, "WI1*20CCEC", "CcecI1*");
  1254		if (err)
  1255			goto free_ports;
  1256	
  1257		err = extron_send_and_wait(extron, NULL, "WO20*CCEC", "CcecO20");
  1258		if (err)
  1259			goto free_ports;
  1260	
  1261		/* Set logical addresses to 15 */
  1262		err = extron_send_and_wait(extron, NULL, "WI1*15LCEC", "LcecI1*15");
  1263		if (err)
  1264			goto free_ports;
  1265	
  1266		for (p = 0; p < extron->num_out_ports; p++) {
  1267			char cmd[16];
  1268			char resp[16];
  1269	
  1270			snprintf(cmd, sizeof(cmd), "WO%u*15LCEC", p + 1);
  1271			snprintf(resp, sizeof(resp), "LcecO%u*15", p + 1);
  1272			err = extron_send_and_wait(extron, extron->ports[p], cmd, resp);
  1273			if (err)
  1274				goto free_ports;
  1275		}
  1276	
  1277		/* Query HDCP and Signal states, used to update the initial state */
  1278		err = extron_send_and_wait(extron, NULL, "WHDCP", "Hdcp");
  1279		if (err)
  1280			goto free_ports;
  1281	
  1282		err = extron_send_and_wait(extron, NULL, "WLS", "Sig");
  1283		if (err)
  1284			goto free_ports;
  1285	
  1286		return 0;
  1287	
  1288	free_ports:
  1289		while (p--) {
  1290			struct extron_port *port = extron->ports[p];
  1291	
  1292			if (!port)
  1293				continue;
  1294			port->disconnected = true;
  1295			cancel_work_sync(&port->irq_work);
  1296			cec_delete_adapter(port->adap);
  1297			v4l2_ctrl_handler_free(&port->hdl);
  1298			mutex_destroy(&port->video_lock);
  1299			extron->ports[p] = NULL;
  1300			kfree(port);
  1301		}
  1302		extron->num_ports = extron->num_in_ports = extron->num_out_ports = 0;
  1303		return err;
  1304	}
  1305	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
