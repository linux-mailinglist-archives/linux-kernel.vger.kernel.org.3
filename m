Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44B0A4E2481
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 11:40:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346427AbiCUKmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 06:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346420AbiCUKmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 06:42:02 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527EC1427DD;
        Mon, 21 Mar 2022 03:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647859236; x=1679395236;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9OjrZFNqm4ZxIsJx1m6bExELNQREp//INti7BcHSqOM=;
  b=Uul91ffUxFP4R18KdtOTlwT1722GmR5VJavor7F9Pd9f2RooTgElP396
   utdIqa2mFgnpVg8qFAhPIxYVcvtHCyFRMA7HVKHh4r8slVwlTD2/aT8PM
   22dFvzom0hKju7vdmvrFr3+SBYmz3QeVcSSrrrs/0Q+A9UQH+EUAE33Wk
   TbbgstwiZoAFx+52BYAV0PbbKgyeiR4TxIrNTo0oGpGEPp8EXkulszsyv
   MpKEEUxz8ANvBXvCi/fvLFWj/5kwDiCTw0RzadUhhPVDHzAageSRyZ+iV
   UGUh1f2eYHvQurfVOOw/ReVl73VBpZ896UNQGOWR5HCWjyBade5M8N+Hf
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10292"; a="237463550"
X-IronPort-AV: E=Sophos;i="5.90,198,1643702400"; 
   d="scan'208";a="237463550"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 03:40:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,198,1643702400"; 
   d="scan'208";a="582823444"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 21 Mar 2022 03:40:33 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nWFSi-000Hj2-CI; Mon, 21 Mar 2022 10:40:32 +0000
Date:   Mon, 21 Mar 2022 18:40:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Subject: [mchehab-experimental:master 131/324] dtbs_check:
 arch/arm/boot/dts/mt2701-evb.dt.yaml: jpegdec@15004000: 'mediatek,larb' does
 not match any of the regexes: 'pinctrl-[0-9]+'
Message-ID: <202203211844.tkcFwWd9-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.linuxtv.org/mchehab/experimental.git master
head:   71e6d0608e4d1b79069990c7dacb3600ced28a3b
commit: 6d0990e6e844cfa045b1a7348f58964caceb4de4 [131/324] media: dt-binding: mediatek: Get rid of mediatek,larb for multimedia HW
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce: make ARCH=arm dtbs_check

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


dtcheck warnings: (new ones prefixed by >>)
   arch/arm/boot/dts/mt2701-evb.dt.yaml: spi@11014000: 'oneOf' conditional failed, one must be fixed:
   	'interrupts' is a required property
   	'interrupts-extended' is a required property
   	From schema: Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml
   arch/arm/boot/dts/mt2701-evb.dt.yaml:0:0: /spi@11016000: failed to match any schema with compatible: ['mediatek,mt2701-spi']
   arch/arm/boot/dts/mt2701-evb.dt.yaml:0:0: /spi@11017000: failed to match any schema with compatible: ['mediatek,mt2701-spi']
   arch/arm/boot/dts/mt2701-evb.dt.yaml:0:0: /clock-controller@11220000: failed to match any schema with compatible: ['mediatek,mt2701-audsys', 'syscon']
   arch/arm/boot/dts/mt2701-evb.dt.yaml:0:0: /clock-controller@11220000/audio-controller: failed to match any schema with compatible: ['mediatek,mt2701-audio']
   arch/arm/boot/dts/mt2701-evb.dt.yaml:0:0: /pwm@1400a000: failed to match any schema with compatible: ['mediatek,mt2701-disp-pwm']
   arch/arm/boot/dts/mt2701-evb.dt.yaml:0:0: /syscon@15000000: failed to match any schema with compatible: ['mediatek,mt2701-imgsys', 'syscon']
>> arch/arm/boot/dts/mt2701-evb.dt.yaml: jpegdec@15004000: 'mediatek,larb' does not match any of the regexes: 'pinctrl-[0-9]+'
   	From schema: Documentation/devicetree/bindings/media/mediatek-jpeg-decoder.yaml
