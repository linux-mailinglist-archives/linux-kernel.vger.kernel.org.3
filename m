Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06F90564C17
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 05:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbiGDDoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 23:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiGDDn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 23:43:58 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF2725FD
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 20:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656906237; x=1688442237;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=j8EJKJgeVb+iVOuSYOumYcr62PeI4CzDf/51rpS7iR0=;
  b=fdO6EiSGbppvfddMsX7xO0eW62espqgEQ0qsf01K8wVbIJCSaCslNQQl
   IaXpNFA5GyNaob/2kt0h7QVWu6ZtOm+3HFw/wcBmzJCRnZiMzOVc92AvV
   Oshr7OCWFLBPb3o17YavXW04cCDPrrUtDhsnpeLz0LTGriQ8PxhADgjkF
   7w9YLvrs40g1rpYKXuit4L3UUkWD+aUCNqx22o0jDILgT1tTWt4vD8q4R
   TT4JCzwmv/AIlGGbp7d7BPSxpJPOG1ZZVw1J205Qni7HEwydXRziHUXqF
   sKcq72umM8cwNxhuDpLClZzPtN0fcmwl9TPhx9MgNLoIjerxZiiJsAAd/
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10397"; a="283753481"
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="283753481"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2022 20:43:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="919163629"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 03 Jul 2022 20:43:53 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o8D04-000HPP-Dj;
        Mon, 04 Jul 2022 03:43:52 +0000
Date:   Mon, 4 Jul 2022 11:42:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jakub =?utf-8?Q?Mat=C4=9Bna?= <matenajakub@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [akpm-mm:mm-unstable 102/232] mm/mmap.c:1094:9: error: 'area'
 undeclared
