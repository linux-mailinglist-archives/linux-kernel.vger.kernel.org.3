Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74B375752DA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 18:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239578AbiGNQc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 12:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbiGNQcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 12:32:54 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB0C65D47
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 09:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657816374; x=1689352374;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=hrSSjMWo8WckyvVnXPS6RM06bADQr4nBTt9NDV+S++0=;
  b=Us9dBHy5ebxu/FzHMuyLYZptao6XZvNloKQS88s72ylvPVgxkG6o5YL9
   S14tcxV4LA+A6XPQM6MakCyo2JuNFLAicDo6AhZcdWT0IDlLbIJ/JjmAS
   nzXD/l4v1KZUwK74ATnuHdGBn1JKgFEkc++oN3OZ+cO6mN8/ExGFp/DTY
   cbA5jOmEJQ/2zYAtv+9cm5XdQ4BCFpzeW+Io3E+ikAniakzZyzrnv+BVb
   IjSm8r42I7H8+r7FqfQM/9j2w+aFnH7aC5QUD2DXoCq+4jH3Fxn5+m4Wv
   1yCLRrmGMNaX/abn1ef52ACmH5tHbFYHkz5kV/2/+nHq4498BbC04vYgQ
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="347245445"
X-IronPort-AV: E=Sophos;i="5.92,271,1650956400"; 
   d="scan'208";a="347245445"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 09:32:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,271,1650956400"; 
   d="scan'208";a="571162785"
Received: from lkp-server01.sh.intel.com (HELO fd2c14d642b4) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 14 Jul 2022 09:32:28 -0700
Received: from kbuild by fd2c14d642b4 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oC1lL-0000sA-8v;
        Thu, 14 Jul 2022 16:32:27 +0000
Date:   Fri, 15 Jul 2022 00:32:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dani Liberman <dliberman@habana.ai>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Oded Gabbay <ogabbay@kernel.org>
Subject: [ogabbay:habanalabs-next 1/3]
 drivers/misc/habanalabs/common/debugfs.c:599:9: warning: function
 'hl_engine_data_sprintf' might be a candidate for 'gnu_printf' format
 attribute
Message-ID: <202207150057.RUJOxIhW-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git habanalabs-next
head:   0339d759da283025aa01ba72cb7e5b6df9978670
commit: b916f64dace37d374de75823a203749caf30fd7c [1/3] habanalabs: removed seq_file parameter from is_idle asic functions
config: i386-randconfig-a001 (https://download.01.org/0day-ci/archive/20220715/202207150057.RUJOxIhW-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git/commit/?id=b916f64dace37d374de75823a203749caf30fd7c
        git remote add ogabbay https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git
        git fetch --no-tags ogabbay habanalabs-next
        git checkout b916f64dace37d374de75823a203749caf30fd7c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/misc/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/misc/habanalabs/common/debugfs.c: In function 'hl_engine_data_sprintf':
>> drivers/misc/habanalabs/common/debugfs.c:599:9: warning: function 'hl_engine_data_sprintf' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
     599 |         str_size = vsnprintf(NULL, 0, fmt, args) + 1;
         |         ^~~~~~~~
   drivers/misc/habanalabs/common/debugfs.c:604:17: warning: function 'hl_engine_data_sprintf' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
     604 |                 vsnprintf(e->buf + e->actual_size, str_size, fmt, args);
         |                 ^~~~~~~~~


vim +599 drivers/misc/habanalabs/common/debugfs.c

   589	
   590	void hl_engine_data_sprintf(struct engines_data *e, const char *fmt, ...)
   591	{
   592		va_list args;
   593		int str_size;
   594	
   595		va_start(args, fmt);
   596		/* Calculate formatted string length. Assuming each string is null terminated, hence
   597		 * increment result by 1
   598		 */
 > 599		str_size = vsnprintf(NULL, 0, fmt, args) + 1;
   600		va_end(args);
   601	
   602		if ((e->actual_size + str_size) < e->allocated_buf_size) {
   603			va_start(args, fmt);
   604			vsnprintf(e->buf + e->actual_size, str_size, fmt, args);
   605			va_end(args);
   606		}
   607	
   608		/* Need to update the size even when not updating destination buffer to get the exact size
   609		 * of all input strings
   610		 */
   611		e->actual_size += str_size;
   612	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
