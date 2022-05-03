Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E808518DA4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 21:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235529AbiECUCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 16:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbiECUCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 16:02:01 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90413FD9C;
        Tue,  3 May 2022 12:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651607907; x=1683143907;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=I1YKrN4zNBmr3LSnE3wscw3PqjskRZqlAis2wuZmCTk=;
  b=g7W2zGz/TuoV88hIXlgRPQziuGOfLPD5dVaeFivNR5yDFqzl9i1+nJjy
   1iBczOC16qes9qOg6rvtEm3hkKHrrDkVAvV1TlUTIv5qo40WdCqTJv8uu
   qkJlNawu5g2T3w6bemxdjOUcmiQu87B2/jq1FBS6TlmWqM67346Cu+QxT
   010l8YXVE76ZdIq9Qlxu9QPSEz069Vk5HiQ48GTh1aLncOwjNXIV1/QnO
   loRvu1H7ykEU5h2iUCrL4iF3bAO62PWswm4yariagLMd/UyDeeqdKOa6h
   eTX8uMqrraWBk0gLvA3j1hZFQqKhJHVKqYkeNH8oprJlargGv/QTnxiwN
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="265162726"
X-IronPort-AV: E=Sophos;i="5.91,196,1647327600"; 
   d="scan'208";a="265162726"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 12:58:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,196,1647327600"; 
   d="scan'208";a="810813952"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 03 May 2022 12:58:23 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nlyf9-000Akj-7Q;
        Tue, 03 May 2022 19:58:23 +0000
Date:   Wed, 4 May 2022 03:57:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>,
        krzysztof.kozlowski+dt@linaro.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        peda@axentia.se
Cc:     kbuild-all@lists.01.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        lee.jones@linaro.org, linux@armlinux.org.uk,
        Manohar.Puri@microchip.com, Kavyasree.Kotagiri@microchip.com,
        UNGLinuxDriver@microchip.com
