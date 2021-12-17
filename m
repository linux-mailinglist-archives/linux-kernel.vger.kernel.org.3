Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 461E3478CE6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 14:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234190AbhLQN4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 08:56:16 -0500
Received: from mga11.intel.com ([192.55.52.93]:34771 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231667AbhLQN4Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 08:56:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639749376; x=1671285376;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Otmlq2qzc1svuonbnVshGBcOYgOfOSQtapBA8oKj0+k=;
  b=WBOIFkBbmKnvXa+EXNFYYwTeVEg6AdOzf0yYchfH2g5paBYACL6sG4bx
   E15qHtoFuK+/IW7msdXaYrfMZhcO19CYFVLrx1zzSSdm7aMi4AQASiZ+P
   JRniGwMZQRU5tCkMlEOF1gqH99VxAT6qJJg6I66dYpvshsD9U51TSKneJ
   o5xvHJqxG94zmFuxaliImhf42JnVaMYxkloi0itYdftJHHsWrkSaKi/Dl
   SbaOla81VAE0249+zUJ8oD3XIRPoahCIUkZnMTFiaugS2FPBJAm47qxWS
   CZmvt4mtdqsNAPwz7PuURng0FUoZU0CFfGMiROxj2WTjrwcHr3qwlxFAF
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10200"; a="237297003"
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="237297003"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2021 05:56:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="466516199"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 17 Dec 2021 05:56:13 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1myDiX-0004mq-9h; Fri, 17 Dec 2021 13:56:13 +0000
Date:   Fri, 17 Dec 2021 21:56:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kai Huang <kai.huang@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Isaku Yamahata <isaku.yamahata@intel.com>
Subject: [intel-tdx:kvm-upstream 132/152] arch/x86/kvm/mmu/tdp_mmu.c:1258:43:
 warning: variable 'shared' is uninitialized when used here
Message-ID: <202112172122.1aS4OBuJ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git kvm-upstream
head:   bdfe06c17daab60c196ff80c1d98467a1d3734fa
commit: 81d423a001d35c498d0c024fa49bba248a916c55 [132/152] KVM, x86/mmu: Support TDX private mapping for TDP MMU
config: x86_64-randconfig-a013-20211216 (https://download.01.org/0day-ci/archive/20211217/202112172122.1aS4OBuJ-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project dd245bab9fbb364faa1581e4f92ba3119a872fba)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel/tdx/commit/81d423a001d35c498d0c024fa49bba248a916c55
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx kvm-upstream
        git checkout 81d423a001d35c498d0c024fa49bba248a916c55
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/kvm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/x86/kvm/mmu/tdp_mmu.c:1258:43: warning: variable 'shared' is uninitialized when used here [-Wuninitialized]
                   tdp_mmu_zap_alias_spte(vcpu, gfn_alias, shared);
                                                           ^~~~~~
   arch/x86/kvm/mmu/tdp_mmu.c:1233:13: note: initialize the variable 'shared' to silence this warning
           bool shared;
                      ^
                       = 0
>> arch/x86/kvm/mmu/tdp_mmu.c:1409:32: warning: operator '?:' has lower precedence than '|'; '|' will be evaluated first [-Wbitwise-conditional-parentheses]
                   is_large_pte(iter->old_spte) ? PT_PAGE_SIZE_MASK : 0;
                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ^
   arch/x86/kvm/mmu/tdp_mmu.c:1409:32: note: place parentheses around the '|' expression to silence this warning
                   is_large_pte(iter->old_spte) ? PT_PAGE_SIZE_MASK : 0;
                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ^
   arch/x86/kvm/mmu/tdp_mmu.c:1409:32: note: place parentheses around the '?:' expression to evaluate it first
                   is_large_pte(iter->old_spte) ? PT_PAGE_SIZE_MASK : 0;
                                                ^
                   (                                                   )
   2 warnings generated.


vim +/shared +1258 arch/x86/kvm/mmu/tdp_mmu.c

  1219	
  1220	/*
  1221	 * Handle a TDP page fault (NPT/EPT violation/misconfiguration) by installing
  1222	 * page tables and SPTEs to translate the faulting guest physical address.
  1223	 */
  1224	int kvm_tdp_mmu_map(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
  1225	{
  1226		struct kvm_mmu *mmu = vcpu->arch.mmu;
  1227		struct tdp_iter iter;
  1228		struct kvm_mmu_page *sp;
  1229		u64 *child_pt;
  1230		u64 new_spte;
  1231		gfn_t raw_gfn;
  1232		bool is_private;
  1233		bool shared;
  1234		int ret;
  1235	
  1236		kvm_mmu_hugepage_adjust(vcpu, fault);
  1237	
  1238		trace_kvm_mmu_spte_requested(fault);
  1239	
  1240		rcu_read_lock();
  1241	
  1242		raw_gfn = fault->addr >> PAGE_SHIFT;
  1243		is_private = kvm_is_private_gfn(vcpu->kvm, raw_gfn);
  1244	
  1245		if (is_error_noslot_pfn(fault->pfn) ||
  1246				kvm_is_reserved_pfn(fault->pfn)) {
  1247			if (is_private) {
  1248				rcu_read_unlock();
  1249				return -EFAULT;
  1250			}
  1251		} else if (vcpu->kvm->arch.gfn_shared_mask) {
  1252			gfn_t gfn_alias = raw_gfn ^ vcpu->kvm->arch.gfn_shared_mask;
  1253			/*
  1254			 * At given time, for one GPA, only one mapping can be valid
  1255			 * (either private, or shared).  Zap aliasing mapping to make
  1256			 * sure of it.  Also see comment in direct_page_fault().
  1257			 */
> 1258			tdp_mmu_zap_alias_spte(vcpu, gfn_alias, shared);
  1259		}
  1260	
  1261		tdp_mmu_for_each_pte(iter, mmu, is_private, raw_gfn, raw_gfn + 1) {
  1262			if (fault->nx_huge_page_workaround_enabled)
  1263				disallowed_hugepage_adjust(fault, iter.old_spte, iter.level);
  1264	
  1265			if (iter.level == fault->goal_level)
  1266				break;
  1267	
  1268			/*
  1269			 * If there is an SPTE mapping a large page at a higher level
  1270			 * than the target, that SPTE must be cleared and replaced
  1271			 * with a non-leaf SPTE.
  1272			 */
  1273			if (is_shadow_present_pte(iter.old_spte) &&
  1274			    is_large_pte(iter.old_spte)) {
  1275				if (!tdp_mmu_zap_spte_flush_excl_or_shared(vcpu->kvm,
  1276							&iter, shared))
  1277					break;
  1278				/*
  1279				 * TODO: large page support.
  1280				 * Doesn't support large page for TDX now
  1281				 */
  1282				WARN_ON(is_private_spte(&iter.old_spte));
  1283	
  1284	
  1285				/*
  1286				 * The iter must explicitly re-read the spte here
  1287				 * because the new value informs the !present
  1288				 * path below.
  1289				 */
  1290				iter.old_spte = READ_ONCE(*rcu_dereference(iter.sptep));
  1291			}
  1292	
  1293			if (!is_shadow_present_pte(iter.old_spte)) {
  1294	
  1295				/*
  1296				 * TODO: large page support.
  1297				 * Not expecting blocked private SPTE points to a
  1298				 * large page now.
  1299				 */
  1300				WARN_ON(is_zapped_private_pte(iter.old_spte) &&
  1301						is_large_pte(iter.old_spte));
  1302	
  1303				/*
  1304				 * If SPTE has been frozen by another thread, just
  1305				 * give up and retry, avoiding unnecessary page table
  1306				 * allocation and free.
  1307				 */
  1308				if (is_removed_spte(iter.old_spte))
  1309					break;
  1310	
  1311				sp = alloc_tdp_mmu_page(vcpu,
  1312						tdp_iter_gfn_unalias(vcpu->kvm, &iter),
  1313						iter.level - 1, is_private);
  1314				child_pt = sp->spt;
  1315	
  1316				new_spte = make_nonleaf_spte(child_pt,
  1317							     !shadow_accessed_mask);
  1318	
  1319				if (tdp_mmu_set_spte_excl_or_shared(vcpu->kvm, &iter,
  1320							new_spte, shared)) {
  1321					tdp_mmu_link_page(vcpu->kvm, sp,
  1322							  fault->huge_page_disallowed &&
  1323							  fault->req_level >= iter.level);
  1324	
  1325					trace_kvm_mmu_get_page(sp, true);
  1326				} else {
  1327					tdp_mmu_free_sp(sp);
  1328					break;
  1329				}
  1330			}
  1331		}
  1332	
  1333		if (iter.level != fault->goal_level) {
  1334			rcu_read_unlock();
  1335			return RET_PF_RETRY;
  1336		}
  1337	
  1338		ret = tdp_mmu_map_handle_target_level(vcpu, fault, &iter, shared);
  1339		rcu_read_unlock();
  1340	
  1341		return ret;
  1342	}
  1343	
  1344	static bool block_private_gfn_range(struct kvm *kvm,
  1345					    struct kvm_gfn_range *range);
  1346	
  1347	bool kvm_tdp_mmu_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range,
  1348					 bool flush)
  1349	{
  1350		struct kvm_mmu_page *root;
  1351	
  1352		for_each_tdp_mmu_root_yield_safe(kvm, root, range->slot->as_id, false) {
  1353			if (is_private_sp(root))
  1354				flush |= block_private_gfn_range(kvm, range);
  1355			else
  1356				flush = zap_gfn_range(kvm, root, range->start, range->end,
  1357					       range->may_block, flush, false);
  1358		}
  1359	
  1360		return flush;
  1361	}
  1362	
  1363	typedef bool (*tdp_handler_t)(struct kvm *kvm, struct tdp_iter *iter,
  1364				      struct kvm_gfn_range *range);
  1365	
  1366	static __always_inline bool kvm_tdp_mmu_handle_gfn(struct kvm *kvm,
  1367							   struct kvm_gfn_range *range,
  1368							   tdp_handler_t handler)
  1369	{
  1370		struct kvm_mmu_page *root;
  1371		struct tdp_iter iter;
  1372		bool ret = false;
  1373	
  1374		rcu_read_lock();
  1375	
  1376		/*
  1377		 * Don't support rescheduling, none of the MMU notifiers that funnel
  1378		 * into this helper allow blocking; it'd be dead, wasteful code.
  1379		 */
  1380		for_each_tdp_mmu_root(kvm, root, range->slot->as_id) {
  1381			/*
  1382			 * For TDX shared mapping, set GFN shared bit to the range,
  1383			 * so the handler() doesn't need to set it, to avoid duplicated
  1384			 * code in multiple handler()s.
  1385			 */
  1386			if (kvm->arch.gfn_shared_mask && !is_private_sp(root)) {
  1387				range->start |= kvm->arch.gfn_shared_mask;
  1388				range->end |= kvm->arch.gfn_shared_mask;
  1389			}
  1390			tdp_root_for_each_leaf_pte(iter, root, range->start, range->end)
  1391				ret |= handler(kvm, &iter, range);
  1392		}
  1393	
  1394		rcu_read_unlock();
  1395	
  1396		return ret;
  1397	}
  1398	
  1399	static bool block_private_spte(struct kvm *kvm, struct tdp_iter *iter,
  1400					    struct kvm_gfn_range *range)
  1401	{
  1402		u64 new_spte;
  1403	
  1404		if (WARN_ON(!is_private_spte(iter->sptep)))
  1405			return false;
  1406	
  1407		new_spte = SPTE_PRIVATE_ZAPPED |
  1408			(spte_to_pfn(iter->old_spte) << PAGE_SHIFT) |
> 1409			is_large_pte(iter->old_spte) ? PT_PAGE_SIZE_MASK : 0;
  1410	
  1411		WRITE_ONCE(*rcu_dereference(iter->sptep), new_spte);
  1412	
  1413		static_call(kvm_x86_zap_private_spte)(kvm, iter->gfn, iter->level);
  1414	
  1415		return true;
  1416	}
  1417	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
