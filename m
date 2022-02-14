Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88F2D4B41FA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 07:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240852AbiBNG2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 01:28:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240841AbiBNG2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 01:28:53 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6715622D
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 22:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644820126; x=1676356126;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=dtOzPCOkaDIchbROJI0d8OrNu+7J3y2/XmEqsTwbEbY=;
  b=KIfIbujJJK+qxtQ9yD8o2oky1GeQArE6PyMQ2BzAALV4CKihpIheDCnx
   ubuKauAFSsQfUQvsTzI4Kd76IXeD5eJXdhDLBTnVPluWN10vZri3cZNAL
   6rUi0ScGNln28vBh1wHHez/WM+xIX0N3nnirbo5LWEORcwoE/+H1FUh17
   boZwohzNl0GkxdLxBX6FiS01wizmqTr010I/E2kfLgh9KBeu9BsW0nUH7
   EFLJzLhP8reJDkypAElYunFBJzF9q0223mDFSQQhwbeWVkV/jJBjp26Ka
   0V558BYXFuzaztwgM9kz+aC8IrcnKqRyDL5ADj9+KLBgsTRbJy2wJDiP3
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="248857610"
X-IronPort-AV: E=Sophos;i="5.88,367,1635231600"; 
   d="scan'208";a="248857610"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2022 22:28:46 -0800
X-IronPort-AV: E=Sophos;i="5.88,367,1635231600"; 
   d="scan'208";a="527925225"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.255.30.201]) ([10.255.30.201])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2022 22:28:44 -0800
Subject: Re: [kbuild-all] Re: include/linux/build_bug.h:78:41: error: static
 assertion failed: "offsetof(struct page, compound_head) == offsetof(struct
 folio, lru)"
To:     Matthew Wilcox <willy@infradead.org>,
        kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        William Kucharski <william.kucharski@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        David Howells <dhowells@redhat.com>
References: <202202131828.VxAopBqR-lkp@intel.com>
 <Ygj3Wop0i5Ld0gXu@casper.infradead.org>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <6f216c76-e86d-7962-5d40-0b9ce68096d5@intel.com>
Date:   Mon, 14 Feb 2022 14:28:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <Ygj3Wop0i5Ld0gXu@casper.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/13/2022 8:19 PM, Matthew Wilcox wrote:
> On Sun, Feb 13, 2022 at 07:00:16PM +0800, kernel test robot wrote:
>> config: parisc-randconfig-r004-20220213 (https://download.01.org/0day-ci/archive/20220213/202202131828.VxAopBqR-lkp@intel.com/config)
>> compiler: hppa64-linux-gcc (GCC) 11.2.0
>> reproduce (this is a W=1 build):
>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7b230db3b8d373219f88a3d25c8fbbf12cc7f233
>>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>          git fetch --no-tags linus master
>>          git checkout 7b230db3b8d373219f88a3d25c8fbbf12cc7f233
>>          # save the config file to linux build tree
>>          mkdir build_dir
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=parisc prepare
> 
> There's something weird going on here.

Hi Matthew,

Sorry for the inconvenience, it's a false positive, the problem is
ARCH=parisc was used to build the 64 bit kernel.

the actual command should be:
COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross 
O=build_dir ARCH=parisc64 prepare

Best Regards,
Rong Chen

> 
> If I just download & install gcc-11-hppa64-linux-gnu from Debian, this
> config file builds just fine.
> 
> If I invoke make.cross as you have it here, I see the same error you
> report.
> 
> Adding 'V=1' to this, shows:
>    sh ../scripts/atomic/check-atomics.sh
>    /home/willy/0day/gcc-9.3.0-nolibc/hppa-linux/bin/hppa-linux-gcc [...]
> 
> which is weird, right?  It's not hppa64, and it's not gcc-11.2.  So my
> suspicion here is that there's some bug in your tooling which is reporting
> a bogus error.  You're probably better situated to debug this further
> than I am.
> 
> Oh, and I checked, in case the filename was confusing me:
> $ /home/willy/0day/gcc-9.3.0-nolibc/hppa-linux/bin/hppa-linux-gcc -v
> Using built-in specs.
> COLLECT_GCC=/home/willy/0day/gcc-9.3.0-nolibc/hppa-linux/bin/hppa-linux-gcc
> COLLECT_LTO_WRAPPER=/home/willy/0day/gcc-9.3.0-nolibc/hppa-linux/bin/../libexec/gcc/hppa-linux/9.3.0/lto-wrapper
> Target: hppa-linux
> Configured with: /tmp/build-crosstools-xh/gcc/gcc-9.3.0/configure --target=hppa-linux --enable-targets=all --prefix=/tmp/build-crosstools-xh/cross --enable-languages=c --without-headers --disable-bootstrap --disable-nls --disable-threads --disable-shared --disable-libmudflap --disable-libssp --disable-libgomp --disable-decimal-float --disable-libquadmath --disable-libatomic --disable-libcc1 --disable-libmpx --enable-checking=release
> Thread model: single
> gcc version 9.3.0 (GCC)
> 
> So it really is a 32-bit hppa build, and it really is gcc 9.3, not 11.2.
> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org
> 
