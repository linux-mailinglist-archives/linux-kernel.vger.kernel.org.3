Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 448194EE489
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 01:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242862AbiCaXO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 19:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231195AbiCaXOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 19:14:24 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262AC1EC635
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 16:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648768356; x=1680304356;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=W4NW8xaMrupsBoko4r0kyBi/5y8nQ7v3a1yNMh9Vios=;
  b=gbEEkuwLbf32e1mKLyvUzkziZjUQLjl542zwfxOD4O+blWrxrHB+5hcq
   2ZP8IXeTQSiAmmE5uNgU4oDiTA0OkYPbt6E5rbAAxPNj9ENGfqAy9ZOgD
   JVp0NgI6XX+N04gFmr5VnsW7tcOWoAQ0cMLPzavurt2PSpQkYW906IMtG
   Dy7+ycCmAkBJ6TJ5E+HszI00mK793oK+5gd+lCmtAROE+xiZPu0Yq6cCd
   CW1AK/2RGTF5P5nnyMuKZC7Ojrxi9NCI+reMmG86Rt90GvIkqWvhuTjui
   gqrWjLjwe2VXzN44+ufj1K2xWH9abvc0BT+FH6dDSOTOo/LbrRLmE521Y
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10303"; a="260166941"
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="260166941"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 16:12:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="520918150"
Received: from lkp-server02.sh.intel.com (HELO 3231c491b0e2) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 31 Mar 2022 16:12:33 -0700
Received: from kbuild by 3231c491b0e2 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1na3xw-0000kH-Tu;
        Thu, 31 Mar 2022 23:12:32 +0000
Date:   Fri, 1 Apr 2022 07:11:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Subject: arch/mips/kvm/mips.c:161:6: warning: no previous prototype for
 'kvm_mips_free_vcpus'
