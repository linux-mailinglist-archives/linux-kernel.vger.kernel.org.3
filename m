Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 917534CCD66
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 06:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238227AbiCDFmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 00:42:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235323AbiCDFmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 00:42:31 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D626154721
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 21:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646372505; x=1677908505;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Q0ZPTvvoQq5YmgFEKWDeKblCeuQlWe7QCuhOqxpmCXU=;
  b=nWcSH1r1QYZqoYAK4+2oIY6301HiYGXvi0sgBJ2s4MgeMHvRh49/W3/c
   upd41AH1CQbzyoUAdxi8pu7QPGNfIbJRsNK2jgzsQ/wddaDTpQoy8UGYk
   3G1tyP3i6LHHvLGjKHxQvwVqVWLwU19a/WEj3MjPDb0c1wSIKRYphAJf+
   izuchSjFDFpzx2WeJV3OYOgOS9fajxWp45zFUTyDr8mPAl7Qz2PJEtUT5
   ImEZkmfpAyzN0+AckxZP8ULkRTz4CsRNtqDQTWLFxVg9SNdJonlOUKrs1
   J0bTVVQjL8FuJGUEn4kHnX69xOq9a0XvWlyc2yj3fbjeVgud1mQffRdAz
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10275"; a="278589777"
X-IronPort-AV: E=Sophos;i="5.90,154,1643702400"; 
   d="scan'208";a="278589777"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 21:41:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,154,1643702400"; 
   d="scan'208";a="494224856"
Received: from lkp-server01.sh.intel.com (HELO ccb16ba0ecc3) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 03 Mar 2022 21:41:42 -0800
Received: from kbuild by ccb16ba0ecc3 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nQ0hC-0001LG-2K; Fri, 04 Mar 2022 05:41:42 +0000
Date:   Fri, 4 Mar 2022 13:41:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Connor O'Brien <connoro@google.com>
Subject: [ammarfaizi2-block:google/android/kernel/common/android-4.14-stable
 642/9999] kernel/bpf/core.c:1532:34: sparse: sparse: incorrect type in
 initializer (different address spaces)
