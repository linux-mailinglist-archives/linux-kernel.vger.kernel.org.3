Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3D7C4C5AD4
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 13:03:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbiB0MEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 07:04:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiB0MEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 07:04:14 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9996613E84
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 04:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645963415; x=1677499415;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Bebz5hgXOhExsQIiHkYpRtmACsvMe0imDjsFr3ri4+E=;
  b=NsdOvW5ZLp13/jOr8i3DLweH4d7NgtQ2r3lV2Hgds6F/6nLcNj9oNrpY
   zP9BXYuLJqsNnnTnZet+yULvuKiT8aW4YynOkX5jW1bXvQG1Hoe8IePim
   b97jLcFjj6fxI+koNoMteZmOpIocGTMH/UeaqvE9H6oQMmDPp6Rpf2IxB
   vwKd/Lzuh2o1TLPv6+ronPxwTkQiiJQV15DJsu/y6ii3GMe8NCUBFilMB
   NEagv4V3oZa7gU4P8hSttqPEFGiobhDN7GkvrYqstMJc1SuWmnsLt0Hyg
   xS1vP9qU/Fr2mqjBFF2RABEEfXaO6VUfgA2lTPNJLN3B8TJMTucn0dzl6
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10270"; a="252458443"
X-IronPort-AV: E=Sophos;i="5.90,141,1643702400"; 
   d="scan'208";a="252458443"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2022 04:03:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,141,1643702400"; 
   d="scan'208";a="638700227"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 27 Feb 2022 04:03:33 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nOIGy-0006V4-N6; Sun, 27 Feb 2022 12:03:32 +0000
Date:   Sun, 27 Feb 2022 20:03:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tomer Tayar <ttayar@habana.ai>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Oded Gabbay <ogabbay@kernel.org>
Subject: [ogabbay:habanalabs-next 49/49]
 drivers/misc/habanalabs/common/device.c:999:25: warning: use of logical '&&'
 with constant operand
