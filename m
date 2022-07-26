Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB242580983
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 04:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbiGZCed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 22:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbiGZCeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 22:34:31 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481FF28E29;
        Mon, 25 Jul 2022 19:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658802870; x=1690338870;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=oQGLDobYwHi1A02VN+sYCWqkJ5xg453HmlwiMQc6qZQ=;
  b=Sx6HWrZu6dpUQRlQNpsq+Az7JnokEicO3tr8H8Vjr8sR6h4AGsM8SiZJ
   Tp4lA6udJONf8pxfKqP+eP2vzwxHbB1WimnPwtyMbEASup/QFWHU3edDN
   M9kQbeH5FADAl60N0HMMiyYPQavor7Yxgwfb0lVxRrPO71qJ73ujusNPM
   PIR7Z+WAxmexulWZaCsZekQjZricfhIy78TNcqEYUkzrnfTqCz/nI0oQf
   h/t+3uTOY+k6KscVL6nrtJAWz5w6//ObzA31Q0q7dx2gbT+NHqpecTIo8
   0jsdT0B7PJOEPrPMy7JSYynIXeHBsKSXKT0sH5mT3u9huCivev4fuy5m9
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10419"; a="289030171"
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="289030171"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2022 19:34:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="742050967"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 25 Jul 2022 19:34:27 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oGAOw-0005sk-2h;
        Tue, 26 Jul 2022 02:34:26 +0000
Date:   Tue, 26 Jul 2022 10:33:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>,
        jikos@kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        benjamin.tissoires@redhat.com, spbnick@gmail.com,
        j.witteveen@gmail.com, stefanberzl@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com,
        =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
Subject: Re: [PATCH v2 6/7] HID: uclogic: Add support for UGEE v2 mouse frames
Message-ID: <202207261047.hUEFf74G-lkp@intel.com>
References: <20220717144333.251190-7-jose.exposito89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220717144333.251190-7-jose.exposito89@gmail.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi "José,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on 0cb1fc0988e32bda84c2b7218e0c761af1430baf]

url:    https://github.com/intel-lab-lkp/linux/commits/Jos-Exp-sito/XP-PEN-Deco-Pro-S-support-for-5-20-uclogic/20220717-224559
base:   0cb1fc0988e32bda84c2b7218e0c761af1430baf
config: x86_64-buildonly-randconfig-r002-20220718 (https://download.01.org/0day-ci/archive/20220726/202207261047.hUEFf74G-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project fa0c7639e91fa1cd0cf2ff0445a1634a90fe850a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/10fcf5d5cca4657c53477c392b1fb675d72cfda3
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jos-Exp-sito/XP-PEN-Deco-Pro-S-support-for-5-20-uclogic/20220717-224559
        git checkout 10fcf5d5cca4657c53477c392b1fb675d72cfda3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ld.lld: error: call to __read_overflow marked "dontcall-error": detected read beyond size of object (1st parameter)

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