Message-ID: <202204010724.vU4CrQtK-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e729dbe8ea1c6145ae7b9efd6a00a5613746d3b0
commit: 0f78355c450835053fed85828c9d6526594c0921 KVM: MIPS: Enable KVM support for Loongson-3
date:   1 year, 10 months ago
config: mips-loongson3_defconfig (https://download.01.org/0day-ci/archive/20220401/202204010724.vU4CrQtK-lkp@intel.com/config)
compiler: mips64el-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0f78355c450835053fed85828c9d6526594c0921
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 0f78355c450835053fed85828c9d6526594c0921
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash arch/mips/kvm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/mips/kvm/mips.c:161:6: warning: no previous prototype for 'kvm_mips_free_vcpus' [-Wmissing-prototypes]
     161 | void kvm_mips_free_vcpus(struct kvm *kvm)
         |      ^~~~~~~~~~~~~~~~~~~
--
>> arch/mips/kvm/emulate.c:946:23: warning: no previous prototype for 'kvm_mips_emul_eret' [-Wmissing-prototypes]
     946 | enum emulation_result kvm_mips_emul_eret(struct kvm_vcpu *vcpu)
         |                       ^~~~~~~~~~~~~~~~~~
>> arch/mips/kvm/emulate.c:1029:23: warning: no previous prototype for 'kvm_mips_emul_tlbr' [-Wmissing-prototypes]
    1029 | enum emulation_result kvm_mips_emul_tlbr(struct kvm_vcpu *vcpu)
         |                       ^~~~~~~~~~~~~~~~~~
>> arch/mips/kvm/emulate.c:1102:23: warning: no previous prototype for 'kvm_mips_emul_tlbwi' [-Wmissing-prototypes]
    1102 | enum emulation_result kvm_mips_emul_tlbwi(struct kvm_vcpu *vcpu)
         |                       ^~~~~~~~~~~~~~~~~~~
>> arch/mips/kvm/emulate.c:1138:23: warning: no previous prototype for 'kvm_mips_emul_tlbwr' [-Wmissing-prototypes]
    1138 | enum emulation_result kvm_mips_emul_tlbwr(struct kvm_vcpu *vcpu)
         |                       ^~~~~~~~~~~~~~~~~~~
>> arch/mips/kvm/emulate.c:1163:23: warning: no previous prototype for 'kvm_mips_emul_tlbp' [-Wmissing-prototypes]
    1163 | enum emulation_result kvm_mips_emul_tlbp(struct kvm_vcpu *vcpu)
         |                       ^~~~~~~~~~~~~~~~~~
   arch/mips/kvm/emulate.c: In function 'kvm_mips_emulate_load':
   arch/mips/kvm/emulate.c:1936:35: warning: this statement may fall through [-Wimplicit-fallthrough=]
    1936 |                 vcpu->mmio_needed = 1;  /* unsigned */
         |                 ~~~~~~~~~~~~~~~~~~^~~
   arch/mips/kvm/emulate.c:1939:9: note: here
    1939 |         case lw_op:
         |         ^~~~
--
>> arch/mips/kvm/loongson_ipi.c:190:6: warning: no previous prototype for 'kvm_init_loongson_ipi' [-Wmissing-prototypes]
     190 | void kvm_init_loongson_ipi(struct kvm *kvm)
         |      ^~~~~~~~~~~~~~~~~~~~~


vim +/kvm_mips_free_vcpus +161 arch/mips/kvm/mips.c

669e846e6c4e13 arch/mips/kvm/kvm_mips.c Sanjay Lal          2012-11-21  160  
669e846e6c4e13 arch/mips/kvm/kvm_mips.c Sanjay Lal          2012-11-21 @161  void kvm_mips_free_vcpus(struct kvm *kvm)
669e846e6c4e13 arch/mips/kvm/kvm_mips.c Sanjay Lal          2012-11-21  162  {
669e846e6c4e13 arch/mips/kvm/kvm_mips.c Sanjay Lal          2012-11-21  163  	unsigned int i;
669e846e6c4e13 arch/mips/kvm/kvm_mips.c Sanjay Lal          2012-11-21  164  	struct kvm_vcpu *vcpu;
669e846e6c4e13 arch/mips/kvm/kvm_mips.c Sanjay Lal          2012-11-21  165  
669e846e6c4e13 arch/mips/kvm/kvm_mips.c Sanjay Lal          2012-11-21  166  	kvm_for_each_vcpu(i, vcpu, kvm) {
4543bdc08857e8 arch/mips/kvm/mips.c     Sean Christopherson 2019-12-18  167  		kvm_vcpu_destroy(vcpu);
669e846e6c4e13 arch/mips/kvm/kvm_mips.c Sanjay Lal          2012-11-21  168  	}
669e846e6c4e13 arch/mips/kvm/kvm_mips.c Sanjay Lal          2012-11-21  169  
669e846e6c4e13 arch/mips/kvm/kvm_mips.c Sanjay Lal          2012-11-21  170  	mutex_lock(&kvm->lock);
669e846e6c4e13 arch/mips/kvm/kvm_mips.c Sanjay Lal          2012-11-21  171  
669e846e6c4e13 arch/mips/kvm/kvm_mips.c Sanjay Lal          2012-11-21  172  	for (i = 0; i < atomic_read(&kvm->online_vcpus); i++)
669e846e6c4e13 arch/mips/kvm/kvm_mips.c Sanjay Lal          2012-11-21  173  		kvm->vcpus[i] = NULL;
669e846e6c4e13 arch/mips/kvm/kvm_mips.c Sanjay Lal          2012-11-21  174  
669e846e6c4e13 arch/mips/kvm/kvm_mips.c Sanjay Lal          2012-11-21  175  	atomic_set(&kvm->online_vcpus, 0);
669e846e6c4e13 arch/mips/kvm/kvm_mips.c Sanjay Lal          2012-11-21  176  
669e846e6c4e13 arch/mips/kvm/kvm_mips.c Sanjay Lal          2012-11-21  177  	mutex_unlock(&kvm->lock);
669e846e6c4e13 arch/mips/kvm/kvm_mips.c Sanjay Lal          2012-11-21  178  }
669e846e6c4e13 arch/mips/kvm/kvm_mips.c Sanjay Lal          2012-11-21  179  

:::::: The code at line 161 was first introduced by commit
:::::: 669e846e6c4e13f16d7418973609931e362cb16a KVM/MIPS32: MIPS arch specific APIs for KVM

:::::: TO: Sanjay Lal <sanjayl@kymasys.com>
:::::: CC: Ralf Baechle <ralf@linux-mips.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