Message-ID: <202207041144.WB9XlrTL-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-unstable
head:   ff9d7221f1fc9bddb4f71f7501154c68b6942b9b
commit: 24a134b0c0a857bbf193eb7b3d8fcbbf77517c5f [102/232] mm: refactor of vma_merge()
config: powerpc-allnoconfig (https://download.01.org/0day-ci/archive/20220704/202207041144.WB9XlrTL-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?id=24a134b0c0a857bbf193eb7b3d8fcbbf77517c5f
        git remote add akpm-mm https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git
        git fetch --no-tags akpm-mm mm-unstable
        git checkout 24a134b0c0a857bbf193eb7b3d8fcbbf77517c5f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   mm/mmap.c: In function 'vma_merge':
>> mm/mmap.c:1094:9: error: 'area' undeclared (first use in this function)
    1094 |         area = next;
         |         ^~~~
   mm/mmap.c:1094:9: note: each undeclared identifier is reported only once for each function it appears in
   mm/mmap.c:1084:14: warning: unused variable 'merge_next' [-Wunused-variable]
    1084 |         bool merge_next = false;
         |              ^~~~~~~~~~
   mm/mmap.c:1083:14: warning: unused variable 'merge_prev' [-Wunused-variable]
    1083 |         bool merge_prev = false;
         |              ^~~~~~~~~~
   mm/mmap.c:1081:45: warning: unused variable 'res' [-Wunused-variable]
    1081 |         struct vm_area_struct *mid, *next, *res;
         |                                             ^~~
   mm/mmap.c:1081:32: warning: unused variable 'mid' [-Wunused-variable]
    1081 |         struct vm_area_struct *mid, *next, *res;
         |                                ^~~


vim +/area +1094 mm/mmap.c

^1da177e4c3f41 Linus Torvalds     2005-04-16  1028  
^1da177e4c3f41 Linus Torvalds     2005-04-16  1029  /*
9a10064f5625d5 Colin Cross        2022-01-14  1030   * Given a mapping request (addr,end,vm_flags,file,pgoff,anon_name),
9a10064f5625d5 Colin Cross        2022-01-14  1031   * figure out whether that can be merged with its predecessor or its
9a10064f5625d5 Colin Cross        2022-01-14  1032   * successor.  Or both (it neatly fills a hole).
^1da177e4c3f41 Linus Torvalds     2005-04-16  1033   *
^1da177e4c3f41 Linus Torvalds     2005-04-16  1034   * In most cases - when called for mmap, brk or mremap - [addr,end) is
^1da177e4c3f41 Linus Torvalds     2005-04-16  1035   * certain not to be mapped by the time vma_merge is called; but when
^1da177e4c3f41 Linus Torvalds     2005-04-16  1036   * called for mprotect, it is certain to be already mapped (either at
^1da177e4c3f41 Linus Torvalds     2005-04-16  1037   * an offset within prev, or at the start of next), and the flags of
^1da177e4c3f41 Linus Torvalds     2005-04-16  1038   * this area are about to be changed to vm_flags - and the no-change
^1da177e4c3f41 Linus Torvalds     2005-04-16  1039   * case has already been eliminated.
^1da177e4c3f41 Linus Torvalds     2005-04-16  1040   *
^1da177e4c3f41 Linus Torvalds     2005-04-16  1041   * The following mprotect cases have to be considered, where AAAA is
^1da177e4c3f41 Linus Torvalds     2005-04-16  1042   * the area passed down from mprotect_fixup, never extending beyond one
^1da177e4c3f41 Linus Torvalds     2005-04-16  1043   * vma, PPPPPP is the prev vma specified, and NNNNNN the next vma after:
^1da177e4c3f41 Linus Torvalds     2005-04-16  1044   *
5d42ab293f5181 Wei Yang           2019-11-30  1045   *     AAAA             AAAA                   AAAA
5d42ab293f5181 Wei Yang           2019-11-30  1046   *    PPPPPPNNNNNN    PPPPPPNNNNNN       PPPPPPNNNNNN
5d42ab293f5181 Wei Yang           2019-11-30  1047   *    cannot merge    might become       might become
5d42ab293f5181 Wei Yang           2019-11-30  1048   *                    PPNNNNNNNNNN       PPPPPPPPPPNN
5d42ab293f5181 Wei Yang           2019-11-30  1049   *    mmap, brk or    case 4 below       case 5 below
5d42ab293f5181 Wei Yang           2019-11-30  1050   *    mremap move:
5d42ab293f5181 Wei Yang           2019-11-30  1051   *                        AAAA               AAAA
5d42ab293f5181 Wei Yang           2019-11-30  1052   *                    PPPP    NNNN       PPPPNNNNXXXX
5d42ab293f5181 Wei Yang           2019-11-30  1053   *                    might become       might become
5d42ab293f5181 Wei Yang           2019-11-30  1054   *                    PPPPPPPPPPPP 1 or  PPPPPPPPPPPP 6 or
5d42ab293f5181 Wei Yang           2019-11-30  1055   *                    PPPPPPPPNNNN 2 or  PPPPPPPPXXXX 7 or
5d42ab293f5181 Wei Yang           2019-11-30  1056   *                    PPPPNNNNNNNN 3     PPPPXXXXXXXX 8
^1da177e4c3f41 Linus Torvalds     2005-04-16  1057   *
8bb4e7a2ee26c0 Wei Yang           2019-03-05  1058   * It is important for case 8 that the vma NNNN overlapping the
e86f15ee64d8ee Andrea Arcangeli   2016-10-07  1059   * region AAAA is never going to extended over XXXX. Instead XXXX must
e86f15ee64d8ee Andrea Arcangeli   2016-10-07  1060   * be extended in region AAAA and NNNN must be removed. This way in
e86f15ee64d8ee Andrea Arcangeli   2016-10-07  1061   * all cases where vma_merge succeeds, the moment vma_adjust drops the
e86f15ee64d8ee Andrea Arcangeli   2016-10-07  1062   * rmap_locks, the properties of the merged vma will be already
e86f15ee64d8ee Andrea Arcangeli   2016-10-07  1063   * correct for the whole merged range. Some of those properties like
e86f15ee64d8ee Andrea Arcangeli   2016-10-07  1064   * vm_page_prot/vm_flags may be accessed by rmap_walks and they must
e86f15ee64d8ee Andrea Arcangeli   2016-10-07  1065   * be correct for the whole merged range immediately after the
e86f15ee64d8ee Andrea Arcangeli   2016-10-07  1066   * rmap_locks are released. Otherwise if XXXX would be removed and
e86f15ee64d8ee Andrea Arcangeli   2016-10-07  1067   * NNNN would be extended over the XXXX range, remove_migration_ptes
e86f15ee64d8ee Andrea Arcangeli   2016-10-07  1068   * or other rmap walkers (if working on addresses beyond the "end"
e86f15ee64d8ee Andrea Arcangeli   2016-10-07  1069   * parameter) may establish ptes with the wrong permissions of NNNN
e86f15ee64d8ee Andrea Arcangeli   2016-10-07  1070   * instead of the right permissions of XXXX.
^1da177e4c3f41 Linus Torvalds     2005-04-16  1071   */
^1da177e4c3f41 Linus Torvalds     2005-04-16  1072  struct vm_area_struct *vma_merge(struct mm_struct *mm,
^1da177e4c3f41 Linus Torvalds     2005-04-16  1073  			struct vm_area_struct *prev, unsigned long addr,
^1da177e4c3f41 Linus Torvalds     2005-04-16  1074  			unsigned long end, unsigned long vm_flags,
^1da177e4c3f41 Linus Torvalds     2005-04-16  1075  			struct anon_vma *anon_vma, struct file *file,
19a809afe2fe08 Andrea Arcangeli   2015-09-04  1076  			pgoff_t pgoff, struct mempolicy *policy,
9a10064f5625d5 Colin Cross        2022-01-14  1077  			struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
5c26f6ac9416b6 Suren Baghdasaryan 2022-03-04  1078  			struct anon_vma_name *anon_name)
^1da177e4c3f41 Linus Torvalds     2005-04-16  1079  {
^1da177e4c3f41 Linus Torvalds     2005-04-16  1080  	pgoff_t pglen = (end - addr) >> PAGE_SHIFT;
24a134b0c0a857 Jakub Matěna       2022-06-03  1081  	struct vm_area_struct *mid, *next, *res;
24a134b0c0a857 Jakub Matěna       2022-06-03  1082  	int err = -1;
24a134b0c0a857 Jakub Matěna       2022-06-03  1083  	bool merge_prev = false;
24a134b0c0a857 Jakub Matěna       2022-06-03  1084  	bool merge_next = false;
^1da177e4c3f41 Linus Torvalds     2005-04-16  1085  
^1da177e4c3f41 Linus Torvalds     2005-04-16  1086  	/*
^1da177e4c3f41 Linus Torvalds     2005-04-16  1087  	 * We later require that vma->vm_flags == vm_flags,
^1da177e4c3f41 Linus Torvalds     2005-04-16  1088  	 * so this tests vma->vm_flags & VM_SPECIAL, too.
^1da177e4c3f41 Linus Torvalds     2005-04-16  1089  	 */
^1da177e4c3f41 Linus Torvalds     2005-04-16  1090  	if (vm_flags & VM_SPECIAL)
^1da177e4c3f41 Linus Torvalds     2005-04-16  1091  		return NULL;
^1da177e4c3f41 Linus Torvalds     2005-04-16  1092  
584b4cb00d55ac Liam R. Howlett    2022-06-21  1093  	next = find_vma(mm, prev ? prev->vm_end : 0);
^1da177e4c3f41 Linus Torvalds     2005-04-16 @1094  	area = next;
e86f15ee64d8ee Andrea Arcangeli   2016-10-07  1095  	if (area && area->vm_end == end)		/* cases 6, 7, 8 */
584b4cb00d55ac Liam R. Howlett    2022-06-21  1096  		next = find_vma(mm, next->vm_end);
^1da177e4c3f41 Linus Torvalds     2005-04-16  1097  
e86f15ee64d8ee Andrea Arcangeli   2016-10-07  1098  	/* verify some invariant that must be enforced by the caller */
e86f15ee64d8ee Andrea Arcangeli   2016-10-07  1099  	VM_WARN_ON(prev && addr <= prev->vm_start);
e86f15ee64d8ee Andrea Arcangeli   2016-10-07  1100  	VM_WARN_ON(area && end > area->vm_end);
e86f15ee64d8ee Andrea Arcangeli   2016-10-07  1101  	VM_WARN_ON(addr >= end);
e86f15ee64d8ee Andrea Arcangeli   2016-10-07  1102  
^1da177e4c3f41 Linus Torvalds     2005-04-16  1103  	/*
^1da177e4c3f41 Linus Torvalds     2005-04-16  1104  	 * Can it merge with the predecessor?
^1da177e4c3f41 Linus Torvalds     2005-04-16  1105  	 */
^1da177e4c3f41 Linus Torvalds     2005-04-16  1106  	if (prev && prev->vm_end == addr &&
^1da177e4c3f41 Linus Torvalds     2005-04-16  1107  			mpol_equal(vma_policy(prev), policy) &&
^1da177e4c3f41 Linus Torvalds     2005-04-16  1108  			can_vma_merge_after(prev, vm_flags,
19a809afe2fe08 Andrea Arcangeli   2015-09-04  1109  					    anon_vma, file, pgoff,
9a10064f5625d5 Colin Cross        2022-01-14  1110  					    vm_userfaultfd_ctx, anon_name)) {
^1da177e4c3f41 Linus Torvalds     2005-04-16  1111  		/*
^1da177e4c3f41 Linus Torvalds     2005-04-16  1112  		 * OK, it can.  Can we now merge in the successor as well?
^1da177e4c3f41 Linus Torvalds     2005-04-16  1113  		 */
^1da177e4c3f41 Linus Torvalds     2005-04-16  1114  		if (next && end == next->vm_start &&
^1da177e4c3f41 Linus Torvalds     2005-04-16  1115  				mpol_equal(policy, vma_policy(next)) &&
^1da177e4c3f41 Linus Torvalds     2005-04-16  1116  				can_vma_merge_before(next, vm_flags,
19a809afe2fe08 Andrea Arcangeli   2015-09-04  1117  						     anon_vma, file,
19a809afe2fe08 Andrea Arcangeli   2015-09-04  1118  						     pgoff+pglen,
9a10064f5625d5 Colin Cross        2022-01-14  1119  						     vm_userfaultfd_ctx, anon_name) &&
^1da177e4c3f41 Linus Torvalds     2005-04-16  1120  				is_mergeable_anon_vma(prev->anon_vma,
965f55dea0e331 Shaohua Li         2011-05-24  1121  						      next->anon_vma, NULL)) {
^1da177e4c3f41 Linus Torvalds     2005-04-16  1122  							/* cases 1, 6 */
e86f15ee64d8ee Andrea Arcangeli   2016-10-07  1123  			err = __vma_adjust(prev, prev->vm_start,
e86f15ee64d8ee Andrea Arcangeli   2016-10-07  1124  					 next->vm_end, prev->vm_pgoff, NULL,
e86f15ee64d8ee Andrea Arcangeli   2016-10-07  1125  					 prev);
^1da177e4c3f41 Linus Torvalds     2005-04-16  1126  		} else					/* cases 2, 5, 7 */
e86f15ee64d8ee Andrea Arcangeli   2016-10-07  1127  			err = __vma_adjust(prev, prev->vm_start,
e86f15ee64d8ee Andrea Arcangeli   2016-10-07  1128  					 end, prev->vm_pgoff, NULL, prev);
5beb49305251e5 Rik van Riel       2010-03-05  1129  		if (err)
5beb49305251e5 Rik van Riel       2010-03-05  1130  			return NULL;
c791576c60288c Yang Shi           2022-05-19  1131  		khugepaged_enter_vma(prev, vm_flags);
^1da177e4c3f41 Linus Torvalds     2005-04-16  1132  		return prev;
^1da177e4c3f41 Linus Torvalds     2005-04-16  1133  	}
^1da177e4c3f41 Linus Torvalds     2005-04-16  1134  
^1da177e4c3f41 Linus Torvalds     2005-04-16  1135  	/*
^1da177e4c3f41 Linus Torvalds     2005-04-16  1136  	 * Can this new request be merged in front of next?
^1da177e4c3f41 Linus Torvalds     2005-04-16  1137  	 */
^1da177e4c3f41 Linus Torvalds     2005-04-16  1138  	if (next && end == next->vm_start &&
^1da177e4c3f41 Linus Torvalds     2005-04-16  1139  			mpol_equal(policy, vma_policy(next)) &&
^1da177e4c3f41 Linus Torvalds     2005-04-16  1140  			can_vma_merge_before(next, vm_flags,
19a809afe2fe08 Andrea Arcangeli   2015-09-04  1141  					     anon_vma, file, pgoff+pglen,
9a10064f5625d5 Colin Cross        2022-01-14  1142  					     vm_userfaultfd_ctx, anon_name)) {
^1da177e4c3f41 Linus Torvalds     2005-04-16  1143  		if (prev && addr < prev->vm_end)	/* case 4 */
e86f15ee64d8ee Andrea Arcangeli   2016-10-07  1144  			err = __vma_adjust(prev, prev->vm_start,
e86f15ee64d8ee Andrea Arcangeli   2016-10-07  1145  					 addr, prev->vm_pgoff, NULL, next);
e86f15ee64d8ee Andrea Arcangeli   2016-10-07  1146  		else {					/* cases 3, 8 */
e86f15ee64d8ee Andrea Arcangeli   2016-10-07  1147  			err = __vma_adjust(area, addr, next->vm_end,
e86f15ee64d8ee Andrea Arcangeli   2016-10-07  1148  					 next->vm_pgoff - pglen, NULL, next);
e86f15ee64d8ee Andrea Arcangeli   2016-10-07  1149  			/*
e86f15ee64d8ee Andrea Arcangeli   2016-10-07  1150  			 * In case 3 area is already equal to next and
e86f15ee64d8ee Andrea Arcangeli   2016-10-07  1151  			 * this is a noop, but in case 8 "area" has
e86f15ee64d8ee Andrea Arcangeli   2016-10-07  1152  			 * been removed and next was expanded over it.
e86f15ee64d8ee Andrea Arcangeli   2016-10-07  1153  			 */
e86f15ee64d8ee Andrea Arcangeli   2016-10-07  1154  			area = next;
e86f15ee64d8ee Andrea Arcangeli   2016-10-07  1155  		}
5beb49305251e5 Rik van Riel       2010-03-05  1156  		if (err)
5beb49305251e5 Rik van Riel       2010-03-05  1157  			return NULL;
c791576c60288c Yang Shi           2022-05-19  1158  		khugepaged_enter_vma(area, vm_flags);
^1da177e4c3f41 Linus Torvalds     2005-04-16  1159  		return area;
^1da177e4c3f41 Linus Torvalds     2005-04-16  1160  	}
^1da177e4c3f41 Linus Torvalds     2005-04-16  1161  
^1da177e4c3f41 Linus Torvalds     2005-04-16  1162  	return NULL;
^1da177e4c3f41 Linus Torvalds     2005-04-16  1163  }
^1da177e4c3f41 Linus Torvalds     2005-04-16  1164  

:::::: The code at line 1094 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