>> arch/arm/boot/dts/mt2701-evb.dt.yaml: jpegenc@1500a000: 'mediatek,larb' does not match any of the regexes: 'pinctrl-[0-9]+'
   	From schema: Documentation/devicetree/bindings/media/mediatek-jpeg-encoder.yaml
   arch/arm/boot/dts/mt2701-evb.dt.yaml:0:0: /syscon@16000000: failed to match any schema with compatible: ['mediatek,mt2701-vdecsys', 'syscon']
   arch/arm/boot/dts/mt2701-evb.dt.yaml:0:0: /syscon@1a000000: failed to match any schema with compatible: ['mediatek,mt2701-hifsys', 'syscon']
   arch/arm/boot/dts/mt2701-evb.dt.yaml:0:0: /syscon@1b000000: failed to match any schema with compatible: ['mediatek,mt2701-ethsys', 'syscon']
   arch/arm/boot/dts/mt2701-evb.dt.yaml:0:0: /ethernet@1b100000: failed to match any schema with compatible: ['mediatek,mt2701-eth', 'syscon']
   arch/arm/boot/dts/mt2701-evb.dt.yaml:0:0: /syscon@1c000000: failed to match any schema with compatible: ['mediatek,mt2701-bdpsys', 'syscon']
   arch/arm/boot/dts/mt2701-evb.dt.yaml:0:0: /sound: failed to match any schema with compatible: ['mediatek,mt2701-cs42448-machine']
   arch/arm/boot/dts/mt2701-evb.dt.yaml: bt_sco_codec: '#sound-dai-cells' is a required property
   	From schema: Documentation/devicetree/bindings/sound/linux,bt-sco.yaml
   arch/arm/boot/dts/mt2701-evb.dt.yaml: backlight_lcd: 'power-supply' is a required property
--
   arch/arm/boot/dts/mt7623n-rfb-emmc.dt.yaml:0:0: /ethernet@1b100000/mac@0: failed to match any schema with compatible: ['mediatek,eth-mac']
   arch/arm/boot/dts/mt7623n-rfb-emmc.dt.yaml:0:0: /ethernet@1b100000/mac@1: failed to match any schema with compatible: ['mediatek,eth-mac']
   arch/arm/boot/dts/mt7623n-rfb-emmc.dt.yaml:0:0: /ethernet@1b100000/mdio-bus/switch@0: failed to match any schema with compatible: ['mediatek,mt7530']
   arch/arm/boot/dts/mt7623n-rfb-emmc.dt.yaml:0:0: /crypto@1b240000: failed to match any schema with compatible: ['mediatek,eip97-crypto']
   arch/arm/boot/dts/mt7623n-rfb-emmc.dt.yaml:0:0: /syscon@1c000000: failed to match any schema with compatible: ['mediatek,mt7623-bdpsys', 'mediatek,mt2701-bdpsys', 'syscon']
   arch/arm/boot/dts/mt7623n-rfb-emmc.dt.yaml:0:0: /syscon@1c000000: failed to match any schema with compatible: ['mediatek,mt7623-bdpsys', 'mediatek,mt2701-bdpsys', 'syscon']
   arch/arm/boot/dts/mt7623n-rfb-emmc.dt.yaml:0:0: /syscon@13000000: failed to match any schema with compatible: ['mediatek,mt7623-g3dsys', 'mediatek,mt2701-g3dsys', 'syscon']
   arch/arm/boot/dts/mt7623n-rfb-emmc.dt.yaml:0:0: /syscon@13000000: failed to match any schema with compatible: ['mediatek,mt7623-g3dsys', 'mediatek,mt2701-g3dsys', 'syscon']
   arch/arm/boot/dts/mt7623n-rfb-emmc.dt.yaml:0:0: /syscon@15000000: failed to match any schema with compatible: ['mediatek,mt7623-imgsys', 'mediatek,mt2701-imgsys', 'syscon']
   arch/arm/boot/dts/mt7623n-rfb-emmc.dt.yaml:0:0: /syscon@15000000: failed to match any schema with compatible: ['mediatek,mt7623-imgsys', 'mediatek,mt2701-imgsys', 'syscon']
