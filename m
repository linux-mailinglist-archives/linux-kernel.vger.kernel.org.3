Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA3BC493485
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 06:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349672AbiASFbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 00:31:01 -0500
Received: from mga05.intel.com ([192.55.52.43]:20785 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231512AbiASFbA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 00:31:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642570260; x=1674106260;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/S6+4AaC4aquNAFqWSSro024H3tLteo4PdifLrqaHEw=;
  b=KjtboQV98/K10ynSQdCJUOvfi4wOP83KZ84Iztc4CIBvqJcBBEgYWqpw
   ffABBfPIeVQRYxGcJM4ClzSD4OyetMalXDY5bDkKhdyFkYHbCQrWdfeds
   y9XIA6RbV+FVUALaxBJ+b7gBzXbIdveY0LyEI5jf9UHCpeAJDp5mrOBLA
   97mRVFzmXCo1usWK1Xn9Y29uh6LsjVUthbptOFaIH4co5oukRFsIzHgpZ
   rro3txDljmb0kuuuP6/ErQnza2mukSTXk27UcTrKMNkY9swgBQaD8qYOe
   Zo/xcMA0KOpacaOO0qzDCb9l3RXWPN85ivVvR+QKibAvnSOpPKCl0Rgad
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10231"; a="331339098"
X-IronPort-AV: E=Sophos;i="5.88,298,1635231600"; 
   d="scan'208";a="331339098"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 21:27:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,298,1635231600"; 
   d="scan'208";a="625758388"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 18 Jan 2022 21:27:19 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nA3V9-000DIS-5h; Wed, 19 Jan 2022 05:27:19 +0000
Date:   Wed, 19 Jan 2022 13:26:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Scally <djrscally@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org,
        Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: drivers/media/i2c/ov5693.c:989:46-51: WARNING: conversion to bool
 not needed here
Message-ID: <202201191326.BbZWNNQm-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   99613159ad749543621da8238acf1a122880144e
commit: 89aef879cb537061f7a0948210fc00c5f1b5dfb4 media: i2c: Add support for ov5693 sensor
date:   7 weeks ago
config: arm64-randconfig-c004-20220117 (https://download.01.org/0day-ci/archive/20220119/202201191326.BbZWNNQm-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cocci warnings: (new ones prefixed by >>)
>> drivers/media/i2c/ov5693.c:989:46-51: WARNING: conversion to bool not needed here
   drivers/media/i2c/ov5693.c:991:46-51: WARNING: conversion to bool not needed here
--
>> drivers/media/i2c/ov5693.c:953:5-8: Unneeded variable: "ret". Return "0" on line 985

Please review and possibly fold the followup patch.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
