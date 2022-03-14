Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4BE4D78F5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 01:48:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235726AbiCNAtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 20:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235723AbiCNAs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 20:48:59 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF56E17AB5
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 17:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647218870; x=1678754870;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1p84JNn8W9fdufZmzln9MGJbyV46QEXk7SuXepV0y+Y=;
  b=EkOh+LoyMp0CPVBqbOitHa/tiiftulx+dc324fwfQ65eirzbk4fRJyQh
   YvVUeJidLYw1m3wMdUQarBY+9tZBaffQLxG8BA5wnRInNIJH9m937EiX5
   NHmzP5DR1Z+k/FaOssdyN0spDzZ+nD5K/my6gxIDo2cOAJAJYeUS4ac+Y
   AgNBaj9DiM0QEeIypg18hKQNufXpMHygD/gmyomWyDmH1Mlvg5kX5fDiv
   +VGcF39IUqpCPlGYM+4uN1RrEoiedhb/W07znegRojh4JLyvaiV58L9LF
   kiciwdmUukDGCnFlXT8PvrWFrTjSjlPHGlgH2e4X1apsnzmFTsR/v2ANo
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10285"; a="255640922"
X-IronPort-AV: E=Sophos;i="5.90,179,1643702400"; 
   d="scan'208";a="255640922"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2022 17:47:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,179,1643702400"; 
   d="scan'208";a="597704199"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 13 Mar 2022 17:47:48 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nTYsF-0009Qw-Ri; Mon, 14 Mar 2022 00:47:47 +0000
Date:   Mon, 14 Mar 2022 08:47:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Subject: [toke:xdp-queueing-03 2/9]
 af_packet.c:(.text.fanout_demux_bpf+0x104): undefined reference to
 `__umoddi3'
Message-ID: <202203140823.sEWeUlHf-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/toke/linux.git xdp-queueing-03
head:   3e7f25d58b1bfd5ad623678bf9e11f27c98a8094
commit: 1cc16c4489cbf066b09942ea224e6dc9ac6a46ac [2/9] bpf: Use 64-bit return value for bpf_prog_run
config: mips-buildonly-randconfig-r006-20220313 (https://download.01.org/0day-ci/archive/20220314/202203140823.sEWeUlHf-lkp@intel.com/config)
compiler: mipsel-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/toke/linux.git/commit/?id=1cc16c4489cbf066b09942ea224e6dc9ac6a46ac
        git remote add toke https://git.kernel.org/pub/scm/linux/kernel/git/toke/linux.git
        git fetch --no-tags toke xdp-queueing-03
        git checkout 1cc16c4489cbf066b09942ea224e6dc9ac6a46ac
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   mipsel-linux-ld: net/packet/af_packet.o: in function `fanout_demux_bpf':
>> af_packet.c:(.text.fanout_demux_bpf+0x104): undefined reference to `__umoddi3'

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