Message-ID: <202203041333.HKzojjDs-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android-4.14-stable
head:   4ab5bac1598e3ed91a6267f6cada336467312112
commit: 5179a6a673e1bff5b9823b1317c59127bacd4641 [642/9999] UPSTREAM: bpf: permit multiple bpf attachments for a single perf event
config: i386-randconfig-s001-20211101 (https://download.01.org/0day-ci/archive/20220304/202203041333.HKzojjDs-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/ammarfaizi2/linux-block/commit/5179a6a673e1bff5b9823b1317c59127bacd4641
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android-4.14-stable
        git checkout 5179a6a673e1bff5b9823b1317c59127bacd4641
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash drivers/gpu/drm/virtio/ kernel/bpf/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   kernel/bpf/core.c:1095:43: sparse: sparse: arithmetics on pointers to functions
   kernel/bpf/core.c:1514:31: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected struct bpf_prog_array [noderef] <asn:4> * @@     got void * @@
   kernel/bpf/core.c:1514:31: sparse:     expected struct bpf_prog_array [noderef] <asn:4> *
   kernel/bpf/core.c:1514:31: sparse:     got void *
   kernel/bpf/core.c:1518:17: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected struct bpf_prog_array [noderef] <asn:4> * @@     got struct bpf_prog_array * @@
   kernel/bpf/core.c:1518:17: sparse:     expected struct bpf_prog_array [noderef] <asn:4> *
   kernel/bpf/core.c:1518:17: sparse:     got struct bpf_prog_array *
   kernel/bpf/core.c:1526:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct callback_head *head @@     got struct callback_head [noderef] <asn:4> * @@
   kernel/bpf/core.c:1526:9: sparse:     expected struct callback_head *head
   kernel/bpf/core.c:1526:9: sparse:     got struct callback_head [noderef] <asn:4> *
>> kernel/bpf/core.c:1532:34: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct bpf_prog **prog @@     got struct bpf_prog *[noderef] <asn:4> * @@
   kernel/bpf/core.c:1532:34: sparse:     expected struct bpf_prog **prog
   kernel/bpf/core.c:1532:34: sparse:     got struct bpf_prog *[noderef] <asn:4> *
>> kernel/bpf/core.c:1555:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct bpf_prog **existing_prog @@     got struct bpf_prog *[noderef] <asn:4> * @@
   kernel/bpf/core.c:1555:31: sparse:     expected struct bpf_prog **existing_prog
   kernel/bpf/core.c:1555:31: sparse:     got struct bpf_prog *[noderef] <asn:4> *
>> kernel/bpf/core.c:1577:15: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct bpf_prog_array *array @@     got struct bpf_prog_array [noderef] <asn:4> * @@
   kernel/bpf/core.c:1577:15: sparse:     expected struct bpf_prog_array *array
   kernel/bpf/core.c:1577:15: sparse:     got struct bpf_prog_array [noderef] <asn:4> *
>> kernel/bpf/core.c:1583:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct bpf_prog **[assigned] existing_prog @@     got struct bpf_prog *[noderef] <asn:4> * @@
   kernel/bpf/core.c:1583:31: sparse:     expected struct bpf_prog **[assigned] existing_prog
   kernel/bpf/core.c:1583:31: sparse:     got struct bpf_prog *[noderef] <asn:4> *
   kernel/bpf/core.c: note: in included file (through include/trace/trace_events.h, include/trace/define_trace.h, include/trace/events/bpf.h, ...):
   include/trace/events/bpf.h:56:1: sparse: sparse: Using plain integer as NULL pointer
   include/trace/events/bpf.h:92:1: sparse: sparse: Using plain integer as NULL pointer
   include/trace/events/bpf.h:117:1: sparse: sparse: Using plain integer as NULL pointer
   include/trace/events/bpf.h:188:1: sparse: sparse: Using plain integer as NULL pointer
   include/trace/events/bpf.h:228:1: sparse: sparse: Using plain integer as NULL pointer
   include/trace/events/bpf.h:282:1: sparse: sparse: Using plain integer as NULL pointer
   include/trace/events/bpf.h:312:1: sparse: sparse: Using plain integer as NULL pointer
   kernel/bpf/core.c: note: in included file (through include/trace/trace_events.h, include/trace/define_trace.h, include/trace/events/xdp.h, ...):
   include/trace/events/xdp.h:28:1: sparse: sparse: Using plain integer as NULL pointer
   include/trace/events/xdp.h:53:1: sparse: sparse: Using plain integer as NULL pointer
   include/trace/events/xdp.h:111:1: sparse: sparse: Using plain integer as NULL pointer
   include/trace/events/xdp.h:126:1: sparse: sparse: Using plain integer as NULL pointer

vim +1532 kernel/bpf/core.c

  1528	
  1529	void bpf_prog_array_delete_safe(struct bpf_prog_array __rcu *progs,
  1530					struct bpf_prog *old_prog)
  1531	{
> 1532		struct bpf_prog **prog = progs->progs;
  1533	
  1534		for (; *prog; prog++)
  1535			if (*prog == old_prog) {
  1536				WRITE_ONCE(*prog, &dummy_bpf_prog.prog);
  1537				break;
  1538			}
  1539	}
  1540	
  1541	int bpf_prog_array_copy(struct bpf_prog_array __rcu *old_array,
  1542				struct bpf_prog *exclude_prog,
  1543				struct bpf_prog *include_prog,
  1544				struct bpf_prog_array **new_array)
  1545	{
  1546		int new_prog_cnt, carry_prog_cnt = 0;
  1547		struct bpf_prog **existing_prog;
  1548		struct bpf_prog_array *array;
  1549		int new_prog_idx = 0;
  1550	
  1551		/* Figure out how many existing progs we need to carry over to
  1552		 * the new array.
  1553		 */
  1554		if (old_array) {
> 1555			existing_prog = old_array->progs;
  1556			for (; *existing_prog; existing_prog++) {
  1557				if (*existing_prog != exclude_prog &&
  1558				    *existing_prog != &dummy_bpf_prog.prog)
  1559					carry_prog_cnt++;
  1560				if (*existing_prog == include_prog)
  1561					return -EEXIST;
  1562			}
  1563		}
  1564	
  1565		/* How many progs (not NULL) will be in the new array? */
  1566		new_prog_cnt = carry_prog_cnt;
  1567		if (include_prog)
  1568			new_prog_cnt += 1;
  1569	
  1570		/* Do we have any prog (not NULL) in the new array? */
  1571		if (!new_prog_cnt) {
  1572			*new_array = NULL;
  1573			return 0;
  1574		}
  1575	
  1576		/* +1 as the end of prog_array is marked with NULL */
> 1577		array = bpf_prog_array_alloc(new_prog_cnt + 1, GFP_KERNEL);
  1578		if (!array)
  1579			return -ENOMEM;
  1580	
  1581		/* Fill in the new prog array */
  1582		if (carry_prog_cnt) {
> 1583			existing_prog = old_array->progs;
  1584			for (; *existing_prog; existing_prog++)
  1585				if (*existing_prog != exclude_prog &&
  1586				    *existing_prog != &dummy_bpf_prog.prog)
  1587					array->progs[new_prog_idx++] = *existing_prog;
  1588		}
  1589		if (include_prog)
  1590			array->progs[new_prog_idx++] = include_prog;
  1591		array->progs[new_prog_idx] = NULL;
  1592		*new_array = array;
  1593		return 0;
  1594	}
  1595	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
