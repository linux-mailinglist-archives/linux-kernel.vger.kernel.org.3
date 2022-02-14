Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52FCF4B5E58
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 00:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbiBNXii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 18:38:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiBNXih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 18:38:37 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94069113D9A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 15:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644881907; x=1676417907;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QOT7AErKbGzkcKVV6l9B9Xuh+We5e2DR2xcgsl+mCE0=;
  b=Zq6JqrK6qHdBE++/zVLRIQj/IFA/bKXtBsntWlhteH6teg/b8PkViIol
   crN1kfl1wa6sDje5X6Y1plVXXtZ+Yl/nSyqy/K4KFnf1m5AADL/l0tmPI
   uKAUICuzUjLA0cOqtROHJPajI6JmoqyJ4IPYUW73J4V2EbgZ4t472HXBt
   4AkIlcCk9EA6svNJx8UtglGAZ6w0Z8CsweqEDK/1uHgNgIRSgVyWH6L5t
   iMwycoqNnJ1I+e1YG99tMt4HBEsyEozGQcXpcZ/HV6SB5CWgr2u09sX7/
   J4Aw1o0qVYp97NKu7cHYmSVnXMq/W4Jw/BaTRLJQeSt/v/WyAnivgZa/L
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="230847311"
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="230847311"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 15:38:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="485825708"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 14 Feb 2022 15:38:22 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nJkvG-00092L-1n; Mon, 14 Feb 2022 23:38:22 +0000
Date:   Tue, 15 Feb 2022 07:37:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Alex Gaynor <alex.gaynor@gmail.com>,
        Finn Behrens <me@kloenk.de>,
        Adam Bratschi-Kaye <ark.email@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        Boris-Chengbiao Zhou <bobo1239@web.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Douglas Su <d0u9.su@outlook.com>,
        Dariusz Sosnowski <dsosnowski@dsosnowski.pl>,
        Antonio Terceiro <antonio.terceiro@linaro.org>,
        Daniel Xu <dxu@dxuuu.xyz>
Subject: [ojeda-linux:rust-next 15/20] rust/helpers.c:22:17: warning: no
 previous prototype for function 'rust_helper_BUG' err: false
