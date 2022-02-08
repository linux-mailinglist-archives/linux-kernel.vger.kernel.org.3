Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BED84AD105
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 06:33:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbiBHFdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 00:33:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232235AbiBHFUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 00:20:19 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5638C0401E9
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 21:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644297617; x=1675833617;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8MrsoLNTPErayS03VO1FikOqS8ZN9khF0wrgeZHsh+8=;
  b=SPKl8h4xJAl0ooQQmwqbG8ELjLY/9I1IhI6oN0PHn9lVFMb+MPRkJMmj
   s/eyCi413EnCEnm2+mxRcu7r1fuHWRU6kmodGtUK/wY1r4QXEPXxVSId8
   SqxOVr0Siz/pbQRjvOu0uYckl/l0wuR5s+4k9avnsWeJqZE4oAHv2pHxm
   Q5jxhoiHyqclteTxrcn2NBqBKujcqtsqhYTRjuM9xK3KoAJ7a7O+p11vD
   WhO/3Z5N5VFc4yk6EO44X2U67NyvndFf9byz7Y7vQ7CZ5TfrZnuqkXL3I
   3rkk5BuE4BrfCg00Dkz+Hhh+PsVvtSFsqOLCZ4xeVVGX3asW5/jbA0IbT
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="335276360"
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="335276360"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 21:20:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="567728816"
Received: from lkp-server01.sh.intel.com (HELO 9dd77a123018) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 07 Feb 2022 21:20:15 -0800
Received: from kbuild by 9dd77a123018 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nHIvH-0001O6-29; Tue, 08 Feb 2022 05:20:15 +0000
Date:   Tue, 8 Feb 2022 13:19:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [ojeda-linux:ci 4/9] rust/helpers.c:39:17: warning: no previous
 declaration for 'rust_helper_BUG'
Message-ID: <202202081303.QEI35DwC-lkp@intel.com>
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

