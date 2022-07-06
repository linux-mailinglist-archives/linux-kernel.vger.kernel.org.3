Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F004E567EF1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 08:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbiGFGuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 02:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbiGFGuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 02:50:32 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE4F193D0
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 23:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657090231; x=1688626231;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=AbwUZbN44hYJupb+OP0Wy3af7ypx0DOwuTDv059I7xc=;
  b=NgMGEtuuY5mqiZ0v+FKIGjfm1kVuZCI9EjUouE+QC4YI4NCkMdJxXh1p
   A0SnY8CX5AH1YGsYcShumHAdWBt5NM5RjGOHHXLpZQUdswqE3Ki56ZqXs
   6PUoAELAwHPCxDMrhCrCdxjuN8Va14pqCjhwRNIlDaiUCwndpAos4KRUq
   t94/Wyk/8xAas0Q1AR79xyTwiZ75x2yHYSDDYjHzdxDUlumLC1Ir+hMte
   dB9FC1nF/wO+ZTsShJR0i5U/XH4D++Si7ZOrhTOCDKlsC2aG2M3YRpzBj
   Ewv+njzboD8cw3rKZxg7lOZDN6Xf8uBVLFRRD8jc+AdmRhfB/hAF69Ley
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="263449059"
X-IronPort-AV: E=Sophos;i="5.92,249,1650956400"; 
   d="scan'208";a="263449059"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 23:50:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,249,1650956400"; 
   d="scan'208";a="920028283"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 05 Jul 2022 23:50:30 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o8yrl-000KAL-Fn;
        Wed, 06 Jul 2022 06:50:29 +0000
Date:   Wed, 6 Jul 2022 14:49:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [vkoul-soundwire:next 1/6] drivers/soundwire/qcom.c:1312:9: error:
 no member named 'audio_cgcr' in 'struct qcom_swrm_ctrl'
