Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88A964F4753
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 01:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344168AbiDEVIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 17:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443877AbiDEPkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:40:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 856BF11D78E
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 07:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UbTGWkO/rEjN35uuRu4kiIpkbVTt6nafNn/HUzlDHhs=; b=V4uwaUUhdLmPfn7O0b8gxkizRD
        9ryrp6BgwX9pHnZyCJv8NE92yTA1lDTfgop4tL/t2QiDtXsgGdlKLAj6F8rfLcId0Io74OpqmpTui
        1nZ15Wvi992swXhXh/vm8zWx5bmPQGcfCqmU/gqMTRbn3lxF5zxrpKlTKHKzwJEqdGnkfQp3h5UqH
        KfOcBmnMDHX49zoe1jWo/1rRBoxCI299xCSvK3NOaM0ajQoCqwYPf8LfBOL0cmsPpVIIAVwkd2e4d
        4E06VTxtZm6w8wD/lWkcgQwQFwmtDO8CavjnZsiWoAbfh84iu0azI5F5keJPCCdP7n7zJJQnNvWgI
        FyzgT5cg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nbjkE-006lpZ-BO; Tue, 05 Apr 2022 14:01:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E50B33001EA;
        Tue,  5 Apr 2022 16:01:15 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CAC2A30C28E79; Tue,  5 Apr 2022 16:01:15 +0200 (CEST)
Date:   Tue, 5 Apr 2022 16:01:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>, mbenes@suse.cz,
        x86@kernel.org
Subject: Re: drivers/gpu/drm/i915/i915.prelink.o: warning: objtool:
 __intel_wait_for_register_fw.cold()+0xce: relocation to !ENDBR:
 vlv_allow_gt_wake.cold+0x0
Message-ID: <YkxLqznOz0ldTz5a@hirez.programming.kicks-ass.net>
References: <202204041241.Hw855BWm-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202204041241.Hw855BWm-lkp@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2022 at 12:33:19PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   3123109284176b1532874591f7c81f3837bbdc17
> commit: d31ed5d767c0452b4f49846d80a0bfeafa3a4ded kbuild: Fixup the IBT kbuild changes
> date:   12 days ago
> config: x86_64-randconfig-a011-20220404 (https://download.01.org/0day-ci/archive/20220404/202204041241.Hw855BWm-lkp@intel.com/config)
> compiler: gcc-11 (Debian 11.2.0-19) 11.2.0
> reproduce (this is a W=1 build):
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d31ed5d767c0452b4f49846d80a0bfeafa3a4ded
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout d31ed5d767c0452b4f49846d80a0bfeafa3a4ded
>         # save the config file to linux build tree
>         mkdir build_dir
>         make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/gpu/
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
> >> drivers/gpu/drm/i915/i915.prelink.o: warning: objtool: __intel_wait_for_register_fw.cold()+0xce: relocation to !ENDBR: vlv_allow_gt_wake.cold+0x0
>    drivers/gpu/drm/i915/i915.prelink.o: warning: objtool: gen6_alloc_va_range.cold()+0x1c6: relocation to !ENDBR: i915_vma_unpin.cold+0x0
> >> drivers/gpu/drm/i915/i915.prelink.o: warning: objtool: fence_update.cold()+0x14a: relocation to !ENDBR: i915_vma_revoke_fence.cold+0x0
>    drivers/gpu/drm/i915/i915.prelink.o: warning: objtool: eb_move_to_gpu.cold()+0x52: relocation to !ENDBR: i915_reset_gen7_sol_offsets.cold+0x0
> >> drivers/gpu/drm/i915/i915.prelink.o: warning: objtool: __i915_gem_object_release_mmap_gtt.cold()+0xce: relocation to !ENDBR: i915_gem_mmap.cold+0x0
>    drivers/gpu/drm/i915/i915.prelink.o: warning: objtool: i915_ttm_io_mem_pfn.cold()+0x52: relocation to !ENDBR: i915_ttm_delayed_free.cold+0x0
> >> drivers/gpu/drm/i915/i915.prelink.o: warning: objtool: ttm_vm_close.cold()+0x52: relocation to !ENDBR: ttm_vm_open.cold+0x0
>    drivers/gpu/drm/i915/i915.prelink.o: warning: objtool: ttm_vm_open.cold()+0x52: relocation to !ENDBR: i915_ttm_shrinker_release_pages.cold+0x0

---
Subject: objtool/ibt: Allow _THIS_IP_ at: sym+len
From: Peter Zijlstra <peterz@infradead.org>
Date: Tue Apr  5 15:54:41 CEST 2022

0day robot reported:

  drivers/gpu/drm/i915/i915.prelink.o: warning: objtool: __intel_wait_for_register_fw.cold()+0xce: relocation to !ENDBR: vlv_allow_gt_wake.cold+0x0

Which turns out to be GCC placing a _THIS_IP_ past the end of the
function:

0000000000001d00 <__intel_wait_for_register_fw.cold>:
    ...
    1dce:       48 c7 c7 00 00 00 00    mov    $0x0,%rdi        1dd1: R_X86_64_32S      .text.unlikely+0x1df8
    1dd5:       e8 00 00 00 00          call   1dda <__intel_wait_for_register_fw.cold+0xda>    1dd6: R_X86_64_PLT32    __trace_bprintk-0x4
    ...
    1df6:       0f 0b                   ud2

Add an exception for this one weird case...

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/check.c |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3198,6 +3198,8 @@ static void warn_noendbr(const char *msg
 static void validate_ibt_dest(struct objtool_file *file, struct instruction *insn,
 			      struct instruction *dest)
 {
+	struct instruction *last, *next;
+
 	if (dest->func && dest->func == insn->func) {
 		/*
 		 * Anything from->to self is either _THIS_IP_ or IRET-to-self.
@@ -3217,6 +3219,21 @@ static void validate_ibt_dest(struct obj
 	if (dest->noendbr)
 		return;
 
+	/*
+	 * Occasionally, when the last instruction of the function is UD2, GCC
+	 * manages to generate a text reference to the instruction after it.
+	 */
+	last = next = insn;
+	for (;;) {
+		next = next_insn_same_sec(file, next);
+		if (!next || next->func != insn->func)
+			break;
+		last = next;
+	}
+	if (last->type == INSN_BUG &&
+	    last->offset + last->len == dest->offset)
+		return;
+
 	warn_noendbr("", insn->sec, insn->offset, dest);
 }
 