tree:   https://github.com/ojeda/linux.git ci
head:   a694f7e200388d6d9686a7d52d348167ce97c388
commit: 614f533db2f380569e01a27b5064527a2f95728e [4/9] rust: helpers: avoid `-Wmissing-prototypes` in `W=1` builds
config: x86_64-randconfig-c022-20220207 (https://download.01.org/0day-ci/archive/20220208/202202081303.QEI35DwC-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/ojeda/linux/commit/614f533db2f380569e01a27b5064527a2f95728e
        git remote add ojeda-linux https://github.com/ojeda/linux.git
        git fetch --no-tags ojeda-linux ci
        git checkout 614f533db2f380569e01a27b5064527a2f95728e
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> rust/helpers.c:39:17: warning: no previous declaration for 'rust_helper_BUG' [-Wmissing-declarations]
      39 | __noreturn void rust_helper_BUG(void)
         |                 ^~~~~~~~~~~~~~~
>> rust/helpers.c:45:6: warning: no previous declaration for 'rust_helper_clk_disable_unprepare' [-Wmissing-declarations]
      45 | void rust_helper_clk_disable_unprepare(struct clk *clk)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> rust/helpers.c:51:5: warning: no previous declaration for 'rust_helper_clk_prepare_enable' [-Wmissing-declarations]
      51 | int rust_helper_clk_prepare_enable(struct clk *clk)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> rust/helpers.c:57:15: warning: no previous declaration for 'rust_helper_copy_from_user' [-Wmissing-declarations]
      57 | unsigned long rust_helper_copy_from_user(void *to, const void __user *from, unsigned long n)
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~~
>> rust/helpers.c:63:15: warning: no previous declaration for 'rust_helper_copy_to_user' [-Wmissing-declarations]
      63 | unsigned long rust_helper_copy_to_user(void __user *to, const void *from, unsigned long n)
         |               ^~~~~~~~~~~~~~~~~~~~~~~~
>> rust/helpers.c:69:15: warning: no previous declaration for 'rust_helper_clear_user' [-Wmissing-declarations]
      69 | unsigned long rust_helper_clear_user(void __user *to, unsigned long n)
         |               ^~~~~~~~~~~~~~~~~~~~~~
>> rust/helpers.c:75:15: warning: no previous declaration for 'rust_helper_ioremap' [-Wmissing-declarations]
      75 | void __iomem *rust_helper_ioremap(resource_size_t offset, unsigned long size)
         |               ^~~~~~~~~~~~~~~~~~~
>> rust/helpers.c:81:4: warning: no previous declaration for 'rust_helper_readb' [-Wmissing-declarations]
      81 | u8 rust_helper_readb(const volatile void __iomem *addr)
         |    ^~~~~~~~~~~~~~~~~
>> rust/helpers.c:87:5: warning: no previous declaration for 'rust_helper_readw' [-Wmissing-declarations]
      87 | u16 rust_helper_readw(const volatile void __iomem *addr)
         |     ^~~~~~~~~~~~~~~~~
>> rust/helpers.c:93:5: warning: no previous declaration for 'rust_helper_readl' [-Wmissing-declarations]
      93 | u32 rust_helper_readl(const volatile void __iomem *addr)
         |     ^~~~~~~~~~~~~~~~~
>> rust/helpers.c:100:5: warning: no previous declaration for 'rust_helper_readq' [-Wmissing-declarations]
     100 | u64 rust_helper_readq(const volatile void __iomem *addr)
         |     ^~~~~~~~~~~~~~~~~
>> rust/helpers.c:107:6: warning: no previous declaration for 'rust_helper_writeb' [-Wmissing-declarations]
     107 | void rust_helper_writeb(u8 value, volatile void __iomem *addr)
         |      ^~~~~~~~~~~~~~~~~~
>> rust/helpers.c:113:6: warning: no previous declaration for 'rust_helper_writew' [-Wmissing-declarations]
     113 | void rust_helper_writew(u16 value, volatile void __iomem *addr)
         |      ^~~~~~~~~~~~~~~~~~
>> rust/helpers.c:119:6: warning: no previous declaration for 'rust_helper_writel' [-Wmissing-declarations]
     119 | void rust_helper_writel(u32 value, volatile void __iomem *addr)
         |      ^~~~~~~~~~~~~~~~~~
>> rust/helpers.c:126:6: warning: no previous declaration for 'rust_helper_writeq' [-Wmissing-declarations]
     126 | void rust_helper_writeq(u64 value, volatile void __iomem *addr)
         |      ^~~~~~~~~~~~~~~~~~
>> rust/helpers.c:133:4: warning: no previous declaration for 'rust_helper_readb_relaxed' [-Wmissing-declarations]
     133 | u8 rust_helper_readb_relaxed(const volatile void __iomem *addr)
         |    ^~~~~~~~~~~~~~~~~~~~~~~~~
>> rust/helpers.c:139:5: warning: no previous declaration for 'rust_helper_readw_relaxed' [-Wmissing-declarations]
     139 | u16 rust_helper_readw_relaxed(const volatile void __iomem *addr)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~
>> rust/helpers.c:145:5: warning: no previous declaration for 'rust_helper_readl_relaxed' [-Wmissing-declarations]
     145 | u32 rust_helper_readl_relaxed(const volatile void __iomem *addr)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~
>> rust/helpers.c:152:5: warning: no previous declaration for 'rust_helper_readq_relaxed' [-Wmissing-declarations]
     152 | u64 rust_helper_readq_relaxed(const volatile void __iomem *addr)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~
>> rust/helpers.c:159:6: warning: no previous declaration for 'rust_helper_writeb_relaxed' [-Wmissing-declarations]
     159 | void rust_helper_writeb_relaxed(u8 value, volatile void __iomem *addr)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~
   rust/helpers.c:165:6: warning: no previous declaration for 'rust_helper_writew_relaxed' [-Wmissing-declarations]
     165 | void rust_helper_writew_relaxed(u16 value, volatile void __iomem *addr)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~
   rust/helpers.c:171:6: warning: no previous declaration for 'rust_helper_writel_relaxed' [-Wmissing-declarations]
     171 | void rust_helper_writel_relaxed(u32 value, volatile void __iomem *addr)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~
   rust/helpers.c:178:6: warning: no previous declaration for 'rust_helper_writeq_relaxed' [-Wmissing-declarations]
     178 | void rust_helper_writeq_relaxed(u64 value, volatile void __iomem *addr)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~
   rust/helpers.c:184:6: warning: no previous declaration for 'rust_helper___spin_lock_init' [-Wmissing-declarations]
     184 | void rust_helper___spin_lock_init(spinlock_t *lock, const char *name,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   rust/helpers.c:195:6: warning: no previous declaration for 'rust_helper_spin_lock' [-Wmissing-declarations]
     195 | void rust_helper_spin_lock(spinlock_t *lock)
         |      ^~~~~~~~~~~~~~~~~~~~~
   rust/helpers.c:201:6: warning: no previous declaration for 'rust_helper_spin_unlock' [-Wmissing-declarations]
     201 | void rust_helper_spin_unlock(spinlock_t *lock)
         |      ^~~~~~~~~~~~~~~~~~~~~~~
   rust/helpers.c:207:15: warning: no previous declaration for 'rust_helper_spin_lock_irqsave' [-Wmissing-declarations]
     207 | unsigned long rust_helper_spin_lock_irqsave(spinlock_t *lock)
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   rust/helpers.c:215:6: warning: no previous declaration for 'rust_helper_spin_unlock_irqrestore' [-Wmissing-declarations]
     215 | void rust_helper_spin_unlock_irqrestore(spinlock_t *lock, unsigned long flags)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   rust/helpers.c:221:6: warning: no previous declaration for 'rust_helper_init_wait' [-Wmissing-declarations]
     221 | void rust_helper_init_wait(struct wait_queue_entry *wq_entry)
         |      ^~~~~~~~~~~~~~~~~~~~~
   rust/helpers.c:227:5: warning: no previous declaration for 'rust_helper_signal_pending' [-Wmissing-declarations]
     227 | int rust_helper_signal_pending(struct task_struct *t)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
   rust/helpers.c:233:14: warning: no previous declaration for 'rust_helper_alloc_pages' [-Wmissing-declarations]
     233 | struct page *rust_helper_alloc_pages(gfp_t gfp_mask, unsigned int order)
         |              ^~~~~~~~~~~~~~~~~~~~~~~
   rust/helpers.c:239:7: warning: no previous declaration for 'rust_helper_kmap' [-Wmissing-declarations]
     239 | void *rust_helper_kmap(struct page *page)
         |       ^~~~~~~~~~~~~~~~
   rust/helpers.c:245:6: warning: no previous declaration for 'rust_helper_kunmap' [-Wmissing-declarations]
     245 | void rust_helper_kunmap(struct page *page)
         |      ^~~~~~~~~~~~~~~~~~
   rust/helpers.c:251:5: warning: no previous declaration for 'rust_helper_cond_resched' [-Wmissing-declarations]
     251 | int rust_helper_cond_resched(void)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~
   rust/helpers.c:257:8: warning: no previous declaration for 'rust_helper_copy_from_iter' [-Wmissing-declarations]
     257 | size_t rust_helper_copy_from_iter(void *addr, size_t bytes, struct iov_iter *i)
         |        ^~~~~~~~~~~~~~~~~~~~~~~~~~
   rust/helpers.c:263:8: warning: no previous declaration for 'rust_helper_copy_to_iter' [-Wmissing-declarations]
     263 | size_t rust_helper_copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
         |        ^~~~~~~~~~~~~~~~~~~~~~~~
   rust/helpers.c:269:6: warning: no previous declaration for 'rust_helper_IS_ERR' [-Wmissing-declarations]
     269 | bool rust_helper_IS_ERR(__force const void *ptr)
         |      ^~~~~~~~~~~~~~~~~~
   rust/helpers.c:275:6: warning: no previous declaration for 'rust_helper_PTR_ERR' [-Wmissing-declarations]
     275 | long rust_helper_PTR_ERR(__force const void *ptr)
         |      ^~~~~~~~~~~~~~~~~~~
   rust/helpers.c:281:13: warning: no previous declaration for 'rust_helper_errname' [-Wmissing-declarations]
     281 | const char *rust_helper_errname(int err)
         |             ^~~~~~~~~~~~~~~~~~~
   rust/helpers.c:287:6: warning: no previous declaration for 'rust_helper_mutex_lock' [-Wmissing-declarations]
     287 | void rust_helper_mutex_lock(struct mutex *lock)
         |      ^~~~~~~~~~~~~~~~~~~~~~
   rust/helpers.c:293:6: warning: no previous declaration for 'rust_helper_amba_set_drvdata' [-Wmissing-declarations]
     293 | void rust_helper_amba_set_drvdata(struct amba_device *dev, void *data)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   rust/helpers.c:299:7: warning: no previous declaration for 'rust_helper_amba_get_drvdata' [-Wmissing-declarations]
     299 | void *rust_helper_amba_get_drvdata(struct amba_device *dev)
         |       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   rust/helpers.c:306:1: warning: no previous declaration for 'rust_helper_platform_get_drvdata' [-Wmissing-declarations]
     306 | rust_helper_platform_get_drvdata(const struct platform_device *pdev)
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   rust/helpers.c:313:1: warning: no previous declaration for 'rust_helper_platform_set_drvdata' [-Wmissing-declarations]
     313 | rust_helper_platform_set_drvdata(struct platform_device *pdev,
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   rust/helpers.c:320:12: warning: no previous declaration for 'rust_helper_REFCOUNT_INIT' [-Wmissing-declarations]
     320 | refcount_t rust_helper_REFCOUNT_INIT(int n)
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~
   rust/helpers.c:326:6: warning: no previous declaration for 'rust_helper_refcount_inc' [-Wmissing-declarations]
     326 | void rust_helper_refcount_inc(refcount_t *r)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~
   rust/helpers.c:332:6: warning: no previous declaration for 'rust_helper_refcount_dec_and_test' [-Wmissing-declarations]
     332 | bool rust_helper_refcount_dec_and_test(refcount_t *r)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   rust/helpers.c:338:6: warning: no previous declaration for 'rust_helper_rb_link_node' [-Wmissing-declarations]
     338 | void rust_helper_rb_link_node(struct rb_node *node, struct rb_node *parent,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~
   rust/helpers.c:345:21: warning: no previous declaration for 'rust_helper_get_current' [-Wmissing-declarations]
     345 | struct task_struct *rust_helper_get_current(void)
         |                     ^~~~~~~~~~~~~~~~~~~~~~~
   rust/helpers.c:351:6: warning: no previous declaration for 'rust_helper_get_task_struct' [-Wmissing-declarations]
     351 | void rust_helper_get_task_struct(struct task_struct * t)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   rust/helpers.c:357:6: warning: no previous declaration for 'rust_helper_put_task_struct' [-Wmissing-declarations]
     357 | void rust_helper_put_task_struct(struct task_struct * t)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   rust/helpers.c:363:5: warning: no previous declaration for 'rust_helper_security_binder_set_context_mgr' [-Wmissing-declarations]
     363 | int rust_helper_security_binder_set_context_mgr(const struct cred *mgr)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   rust/helpers.c:369:5: warning: no previous declaration for 'rust_helper_security_binder_transaction' [-Wmissing-declarations]
     369 | int rust_helper_security_binder_transaction(const struct cred *from,


vim +/rust_helper_BUG +39 rust/helpers.c

40cbc3f043eeea Miguel Ojeda         2019-09-24   38  
5444b8b2ad903d Gary Guo             2021-07-29  @39  __noreturn void rust_helper_BUG(void)
40cbc3f043eeea Miguel Ojeda         2019-09-24   40  {
40cbc3f043eeea Miguel Ojeda         2019-09-24   41  	BUG();
40cbc3f043eeea Miguel Ojeda         2019-09-24   42  }
556905864c54b7 Wei Liu              2022-01-20   43  EXPORT_SYMBOL_GPL(rust_helper_BUG);
40cbc3f043eeea Miguel Ojeda         2019-09-24   44  
632ef868c289ee Maciej Falkowski     2021-10-29  @45  void rust_helper_clk_disable_unprepare(struct clk *clk)
632ef868c289ee Maciej Falkowski     2021-10-29   46  {
632ef868c289ee Maciej Falkowski     2021-10-29   47  	return clk_disable_unprepare(clk);
632ef868c289ee Maciej Falkowski     2021-10-29   48  }
632ef868c289ee Maciej Falkowski     2021-10-29   49  EXPORT_SYMBOL_GPL(rust_helper_clk_disable_unprepare);
632ef868c289ee Maciej Falkowski     2021-10-29   50  
632ef868c289ee Maciej Falkowski     2021-10-29  @51  int rust_helper_clk_prepare_enable(struct clk *clk)
632ef868c289ee Maciej Falkowski     2021-10-29   52  {
632ef868c289ee Maciej Falkowski     2021-10-29   53  	return clk_prepare_enable(clk);
632ef868c289ee Maciej Falkowski     2021-10-29   54  }
632ef868c289ee Maciej Falkowski     2021-10-29   55  EXPORT_SYMBOL_GPL(rust_helper_clk_prepare_enable);
632ef868c289ee Maciej Falkowski     2021-10-29   56  
7c6155bc5ecf03 Miguel Ojeda         2020-11-27  @57  unsigned long rust_helper_copy_from_user(void *to, const void __user *from, unsigned long n)
7c6155bc5ecf03 Miguel Ojeda         2020-11-27   58  {
7c6155bc5ecf03 Miguel Ojeda         2020-11-27   59  	return copy_from_user(to, from, n);
7c6155bc5ecf03 Miguel Ojeda         2020-11-27   60  }
556905864c54b7 Wei Liu              2022-01-20   61  EXPORT_SYMBOL_GPL(rust_helper_copy_from_user);
7c6155bc5ecf03 Miguel Ojeda         2020-11-27   62  
7c6155bc5ecf03 Miguel Ojeda         2020-11-27  @63  unsigned long rust_helper_copy_to_user(void __user *to, const void *from, unsigned long n)
7c6155bc5ecf03 Miguel Ojeda         2020-11-27   64  {
7c6155bc5ecf03 Miguel Ojeda         2020-11-27   65  	return copy_to_user(to, from, n);
7c6155bc5ecf03 Miguel Ojeda         2020-11-27   66  }
556905864c54b7 Wei Liu              2022-01-20   67  EXPORT_SYMBOL_GPL(rust_helper_copy_to_user);
40cbc3f043eeea Miguel Ojeda         2019-09-24   68  
126c162b3f0d35 Wedson Almeida Filho 2021-04-23  @69  unsigned long rust_helper_clear_user(void __user *to, unsigned long n)
126c162b3f0d35 Wedson Almeida Filho 2021-04-23   70  {
126c162b3f0d35 Wedson Almeida Filho 2021-04-23   71  	return clear_user(to, n);
126c162b3f0d35 Wedson Almeida Filho 2021-04-23   72  }
556905864c54b7 Wei Liu              2022-01-20   73  EXPORT_SYMBOL_GPL(rust_helper_clear_user);
126c162b3f0d35 Wedson Almeida Filho 2021-04-23   74  
f9e2f7e1a4468a Wedson Almeida Filho 2021-07-29  @75  void __iomem *rust_helper_ioremap(resource_size_t offset, unsigned long size)
f9e2f7e1a4468a Wedson Almeida Filho 2021-07-29   76  {
f9e2f7e1a4468a Wedson Almeida Filho 2021-07-29   77  	return ioremap(offset, size);
f9e2f7e1a4468a Wedson Almeida Filho 2021-07-29   78  }
f9e2f7e1a4468a Wedson Almeida Filho 2021-07-29   79  EXPORT_SYMBOL_GPL(rust_helper_ioremap);
f9e2f7e1a4468a Wedson Almeida Filho 2021-07-29   80  
f9e2f7e1a4468a Wedson Almeida Filho 2021-07-29  @81  u8 rust_helper_readb(const volatile void __iomem *addr)
f9e2f7e1a4468a Wedson Almeida Filho 2021-07-29   82  {
f9e2f7e1a4468a Wedson Almeida Filho 2021-07-29   83  	return readb(addr);
f9e2f7e1a4468a Wedson Almeida Filho 2021-07-29   84  }
f9e2f7e1a4468a Wedson Almeida Filho 2021-07-29   85  EXPORT_SYMBOL_GPL(rust_helper_readb);
f9e2f7e1a4468a Wedson Almeida Filho 2021-07-29   86  
f9e2f7e1a4468a Wedson Almeida Filho 2021-07-29  @87  u16 rust_helper_readw(const volatile void __iomem *addr)
f9e2f7e1a4468a Wedson Almeida Filho 2021-07-29   88  {
f9e2f7e1a4468a Wedson Almeida Filho 2021-07-29   89  	return readw(addr);
f9e2f7e1a4468a Wedson Almeida Filho 2021-07-29   90  }
f9e2f7e1a4468a Wedson Almeida Filho 2021-07-29   91  EXPORT_SYMBOL_GPL(rust_helper_readw);
f9e2f7e1a4468a Wedson Almeida Filho 2021-07-29   92  
f9e2f7e1a4468a Wedson Almeida Filho 2021-07-29  @93  u32 rust_helper_readl(const volatile void __iomem *addr)
f9e2f7e1a4468a Wedson Almeida Filho 2021-07-29   94  {
f9e2f7e1a4468a Wedson Almeida Filho 2021-07-29   95  	return readl(addr);
f9e2f7e1a4468a Wedson Almeida Filho 2021-07-29   96  }
f9e2f7e1a4468a Wedson Almeida Filho 2021-07-29   97  EXPORT_SYMBOL_GPL(rust_helper_readl);
f9e2f7e1a4468a Wedson Almeida Filho 2021-07-29   98  
f9e2f7e1a4468a Wedson Almeida Filho 2021-07-29   99  #ifdef CONFIG_64BIT
f9e2f7e1a4468a Wedson Almeida Filho 2021-07-29 @100  u64 rust_helper_readq(const volatile void __iomem *addr)
f9e2f7e1a4468a Wedson Almeida Filho 2021-07-29  101  {
f9e2f7e1a4468a Wedson Almeida Filho 2021-07-29  102  	return readq(addr);
f9e2f7e1a4468a Wedson Almeida Filho 2021-07-29  103  }
f9e2f7e1a4468a Wedson Almeida Filho 2021-07-29  104  EXPORT_SYMBOL_GPL(rust_helper_readq);
f9e2f7e1a4468a Wedson Almeida Filho 2021-07-29  105  #endif
f9e2f7e1a4468a Wedson Almeida Filho 2021-07-29  106  
f9e2f7e1a4468a Wedson Almeida Filho 2021-07-29 @107  void rust_helper_writeb(u8 value, volatile void __iomem *addr)
f9e2f7e1a4468a Wedson Almeida Filho 2021-07-29  108  {
f9e2f7e1a4468a Wedson Almeida Filho 2021-07-29  109  	writeb(value, addr);
f9e2f7e1a4468a Wedson Almeida Filho 2021-07-29  110  }
f9e2f7e1a4468a Wedson Almeida Filho 2021-07-29  111  EXPORT_SYMBOL_GPL(rust_helper_writeb);
f9e2f7e1a4468a Wedson Almeida Filho 2021-07-29  112  
f9e2f7e1a4468a Wedson Almeida Filho 2021-07-29 @113  void rust_helper_writew(u16 value, volatile void __iomem *addr)
f9e2f7e1a4468a Wedson Almeida Filho 2021-07-29  114  {
f9e2f7e1a4468a Wedson Almeida Filho 2021-07-29  115  	writew(value, addr);
f9e2f7e1a4468a Wedson Almeida Filho 2021-07-29  116  }
f9e2f7e1a4468a Wedson Almeida Filho 2021-07-29  117  EXPORT_SYMBOL_GPL(rust_helper_writew);
f9e2f7e1a4468a Wedson Almeida Filho 2021-07-29  118  
f9e2f7e1a4468a Wedson Almeida Filho 2021-07-29 @119  void rust_helper_writel(u32 value, volatile void __iomem *addr)
f9e2f7e1a4468a Wedson Almeida Filho 2021-07-29  120  {
f9e2f7e1a4468a Wedson Almeida Filho 2021-07-29  121  	writel(value, addr);
f9e2f7e1a4468a Wedson Almeida Filho 2021-07-29  122  }
f9e2f7e1a4468a Wedson Almeida Filho 2021-07-29  123  EXPORT_SYMBOL_GPL(rust_helper_writel);
f9e2f7e1a4468a Wedson Almeida Filho 2021-07-29  124  
f9e2f7e1a4468a Wedson Almeida Filho 2021-07-29  125  #ifdef CONFIG_64BIT
f9e2f7e1a4468a Wedson Almeida Filho 2021-07-29 @126  void rust_helper_writeq(u64 value, volatile void __iomem *addr)
f9e2f7e1a4468a Wedson Almeida Filho 2021-07-29  127  {
f9e2f7e1a4468a Wedson Almeida Filho 2021-07-29  128  	writeq(value, addr);
f9e2f7e1a4468a Wedson Almeida Filho 2021-07-29  129  }
f9e2f7e1a4468a Wedson Almeida Filho 2021-07-29  130  EXPORT_SYMBOL_GPL(rust_helper_writeq);
f9e2f7e1a4468a Wedson Almeida Filho 2021-07-29  131  #endif
f9e2f7e1a4468a Wedson Almeida Filho 2021-07-29  132  
e29f395275ea15 Maciej Falkowski     2021-10-29 @133  u8 rust_helper_readb_relaxed(const volatile void __iomem *addr)
e29f395275ea15 Maciej Falkowski     2021-10-29  134  {
e29f395275ea15 Maciej Falkowski     2021-10-29  135  	return readb_relaxed(addr);
e29f395275ea15 Maciej Falkowski     2021-10-29  136  }
e29f395275ea15 Maciej Falkowski     2021-10-29  137  EXPORT_SYMBOL_GPL(rust_helper_readb_relaxed);
e29f395275ea15 Maciej Falkowski     2021-10-29  138  
e29f395275ea15 Maciej Falkowski     2021-10-29 @139  u16 rust_helper_readw_relaxed(const volatile void __iomem *addr)
e29f395275ea15 Maciej Falkowski     2021-10-29  140  {
e29f395275ea15 Maciej Falkowski     2021-10-29  141  	return readw_relaxed(addr);
e29f395275ea15 Maciej Falkowski     2021-10-29  142  }
e29f395275ea15 Maciej Falkowski     2021-10-29  143  EXPORT_SYMBOL_GPL(rust_helper_readw_relaxed);
e29f395275ea15 Maciej Falkowski     2021-10-29  144  
e29f395275ea15 Maciej Falkowski     2021-10-29 @145  u32 rust_helper_readl_relaxed(const volatile void __iomem *addr)
e29f395275ea15 Maciej Falkowski     2021-10-29  146  {
e29f395275ea15 Maciej Falkowski     2021-10-29  147  	return readl_relaxed(addr);
e29f395275ea15 Maciej Falkowski     2021-10-29  148  }
e29f395275ea15 Maciej Falkowski     2021-10-29  149  EXPORT_SYMBOL_GPL(rust_helper_readl_relaxed);
e29f395275ea15 Maciej Falkowski     2021-10-29  150  
e29f395275ea15 Maciej Falkowski     2021-10-29  151  #ifdef CONFIG_64BIT
e29f395275ea15 Maciej Falkowski     2021-10-29 @152  u64 rust_helper_readq_relaxed(const volatile void __iomem *addr)
e29f395275ea15 Maciej Falkowski     2021-10-29  153  {
e29f395275ea15 Maciej Falkowski     2021-10-29  154  	return readq_relaxed(addr);
e29f395275ea15 Maciej Falkowski     2021-10-29  155  }
e29f395275ea15 Maciej Falkowski     2021-10-29  156  EXPORT_SYMBOL_GPL(rust_helper_readq_relaxed);
e29f395275ea15 Maciej Falkowski     2021-10-29  157  #endif
e29f395275ea15 Maciej Falkowski     2021-10-29  158  
e29f395275ea15 Maciej Falkowski     2021-10-29 @159  void rust_helper_writeb_relaxed(u8 value, volatile void __iomem *addr)
e29f395275ea15 Maciej Falkowski     2021-10-29  160  {
e29f395275ea15 Maciej Falkowski     2021-10-29  161          writeb_relaxed(value, addr);
e29f395275ea15 Maciej Falkowski     2021-10-29  162  }
e29f395275ea15 Maciej Falkowski     2021-10-29  163  EXPORT_SYMBOL_GPL(rust_helper_writeb_relaxed);
e29f395275ea15 Maciej Falkowski     2021-10-29  164  
e29f395275ea15 Maciej Falkowski     2021-10-29 @165  void rust_helper_writew_relaxed(u16 value, volatile void __iomem *addr)
e29f395275ea15 Maciej Falkowski     2021-10-29  166  {
e29f395275ea15 Maciej Falkowski     2021-10-29  167          writew_relaxed(value, addr);
e29f395275ea15 Maciej Falkowski     2021-10-29  168  }
e29f395275ea15 Maciej Falkowski     2021-10-29  169  EXPORT_SYMBOL_GPL(rust_helper_writew_relaxed);
e29f395275ea15 Maciej Falkowski     2021-10-29  170  
e29f395275ea15 Maciej Falkowski     2021-10-29 @171  void rust_helper_writel_relaxed(u32 value, volatile void __iomem *addr)
e29f395275ea15 Maciej Falkowski     2021-10-29  172  {
e29f395275ea15 Maciej Falkowski     2021-10-29  173          writel_relaxed(value, addr);
e29f395275ea15 Maciej Falkowski     2021-10-29  174  }
e29f395275ea15 Maciej Falkowski     2021-10-29  175  EXPORT_SYMBOL_GPL(rust_helper_writel_relaxed);
e29f395275ea15 Maciej Falkowski     2021-10-29  176  
e29f395275ea15 Maciej Falkowski     2021-10-29  177  #ifdef CONFIG_64BIT
e29f395275ea15 Maciej Falkowski     2021-10-29 @178  void rust_helper_writeq_relaxed(u64 value, volatile void __iomem *addr)
e29f395275ea15 Maciej Falkowski     2021-10-29  179  {
e29f395275ea15 Maciej Falkowski     2021-10-29  180          writeq_relaxed(value, addr);
e29f395275ea15 Maciej Falkowski     2021-10-29  181  }
e29f395275ea15 Maciej Falkowski     2021-10-29  182  EXPORT_SYMBOL_GPL(rust_helper_writeq_relaxed);
e29f395275ea15 Maciej Falkowski     2021-10-29  183  #endif
5444b8b2ad903d Gary Guo             2021-07-29 @184  void rust_helper___spin_lock_init(spinlock_t *lock, const char *name,
ba93231f3de539 Wedson Almeida Filho 2021-03-11  185  				  struct lock_class_key *key)
ba93231f3de539 Wedson Almeida Filho 2021-03-11  186  {
ba93231f3de539 Wedson Almeida Filho 2021-03-11  187  #ifdef CONFIG_DEBUG_SPINLOCK
ba93231f3de539 Wedson Almeida Filho 2021-03-11  188  	__spin_lock_init(lock, name, key);
ba93231f3de539 Wedson Almeida Filho 2021-03-11  189  #else
ba93231f3de539 Wedson Almeida Filho 2021-03-11  190  	spin_lock_init(lock);
ba93231f3de539 Wedson Almeida Filho 2021-03-11  191  #endif
ba93231f3de539 Wedson Almeida Filho 2021-03-11  192  }
5444b8b2ad903d Gary Guo             2021-07-29  193  EXPORT_SYMBOL_GPL(rust_helper___spin_lock_init);
ba93231f3de539 Wedson Almeida Filho 2021-03-11  194  
ba93231f3de539 Wedson Almeida Filho 2021-03-11 @195  void rust_helper_spin_lock(spinlock_t *lock)
ba93231f3de539 Wedson Almeida Filho 2021-03-11  196  {
ba93231f3de539 Wedson Almeida Filho 2021-03-11  197  	spin_lock(lock);
ba93231f3de539 Wedson Almeida Filho 2021-03-11  198  }
da968f8d40d365 Miguel Ojeda         2021-04-13  199  EXPORT_SYMBOL_GPL(rust_helper_spin_lock);
ba93231f3de539 Wedson Almeida Filho 2021-03-11  200  
ba93231f3de539 Wedson Almeida Filho 2021-03-11 @201  void rust_helper_spin_unlock(spinlock_t *lock)
ba93231f3de539 Wedson Almeida Filho 2021-03-11  202  {
ba93231f3de539 Wedson Almeida Filho 2021-03-11  203  	spin_unlock(lock);
ba93231f3de539 Wedson Almeida Filho 2021-03-11  204  }
da968f8d40d365 Miguel Ojeda         2021-04-13  205  EXPORT_SYMBOL_GPL(rust_helper_spin_unlock);
ba93231f3de539 Wedson Almeida Filho 2021-03-11  206  
6d6e1d5ac5785e Wedson Almeida Filho 2021-11-05 @207  unsigned long rust_helper_spin_lock_irqsave(spinlock_t *lock)
6d6e1d5ac5785e Wedson Almeida Filho 2021-11-05  208  {
6d6e1d5ac5785e Wedson Almeida Filho 2021-11-05  209  	unsigned long flags;
6d6e1d5ac5785e Wedson Almeida Filho 2021-11-05  210  	spin_lock_irqsave(lock, flags);
6d6e1d5ac5785e Wedson Almeida Filho 2021-11-05  211  	return flags;
6d6e1d5ac5785e Wedson Almeida Filho 2021-11-05  212  }
6d6e1d5ac5785e Wedson Almeida Filho 2021-11-05  213  EXPORT_SYMBOL_GPL(rust_helper_spin_lock_irqsave);
6d6e1d5ac5785e Wedson Almeida Filho 2021-11-05  214  
6d6e1d5ac5785e Wedson Almeida Filho 2021-11-05 @215  void rust_helper_spin_unlock_irqrestore(spinlock_t *lock, unsigned long flags)
6d6e1d5ac5785e Wedson Almeida Filho 2021-11-05  216  {
6d6e1d5ac5785e Wedson Almeida Filho 2021-11-05  217  	spin_unlock_irqrestore(lock, flags);
6d6e1d5ac5785e Wedson Almeida Filho 2021-11-05  218  }
6d6e1d5ac5785e Wedson Almeida Filho 2021-11-05  219  EXPORT_SYMBOL_GPL(rust_helper_spin_unlock_irqrestore);
6d6e1d5ac5785e Wedson Almeida Filho 2021-11-05  220  
1640a97de758bc Wedson Almeida Filho 2021-03-11 @221  void rust_helper_init_wait(struct wait_queue_entry *wq_entry)
1640a97de758bc Wedson Almeida Filho 2021-03-11  222  {
1640a97de758bc Wedson Almeida Filho 2021-03-11  223  	init_wait(wq_entry);
1640a97de758bc Wedson Almeida Filho 2021-03-11  224  }
da968f8d40d365 Miguel Ojeda         2021-04-13  225  EXPORT_SYMBOL_GPL(rust_helper_init_wait);
1640a97de758bc Wedson Almeida Filho 2021-03-11  226  
6556b37a7fc577 Wedson Almeida Filho 2021-07-01 @227  int rust_helper_signal_pending(struct task_struct *t)
d8dcaf80c95350 Wedson Almeida Filho 2021-04-11  228  {
6556b37a7fc577 Wedson Almeida Filho 2021-07-01  229  	return signal_pending(t);
1640a97de758bc Wedson Almeida Filho 2021-03-11  230  }
da968f8d40d365 Miguel Ojeda         2021-04-13  231  EXPORT_SYMBOL_GPL(rust_helper_signal_pending);
1640a97de758bc Wedson Almeida Filho 2021-03-11  232  
d8dcaf80c95350 Wedson Almeida Filho 2021-04-11 @233  struct page *rust_helper_alloc_pages(gfp_t gfp_mask, unsigned int order)
d8dcaf80c95350 Wedson Almeida Filho 2021-04-11  234  {
d8dcaf80c95350 Wedson Almeida Filho 2021-04-11  235  	return alloc_pages(gfp_mask, order);
d8dcaf80c95350 Wedson Almeida Filho 2021-04-11  236  }
da968f8d40d365 Miguel Ojeda         2021-04-13  237  EXPORT_SYMBOL_GPL(rust_helper_alloc_pages);
d8dcaf80c95350 Wedson Almeida Filho 2021-04-11  238  

:::::: The code at line 39 was first introduced by commit
:::::: 5444b8b2ad903d4d85bc01519b16fea3555b1cb7 rust: use the generated helper bindings

:::::: TO: Gary Guo <gary@garyguo.net>
:::::: CC: Gary Guo <gary@garyguo.net>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