Message-ID: <202202271939.kiogjqgT-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git habanalabs-next
head:   1a98edfc49018e5409e22e0fa63371df8275e5ff
commit: 1a98edfc49018e5409e22e0fa63371df8275e5ff [49/49] habanalabs: add an option to delay a device reset
config: riscv-randconfig-r042-20220227 (https://download.01.org/0day-ci/archive/20220227/202202271939.kiogjqgT-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git/commit/?id=1a98edfc49018e5409e22e0fa63371df8275e5ff
        git remote add ogabbay https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git
        git fetch --no-tags ogabbay habanalabs-next
        git checkout 1a98edfc49018e5409e22e0fa63371df8275e5ff
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/misc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/misc/habanalabs/common/device.c:11:
   In file included from drivers/misc/habanalabs/common/habanalabs.h:11:
   In file included from drivers/misc/habanalabs/common/../include/common/cpucp_if.h:12:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:464:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:477:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
                                                     ^
   In file included from drivers/misc/habanalabs/common/device.c:11:
   In file included from drivers/misc/habanalabs/common/habanalabs.h:11:
   In file included from drivers/misc/habanalabs/common/../include/common/cpucp_if.h:12:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:490:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
                                                     ^
   In file included from drivers/misc/habanalabs/common/device.c:11:
   In file included from drivers/misc/habanalabs/common/habanalabs.h:11:
   In file included from drivers/misc/habanalabs/common/../include/common/cpucp_if.h:12:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:501:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:511:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:521:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:1024:55: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
                                                     ~~~~~~~~~~ ^
>> drivers/misc/habanalabs/common/device.c:999:25: warning: use of logical '&&' with constant operand [-Wconstant-logical-operand]
           delay_reset = !!(flags && HL_DRV_RESET_DELAY);
                                  ^  ~~~~~~~~~~~~~~~~~~
   drivers/misc/habanalabs/common/device.c:999:25: note: use '&' for a bitwise operation
           delay_reset = !!(flags && HL_DRV_RESET_DELAY);
                                  ^~
                                  &
   drivers/misc/habanalabs/common/device.c:999:25: note: remove constant to silence this warning
           delay_reset = !!(flags && HL_DRV_RESET_DELAY);
                                 ~^~~~~~~~~~~~~~~~~~~~~
>> drivers/misc/habanalabs/common/device.c:999:28: warning: converting the result of '<<' to a boolean always evaluates to true [-Wtautological-constant-compare]
           delay_reset = !!(flags && HL_DRV_RESET_DELAY);
                                     ^
   drivers/misc/habanalabs/common/habanalabs.h:157:32: note: expanded from macro 'HL_DRV_RESET_DELAY'
   #define HL_DRV_RESET_DELAY              (1 << 7)
                                              ^
   9 warnings generated.


vim +999 drivers/misc/habanalabs/common/device.c

   964	
   965	/*
   966	 * hl_device_reset - reset the device
   967	 *
   968	 * @hdev: pointer to habanalabs device structure
   969	 * @flags: reset flags.
   970	 *
   971	 * Block future CS and wait for pending CS to be enqueued
   972	 * Call ASIC H/W fini
   973	 * Flush all completions
   974	 * Re-initialize all internal data structures
   975	 * Call ASIC H/W init, late_init
   976	 * Test queues
   977	 * Enable device
   978	 *
   979	 * Returns 0 for success or an error on failure.
   980	 */
   981	int hl_device_reset(struct hl_device *hdev, u32 flags)
   982	{
   983		bool hard_reset, from_hard_reset_thread, fw_reset, hard_instead_soft = false,
   984				reset_upon_device_release = false, schedule_hard_reset = false,
   985				skip_wq_flush, delay_reset;
   986		u64 idle_mask[HL_BUSY_ENGINES_MASK_EXT_SIZE] = {0};
   987		struct hl_ctx *ctx;
   988		int i, rc;
   989	
   990		if (!hdev->init_done) {
   991			dev_err(hdev->dev, "Can't reset before initialization is done\n");
   992			return 0;
   993		}
   994	
   995		hard_reset = !!(flags & HL_DRV_RESET_HARD);
   996		from_hard_reset_thread = !!(flags & HL_DRV_RESET_FROM_RESET_THR);
   997		fw_reset = !!(flags & HL_DRV_RESET_BYPASS_REQ_TO_FW);
   998		skip_wq_flush = !!(flags & HL_DRV_RESET_DEV_RELEASE);
 > 999		delay_reset = !!(flags && HL_DRV_RESET_DELAY);
  1000	
  1001		if (!hard_reset && !hdev->asic_prop.supports_soft_reset) {
  1002			hard_instead_soft = true;
  1003			hard_reset = true;
  1004		}
  1005	
  1006		if (hdev->reset_upon_device_release && (flags & HL_DRV_RESET_DEV_RELEASE)) {
  1007			if (hard_reset) {
  1008				dev_crit(hdev->dev,
  1009					"Aborting reset because hard-reset is mutually exclusive with reset-on-device-release\n");
  1010				return -EINVAL;
  1011			}
  1012	
  1013			reset_upon_device_release = true;
  1014	
  1015			goto do_reset;
  1016		}
  1017	
  1018		if (!hard_reset && !hdev->asic_prop.allow_inference_soft_reset) {
  1019			hard_instead_soft = true;
  1020			hard_reset = true;
  1021		}
  1022	
  1023		if (hard_instead_soft)
  1024			dev_dbg(hdev->dev, "Doing hard-reset instead of soft-reset\n");
  1025	
  1026	do_reset:
  1027		/* Re-entry of reset thread */
  1028		if (from_hard_reset_thread && hdev->process_kill_trial_cnt)
  1029			goto kill_processes;
  1030	
  1031		/*
  1032		 * Prevent concurrency in this function - only one reset should be
  1033		 * done at any given time. Only need to perform this if we didn't
  1034		 * get from the dedicated hard reset thread
  1035		 */
  1036		if (!from_hard_reset_thread) {
  1037			/* Block future CS/VM/JOB completion operations */
  1038			spin_lock(&hdev->reset_info.lock);
  1039			if (hdev->reset_info.in_reset) {
  1040				/* We only allow scheduling of a hard reset during soft reset */
  1041				if (hard_reset && hdev->reset_info.is_in_soft_reset)
  1042					hdev->reset_info.hard_reset_schedule_flags = flags;
  1043				spin_unlock(&hdev->reset_info.lock);
  1044				return 0;
  1045			}
  1046			hdev->reset_info.in_reset = 1;
  1047			spin_unlock(&hdev->reset_info.lock);
  1048	
  1049			if (delay_reset)
  1050				usleep_range(HL_RESET_DELAY_USEC, HL_RESET_DELAY_USEC << 1);
  1051	
  1052			handle_reset_trigger(hdev, flags);
  1053	
  1054			/* This still allows the completion of some KDMA ops */
  1055			hdev->reset_info.is_in_soft_reset = !hard_reset;
  1056	
  1057			/* This also blocks future CS/VM/JOB completion operations */
  1058			hdev->disabled = true;
  1059	
  1060			take_release_locks(hdev);
  1061	
  1062			if (hard_reset)
  1063				dev_info(hdev->dev, "Going to reset device\n");
  1064			else if (reset_upon_device_release)
  1065				dev_info(hdev->dev, "Going to reset device after release by user\n");
  1066			else
  1067				dev_info(hdev->dev, "Going to reset engines of inference device\n");
  1068		}
  1069	
  1070	again:
  1071		if ((hard_reset) && (!from_hard_reset_thread)) {
  1072			hdev->reset_info.hard_reset_pending = true;
  1073	
  1074			hdev->process_kill_trial_cnt = 0;
  1075	
  1076			hdev->device_reset_work.flags = flags;
  1077	
  1078			/*
  1079			 * Because the reset function can't run from heartbeat work,
  1080			 * we need to call the reset function from a dedicated work.
  1081			 */
  1082			queue_delayed_work(hdev->device_reset_work.wq,
  1083				&hdev->device_reset_work.reset_work, 0);
  1084	
  1085			return 0;
  1086		}
  1087	
  1088		cleanup_resources(hdev, hard_reset, fw_reset, skip_wq_flush);
  1089	
  1090	kill_processes:
  1091		if (hard_reset) {
  1092			/* Kill processes here after CS rollback. This is because the
  1093			 * process can't really exit until all its CSs are done, which
  1094			 * is what we do in cs rollback
  1095			 */
  1096			rc = device_kill_open_processes(hdev, 0, false);
  1097	
  1098			if (rc == -EBUSY) {
  1099				if (hdev->device_fini_pending) {
  1100					dev_crit(hdev->dev,
  1101						"Failed to kill all open processes, stopping hard reset\n");
  1102					goto out_err;
  1103				}
  1104	
  1105				/* signal reset thread to reschedule */
  1106				return rc;
  1107			}
  1108	
  1109			if (rc) {
  1110				dev_crit(hdev->dev,
  1111					"Failed to kill all open processes, stopping hard reset\n");
  1112				goto out_err;
  1113			}
  1114	
  1115			/* Flush the Event queue workers to make sure no other thread is
  1116			 * reading or writing to registers during the reset
  1117			 */
  1118			flush_workqueue(hdev->eq_wq);
  1119		}
  1120	
  1121		/* Reset the H/W. It will be in idle state after this returns */
  1122		hdev->asic_funcs->hw_fini(hdev, hard_reset, fw_reset);
  1123	
  1124		if (hard_reset) {
  1125			hdev->fw_loader.fw_comp_loaded = FW_TYPE_NONE;
  1126	
  1127			/* Release kernel context */
  1128			if (hdev->kernel_ctx && hl_ctx_put(hdev->kernel_ctx) == 1)
  1129				hdev->kernel_ctx = NULL;
  1130	
  1131			hl_vm_fini(hdev);
  1132			hl_mmu_fini(hdev);
  1133			hl_eq_reset(hdev, &hdev->event_queue);
  1134		}
  1135	
  1136		/* Re-initialize PI,CI to 0 in all queues (hw queue, cq) */
  1137		hl_hw_queue_reset(hdev, hard_reset);
  1138		for (i = 0 ; i < hdev->asic_prop.completion_queues_count ; i++)
  1139			hl_cq_reset(hdev, &hdev->completion_queue[i]);
  1140	
  1141		/* Make sure the context switch phase will run again */
  1142		ctx = hl_get_compute_ctx(hdev);
  1143		if (ctx) {
  1144			atomic_set(&ctx->thread_ctx_switch_token, 1);
  1145			ctx->thread_ctx_switch_wait_token = 0;
  1146			hl_ctx_put(ctx);
  1147		}
  1148	
  1149		/* Finished tear-down, starting to re-initialize */
  1150	
  1151		if (hard_reset) {
  1152			hdev->device_cpu_disabled = false;
  1153			hdev->reset_info.hard_reset_pending = false;
  1154	
  1155			if (hdev->reset_info.reset_trigger_repeated &&
  1156					(hdev->reset_info.prev_reset_trigger ==
  1157							HL_DRV_RESET_FW_FATAL_ERR)) {
  1158				/* if there 2 back to back resets from FW,
  1159				 * ensure driver puts the driver in a unusable state
  1160				 */
  1161				dev_crit(hdev->dev,
  1162					"Consecutive FW fatal errors received, stopping hard reset\n");
  1163				rc = -EIO;
  1164				goto out_err;
  1165			}
  1166	
  1167			if (hdev->kernel_ctx) {
  1168				dev_crit(hdev->dev,
  1169					"kernel ctx was alive during hard reset, something is terribly wrong\n");
  1170				rc = -EBUSY;
  1171				goto out_err;
  1172			}
  1173	
  1174			rc = hl_mmu_init(hdev);
  1175			if (rc) {
  1176				dev_err(hdev->dev,
  1177					"Failed to initialize MMU S/W after hard reset\n");
  1178				goto out_err;
  1179			}
  1180	
  1181			/* Allocate the kernel context */
  1182			hdev->kernel_ctx = kzalloc(sizeof(*hdev->kernel_ctx),
  1183							GFP_KERNEL);
  1184			if (!hdev->kernel_ctx) {
  1185				rc = -ENOMEM;
  1186				hl_mmu_fini(hdev);
  1187				goto out_err;
  1188			}
  1189	
  1190			hdev->is_compute_ctx_active = false;
  1191	
  1192			rc = hl_ctx_init(hdev, hdev->kernel_ctx, true);
  1193			if (rc) {
  1194				dev_err(hdev->dev,
  1195					"failed to init kernel ctx in hard reset\n");
  1196				kfree(hdev->kernel_ctx);
  1197				hdev->kernel_ctx = NULL;
  1198				hl_mmu_fini(hdev);
  1199				goto out_err;
  1200			}
  1201		}
  1202	
  1203		/* Device is now enabled as part of the initialization requires
  1204		 * communication with the device firmware to get information that
  1205		 * is required for the initialization itself
  1206		 */
  1207		hdev->disabled = false;
  1208	
  1209		rc = hdev->asic_funcs->hw_init(hdev);
  1210		if (rc) {
  1211			dev_err(hdev->dev, "failed to initialize the H/W after reset\n");
  1212			goto out_err;
  1213		}
  1214	
  1215		/* If device is not idle fail the reset process */
  1216		if (!hdev->asic_funcs->is_device_idle(hdev, idle_mask,
  1217				HL_BUSY_ENGINES_MASK_EXT_SIZE, NULL)) {
  1218			dev_err(hdev->dev, "device is not idle (mask 0x%llx_%llx) after reset\n",
  1219				idle_mask[1], idle_mask[0]);
  1220			rc = -EIO;
  1221			goto out_err;
  1222		}
  1223	
  1224		/* Check that the communication with the device is working */
  1225		rc = hdev->asic_funcs->test_queues(hdev);
  1226		if (rc) {
  1227			dev_err(hdev->dev, "Failed to detect if device is alive after reset\n");
  1228			goto out_err;
  1229		}
  1230	
  1231		if (hard_reset) {
  1232			rc = device_late_init(hdev);
  1233			if (rc) {
  1234				dev_err(hdev->dev, "Failed late init after hard reset\n");
  1235				goto out_err;
  1236			}
  1237	
  1238			rc = hl_vm_init(hdev);
  1239			if (rc) {
  1240				dev_err(hdev->dev, "Failed to init memory module after hard reset\n");
  1241				goto out_err;
  1242			}
  1243	
  1244			hl_fw_set_max_power(hdev);
  1245		} else {
  1246			rc = hdev->asic_funcs->non_hard_reset_late_init(hdev);
  1247			if (rc) {
  1248				if (reset_upon_device_release)
  1249					dev_err(hdev->dev,
  1250						"Failed late init in reset after device release\n");
  1251				else
  1252					dev_err(hdev->dev, "Failed late init after soft reset\n");
  1253				goto out_err;
  1254			}
  1255		}
  1256	
  1257		spin_lock(&hdev->reset_info.lock);
  1258		hdev->reset_info.is_in_soft_reset = false;
  1259	
  1260		/* Schedule hard reset only if requested and if not already in hard reset.
  1261		 * We keep 'in_reset' enabled, so no other reset can go in during the hard
  1262		 * reset schedule
  1263		 */
  1264		if (!hard_reset && hdev->reset_info.hard_reset_schedule_flags)
  1265			schedule_hard_reset = true;
  1266		else
  1267			hdev->reset_info.in_reset = 0;
  1268	
  1269		spin_unlock(&hdev->reset_info.lock);
  1270	
  1271		hdev->reset_info.needs_reset = false;
  1272	
  1273		dev_notice(hdev->dev, "Successfully finished resetting the device\n");
  1274	
  1275		if (hard_reset) {
  1276			hdev->reset_info.hard_reset_cnt++;
  1277	
  1278			/* After reset is done, we are ready to receive events from
  1279			 * the F/W. We can't do it before because we will ignore events
  1280			 * and if those events are fatal, we won't know about it and
  1281			 * the device will be operational although it shouldn't be
  1282			 */
  1283			hdev->asic_funcs->enable_events_from_fw(hdev);
  1284		} else if (!reset_upon_device_release) {
  1285			hdev->reset_info.soft_reset_cnt++;
  1286		}
  1287	
  1288		if (schedule_hard_reset) {
  1289			dev_info(hdev->dev, "Performing hard reset scheduled during soft reset\n");
  1290			flags = hdev->reset_info.hard_reset_schedule_flags;
  1291			hdev->reset_info.hard_reset_schedule_flags = 0;
  1292			hdev->disabled = true;
  1293			hard_reset = true;
  1294			handle_reset_trigger(hdev, flags);
  1295			goto again;
  1296		}
  1297	
  1298		return 0;
  1299	
  1300	out_err:
  1301		hdev->disabled = true;
  1302		hdev->reset_info.is_in_soft_reset = false;
  1303	
  1304		if (hard_reset) {
  1305			dev_err(hdev->dev, "Failed to reset! Device is NOT usable\n");
  1306			hdev->reset_info.hard_reset_cnt++;
  1307		} else if (reset_upon_device_release) {
  1308			dev_err(hdev->dev, "Failed to reset device after user release\n");
  1309			flags |= HL_DRV_RESET_HARD;
  1310			flags &= ~HL_DRV_RESET_DEV_RELEASE;
  1311			hard_reset = true;
  1312			goto again;
  1313		} else {
  1314			dev_err(hdev->dev, "Failed to do soft-reset\n");
  1315			hdev->reset_info.soft_reset_cnt++;
  1316			flags |= HL_DRV_RESET_HARD;
  1317			hard_reset = true;
  1318			goto again;
  1319		}
  1320	
  1321		hdev->reset_info.in_reset = 0;
  1322	
  1323		return rc;
  1324	}
  1325	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
