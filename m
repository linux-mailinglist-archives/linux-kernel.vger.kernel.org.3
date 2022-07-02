Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2395A5642CC
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 23:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbiGBU7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 16:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbiGBU7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 16:59:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F107FAE6E
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 13:59:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A1BA3B8087F
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 20:59:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4185CC341C8;
        Sat,  2 Jul 2022 20:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1656795553;
        bh=7WGeJy6P8hNsZjLQ0kAqTrYs7c+jRQ5n2TEJ2FukCio=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SwALkcSVRogT2MDg7Qfblvjb0Q2wiZkPkdgrqHt7fyG2N9j9FV0QhJe4PhndLEDpk
         2aHzdqOBhWTts7CzCCBPyaDvyL2773ybI+WmH8z0BcnESt5DlqVUIPRXgjZHKKX+io
         iS6bgbWHIta/shsb1vxWrq+Zn3wKSPosLMtQTkCU=
Date:   Sat, 2 Jul 2022 13:59:12 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [akpm-mm:mm-unstable 321/323] include/linux/pgtable.h:1713:10:
 error: redefinition of 'vm_get_page_prot'
Message-Id: <20220702135912.f02c51dcdfa59f4e85860ccb@linux-foundation.org>
In-Reply-To: <202207030224.tqi3q1Wh-lkp@intel.com>
References: <202207030224.tqi3q1Wh-lkp@intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Jul 2022 02:16:09 +0800 kernel test robot <lkp@intel.com> wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-unstable
> head:   706370e5c2ea7bb4544eee6e1172c4d68117a526
> commit: 5b0de55b24615b5f5f600e2a61c297a0432a5e82 [321/323] sh/mm: enable ARCH_HAS_VM_GET_PAGE_PROT
> config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20220703/202207030224.tqi3q1Wh-lkp@intel.com/config)
> compiler: sh4-linux-gcc (GCC) 11.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?id=5b0de55b24615b5f5f600e2a61c297a0432a5e82
>         git remote add akpm-mm https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git
>         git fetch --no-tags akpm-mm mm-unstable
>         git checkout 5b0de55b24615b5f5f600e2a61c297a0432a5e82
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=sh SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from arch/sh/include/asm/io.h:21,
>                     from include/linux/io.h:13,
>                     from arch/sh/mm/mmap.c:10:
> >> include/linux/pgtable.h:1713:10: error: redefinition of 'vm_get_page_prot'
>     1713 | pgprot_t vm_get_page_prot(unsigned long vm_flags)                       \
>          |          ^~~~~~~~~~~~~~~~
>    arch/sh/mm/mmap.c:184:1: note: in expansion of macro 'DECLARE_VM_GET_PAGE_PROT'
>      184 | DECLARE_VM_GET_PAGE_PROT
>          | ^~~~~~~~~~~~~~~~~~~~~~~~
>    In file included from arch/sh/mm/mmap.c:11:
>    include/linux/mm.h:2864:24: note: previous definition of 'vm_get_page_prot' with type 'pgprot_t(long unsigned int)'
>     2864 | static inline pgprot_t vm_get_page_prot(unsigned long vm_flags)
>          |                        ^~~~~~~~~~~~~~~~
> 

um, OK, CONFIG_MMU=n.  I'll let Anshuman ponder this one.

btw, that macro should be called DEFINE_VM_GET_PAGE_PROT - it provides
a definition, not a declaration.

