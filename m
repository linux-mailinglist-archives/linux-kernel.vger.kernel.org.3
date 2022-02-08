Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 303CD4AD766
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 12:35:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245300AbiBHLdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 06:33:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347678AbiBHLIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 06:08:31 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3CE5C03FEC0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 03:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644318509; x=1675854509;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=w0OyASRgPZ8xLiBy2HoDAX25Z26Ocs5YkZNDBp5V3bk=;
  b=ngnHkHOW+TAGhg86KkGOABHgtB8cISxS8umoD3olAabnRphQ2TPabKpx
   L1xwfAWl3POjko241cPkjXviiWtfoL0+bThzYbUrI9c8kEIvkfK7qZQtA
   mKIIsaGpFNAiwDb6hLsCPgejaa6mZoMzIMivVFzzhCJtOO6I65dnmdi0v
   AcqqPPO7qj8JOUHNIV8emIHHmxWsR5I1mBNy73Y0USTWcRZlOIlgRYC02
   2OEoBaPIzT0SqyfFmg/swj4bg4PodpTUOJmTyCQltq3d0u6BazGEA+nEO
   EEJhwf0xqRF7hKHK9EW+HbZGCdUScB9Fk3tJRk+7E09/PXv/zHq3kLHbX
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="335329247"
X-IronPort-AV: E=Sophos;i="5.88,352,1635231600"; 
   d="scan'208";a="335329247"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 03:08:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,352,1635231600"; 
   d="scan'208";a="700810988"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 08 Feb 2022 03:08:21 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nHOM8-00005M-Ls; Tue, 08 Feb 2022 11:08:20 +0000
Date:   Tue, 8 Feb 2022 19:07:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>
Subject: [bpf-next:master 212/221] arch/sparc/net/bpf_jit_comp_64.c:1602:56:
 error: 'struct bpf_binary_header' has no member named 'pages'