>> arch/arm/boot/dts/mt7623n-rfb-emmc.dt.yaml: jpegdec@15004000: 'mediatek,larb' does not match any of the regexes: 'pinctrl-[0-9]+'
   	From schema: Documentation/devicetree/bindings/media/mediatek-jpeg-decoder.yaml
   arch/arm/boot/dts/mt7623n-rfb-emmc.dt.yaml: smi@1000c000: clock-names: ['apb', 'smi', 'async'] is too long
   	From schema: Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
   arch/arm/boot/dts/mt7623n-rfb-emmc.dt.yaml:0:0: /ovl@14007000: failed to match any schema with compatible: ['mediatek,mt7623-disp-ovl', 'mediatek,mt2701-disp-ovl']
   arch/arm/boot/dts/mt7623n-rfb-emmc.dt.yaml:0:0: /ovl@14007000: failed to match any schema with compatible: ['mediatek,mt7623-disp-ovl', 'mediatek,mt2701-disp-ovl']
   arch/arm/boot/dts/mt7623n-rfb-emmc.dt.yaml:0:0: /rdma@14008000: failed to match any schema with compatible: ['mediatek,mt7623-disp-rdma', 'mediatek,mt2701-disp-rdma']
   arch/arm/boot/dts/mt7623n-rfb-emmc.dt.yaml:0:0: /rdma@14008000: failed to match any schema with compatible: ['mediatek,mt7623-disp-rdma', 'mediatek,mt2701-disp-rdma']
   arch/arm/boot/dts/mt7623n-rfb-emmc.dt.yaml:0:0: /wdma@14009000: failed to match any schema with compatible: ['mediatek,mt7623-disp-wdma', 'mediatek,mt2701-disp-wdma']
   arch/arm/boot/dts/mt7623n-rfb-emmc.dt.yaml:0:0: /wdma@14009000: failed to match any schema with compatible: ['mediatek,mt7623-disp-wdma', 'mediatek,mt2701-disp-wdma']
   arch/arm/boot/dts/mt7623n-rfb-emmc.dt.yaml:0:0: /pwm@1400a000: failed to match any schema with compatible: ['mediatek,mt7623-disp-pwm', 'mediatek,mt2701-disp-pwm']
--
   arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dt.yaml:0:0: /ethernet@1b100000: failed to match any schema with compatible: ['mediatek,mt7623-eth', 'mediatek,mt2701-eth', 'syscon']
   arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dt.yaml:0:0: /ethernet@1b100000/mac@0: failed to match any schema with compatible: ['mediatek,eth-mac']
   arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dt.yaml:0:0: /ethernet@1b100000/mdio-bus/switch@0: failed to match any schema with compatible: ['mediatek,mt7530']
   arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dt.yaml:0:0: /crypto@1b240000: failed to match any schema with compatible: ['mediatek,eip97-crypto']
   arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dt.yaml:0:0: /syscon@1c000000: failed to match any schema with compatible: ['mediatek,mt7623-bdpsys', 'mediatek,mt2701-bdpsys', 'syscon']
   arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dt.yaml:0:0: /syscon@1c000000: failed to match any schema with compatible: ['mediatek,mt7623-bdpsys', 'mediatek,mt2701-bdpsys', 'syscon']
   arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dt.yaml:0:0: /syscon@13000000: failed to match any schema with compatible: ['mediatek,mt7623-g3dsys', 'mediatek,mt2701-g3dsys', 'syscon']
   arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dt.yaml:0:0: /syscon@13000000: failed to match any schema with compatible: ['mediatek,mt7623-g3dsys', 'mediatek,mt2701-g3dsys', 'syscon']
   arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dt.yaml:0:0: /syscon@15000000: failed to match any schema with compatible: ['mediatek,mt7623-imgsys', 'mediatek,mt2701-imgsys', 'syscon']
   arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dt.yaml:0:0: /syscon@15000000: failed to match any schema with compatible: ['mediatek,mt7623-imgsys', 'mediatek,mt2701-imgsys', 'syscon']
>> arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dt.yaml: jpegdec@15004000: 'mediatek,larb' does not match any of the regexes: 'pinctrl-[0-9]+'
   	From schema: Documentation/devicetree/bindings/media/mediatek-jpeg-decoder.yaml
   arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dt.yaml: smi@1000c000: clock-names: ['apb', 'smi', 'async'] is too long
   	From schema: Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
   arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dt.yaml:0:0: /ovl@14007000: failed to match any schema with compatible: ['mediatek,mt7623-disp-ovl', 'mediatek,mt2701-disp-ovl']
   arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dt.yaml:0:0: /ovl@14007000: failed to match any schema with compatible: ['mediatek,mt7623-disp-ovl', 'mediatek,mt2701-disp-ovl']
   arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dt.yaml:0:0: /rdma@14008000: failed to match any schema with compatible: ['mediatek,mt7623-disp-rdma', 'mediatek,mt2701-disp-rdma']
   arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dt.yaml:0:0: /rdma@14008000: failed to match any schema with compatible: ['mediatek,mt7623-disp-rdma', 'mediatek,mt2701-disp-rdma']
   arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dt.yaml:0:0: /wdma@14009000: failed to match any schema with compatible: ['mediatek,mt7623-disp-wdma', 'mediatek,mt2701-disp-wdma']
   arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dt.yaml:0:0: /wdma@14009000: failed to match any schema with compatible: ['mediatek,mt7623-disp-wdma', 'mediatek,mt2701-disp-wdma']
   arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dt.yaml:0:0: /pwm@1400a000: failed to match any schema with compatible: ['mediatek,mt7623-disp-pwm', 'mediatek,mt2701-disp-pwm']

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
