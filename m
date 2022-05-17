Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30D5A52AE9D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 01:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbiEQXbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 19:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbiEQXbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 19:31:13 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F612B180;
        Tue, 17 May 2022 16:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652830271; x=1684366271;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=KbP9bBNoJQH+BgtArjeJnCSjiZshkm0O+Ej8OeaI8dI=;
  b=Jnzbhb8TKRFS8QrdCziOSArXfjKe2ttz/YPw/6ybzx9E7V7JEIluQSkE
   /FZfdM1rKs/DGR18zMe/Pk4ZaJvAcf01BIznXrDLCwVsa60xO2QDNQkO4
   ZbFzEO/Wzz2WAF8tNspC4j8JTvW9RRUJkE+hpUNZ+tJ2+ttOOwa86OOFv
   1KPivWgKts64nO3ADtmzDd9K/Uyz1dbd0MEM5e3xeg4aObuCm58fXQdJN
   yP9X/8a5QaUV0zlVekxGUU3PYuEAZQELtOtJNXA01IN+9Tk4q0fUlOeSs
   PavrVda66k8v3odXMMKSKNdKGMMdYO9a79bF2o6WGxOl5L1JF55HXulQk
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="270206655"
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="270206655"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 16:31:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="523203349"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 17 May 2022 16:31:08 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nr6eh-0001ZJ-QY;
        Tue, 17 May 2022 23:31:07 +0000
Date:   Wed, 18 May 2022 07:30:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>,
        jikos@kernel.org
Cc:     kbuild-all@lists.01.org, benjamin.tissoires@redhat.com,
        spbnick@gmail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, stefanberzl@gmail.com,
        =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
Subject: Re: [PATCH for-5.19/uclogic 3/4] HID: uclogic: Allow to generate
 frame templates
Message-ID: <202205180755.I9jze1Z4-lkp@intel.com>
References: <20220516181323.59554-4-jose.exposito89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220516181323.59554-4-jose.exposito89@gmail.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi "José,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on f7d8e387d9aeff963e6691c0166269b8042b4ff9]

url:    https://github.com/intel-lab-lkp/linux/commits/Jos-Exp-sito/Add-support-for-XP-PEN-Deco-L/20220517-021641
base:   f7d8e387d9aeff963e6691c0166269b8042b4ff9
config: mips-randconfig-s032-20220516 (https://download.01.org/0day-ci/archive/20220518/202205180755.I9jze1Z4-lkp@intel.com/config)
compiler: mipsel-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/intel-lab-lkp/linux/commit/d296b420a45eab3527916c73203ed045b65af58e
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jos-Exp-sito/Add-support-for-XP-PEN-Deco-L/20220517-021641
        git checkout d296b420a45eab3527916c73203ed045b65af58e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=mips SHELL=/bin/bash drivers/hid/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   command-line: note: in included file:
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQUIRE redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_SEQ_CST redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQ_REL redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_RELEASE redefined
   builtin:0:0: sparse: this was the original definition
   drivers/hid/hid-uclogic-rdesc.c:1014:25: sparse: sparse: incorrect type in assignment (different base types) @@     expected signed int x @@     got restricted __le32 [usertype] @@
   drivers/hid/hid-uclogic-rdesc.c:1014:25: sparse:     expected signed int x
   drivers/hid/hid-uclogic-rdesc.c:1014:25: sparse:     got restricted __le32 [usertype]
>> drivers/hid/hid-uclogic-rdesc.c:1020:44: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] val @@     got restricted __le16 [usertype] @@
   drivers/hid/hid-uclogic-rdesc.c:1020:44: sparse:     expected unsigned short [usertype] val
   drivers/hid/hid-uclogic-rdesc.c:1020:44: sparse:     got restricted __le16 [usertype]

vim +1020 drivers/hid/hid-uclogic-rdesc.c

   974	
   975	const size_t uclogic_rdesc_xppen_deco01_frame_size =
   976				sizeof(uclogic_rdesc_xppen_deco01_frame_arr);
   977	
   978	/**
   979	 * uclogic_rdesc_template_apply() - apply report descriptor parameters to a
   980	 * report descriptor template, creating a report descriptor. Copies the
   981	 * template over to the new report descriptor and replaces every occurrence of
   982	 * the template placeholders, followed by an index byte, with the value from the
   983	 * parameter list at that index.
   984	 *
   985	 * @template_ptr:	Pointer to the template buffer.
   986	 * @template_size:	Size of the template buffer.
   987	 * @param_list:		List of template parameters.
   988	 * @param_num:		Number of parameters in the list.
   989	 *
   990	 * Returns:
   991	 *	Kmalloc-allocated pointer to the created report descriptor,
   992	 *	or NULL if allocation failed.
   993	 */
   994	__u8 *uclogic_rdesc_template_apply(const __u8 *template_ptr,
   995					   size_t template_size,
   996					   const s32 *param_list,
   997					   size_t param_num)
   998	{
   999		static const __u8 btn_head[] = {UCLOGIC_RDESC_FRAME_PH_BTN_HEAD};
  1000		static const __u8 pen_head[] = {UCLOGIC_RDESC_PEN_PH_HEAD};
  1001		__u8 *rdesc_ptr;
  1002		__u8 *p;
  1003		s32 v;
  1004	
  1005		rdesc_ptr = kmemdup(template_ptr, template_size, GFP_KERNEL);
  1006		if (rdesc_ptr == NULL)
  1007			return NULL;
  1008	
  1009		for (p = rdesc_ptr; p + sizeof(btn_head) < rdesc_ptr + template_size;) {
  1010			if (p + sizeof(pen_head) < rdesc_ptr + template_size &&
  1011			    memcmp(p, pen_head, sizeof(pen_head)) == 0 &&
  1012			    p[sizeof(pen_head)] < param_num) {
  1013				v = param_list[p[sizeof(pen_head)]];
  1014				put_unaligned(cpu_to_le32(v), (s32 *)p);
  1015				p += sizeof(pen_head) + 1;
  1016			} else if (memcmp(p, btn_head, sizeof(btn_head)) == 0 &&
  1017				   p[sizeof(btn_head)] < param_num) {
  1018				v = param_list[p[sizeof(btn_head)]];
  1019				put_unaligned((__u8)0x2A, p); /* Usage Maximum */
> 1020				put_unaligned_le16(cpu_to_le16(v), p + 1);

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
