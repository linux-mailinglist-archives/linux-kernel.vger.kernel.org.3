Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1DEE4D972B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 10:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346375AbiCOJJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 05:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346008AbiCOJJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 05:09:33 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4812013F10;
        Tue, 15 Mar 2022 02:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647335301; x=1678871301;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=CNNTAzHpUPwB4POxTn5Q49CkAO4SbnCfNETDTGa4LkE=;
  b=Xq4uCg59oP9By95zpUy2MsDUye8rGdGvOxcO9BeUmng6+E09pidV2+6U
   vRdK+ETN/JDFDugrG588Tf+OX+TfYEy0rJ6temcNex4gs/dID3UrlJywm
   bRrJPvE+/4Ng6j/eEPMhGJzSn72gmaGgd94l4ozTMqMVWucKkkTa9Ybyu
   y92+wY2CPh+K4CSkbCOJxnXXRGRKp5BiXUZf+Rj+maqw4W6z6rNeedBbC
   a4lldFHdP64f1Rbh7YZIOSvu/7Hy0xe2AZv76BHPhxUixVMUeW0aylo/Y
   mBQcRmT7Jey+HdA55itq2MDg7spVENBiyXN2ZWBxU9AoRXtg+IiGNwQho
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="316973354"
X-IronPort-AV: E=Sophos;i="5.90,182,1643702400"; 
   d="scan'208";a="316973354"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 02:08:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,182,1643702400"; 
   d="scan'208";a="634518596"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Mar 2022 02:08:19 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nU3AA-000AmH-IW; Tue, 15 Mar 2022 09:08:18 +0000
Date:   Tue, 15 Mar 2022 17:07:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: [hverkuil-media-tree:for-v5.18a 391/413] ERROR: modpost: "__moddi3"
 [drivers/media/platform/nxp/amphion/amphion-vpu.ko] undefined!
Message-ID: <202203151735.g55hxX0O-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

First bad commit (maybe != root cause):

tree:   git://linuxtv.org/hverkuil/media_tree.git for-v5.18a
head:   dedb332353901b49b6979a45a73884653ee3681f
commit: 212e0112b5f6ca12ea2d72dfb3ad16b9454cee3f [391/413] media: platform: rename amphion/ to nxp/amphion/
config: mips-allmodconfig (https://download.01.org/0day-ci/archive/20220315/202203151735.g55hxX0O-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add hverkuil-media-tree git://linuxtv.org/hverkuil/media_tree.git
        git fetch --no-tags hverkuil-media-tree for-v5.18a
        git checkout 212e0112b5f6ca12ea2d72dfb3ad16b9454cee3f
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

Note: the hverkuil-media-tree/for-v5.18a HEAD dedb332353901b49b6979a45a73884653ee3681f builds fine.
      It only hurts bisectability.

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "__moddi3" [drivers/media/platform/nxp/amphion/amphion-vpu.ko] undefined!
>> ERROR: modpost: "__divdi3" [drivers/media/platform/nxp/amphion/amphion-vpu.ko] undefined!

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
