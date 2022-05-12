Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1C95247C0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 10:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351354AbiELIRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 04:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235236AbiELIRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 04:17:38 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7178531532
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 01:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dYzfOK1yyq8AEwmqxkCqMkqbjmK+8XEL4Qwke3UqJ2o=; b=Ec/RIDgryQPhFMN3vweDGXRhKN
        XeDfPljFrMb+oilFqohni3pvhModRg38PYSjWhU1LOPwP28l20voa9XFPeXDE9ds60yxtIvItZTh2
        N1lt26tm/8paLVJ7NvoHMYxzSRvzUMo3IRITyQ69o18PkM6p68qBV5m6bfDgdim1fVuf4MwNVfd6c
        degtJFQGauGYZy7PHEEy6Tdz4aaqrPb3gEuQRW4aVv6AQPFhrZxYHIVaPZXe6aUZ4gDuGe+ZTytgZ
        2B8sLtT4eMcsge4gm/ofxKLXP2255dMjWG5+8OIGTBGlJ9rLTD07+FSm0txdca2Ur3+70ZJ/ojVGj
        7IbUdVGQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1np40W-00DSDK-47; Thu, 12 May 2022 08:17:13 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id AD5F198100A; Thu, 12 May 2022 10:17:09 +0200 (CEST)
Date:   Thu, 12 May 2022 10:17:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
        Borislav Petkov <bp@suse.de>
Subject: Re: [ammarfaizi2-block:stable/linux-stable-rc/queue/5.15 146/150]
 kernel/futex.o: warning: objtool: futex_atomic_op_inuser()+0xb8: unreachable
 instruction
Message-ID: <20220512081709.GD76023@worktop.programming.kicks-ass.net>
References: <202205120956.qLpGQurX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202205120956.qLpGQurX-lkp@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 10:00:33AM +0800, kernel test robot wrote:
> tree:   https://github.com/ammarfaizi2/linux-block stable/linux-stable-rc/queue/5.15
> head:   305e905f70311e1b49cc730931a19c3e364f4d8c
> commit: 45dc9d706619a6814e4063d5431483f94badb5a1 [146/150] x86: Add straight-line-speculation mitigation
> config: x86_64-randconfig-m001-20220509 (https://download.01.org/0day-ci/archive/20220512/202205120956.qLpGQurX-lkp@intel.com/config)
> compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
> reproduce (this is a W=1 build):
>         # https://github.com/ammarfaizi2/linux-block/commit/45dc9d706619a6814e4063d5431483f94badb5a1
>         git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
>         git fetch --no-tags ammarfaizi2-block stable/linux-stable-rc/queue/5.15
>         git checkout 45dc9d706619a6814e4063d5431483f94badb5a1
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
> >> kernel/futex.o: warning: objtool: futex_atomic_op_inuser()+0xb8: unreachable instruction
> --
> >> mm/madvise.o: warning: objtool: madvise_behavior()+0x69: unreachable instruction
> --
> >> kernel/bpf/btf.o: warning: objtool: __btf_resolve_size()+0x72: unreachable instruction

Would it be possible for the robot to include the output of this script:

  https://lkml.kernel.org/r/3eb3f091fd6bd9caba50392ceab98ce756804f3b.1650578171.git.jpoimboe@redhat.com

for each objtool warning it gives (as run on vmlinux.o):

  $ ./scripts/objdump-func build-output/vmlinux.o futex_atomic_op_inuser
  $ ./scripts/objdump-func build-output/vmlinux.o madvise_behavior
  $ ./scripts/objdump-func build-output/vmlinux.o __btf_resolve_size

etc.. that would make it easier to see what the problem is without
having to reproduce the build.

A super wild guess; but try this commit:

  1ffbe4e935f9 ("objtool: Default ignore INT3 for unreachable")


