Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 733E756D109
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 21:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiGJTU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 15:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiGJTU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 15:20:27 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3F2BC9A
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 12:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657480825; x=1689016825;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=69gOGoGXhW2chzFXjKMMkPA8Ddg/6/ejvL81GS1H418=;
  b=ZXP2o05uhDoyIuwxdJwwS9sDkYt6TSAla6HYhQ+ermJlfm8A1XatMij5
   3z6yGYoPd523yXkZDOJWZG4ZEmigfMo5mL5V4pf3FT+M7zVDWOo7fc6fl
   kmwo7Eb3TCmRn6yhgG3X74lt2PTlY2/RQfm2aZfLtNJ33xorIT1Qcufgk
   MCVV5AHB7z6v97XRF1+XUY4VAvadJEon2iVguYPuIhO7rHf9plwOwCUOE
   iwlX4J7RDaeTsZ/yeBVFc3XgbaufVqqhNO7E2Er9KVhTiObZbeG++PsiW
   owKCTtcrtPY+aXdi4L8oNIBuP+32a7j0bLYHByw/088vdqcay9rdnPL3c
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10404"; a="284555243"
X-IronPort-AV: E=Sophos;i="5.92,261,1650956400"; 
   d="scan'208";a="284555243"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2022 12:20:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,261,1650956400"; 
   d="scan'208";a="594657655"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 10 Jul 2022 12:20:24 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oAcTf-000Q7k-K5;
        Sun, 10 Jul 2022 19:20:23 +0000
Date:   Mon, 11 Jul 2022 03:20:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [ogabbay:gaudi2 52/62]
 drivers/misc/habanalabs/gaudi2/gaudi2.c:9500:48-53: WARNING: conversion to
 bool not needed here
Message-ID: <202207110303.LlORIomX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git gaudi2
head:   cdf0db9c5190d3f87662583db935ef9f5c0b7e4a
commit: db0c0cf75ce55851443487f3b7c6e033f112102d [52/62] habanalabs: add gaudi2 asic-specific code
config: xtensa-randconfig-c004-20220710 (https://download.01.org/0day-ci/archive/20220711/202207110303.LlORIomX-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 11.3.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


cocci warnings: (new ones prefixed by >>)
>> drivers/misc/habanalabs/gaudi2/gaudi2.c:9500:48-53: WARNING: conversion to bool not needed here
--
>> drivers/misc/habanalabs/gaudi2/gaudi2.c:8016:2-3: Unneeded semicolon

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
