Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CAE0478588
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 08:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233651AbhLQHUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 02:20:00 -0500
Received: from mga07.intel.com ([134.134.136.100]:43256 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231258AbhLQHUA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 02:20:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639725600; x=1671261600;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=UdJ0ib078EerhAGCS65Pb++4+rQUrLAfrqwJGNNXclQ=;
  b=dhBtYXUEZXdoF2Sfbz9zZO5TXNsS0ygmisJgQTxhoGf/lHs3448pF4ja
   h1oepVQFnTmzg5n8Io9kTpIPVTboMtOXr3BWbk5+uD6eC3hcRw8FLfIHn
   cJyucoj0BK5dQQAcyghC8ovEJfqBHeZhmkKA14b+d0k3dnhwLgqAmJN5J
   cNvOlcNYRba/8I+KIVGa0FoGhtS55tgf9lHPSIhwMmnlHgvfqUVzm7Ij9
   RRW4UTNIKoXBOu4twsIo570O7v56gYvZAFlx9FFDWS2Ebc+rFG64Pll0M
   RcL6saS7NMTaEsndwqHQoZo6Vjkq8ugR2SBWYyqLk5feErlCVGn/r8728
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10200"; a="303075263"
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="303075263"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 23:19:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="465031695"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 16 Dec 2021 23:19:58 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1my7X3-0004PJ-Mh; Fri, 17 Dec 2021 07:19:57 +0000
Date:   Fri, 17 Dec 2021 15:19:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [pinchartl-media:gmsl/max9286/bindings 2/45]
 drivers/media/v4l2-core/v4l2-subdev.c:951:17: error: implicit declaration of
 function '__v4l2_subdev_state_alloc'
Message-ID: <202112171508.QfPJWLAu-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://linuxtv.org/pinchartl/media.git gmsl/max9286/bindings
head:   b551a93fb443867f1a950d6063910639bd303daf
commit: 3e5486c9f448f3d9067b1050ed189db7d062fdf4 [2/45] media: subdev: add active state to struct v4l2_subdev
config: sparc64-randconfig-r014-20211216 (https://download.01.org/0day-ci/archive/20211217/202112171508.QfPJWLAu-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add pinchartl-media git://linuxtv.org/pinchartl/media.git
        git fetch --no-tags pinchartl-media gmsl/max9286/bindings
        git checkout 3e5486c9f448f3d9067b1050ed189db7d062fdf4
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sparc64 SHELL=/bin/bash drivers/media/v4l2-core/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   drivers/media/v4l2-core/v4l2-subdev.c: In function 'v4l2_subdev_init_finalize':
>> drivers/media/v4l2-core/v4l2-subdev.c:951:17: error: implicit declaration of function '__v4l2_subdev_state_alloc' [-Werror=implicit-function-declaration]
     951 |         state = __v4l2_subdev_state_alloc(sd);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/media/v4l2-core/v4l2-subdev.c:951:15: warning: assignment to 'struct v4l2_subdev_state *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     951 |         state = __v4l2_subdev_state_alloc(sd);
         |               ^
   drivers/media/v4l2-core/v4l2-subdev.c: In function 'v4l2_subdev_cleanup':
>> drivers/media/v4l2-core/v4l2-subdev.c:963:9: error: implicit declaration of function '__v4l2_subdev_state_free' [-Werror=implicit-function-declaration]
     963 |         __v4l2_subdev_state_free(sd->active_state);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/__v4l2_subdev_state_alloc +951 drivers/media/v4l2-core/v4l2-subdev.c

   946	
   947	int v4l2_subdev_init_finalize(struct v4l2_subdev *sd)
   948	{
   949		struct v4l2_subdev_state *state;
   950	
 > 951		state = __v4l2_subdev_state_alloc(sd);
   952		if (IS_ERR(state))
   953			return PTR_ERR(state);
   954	
   955		sd->active_state = state;
   956	
   957		return 0;
   958	}
   959	EXPORT_SYMBOL_GPL(v4l2_subdev_init_finalize);
   960	
   961	void v4l2_subdev_cleanup(struct v4l2_subdev *sd)
   962	{
 > 963		__v4l2_subdev_state_free(sd->active_state);

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