Message-ID: <202202150744.IRLmiHc4-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ojeda/linux.git rust-next
head:   ced9f62ec4355bbb92226ac3f019da468a5c996b
commit: 5d287d7e9c9bd455f8eb9abf80f320927433e168 [15/20] Kbuild: add Rust support
config: riscv-randconfig-r002-20220214 (https://download.01.org/0day-ci/archive/20220215/202202150744.IRLmiHc4-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project ea071884b0cc7210b3cc5fe858f0e892a779a23b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/ojeda/linux/commit/5d287d7e9c9bd455f8eb9abf80f320927433e168
        git remote add ojeda-linux https://github.com/ojeda/linux.git
        git fetch --no-tags ojeda-linux rust-next
        git checkout 5d287d7e9c9bd455f8eb9abf80f320927433e168
        # save the config file to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=riscv 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> rust/helpers.c:22:17: warning: no previous prototype for function 'rust_helper_BUG' err: false
>> rust/helpers.c:27:6: warning: no previous prototype for function 'rust_helper_clk_disable_unprepare' err: false
>> rust/helpers.c:33:5: warning: no previous prototype for function 'rust_helper_clk_prepare_enable' err: false
>> rust/helpers.c:39:15: warning: no previous prototype for function 'rust_helper_copy_from_user' err: false
>> rust/helpers.c:44:15: warning: no previous prototype for function 'rust_helper_copy_to_user' err: false
>> rust/helpers.c:49:15: warning: no previous prototype for function 'rust_helper_clear_user' err: false
>> rust/helpers.c:54:15: warning: no previous prototype for function 'rust_helper_ioremap' err: false
>> rust/helpers.c:60:4: warning: no previous prototype for function 'rust_helper_readb' err: false
>> rust/helpers.c:66:5: warning: no previous prototype for function 'rust_helper_readw' err: false
>> rust/helpers.c:72:5: warning: no previous prototype for function 'rust_helper_readl' err: false
>> rust/helpers.c:79:5: warning: no previous prototype for function 'rust_helper_readq' err: false
>> rust/helpers.c:86:6: warning: no previous prototype for function 'rust_helper_writeb' err: false
>> rust/helpers.c:92:6: warning: no previous prototype for function 'rust_helper_writew' err: false
>> rust/helpers.c:98:6: warning: no previous prototype for function 'rust_helper_writel' err: false
>> rust/helpers.c:105:6: warning: no previous prototype for function 'rust_helper_writeq' err: false
>> rust/helpers.c:112:4: warning: no previous prototype for function 'rust_helper_readb_relaxed' err: false
>> rust/helpers.c:118:5: warning: no previous prototype for function 'rust_helper_readw_relaxed' err: false
>> rust/helpers.c:124:5: warning: no previous prototype for function 'rust_helper_readl_relaxed' err: false
>> rust/helpers.c:131:5: warning: no previous prototype for function 'rust_helper_readq_relaxed' err: false
>> rust/helpers.c:138:6: warning: no previous prototype for function 'rust_helper_writeb_relaxed' err: false
   rust/helpers.c:144:6: warning: no previous prototype for function 'rust_helper_writew_relaxed' err: false
   rust/helpers.c:150:6: warning: no previous prototype for function 'rust_helper_writel_relaxed' err: false
   rust/helpers.c:157:6: warning: no previous prototype for function 'rust_helper_writeq_relaxed' err: false
   rust/helpers.c:163:6: warning: no previous prototype for function 'rust_helper___spin_lock_init' err: false
   rust/helpers.c:174:6: warning: no previous prototype for function 'rust_helper_spin_lock' err: false
   rust/helpers.c:180:6: warning: no previous prototype for function 'rust_helper_spin_unlock' err: false
   rust/helpers.c:186:15: warning: no previous prototype for function 'rust_helper_spin_lock_irqsave' err: false
   rust/helpers.c:194:6: warning: no previous prototype for function 'rust_helper_spin_unlock_irqrestore' err: false
   rust/helpers.c:200:6: warning: no previous prototype for function 'rust_helper_init_wait' err: false
   rust/helpers.c:206:5: warning: no previous prototype for function 'rust_helper_signal_pending' err: false
   rust/helpers.c:212:14: warning: no previous prototype for function 'rust_helper_alloc_pages' err: false
   rust/helpers.c:218:7: warning: no previous prototype for function 'rust_helper_kmap' err: false
   rust/helpers.c:224:6: warning: no previous prototype for function 'rust_helper_kunmap' err: false
   rust/helpers.c:230:5: warning: no previous prototype for function 'rust_helper_cond_resched' err: false
   rust/helpers.c:236:8: warning: no previous prototype for function 'rust_helper_copy_from_iter' err: false
   rust/helpers.c:242:8: warning: no previous prototype for function 'rust_helper_copy_to_iter' err: false
   rust/helpers.c:248:6: warning: no previous prototype for function 'rust_helper_IS_ERR' err: false
   rust/helpers.c:254:6: warning: no previous prototype for function 'rust_helper_PTR_ERR' err: false
   rust/helpers.c:260:13: warning: no previous prototype for function 'rust_helper_errname' err: false
   rust/helpers.c:266:6: warning: no previous prototype for function 'rust_helper_mutex_lock' err: false
   rust/helpers.c:272:6: warning: no previous prototype for function 'rust_helper_amba_set_drvdata' err: false
   rust/helpers.c:278:7: warning: no previous prototype for function 'rust_helper_amba_get_drvdata' err: false
   rust/helpers.c:285:1: warning: no previous prototype for function 'rust_helper_platform_get_drvdata' err: false
   rust/helpers.c:292:1: warning: no previous prototype for function 'rust_helper_platform_set_drvdata' err: false
   rust/helpers.c:299:12: warning: no previous prototype for function 'rust_helper_REFCOUNT_INIT' err: false
   rust/helpers.c:305:6: warning: no previous prototype for function 'rust_helper_refcount_inc' err: false
   rust/helpers.c:311:6: warning: no previous prototype for function 'rust_helper_refcount_dec_and_test' err: false
   rust/helpers.c:317:6: warning: no previous prototype for function 'rust_helper_rb_link_node' err: false
   rust/helpers.c:324:21: warning: no previous prototype for function 'rust_helper_get_current' err: false
   rust/helpers.c:330:6: warning: no previous prototype for function 'rust_helper_get_task_struct' err: false
   rust/helpers.c:336:6: warning: no previous prototype for function 'rust_helper_put_task_struct' err: false
   rust/helpers.c:342:5: warning: no previous prototype for function 'rust_helper_security_binder_set_context_mgr' err: false
   rust/helpers.c:348:5: warning: no previous prototype for function 'rust_helper_security_binder_transaction' err: false
   rust/helpers.c:355:5: warning: no previous prototype for function 'rust_helper_security_binder_transfer_binder' err: false
   rust/helpers.c:362:5: warning: no previous prototype for function 'rust_helper_security_binder_transfer_file' err: false
   rust/helpers.c:370:6: warning: no previous prototype for function 'rust_helper_rcu_read_lock' err: false
   rust/helpers.c:376:6: warning: no previous prototype for function 'rust_helper_rcu_read_unlock' err: false
   rust/helpers.c:382:6: warning: no previous prototype for function 'rust_helper_synchronize_rcu' err: false
   rust/helpers.c:388:7: warning: no previous prototype for function 'rust_helper_dev_get_drvdata' err: false
   rust/helpers.c:394:13: warning: no previous prototype for function 'rust_helper_dev_name' err: false
   rust/helpers.c:400:6: warning: no previous prototype for function 'rust_helper___seqcount_init' err: false
   rust/helpers.c:407:10: warning: no previous prototype for function 'rust_helper_read_seqcount_begin' err: false
   rust/helpers.c:413:5: warning: no previous prototype for function 'rust_helper_read_seqcount_retry' err: false
   rust/helpers.c:419:6: warning: no previous prototype for function 'rust_helper_write_seqcount_begin' err: false
   rust/helpers.c:425:6: warning: no previous prototype for function 'rust_helper_write_seqcount_end' err: false
   rust/helpers.c:431:6: warning: no previous prototype for function 'rust_helper_irq_set_handler_locked' err: false
   rust/helpers.c:438:7: warning: no previous prototype for function 'rust_helper_irq_data_get_irq_chip_data' err: false
   rust/helpers.c:444:18: warning: no previous prototype for function 'rust_helper_irq_desc_get_chip' err: false
   rust/helpers.c:450:7: warning: no previous prototype for function 'rust_helper_irq_desc_get_handler_data' err: false
   rust/helpers.c:456:6: warning: no previous prototype for function 'rust_helper_chained_irq_enter' err: false
   rust/helpers.c:463:6: warning: no previous prototype for function 'rust_helper_chained_irq_exit' err: false
   rust/helpers.c:470:20: warning: no previous prototype for function 'rust_helper_get_cred' err: false
   rust/helpers.c:476:6: warning: no previous prototype for function 'rust_helper_put_cred' err: false
   rust/helpers.c:481:28: warning: no previous prototype for function 'rust_helper_of_match_device' err: false
   ld.lld: error: section .rela.dyn file range overlaps with .text
   >>> .rela.dyn range is [0x358, 0xAA7]
   >>> .text range is [0x800, 0x2365]


vim +/rust_helper_BUG +22 rust/helpers.c

0be29b05808bf1 Miguel Ojeda 2021-07-03   21  
0be29b05808bf1 Miguel Ojeda 2021-07-03  @22  __noreturn void rust_helper_BUG(void)
0be29b05808bf1 Miguel Ojeda 2021-07-03   23  {
0be29b05808bf1 Miguel Ojeda 2021-07-03   24  	BUG();
0be29b05808bf1 Miguel Ojeda 2021-07-03   25  }
0be29b05808bf1 Miguel Ojeda 2021-07-03   26  
0be29b05808bf1 Miguel Ojeda 2021-07-03  @27  void rust_helper_clk_disable_unprepare(struct clk *clk)
0be29b05808bf1 Miguel Ojeda 2021-07-03   28  {
0be29b05808bf1 Miguel Ojeda 2021-07-03   29  	return clk_disable_unprepare(clk);
0be29b05808bf1 Miguel Ojeda 2021-07-03   30  }
0be29b05808bf1 Miguel Ojeda 2021-07-03   31  EXPORT_SYMBOL_GPL(rust_helper_clk_disable_unprepare);
0be29b05808bf1 Miguel Ojeda 2021-07-03   32  
0be29b05808bf1 Miguel Ojeda 2021-07-03  @33  int rust_helper_clk_prepare_enable(struct clk *clk)
0be29b05808bf1 Miguel Ojeda 2021-07-03   34  {
0be29b05808bf1 Miguel Ojeda 2021-07-03   35  	return clk_prepare_enable(clk);
0be29b05808bf1 Miguel Ojeda 2021-07-03   36  }
0be29b05808bf1 Miguel Ojeda 2021-07-03   37  EXPORT_SYMBOL_GPL(rust_helper_clk_prepare_enable);
0be29b05808bf1 Miguel Ojeda 2021-07-03   38  
0be29b05808bf1 Miguel Ojeda 2021-07-03  @39  unsigned long rust_helper_copy_from_user(void *to, const void __user *from, unsigned long n)
0be29b05808bf1 Miguel Ojeda 2021-07-03   40  {
0be29b05808bf1 Miguel Ojeda 2021-07-03   41  	return copy_from_user(to, from, n);
0be29b05808bf1 Miguel Ojeda 2021-07-03   42  }
0be29b05808bf1 Miguel Ojeda 2021-07-03   43  
0be29b05808bf1 Miguel Ojeda 2021-07-03  @44  unsigned long rust_helper_copy_to_user(void __user *to, const void *from, unsigned long n)
0be29b05808bf1 Miguel Ojeda 2021-07-03   45  {
0be29b05808bf1 Miguel Ojeda 2021-07-03   46  	return copy_to_user(to, from, n);
0be29b05808bf1 Miguel Ojeda 2021-07-03   47  }
0be29b05808bf1 Miguel Ojeda 2021-07-03   48  
0be29b05808bf1 Miguel Ojeda 2021-07-03  @49  unsigned long rust_helper_clear_user(void __user *to, unsigned long n)
0be29b05808bf1 Miguel Ojeda 2021-07-03   50  {
0be29b05808bf1 Miguel Ojeda 2021-07-03   51  	return clear_user(to, n);
0be29b05808bf1 Miguel Ojeda 2021-07-03   52  }
0be29b05808bf1 Miguel Ojeda 2021-07-03   53  
0be29b05808bf1 Miguel Ojeda 2021-07-03  @54  void __iomem *rust_helper_ioremap(resource_size_t offset, unsigned long size)
0be29b05808bf1 Miguel Ojeda 2021-07-03   55  {
0be29b05808bf1 Miguel Ojeda 2021-07-03   56  	return ioremap(offset, size);
0be29b05808bf1 Miguel Ojeda 2021-07-03   57  }
0be29b05808bf1 Miguel Ojeda 2021-07-03   58  EXPORT_SYMBOL_GPL(rust_helper_ioremap);
0be29b05808bf1 Miguel Ojeda 2021-07-03   59  
0be29b05808bf1 Miguel Ojeda 2021-07-03  @60  u8 rust_helper_readb(const volatile void __iomem *addr)
0be29b05808bf1 Miguel Ojeda 2021-07-03   61  {
0be29b05808bf1 Miguel Ojeda 2021-07-03   62  	return readb(addr);
0be29b05808bf1 Miguel Ojeda 2021-07-03   63  }
0be29b05808bf1 Miguel Ojeda 2021-07-03   64  EXPORT_SYMBOL_GPL(rust_helper_readb);
0be29b05808bf1 Miguel Ojeda 2021-07-03   65  
0be29b05808bf1 Miguel Ojeda 2021-07-03  @66  u16 rust_helper_readw(const volatile void __iomem *addr)
0be29b05808bf1 Miguel Ojeda 2021-07-03   67  {
0be29b05808bf1 Miguel Ojeda 2021-07-03   68  	return readw(addr);
0be29b05808bf1 Miguel Ojeda 2021-07-03   69  }
0be29b05808bf1 Miguel Ojeda 2021-07-03   70  EXPORT_SYMBOL_GPL(rust_helper_readw);
0be29b05808bf1 Miguel Ojeda 2021-07-03   71  
0be29b05808bf1 Miguel Ojeda 2021-07-03  @72  u32 rust_helper_readl(const volatile void __iomem *addr)
0be29b05808bf1 Miguel Ojeda 2021-07-03   73  {
0be29b05808bf1 Miguel Ojeda 2021-07-03   74  	return readl(addr);
0be29b05808bf1 Miguel Ojeda 2021-07-03   75  }
0be29b05808bf1 Miguel Ojeda 2021-07-03   76  EXPORT_SYMBOL_GPL(rust_helper_readl);
0be29b05808bf1 Miguel Ojeda 2021-07-03   77  
0be29b05808bf1 Miguel Ojeda 2021-07-03   78  #ifdef CONFIG_64BIT
0be29b05808bf1 Miguel Ojeda 2021-07-03  @79  u64 rust_helper_readq(const volatile void __iomem *addr)
0be29b05808bf1 Miguel Ojeda 2021-07-03   80  {
0be29b05808bf1 Miguel Ojeda 2021-07-03   81  	return readq(addr);
0be29b05808bf1 Miguel Ojeda 2021-07-03   82  }
0be29b05808bf1 Miguel Ojeda 2021-07-03   83  EXPORT_SYMBOL_GPL(rust_helper_readq);
0be29b05808bf1 Miguel Ojeda 2021-07-03   84  #endif
0be29b05808bf1 Miguel Ojeda 2021-07-03   85  
0be29b05808bf1 Miguel Ojeda 2021-07-03  @86  void rust_helper_writeb(u8 value, volatile void __iomem *addr)
0be29b05808bf1 Miguel Ojeda 2021-07-03   87  {
0be29b05808bf1 Miguel Ojeda 2021-07-03   88  	writeb(value, addr);
0be29b05808bf1 Miguel Ojeda 2021-07-03   89  }
0be29b05808bf1 Miguel Ojeda 2021-07-03   90  EXPORT_SYMBOL_GPL(rust_helper_writeb);
0be29b05808bf1 Miguel Ojeda 2021-07-03   91  
0be29b05808bf1 Miguel Ojeda 2021-07-03  @92  void rust_helper_writew(u16 value, volatile void __iomem *addr)
0be29b05808bf1 Miguel Ojeda 2021-07-03   93  {
0be29b05808bf1 Miguel Ojeda 2021-07-03   94  	writew(value, addr);
0be29b05808bf1 Miguel Ojeda 2021-07-03   95  }
0be29b05808bf1 Miguel Ojeda 2021-07-03   96  EXPORT_SYMBOL_GPL(rust_helper_writew);
0be29b05808bf1 Miguel Ojeda 2021-07-03   97  
0be29b05808bf1 Miguel Ojeda 2021-07-03  @98  void rust_helper_writel(u32 value, volatile void __iomem *addr)
0be29b05808bf1 Miguel Ojeda 2021-07-03   99  {
0be29b05808bf1 Miguel Ojeda 2021-07-03  100  	writel(value, addr);
0be29b05808bf1 Miguel Ojeda 2021-07-03  101  }
0be29b05808bf1 Miguel Ojeda 2021-07-03  102  EXPORT_SYMBOL_GPL(rust_helper_writel);
0be29b05808bf1 Miguel Ojeda 2021-07-03  103  
0be29b05808bf1 Miguel Ojeda 2021-07-03  104  #ifdef CONFIG_64BIT
0be29b05808bf1 Miguel Ojeda 2021-07-03 @105  void rust_helper_writeq(u64 value, volatile void __iomem *addr)
0be29b05808bf1 Miguel Ojeda 2021-07-03  106  {
0be29b05808bf1 Miguel Ojeda 2021-07-03  107  	writeq(value, addr);
0be29b05808bf1 Miguel Ojeda 2021-07-03  108  }
0be29b05808bf1 Miguel Ojeda 2021-07-03  109  EXPORT_SYMBOL_GPL(rust_helper_writeq);
0be29b05808bf1 Miguel Ojeda 2021-07-03  110  #endif
0be29b05808bf1 Miguel Ojeda 2021-07-03  111  
0be29b05808bf1 Miguel Ojeda 2021-07-03 @112  u8 rust_helper_readb_relaxed(const volatile void __iomem *addr)
0be29b05808bf1 Miguel Ojeda 2021-07-03  113  {
0be29b05808bf1 Miguel Ojeda 2021-07-03  114  	return readb_relaxed(addr);
0be29b05808bf1 Miguel Ojeda 2021-07-03  115  }
0be29b05808bf1 Miguel Ojeda 2021-07-03  116  EXPORT_SYMBOL_GPL(rust_helper_readb_relaxed);
0be29b05808bf1 Miguel Ojeda 2021-07-03  117  
0be29b05808bf1 Miguel Ojeda 2021-07-03 @118  u16 rust_helper_readw_relaxed(const volatile void __iomem *addr)
0be29b05808bf1 Miguel Ojeda 2021-07-03  119  {
0be29b05808bf1 Miguel Ojeda 2021-07-03  120  	return readw_relaxed(addr);
0be29b05808bf1 Miguel Ojeda 2021-07-03  121  }
0be29b05808bf1 Miguel Ojeda 2021-07-03  122  EXPORT_SYMBOL_GPL(rust_helper_readw_relaxed);
0be29b05808bf1 Miguel Ojeda 2021-07-03  123  
0be29b05808bf1 Miguel Ojeda 2021-07-03 @124  u32 rust_helper_readl_relaxed(const volatile void __iomem *addr)
0be29b05808bf1 Miguel Ojeda 2021-07-03  125  {
0be29b05808bf1 Miguel Ojeda 2021-07-03  126  	return readl_relaxed(addr);
0be29b05808bf1 Miguel Ojeda 2021-07-03  127  }
0be29b05808bf1 Miguel Ojeda 2021-07-03  128  EXPORT_SYMBOL_GPL(rust_helper_readl_relaxed);
0be29b05808bf1 Miguel Ojeda 2021-07-03  129  
0be29b05808bf1 Miguel Ojeda 2021-07-03  130  #ifdef CONFIG_64BIT
0be29b05808bf1 Miguel Ojeda 2021-07-03 @131  u64 rust_helper_readq_relaxed(const volatile void __iomem *addr)
0be29b05808bf1 Miguel Ojeda 2021-07-03  132  {
0be29b05808bf1 Miguel Ojeda 2021-07-03  133  	return readq_relaxed(addr);
0be29b05808bf1 Miguel Ojeda 2021-07-03  134  }
0be29b05808bf1 Miguel Ojeda 2021-07-03  135  EXPORT_SYMBOL_GPL(rust_helper_readq_relaxed);
0be29b05808bf1 Miguel Ojeda 2021-07-03  136  #endif
0be29b05808bf1 Miguel Ojeda 2021-07-03  137  
0be29b05808bf1 Miguel Ojeda 2021-07-03 @138  void rust_helper_writeb_relaxed(u8 value, volatile void __iomem *addr)
0be29b05808bf1 Miguel Ojeda 2021-07-03  139  {
0be29b05808bf1 Miguel Ojeda 2021-07-03  140          writeb_relaxed(value, addr);
0be29b05808bf1 Miguel Ojeda 2021-07-03  141  }
0be29b05808bf1 Miguel Ojeda 2021-07-03  142  EXPORT_SYMBOL_GPL(rust_helper_writeb_relaxed);
0be29b05808bf1 Miguel Ojeda 2021-07-03  143  
0be29b05808bf1 Miguel Ojeda 2021-07-03 @144  void rust_helper_writew_relaxed(u16 value, volatile void __iomem *addr)
0be29b05808bf1 Miguel Ojeda 2021-07-03  145  {
0be29b05808bf1 Miguel Ojeda 2021-07-03  146          writew_relaxed(value, addr);
0be29b05808bf1 Miguel Ojeda 2021-07-03  147  }
0be29b05808bf1 Miguel Ojeda 2021-07-03  148  EXPORT_SYMBOL_GPL(rust_helper_writew_relaxed);
0be29b05808bf1 Miguel Ojeda 2021-07-03  149  
0be29b05808bf1 Miguel Ojeda 2021-07-03 @150  void rust_helper_writel_relaxed(u32 value, volatile void __iomem *addr)
0be29b05808bf1 Miguel Ojeda 2021-07-03  151  {
0be29b05808bf1 Miguel Ojeda 2021-07-03  152          writel_relaxed(value, addr);
0be29b05808bf1 Miguel Ojeda 2021-07-03  153  }
0be29b05808bf1 Miguel Ojeda 2021-07-03  154  EXPORT_SYMBOL_GPL(rust_helper_writel_relaxed);
0be29b05808bf1 Miguel Ojeda 2021-07-03  155  
0be29b05808bf1 Miguel Ojeda 2021-07-03  156  #ifdef CONFIG_64BIT
0be29b05808bf1 Miguel Ojeda 2021-07-03 @157  void rust_helper_writeq_relaxed(u64 value, volatile void __iomem *addr)
0be29b05808bf1 Miguel Ojeda 2021-07-03  158  {
0be29b05808bf1 Miguel Ojeda 2021-07-03  159          writeq_relaxed(value, addr);
0be29b05808bf1 Miguel Ojeda 2021-07-03  160  }
0be29b05808bf1 Miguel Ojeda 2021-07-03  161  EXPORT_SYMBOL_GPL(rust_helper_writeq_relaxed);
0be29b05808bf1 Miguel Ojeda 2021-07-03  162  #endif
0be29b05808bf1 Miguel Ojeda 2021-07-03 @163  void rust_helper___spin_lock_init(spinlock_t *lock, const char *name,
0be29b05808bf1 Miguel Ojeda 2021-07-03  164  				  struct lock_class_key *key)
0be29b05808bf1 Miguel Ojeda 2021-07-03  165  {
0be29b05808bf1 Miguel Ojeda 2021-07-03  166  #ifdef CONFIG_DEBUG_SPINLOCK
0be29b05808bf1 Miguel Ojeda 2021-07-03  167  	__spin_lock_init(lock, name, key);
0be29b05808bf1 Miguel Ojeda 2021-07-03  168  #else
0be29b05808bf1 Miguel Ojeda 2021-07-03  169  	spin_lock_init(lock);
0be29b05808bf1 Miguel Ojeda 2021-07-03  170  #endif
0be29b05808bf1 Miguel Ojeda 2021-07-03  171  }
0be29b05808bf1 Miguel Ojeda 2021-07-03  172  EXPORT_SYMBOL_GPL(rust_helper___spin_lock_init);
0be29b05808bf1 Miguel Ojeda 2021-07-03  173  
0be29b05808bf1 Miguel Ojeda 2021-07-03 @174  void rust_helper_spin_lock(spinlock_t *lock)
0be29b05808bf1 Miguel Ojeda 2021-07-03  175  {
0be29b05808bf1 Miguel Ojeda 2021-07-03  176  	spin_lock(lock);
0be29b05808bf1 Miguel Ojeda 2021-07-03  177  }
0be29b05808bf1 Miguel Ojeda 2021-07-03  178  EXPORT_SYMBOL_GPL(rust_helper_spin_lock);
0be29b05808bf1 Miguel Ojeda 2021-07-03  179  
0be29b05808bf1 Miguel Ojeda 2021-07-03 @180  void rust_helper_spin_unlock(spinlock_t *lock)
0be29b05808bf1 Miguel Ojeda 2021-07-03  181  {
0be29b05808bf1 Miguel Ojeda 2021-07-03  182  	spin_unlock(lock);
0be29b05808bf1 Miguel Ojeda 2021-07-03  183  }
0be29b05808bf1 Miguel Ojeda 2021-07-03  184  EXPORT_SYMBOL_GPL(rust_helper_spin_unlock);
0be29b05808bf1 Miguel Ojeda 2021-07-03  185  
0be29b05808bf1 Miguel Ojeda 2021-07-03 @186  unsigned long rust_helper_spin_lock_irqsave(spinlock_t *lock)
0be29b05808bf1 Miguel Ojeda 2021-07-03  187  {
0be29b05808bf1 Miguel Ojeda 2021-07-03  188  	unsigned long flags;
0be29b05808bf1 Miguel Ojeda 2021-07-03  189  	spin_lock_irqsave(lock, flags);
0be29b05808bf1 Miguel Ojeda 2021-07-03  190  	return flags;
0be29b05808bf1 Miguel Ojeda 2021-07-03  191  }
0be29b05808bf1 Miguel Ojeda 2021-07-03  192  EXPORT_SYMBOL_GPL(rust_helper_spin_lock_irqsave);
0be29b05808bf1 Miguel Ojeda 2021-07-03  193  
0be29b05808bf1 Miguel Ojeda 2021-07-03 @194  void rust_helper_spin_unlock_irqrestore(spinlock_t *lock, unsigned long flags)
0be29b05808bf1 Miguel Ojeda 2021-07-03  195  {
0be29b05808bf1 Miguel Ojeda 2021-07-03  196  	spin_unlock_irqrestore(lock, flags);
0be29b05808bf1 Miguel Ojeda 2021-07-03  197  }
0be29b05808bf1 Miguel Ojeda 2021-07-03  198  EXPORT_SYMBOL_GPL(rust_helper_spin_unlock_irqrestore);
0be29b05808bf1 Miguel Ojeda 2021-07-03  199  
0be29b05808bf1 Miguel Ojeda 2021-07-03 @200  void rust_helper_init_wait(struct wait_queue_entry *wq_entry)
0be29b05808bf1 Miguel Ojeda 2021-07-03  201  {
0be29b05808bf1 Miguel Ojeda 2021-07-03  202  	init_wait(wq_entry);
0be29b05808bf1 Miguel Ojeda 2021-07-03  203  }
0be29b05808bf1 Miguel Ojeda 2021-07-03  204  EXPORT_SYMBOL_GPL(rust_helper_init_wait);
0be29b05808bf1 Miguel Ojeda 2021-07-03  205  
0be29b05808bf1 Miguel Ojeda 2021-07-03 @206  int rust_helper_signal_pending(struct task_struct *t)
0be29b05808bf1 Miguel Ojeda 2021-07-03  207  {
0be29b05808bf1 Miguel Ojeda 2021-07-03  208  	return signal_pending(t);
0be29b05808bf1 Miguel Ojeda 2021-07-03  209  }
0be29b05808bf1 Miguel Ojeda 2021-07-03  210  EXPORT_SYMBOL_GPL(rust_helper_signal_pending);
0be29b05808bf1 Miguel Ojeda 2021-07-03  211  
0be29b05808bf1 Miguel Ojeda 2021-07-03 @212  struct page *rust_helper_alloc_pages(gfp_t gfp_mask, unsigned int order)
0be29b05808bf1 Miguel Ojeda 2021-07-03  213  {
0be29b05808bf1 Miguel Ojeda 2021-07-03  214  	return alloc_pages(gfp_mask, order);
0be29b05808bf1 Miguel Ojeda 2021-07-03  215  }
0be29b05808bf1 Miguel Ojeda 2021-07-03  216  EXPORT_SYMBOL_GPL(rust_helper_alloc_pages);
0be29b05808bf1 Miguel Ojeda 2021-07-03  217  
0be29b05808bf1 Miguel Ojeda 2021-07-03 @218  void *rust_helper_kmap(struct page *page)
0be29b05808bf1 Miguel Ojeda 2021-07-03  219  {
0be29b05808bf1 Miguel Ojeda 2021-07-03  220  	return kmap(page);
0be29b05808bf1 Miguel Ojeda 2021-07-03  221  }
0be29b05808bf1 Miguel Ojeda 2021-07-03  222  EXPORT_SYMBOL_GPL(rust_helper_kmap);
0be29b05808bf1 Miguel Ojeda 2021-07-03  223  

:::::: The code at line 22 was first introduced by commit
:::::: 0be29b05808bf1dd4f695555205930b5e72ca44a rust: add C helpers

:::::: TO: Miguel Ojeda <ojeda@kernel.org>
:::::: CC: Miguel Ojeda <ojeda@kernel.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