Subject: Re: [PATCH 4/4] mux: lan966: Add support for flexcom mux controller
Message-ID: <202205040310.pikNhpUq-lkp@intel.com>
References: <20220503105528.12824-5-kavyasree.kotagiri@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220503105528.12824-5-kavyasree.kotagiri@microchip.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kavyasree,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on lee-mfd/for-mfd-next]
[also build test ERROR on robh/for-next]
[cannot apply to soc/for-next linus/master v5.18-rc5 next-20220503]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Kavyasree-Kotagiri/Add-support-for-lan966-flexcom-multiplexer/20220503-190011
base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git for-mfd-next
config: mips-randconfig-r014-20220502 (https://download.01.org/0day-ci/archive/20220504/202205040310.pikNhpUq-lkp@intel.com/config)
compiler: mips64el-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/f8c4bcef1d51c8668507ca53f7cad11e6ace1b2b
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Kavyasree-Kotagiri/Add-support-for-lan966-flexcom-multiplexer/20220503-190011
        git checkout f8c4bcef1d51c8668507ca53f7cad11e6ace1b2b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `drivers/mailbox/mailbox-altera.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `drivers/hwspinlock/hwspinlock_core.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `drivers/remoteproc/remoteproc_core.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `drivers/remoteproc/remoteproc_coredump.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `drivers/remoteproc/remoteproc_debugfs.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `drivers/remoteproc/remoteproc_sysfs.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `drivers/remoteproc/remoteproc_virtio.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `drivers/remoteproc/remoteproc_elf_loader.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `drivers/remoteproc/remoteproc_cdev.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `drivers/soundwire/bus_type.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `drivers/soundwire/bus.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `drivers/soundwire/master.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `drivers/soundwire/slave.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `drivers/soundwire/mipi_disco.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `drivers/soundwire/stream.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `drivers/soundwire/sysfs_slave.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `drivers/soundwire/sysfs_slave_dpn.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `drivers/soundwire/debugfs.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `drivers/devfreq/devfreq.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `drivers/devfreq/devfreq-event.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `drivers/devfreq/governor_simpleondemand.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `drivers/devfreq/governor_powersave.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `drivers/extcon/extcon.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `drivers/extcon/devres.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `drivers/extcon/extcon-gpio.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `drivers/extcon/extcon-usb-gpio.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `drivers/memory/jz4780-nemc.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `drivers/vme/vme.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `drivers/vme/bridges/vme_ca91cx42.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `drivers/vme/boards/vme_vmivme7805.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `drivers/ntb/core.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `drivers/ntb/test/ntb_tool.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `drivers/ntb/ntb_transport.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `drivers/powercap/powercap_sys.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `drivers/powercap/idle_inject.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `drivers/ras/ras.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `drivers/ras/debugfs.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `drivers/hwtracing/intel_th/core.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `drivers/hwtracing/intel_th/msu.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `drivers/hwtracing/intel_th/msu-sink.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `drivers/nvmem/core.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `drivers/interconnect/core.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `drivers/interconnect/bulk.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `drivers/counter/counter-core.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `drivers/counter/counter-sysfs.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `drivers/counter/counter-chrdev.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `drivers/counter/ftm-quaddec.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `sound/sound_core.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `sound/core/sound.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `sound/core/init.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `sound/core/memory.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `sound/core/control.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `sound/core/misc.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `sound/core/device.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `sound/core/info.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `sound/core/info_oss.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `sound/core/isadma.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `sound/core/sound_oss.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `sound/core/ctljack.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `sound/core/jack.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `sound/core/timer.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `sound/core/pcm.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `sound/core/pcm_native.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `sound/core/pcm_lib.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `sound/core/pcm_misc.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `sound/core/pcm_memory.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `sound/core/memalloc.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `sound/core/seq_device.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `sound/core/rawmidi.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `sound/core/seq/seq.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `sound/core/seq/seq_lock.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `sound/core/seq/seq_clientmgr.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `sound/core/seq/seq_memory.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `sound/core/seq/seq_queue.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `sound/core/seq/seq_fifo.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `sound/core/seq/seq_prioq.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `sound/core/seq/seq_timer.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `sound/core/seq/seq_system.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `sound/core/seq/seq_ports.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `sound/core/seq/seq_info.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `sound/core/seq/seq_dummy.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `sound/core/seq/seq_midi.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `sound/core/seq/seq_midi_event.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `sound/drivers/dummy.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `sound/drivers/serial-u16550.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `sound/drivers/mtpav.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `sound/virtio/virtio_card.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `sound/virtio/virtio_chmap.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `sound/virtio/virtio_ctl_msg.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `sound/virtio/virtio_jack.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `sound/virtio/virtio_pcm.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `sound/virtio/virtio_pcm_msg.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `sound/virtio/virtio_pcm_ops.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `sound/last.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `arch/mips/pci/pci.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `arch/mips/pci/pci-legacy.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `arch/mips/pci/fixup-fuloong2e.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `arch/mips/pci/ops-loongson2.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: warning: orphan section `.ctors.65436' from `arch/mips/crypto/poly1305-glue.o' being placed in section `.ctors.65436'
   mips64el-linux-ld: drivers/mfd/atmel-flexcom.o: in function `atmel_flexcom_probe':
>> drivers/mfd/atmel-flexcom.c:97: undefined reference to `devm_mux_control_get'
   mips64el-linux-ld: drivers/mfd/atmel-flexcom.o: in function `mux_control_select':
>> include/linux/mux/consumer.h:34: undefined reference to `mux_control_select_delay'
   mips64el-linux-ld: drivers/mfd/atmel-flexcom.o: in function `atmel_flexcom_probe':
>> drivers/mfd/atmel-flexcom.c:109: undefined reference to `mux_control_deselect'


vim +97 drivers/mfd/atmel-flexcom.c

    41	
    42	static int atmel_flexcom_probe(struct platform_device *pdev)
    43	{
    44		struct device_node *np = pdev->dev.of_node;
    45		const struct atmel_flex_caps *caps;
    46		struct resource *res;
    47		struct atmel_flexcom *ddata;
    48		int err;
    49	
    50		ddata = devm_kzalloc(&pdev->dev, sizeof(*ddata), GFP_KERNEL);
    51		if (!ddata)
    52			return -ENOMEM;
    53	
    54		platform_set_drvdata(pdev, ddata);
    55	
    56		err = of_property_read_u32(np, "atmel,flexcom-mode", &ddata->opmode);
    57		if (err)
    58			return err;
    59	
    60		if (ddata->opmode < ATMEL_FLEXCOM_MODE_USART ||
    61		    ddata->opmode > ATMEL_FLEXCOM_MODE_TWI)
    62			return -EINVAL;
    63	
    64		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
    65		ddata->base = devm_ioremap_resource(&pdev->dev, res);
    66		if (IS_ERR(ddata->base))
    67			return PTR_ERR(ddata->base);
    68	
    69		ddata->clk = devm_clk_get(&pdev->dev, NULL);
    70		if (IS_ERR(ddata->clk))
    71			return PTR_ERR(ddata->clk);
    72	
    73		err = clk_prepare_enable(ddata->clk);
    74		if (err)
    75			return err;
    76	
    77		/*
    78		 * Set the Operating Mode in the Mode Register: only the selected device
    79		 * is clocked. Hence, registers of the other serial devices remain
    80		 * inaccessible and are read as zero. Also the external I/O lines of the
    81		 * Flexcom are muxed to reach the selected device.
    82		 */
    83		writel(FLEX_MR_OPMODE(ddata->opmode), ddata->base + FLEX_MR);
    84	
    85		caps = of_device_get_match_data(&pdev->dev);
    86		if (!caps) {
    87			dev_err(&pdev->dev, "Could not retrieve flexcom caps\n");
    88			return -EINVAL;
    89		}
    90	
    91		/* Flexcom Mux */
    92		if (caps->has_flx_mux && of_property_read_bool(np, "mux-controls")) {
    93			struct mux_control *flx_mux;
    94			struct of_phandle_args args;
    95			int i, count;
    96	
  > 97			flx_mux = devm_mux_control_get(&pdev->dev, NULL);
    98			if (IS_ERR(flx_mux))
    99				return PTR_ERR(flx_mux);
   100	
   101			count = of_property_count_strings(np, "mux-control-names");
   102			for (i = 0; i < count; i++) {
   103				err = of_parse_phandle_with_fixed_args(np, "mux-controls", 1, i, &args);
   104				if (err)
   105					break;
   106	
   107				err = mux_control_select(flx_mux, args.args[0]);
   108				if (!err) {
 > 109					mux_control_deselect(flx_mux);
   110				} else {
   111					dev_err(&pdev->dev, "Failed to select FLEXCOM mux\n");
   112					return err;
   113				}
   114			}
   115		}
   116	
   117		clk_disable_unprepare(ddata->clk);
   118	
   119		return devm_of_platform_populate(&pdev->dev);
   120	}
   121	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