Message-ID: <202202081815.gh1kFj08-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
head:   5d1e9f437df5ef21e7567f1970a00fda3b5d1126
commit: ed2d9e1a26cca963ff5ed3b76326d70f7d8201a9 [212/221] bpf: Use size instead of pages in bpf_binary_header
config: sparc-randconfig-r036-20220207 (https://download.01.org/0day-ci/archive/20220208/202202081815.gh1kFj08-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/commit/?id=ed2d9e1a26cca963ff5ed3b76326d70f7d8201a9
        git remote add bpf-next https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git
        git fetch --no-tags bpf-next master
        git checkout ed2d9e1a26cca963ff5ed3b76326d70f7d8201a9
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sparc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/sparc/net/bpf_jit_comp_64.c: In function 'bpf_int_jit_compile':
>> arch/sparc/net/bpf_jit_comp_64.c:1602:56: error: 'struct bpf_binary_header' has no member named 'pages'
    1602 |         bpf_flush_icache(header, (u8 *)header + (header->pages * PAGE_SIZE));
         |                                                        ^~


vim +1602 arch/sparc/net/bpf_jit_comp_64.c

5f5a641116391f David Miller       2017-12-22  1479  
7a12b5031c6b94 David S. Miller    2017-04-17  1480  struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
7a12b5031c6b94 David S. Miller    2017-04-17  1481  {
7a12b5031c6b94 David S. Miller    2017-04-17  1482  	struct bpf_prog *tmp, *orig_prog = prog;
5f5a641116391f David Miller       2017-12-22  1483  	struct sparc64_jit_data *jit_data;
7a12b5031c6b94 David S. Miller    2017-04-17  1484  	struct bpf_binary_header *header;
c44768a33da81b David Miller       2018-11-26  1485  	u32 prev_image_size, image_size;
7a12b5031c6b94 David S. Miller    2017-04-17  1486  	bool tmp_blinded = false;
5f5a641116391f David Miller       2017-12-22  1487  	bool extra_pass = false;
7a12b5031c6b94 David S. Miller    2017-04-17  1488  	struct jit_ctx ctx;
7a12b5031c6b94 David S. Miller    2017-04-17  1489  	u8 *image_ptr;
c44768a33da81b David Miller       2018-11-26  1490  	int pass, i;
7a12b5031c6b94 David S. Miller    2017-04-17  1491  
60b58afc96c9df Alexei Starovoitov 2017-12-14  1492  	if (!prog->jit_requested)
7a12b5031c6b94 David S. Miller    2017-04-17  1493  		return orig_prog;
7a12b5031c6b94 David S. Miller    2017-04-17  1494  
7a12b5031c6b94 David S. Miller    2017-04-17  1495  	tmp = bpf_jit_blind_constants(prog);
7a12b5031c6b94 David S. Miller    2017-04-17  1496  	/* If blinding was requested and we failed during blinding,
7a12b5031c6b94 David S. Miller    2017-04-17  1497  	 * we must fall back to the interpreter.
7a12b5031c6b94 David S. Miller    2017-04-17  1498  	 */
7a12b5031c6b94 David S. Miller    2017-04-17  1499  	if (IS_ERR(tmp))
7a12b5031c6b94 David S. Miller    2017-04-17  1500  		return orig_prog;
7a12b5031c6b94 David S. Miller    2017-04-17  1501  	if (tmp != prog) {
7a12b5031c6b94 David S. Miller    2017-04-17  1502  		tmp_blinded = true;
7a12b5031c6b94 David S. Miller    2017-04-17  1503  		prog = tmp;
7a12b5031c6b94 David S. Miller    2017-04-17  1504  	}
7a12b5031c6b94 David S. Miller    2017-04-17  1505  
5f5a641116391f David Miller       2017-12-22  1506  	jit_data = prog->aux->jit_data;
5f5a641116391f David Miller       2017-12-22  1507  	if (!jit_data) {
5f5a641116391f David Miller       2017-12-22  1508  		jit_data = kzalloc(sizeof(*jit_data), GFP_KERNEL);
5f5a641116391f David Miller       2017-12-22  1509  		if (!jit_data) {
5f5a641116391f David Miller       2017-12-22  1510  			prog = orig_prog;
5f5a641116391f David Miller       2017-12-22  1511  			goto out;
5f5a641116391f David Miller       2017-12-22  1512  		}
5f5a641116391f David Miller       2017-12-22  1513  		prog->aux->jit_data = jit_data;
5f5a641116391f David Miller       2017-12-22  1514  	}
5f5a641116391f David Miller       2017-12-22  1515  	if (jit_data->ctx.offset) {
5f5a641116391f David Miller       2017-12-22  1516  		ctx = jit_data->ctx;
5f5a641116391f David Miller       2017-12-22  1517  		image_ptr = jit_data->image;
5f5a641116391f David Miller       2017-12-22  1518  		header = jit_data->header;
5f5a641116391f David Miller       2017-12-22  1519  		extra_pass = true;
5f5a641116391f David Miller       2017-12-22  1520  		image_size = sizeof(u32) * ctx.idx;
c44768a33da81b David Miller       2018-11-26  1521  		prev_image_size = image_size;
c44768a33da81b David Miller       2018-11-26  1522  		pass = 1;
5f5a641116391f David Miller       2017-12-22  1523  		goto skip_init_ctx;
5f5a641116391f David Miller       2017-12-22  1524  	}
5f5a641116391f David Miller       2017-12-22  1525  
7a12b5031c6b94 David S. Miller    2017-04-17  1526  	memset(&ctx, 0, sizeof(ctx));
7a12b5031c6b94 David S. Miller    2017-04-17  1527  	ctx.prog = prog;
7a12b5031c6b94 David S. Miller    2017-04-17  1528  
c44768a33da81b David Miller       2018-11-26  1529  	ctx.offset = kmalloc_array(prog->len, sizeof(unsigned int), GFP_KERNEL);
7a12b5031c6b94 David S. Miller    2017-04-17  1530  	if (ctx.offset == NULL) {
7a12b5031c6b94 David S. Miller    2017-04-17  1531  		prog = orig_prog;
5f5a641116391f David Miller       2017-12-22  1532  		goto out_off;
7a12b5031c6b94 David S. Miller    2017-04-17  1533  	}
7a12b5031c6b94 David S. Miller    2017-04-17  1534  
c44768a33da81b David Miller       2018-11-26  1535  	/* Longest sequence emitted is for bswap32, 12 instructions.  Pre-cook
c44768a33da81b David Miller       2018-11-26  1536  	 * the offset array so that we converge faster.
7a12b5031c6b94 David S. Miller    2017-04-17  1537  	 */
c44768a33da81b David Miller       2018-11-26  1538  	for (i = 0; i < prog->len; i++)
c44768a33da81b David Miller       2018-11-26  1539  		ctx.offset[i] = i * (12 * 4);
c44768a33da81b David Miller       2018-11-26  1540  
c44768a33da81b David Miller       2018-11-26  1541  	prev_image_size = ~0U;
c44768a33da81b David Miller       2018-11-26  1542  	for (pass = 1; pass < 40; pass++) {
c44768a33da81b David Miller       2018-11-26  1543  		ctx.idx = 0;
c44768a33da81b David Miller       2018-11-26  1544  
c44768a33da81b David Miller       2018-11-26  1545  		build_prologue(&ctx);
7a12b5031c6b94 David S. Miller    2017-04-17  1546  		if (build_body(&ctx)) {
7a12b5031c6b94 David S. Miller    2017-04-17  1547  			prog = orig_prog;
7a12b5031c6b94 David S. Miller    2017-04-17  1548  			goto out_off;
7a12b5031c6b94 David S. Miller    2017-04-17  1549  		}
7a12b5031c6b94 David S. Miller    2017-04-17  1550  		build_epilogue(&ctx);
7a12b5031c6b94 David S. Miller    2017-04-17  1551  
c44768a33da81b David Miller       2018-11-26  1552  		if (bpf_jit_enable > 1)
c44768a33da81b David Miller       2018-11-26  1553  			pr_info("Pass %d: size = %u, seen = [%c%c%c%c%c%c]\n", pass,
c44768a33da81b David Miller       2018-11-26  1554  				ctx.idx * 4,
c44768a33da81b David Miller       2018-11-26  1555  				ctx.tmp_1_used ? '1' : ' ',
c44768a33da81b David Miller       2018-11-26  1556  				ctx.tmp_2_used ? '2' : ' ',
c44768a33da81b David Miller       2018-11-26  1557  				ctx.tmp_3_used ? '3' : ' ',
c44768a33da81b David Miller       2018-11-26  1558  				ctx.saw_frame_pointer ? 'F' : ' ',
c44768a33da81b David Miller       2018-11-26  1559  				ctx.saw_call ? 'C' : ' ',
c44768a33da81b David Miller       2018-11-26  1560  				ctx.saw_tail_call ? 'T' : ' ');
c44768a33da81b David Miller       2018-11-26  1561  
c44768a33da81b David Miller       2018-11-26  1562  		if (ctx.idx * 4 == prev_image_size)
c44768a33da81b David Miller       2018-11-26  1563  			break;
c44768a33da81b David Miller       2018-11-26  1564  		prev_image_size = ctx.idx * 4;
c44768a33da81b David Miller       2018-11-26  1565  		cond_resched();
c44768a33da81b David Miller       2018-11-26  1566  	}
c44768a33da81b David Miller       2018-11-26  1567  
7a12b5031c6b94 David S. Miller    2017-04-17  1568  	/* Now we know the actual image size. */
7a12b5031c6b94 David S. Miller    2017-04-17  1569  	image_size = sizeof(u32) * ctx.idx;
7a12b5031c6b94 David S. Miller    2017-04-17  1570  	header = bpf_jit_binary_alloc(image_size, &image_ptr,
7a12b5031c6b94 David S. Miller    2017-04-17  1571  				      sizeof(u32), jit_fill_hole);
7a12b5031c6b94 David S. Miller    2017-04-17  1572  	if (header == NULL) {
7a12b5031c6b94 David S. Miller    2017-04-17  1573  		prog = orig_prog;
7a12b5031c6b94 David S. Miller    2017-04-17  1574  		goto out_off;
7a12b5031c6b94 David S. Miller    2017-04-17  1575  	}
7a12b5031c6b94 David S. Miller    2017-04-17  1576  
7a12b5031c6b94 David S. Miller    2017-04-17  1577  	ctx.image = (u32 *)image_ptr;
5f5a641116391f David Miller       2017-12-22  1578  skip_init_ctx:
7a12b5031c6b94 David S. Miller    2017-04-17  1579  	ctx.idx = 0;
7a12b5031c6b94 David S. Miller    2017-04-17  1580  
7a12b5031c6b94 David S. Miller    2017-04-17  1581  	build_prologue(&ctx);
7a12b5031c6b94 David S. Miller    2017-04-17  1582  
7a12b5031c6b94 David S. Miller    2017-04-17  1583  	if (build_body(&ctx)) {
7a12b5031c6b94 David S. Miller    2017-04-17  1584  		bpf_jit_binary_free(header);
7a12b5031c6b94 David S. Miller    2017-04-17  1585  		prog = orig_prog;
7a12b5031c6b94 David S. Miller    2017-04-17  1586  		goto out_off;
7a12b5031c6b94 David S. Miller    2017-04-17  1587  	}
7a12b5031c6b94 David S. Miller    2017-04-17  1588  
7a12b5031c6b94 David S. Miller    2017-04-17  1589  	build_epilogue(&ctx);
7a12b5031c6b94 David S. Miller    2017-04-17  1590  
c44768a33da81b David Miller       2018-11-26  1591  	if (ctx.idx * 4 != prev_image_size) {
c44768a33da81b David Miller       2018-11-26  1592  		pr_err("bpf_jit: Failed to converge, prev_size=%u size=%d\n",
c44768a33da81b David Miller       2018-11-26  1593  		       prev_image_size, ctx.idx * 4);
c44768a33da81b David Miller       2018-11-26  1594  		bpf_jit_binary_free(header);
c44768a33da81b David Miller       2018-11-26  1595  		prog = orig_prog;
c44768a33da81b David Miller       2018-11-26  1596  		goto out_off;
7a12b5031c6b94 David S. Miller    2017-04-17  1597  	}
7a12b5031c6b94 David S. Miller    2017-04-17  1598  
7a12b5031c6b94 David S. Miller    2017-04-17  1599  	if (bpf_jit_enable > 1)
7a12b5031c6b94 David S. Miller    2017-04-17  1600  		bpf_jit_dump(prog->len, image_size, pass, ctx.image);
7a12b5031c6b94 David S. Miller    2017-04-17  1601  
7a12b5031c6b94 David S. Miller    2017-04-17 @1602  	bpf_flush_icache(header, (u8 *)header + (header->pages * PAGE_SIZE));

:::::: The code at line 1602 was first introduced by commit
:::::: 7a12b5031c6b947cc13918237ae652b536243b76 sparc64: Add eBPF JIT.

:::::: TO: David S. Miller <davem@davemloft.net>
:::::: CC: David S. Miller <davem@davemloft.net>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
