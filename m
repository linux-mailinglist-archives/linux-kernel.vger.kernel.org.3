Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6542758854B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 03:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233483AbiHCBJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 21:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiHCBJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 21:09:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E263550AE
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 18:09:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3FD76B8202B
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 01:09:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B44CAC433D6;
        Wed,  3 Aug 2022 01:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1659488990;
        bh=ZGfXtJXYckiqLI2OLNiUd35oN8pZrrFA74XGucTzrjA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hPU7aVFaT/I1UDsj1ptPQu810ub32IqakJANGGKwnd/TlQWVG9AyPwYwvP23XG/pX
         7D1CwWxAcnBx2U9OGAfeWAQ8oxM/4LuteKNb3JspCdyTLtHhaZfl1vZ2j+GTjdwr4X
         e/InQoWAamrsyjMliCOi0JZecGSLLhNcowkP7kW0=
Date:   Tue, 2 Aug 2022 18:09:49 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Ralph Campbell <rcampbell@nvidia.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Alistair Popple <apopple@nvidia.com>
Subject: Re: [akpm-mm:mm-stable 242/251] hmm-tests.c:1607:42: error:
 'HMM_DMIRROR_MIGRATE' undeclared; did you mean 'HMM_DMIRROR_WRITE'?
Message-Id: <20220802180949.1a6429096f9ebede543034fc@linux-foundation.org>
In-Reply-To: <202208030814.FpNJkXbm-lkp@intel.com>
References: <202208030814.FpNJkXbm-lkp@intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Aug 2022 08:24:08 +0800 kernel test robot <lkp@intel.com> wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-stable
> head:   1a44131d4f524e18d873bbe363598e39841001bf
> commit: f6c3e1ae0114cd0f5123cf38187d450c1b119e67 [242/251] mm/hmm: add a test for cross device private faults
> compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
> reproduce:
>         # https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?id=f6c3e1ae0114cd0f5123cf38187d450c1b119e67
>         git remote add akpm-mm https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git
>         git fetch --no-tags akpm-mm mm-stable
>         git checkout f6c3e1ae0114cd0f5123cf38187d450c1b119e67
>         make O=/tmp/kselftest headers
>         make O=/tmp/kselftest -C tools/testing/selftests
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    hmm-tests.c: In function 'hmm2_double_map':
> >> hmm-tests.c:1607:42: error: 'HMM_DMIRROR_MIGRATE' undeclared (first use in this function); did you mean 'HMM_DMIRROR_WRITE'?
>     1607 |         ret = hmm_dmirror_cmd(self->fd1, HMM_DMIRROR_MIGRATE, buffer, npages);
>          |                                          ^~~~~~~~~~~~~~~~~~~
>          |                                          HMM_DMIRROR_WRITE
>    hmm-tests.c:1607:42: note: each undeclared identifier is reported only once for each function it appears in

oops, thanks.  It's been a week - I'm surprised this wasn't picked up
sooner?

Ralph, Alistair, is this right?



From: Andrew Morton <akpm@linux-foundation.org>
Subject: tools/testing/selftests/vm/hmm-tests.c: fix build
Date: Tue Aug  2 06:03:03 PM PDT 2022

hmm-tests.c:1607:42: error: 'HMM_DMIRROR_MIGRATE' undeclared (first use in this function); did you mean 'HMM_DMIRROR_WRITE'?

Fixes: f6c3e1ae0114cd0 ("mm/hmm: add a test for cross device private faults")
Reported-by: kernel test robot <lkp@intel.com>
Cc: Ralph Campbell <rcampbell@nvidia.com>
Cc: Alistair Popple <apopple@nvidia.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 tools/testing/selftests/vm/hmm-tests.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/testing/selftests/vm/hmm-tests.c~tools-testing-selftests-vm-hmm-testsc-fix-build
+++ a/tools/testing/selftests/vm/hmm-tests.c
@@ -1604,7 +1604,7 @@ TEST_F(hmm2, double_map)
 		ASSERT_EQ(ptr[i], i);
 
 	/* Migrate pages to device 1 and try to read from device 0. */
-	ret = hmm_dmirror_cmd(self->fd1, HMM_DMIRROR_MIGRATE, buffer, npages);
+	ret = hmm_migrate_sys_to_dev(self->fd1, buffer, npages);
 	ASSERT_EQ(ret, 0);
 	ASSERT_EQ(buffer->cpages, npages);
 
_

