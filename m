Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97FE0497F15
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 13:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238940AbiAXMQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 07:16:22 -0500
Received: from mga05.intel.com ([192.55.52.43]:4341 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242216AbiAXMPc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 07:15:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643026532; x=1674562532;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sYibUVZxAIos3Y+42FqhQ+3de5FeeBaOdC4uBXCfPlA=;
  b=dsS6CZC2d7qvYf3myzizZqybidQonlAEtIPCOA8eU5fBppxGWOaj4JTy
   tCejUrjUgA6i79NHUp8rpgI98pa6SUcZmaSo54BEC3DBX3BlGWqbUEAOz
   U/XEdmSOkcGie9OLIGqa2XPVli4HNFlCwX1OEeYw8FDdqiaQNUepaEob/
   PiuJVlHe8JenpfE+vsZyx1WZaNRQYUgYONEW9wcU35onD5aQCvzCh4qe3
   oLM+LOln10pwiT9xXCej0MrOWiNd2tkZ3rtYQeJ8yMUT7zTgGEi4upJgb
   X3eIsS4Uo4FE25y9XhNWw4D3ZPBnMV3HWV8H/OjeLnKhv9Nkl0YYgrCvg
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="332385123"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="332385123"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 04:14:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="766378082"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 24 Jan 2022 04:14:39 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nByF5-000IHz-1N; Mon, 24 Jan 2022 12:14:39 +0000
Date:   Mon, 24 Jan 2022 20:14:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Xin Ji <xji@analogixsemi.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kbuild-all@lists.01.org, bliang@analogixsemi.com,
        qwen@analogixsemi.com, jli@analogixsemi.com,
        Xin Ji <xji@analogixsemi.com>, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v3 2/2] usb: typec: anx7411: Add Analogix PD ANX7411
 support
Message-ID: <202201242014.N4URst2I-lkp@intel.com>
References: <20220121061856.2038958-2-xji@analogixsemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220121061856.2038958-2-xji@analogixsemi.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xin,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on usb/usb-testing]
[also build test WARNING on robh/for-next peter-chen-usb/for-usb-next v5.17-rc1 next-20220124]
[cannot apply to balbi-usb/testing/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Xin-Ji/dt-bindings-usb-Add-analogix-anx7411-PD-binding/20220121-142000
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
config: s390-randconfig-s031-20220124 (https://download.01.org/0day-ci/archive/20220124/202201242014.N4URst2I-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/0day-ci/linux/commit/f75d15d4f011dabf8a702d85fb788f9aefb326e2
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Xin-Ji/dt-bindings-usb-Add-analogix-anx7411-PD-binding/20220121-142000
        git checkout f75d15d4f011dabf8a702d85fb788f9aefb326e2
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=s390 SHELL=/bin/bash drivers/irqchip/ drivers/usb/typec/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/usb/typec/anx7411.c:636:28: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/usb/typec/anx7411.c:636:28: sparse:     expected unsigned int [usertype]
   drivers/usb/typec/anx7411.c:636:28: sparse:     got restricted __le32 [usertype]

vim +636 drivers/usb/typec/anx7411.c

   621	
   622	static void anx7411_translate_payload(struct device *dev, u32 *payload,
   623					      u32 *pdo, int nr, const char *type)
   624	{
   625		int i;
   626	
   627		dev_info(dev, "convert %s pdos to little endian format\n", type);
   628		if (nr > PDO_MAX_OBJECTS) {
   629			dev_err(dev, "nr(%d) exceed PDO_MAX_OBJECTS(%d)\n",
   630				nr, PDO_MAX_OBJECTS);
   631	
   632			return;
   633		}
   634	
   635		for (i = 0; i < nr; i++)
 > 636			payload[i] = cpu_to_le32(pdo[i]);
   637	}
   638	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