Message-ID: <202207061401.0ckPaFMr-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git next
head:   89ac225d323b8ab0cc4c416316bb1c72e6706917
commit: 37a0ca7e5cdf175a1a820adb3adba904612fed46 [1/6] soundwire: qcom: Add flag for software clock gating check
config: hexagon-randconfig-r012-20220703 (https://download.01.org/0day-ci/archive/20220706/202207061401.0ckPaFMr-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project f553287b588916de09c66e3e32bf75e5060f967f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git/commit/?id=37a0ca7e5cdf175a1a820adb3adba904612fed46
        git remote add vkoul-soundwire https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git
        git fetch --no-tags vkoul-soundwire next
        git checkout 37a0ca7e5cdf175a1a820adb3adba904612fed46
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/soundwire/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/soundwire/qcom.c:1312:9: error: no member named 'audio_cgcr' in 'struct qcom_swrm_ctrl'
                   ctrl->audio_cgcr = devm_reset_control_get_exclusive(dev, "swr_audio_cgcr");
                   ~~~~  ^
>> drivers/soundwire/qcom.c:1312:22: error: call to undeclared function 'devm_reset_control_get_exclusive'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                   ctrl->audio_cgcr = devm_reset_control_get_exclusive(dev, "swr_audio_cgcr");
                                      ^
   drivers/soundwire/qcom.c:1313:28: error: no member named 'audio_cgcr' in 'struct qcom_swrm_ctrl'
                   if (IS_ERR_OR_NULL(ctrl->audio_cgcr)) {
                                      ~~~~  ^
   drivers/soundwire/qcom.c:1315:24: error: no member named 'audio_cgcr' in 'struct qcom_swrm_ctrl'
                           ret = PTR_ERR(ctrl->audio_cgcr);
                                         ~~~~  ^
   4 errors generated.


vim +1312 drivers/soundwire/qcom.c

  1275	
  1276	static int qcom_swrm_probe(struct platform_device *pdev)
  1277	{
  1278		struct device *dev = &pdev->dev;
  1279		struct sdw_master_prop *prop;
  1280		struct sdw_bus_params *params;
  1281		struct qcom_swrm_ctrl *ctrl;
  1282		const struct qcom_swrm_data *data;
  1283		int ret;
  1284		u32 val;
  1285	
  1286		ctrl = devm_kzalloc(dev, sizeof(*ctrl), GFP_KERNEL);
  1287		if (!ctrl)
  1288			return -ENOMEM;
  1289	
  1290		data = of_device_get_match_data(dev);
  1291		ctrl->rows_index = sdw_find_row_index(data->default_rows);
  1292		ctrl->cols_index = sdw_find_col_index(data->default_cols);
  1293	#if IS_REACHABLE(CONFIG_SLIMBUS)
  1294		if (dev->parent->bus == &slimbus_bus) {
  1295	#else
  1296		if (false) {
  1297	#endif
  1298			ctrl->reg_read = qcom_swrm_ahb_reg_read;
  1299			ctrl->reg_write = qcom_swrm_ahb_reg_write;
  1300			ctrl->regmap = dev_get_regmap(dev->parent, NULL);
  1301			if (!ctrl->regmap)
  1302				return -EINVAL;
  1303		} else {
  1304			ctrl->reg_read = qcom_swrm_cpu_reg_read;
  1305			ctrl->reg_write = qcom_swrm_cpu_reg_write;
  1306			ctrl->mmio = devm_platform_ioremap_resource(pdev, 0);
  1307			if (IS_ERR(ctrl->mmio))
  1308				return PTR_ERR(ctrl->mmio);
  1309		}
  1310	
  1311		if (data->sw_clk_gate_required) {
> 1312			ctrl->audio_cgcr = devm_reset_control_get_exclusive(dev, "swr_audio_cgcr");
  1313			if (IS_ERR_OR_NULL(ctrl->audio_cgcr)) {
  1314				dev_err(dev, "Failed to get cgcr reset ctrl required for SW gating\n");
  1315				ret = PTR_ERR(ctrl->audio_cgcr);
  1316				goto err_init;
  1317			}
  1318		}
  1319	
  1320		ctrl->irq = of_irq_get(dev->of_node, 0);
  1321		if (ctrl->irq < 0) {
  1322			ret = ctrl->irq;
  1323			goto err_init;
  1324		}
  1325	
  1326		ctrl->hclk = devm_clk_get(dev, "iface");
  1327		if (IS_ERR(ctrl->hclk)) {
  1328			ret = PTR_ERR(ctrl->hclk);
  1329			goto err_init;
  1330		}
  1331	
  1332		clk_prepare_enable(ctrl->hclk);
  1333	
  1334		ctrl->dev = dev;
  1335		dev_set_drvdata(&pdev->dev, ctrl);
  1336		mutex_init(&ctrl->port_lock);
  1337		init_completion(&ctrl->broadcast);
  1338		init_completion(&ctrl->enumeration);
  1339	
  1340		ctrl->bus.ops = &qcom_swrm_ops;
  1341		ctrl->bus.port_ops = &qcom_swrm_port_ops;
  1342		ctrl->bus.compute_params = &qcom_swrm_compute_params;
  1343		ctrl->bus.clk_stop_timeout = 300;
  1344	
  1345		ret = qcom_swrm_get_port_config(ctrl);
  1346		if (ret)
  1347			goto err_clk;
  1348	
  1349		params = &ctrl->bus.params;
  1350		params->max_dr_freq = DEFAULT_CLK_FREQ;
  1351		params->curr_dr_freq = DEFAULT_CLK_FREQ;
  1352		params->col = data->default_cols;
  1353		params->row = data->default_rows;
  1354		ctrl->reg_read(ctrl, SWRM_MCP_STATUS, &val);
  1355		params->curr_bank = val & SWRM_MCP_STATUS_BANK_NUM_MASK;
  1356		params->next_bank = !params->curr_bank;
  1357	
  1358		prop = &ctrl->bus.prop;
  1359		prop->max_clk_freq = DEFAULT_CLK_FREQ;
  1360		prop->num_clk_gears = 0;
  1361		prop->num_clk_freq = MAX_FREQ_NUM;
  1362		prop->clk_freq = &qcom_swrm_freq_tbl[0];
  1363		prop->default_col = data->default_cols;
  1364		prop->default_row = data->default_rows;
  1365	
  1366		ctrl->reg_read(ctrl, SWRM_COMP_HW_VERSION, &ctrl->version);
  1367	
  1368		ret = devm_request_threaded_irq(dev, ctrl->irq, NULL,
  1369						qcom_swrm_irq_handler,
  1370						IRQF_TRIGGER_RISING |
  1371						IRQF_ONESHOT,
  1372						"soundwire", ctrl);
  1373		if (ret) {
  1374			dev_err(dev, "Failed to request soundwire irq\n");
  1375			goto err_clk;
  1376		}
  1377	
  1378		ctrl->wake_irq = of_irq_get(dev->of_node, 1);
  1379		if (ctrl->wake_irq > 0) {
  1380			ret = devm_request_threaded_irq(dev, ctrl->wake_irq, NULL,
  1381							qcom_swrm_wake_irq_handler,
  1382							IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
  1383							"swr_wake_irq", ctrl);
  1384			if (ret) {
  1385				dev_err(dev, "Failed to request soundwire wake irq\n");
  1386				goto err_init;
  1387			}
  1388		}
  1389	
  1390		ret = sdw_bus_master_add(&ctrl->bus, dev, dev->fwnode);
  1391		if (ret) {
  1392			dev_err(dev, "Failed to register Soundwire controller (%d)\n",
  1393				ret);
  1394			goto err_clk;
  1395		}
  1396	
  1397		qcom_swrm_init(ctrl);
  1398		wait_for_completion_timeout(&ctrl->enumeration,
  1399					    msecs_to_jiffies(TIMEOUT_MS));
  1400		ret = qcom_swrm_register_dais(ctrl);
  1401		if (ret)
  1402			goto err_master_add;
  1403	
  1404		dev_info(dev, "Qualcomm Soundwire controller v%x.%x.%x Registered\n",
  1405			 (ctrl->version >> 24) & 0xff, (ctrl->version >> 16) & 0xff,
  1406			 ctrl->version & 0xffff);
  1407	
  1408		pm_runtime_set_autosuspend_delay(dev, 3000);
  1409		pm_runtime_use_autosuspend(dev);
  1410		pm_runtime_mark_last_busy(dev);
  1411		pm_runtime_set_active(dev);
  1412		pm_runtime_enable(dev);
  1413	
  1414		/* Clk stop is not supported on WSA Soundwire masters */
  1415		if (ctrl->version <= 0x01030000) {
  1416			ctrl->clock_stop_not_supported = true;
  1417		} else {
  1418			ctrl->reg_read(ctrl, SWRM_COMP_MASTER_ID, &val);
  1419			if (val == MASTER_ID_WSA)
  1420				ctrl->clock_stop_not_supported = true;
  1421		}
  1422	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
