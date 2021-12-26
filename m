Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EDA147F70E
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 15:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233659AbhLZODt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 09:03:49 -0500
Received: from mga05.intel.com ([192.55.52.43]:63282 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230035AbhLZODs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 09:03:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640527428; x=1672063428;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=JyQw84yzbD12QRN6tQ+pCU23brqQBHbn04H85KS1W0c=;
  b=GCtSZKJRy3xPNWfbTupYmVlOi5BDejtbggdxfBAcUhFX08CQDGZ9+vgT
   lY1rY8KxqNqlSj2RNvpgz4ImzU5JAtk6MUuXRIyuvwZwnW82ydVwhqH0x
   iNGBIeBIVJ6XK9vT4j3Oaie3fxR477/hmIFplny981dqY9vVjPait75lu
   ls6K3spTEkxTF76xJas0QwDdhV9ftFClMIHXKx2uP8StyJqWpNpcGn6Iz
   vGZkFBA4pHt/OJcuGbDKkT65/apy+LAhLUzoKrpOZv6KqG7DfJX++RjKh
   oRhYS4+ZUN87HrWbNplqx1cKWo3f0cw+ehm5YVCHmBQHuj/mtHbUZNGWe
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10208"; a="327435644"
X-IronPort-AV: E=Sophos;i="5.88,237,1635231600"; 
   d="scan'208";a="327435644"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2021 06:03:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,237,1635231600"; 
   d="scan'208";a="618175259"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 26 Dec 2021 06:03:45 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n1U7l-0005Qp-56; Sun, 26 Dec 2021 14:03:45 +0000
Date:   Sun, 26 Dec 2021 22:02:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>,
        melissa.srw@gmail.com
Cc:     kbuild-all@lists.01.org, mwen@igalia.com,
        rodrigosiqueiramelo@gmail.com, hamohammed.sa@gmail.com,
        daniel@ffwll.ch, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
Subject: Re: [PATCH v2 1/1] drm/vkms: add zpos plane property
Message-ID: <202112262122.WMEshF8D-lkp@intel.com>
References: <20211226111219.27616-2-jose.exposito89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211226111219.27616-2-jose.exposito89@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi "José,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on drm/drm-next]
[also build test ERROR on v5.16-rc6 next-20211224]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Jos-Exp-sito/drm-vkms-zpos/20211226-191434
base:   git://anongit.freedesktop.org/drm/drm drm-next
config: arc-randconfig-r043-20211226 (https://download.01.org/0day-ci/archive/20211226/202112262122.WMEshF8D-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/48c96494b71972f4bf1769682e94e59724dba874
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Jos-Exp-sito/drm-vkms-zpos/20211226-191434
        git checkout 48c96494b71972f4bf1769682e94e59724dba874
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash drivers/gpu/drm/vkms/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/gpu/drm/vkms/vkms_plane.c: In function 'vkms_plane_create_zpos_property':
>> drivers/gpu/drm/vkms/vkms_plane.c:170:57: error: 'NUM_OVERLAY_PLANES' undeclared (first use in this function)
     170 |                                                      1, NUM_OVERLAY_PLANES);
         |                                                         ^~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/vkms/vkms_plane.c:170:57: note: each undeclared identifier is reported only once for each function it appears in


vim +/NUM_OVERLAY_PLANES +170 drivers/gpu/drm/vkms/vkms_plane.c

   162	
   163	static int vkms_plane_create_zpos_property(struct vkms_plane *plane)
   164	{
   165		int ret;
   166		unsigned int zpos = drm_plane_index(&plane->base);
   167	
   168		if (plane->base.type == DRM_PLANE_TYPE_OVERLAY) {
   169			ret = drm_plane_create_zpos_property(&plane->base, zpos,
 > 170							     1, NUM_OVERLAY_PLANES);
   171		} else {
   172			ret = drm_plane_create_zpos_immutable_property(&plane->base,
   173								       zpos);
   174		}
   175	
   176		return ret;
   177	}
   178	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
