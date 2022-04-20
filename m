Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96E9B50849F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 11:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356094AbiDTJPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 05:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237435AbiDTJPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 05:15:03 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344F01CFF4;
        Wed, 20 Apr 2022 02:12:18 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CE1E7210EB;
        Wed, 20 Apr 2022 09:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1650445936; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lY/g1frde4oX7eBXwM2/Tj1cBWBaluAIQ/i9m+pZh34=;
        b=lKy38Wws2D85mw2BVvnN5XnZ85esLb81BMQSZFtV4+1CeP14CXJdRYLjhu2sgnesVFbntD
        QPA3UUtf+bcOpYDeNIIngGXPeCtaUhHoWogi/wJImv4JdA4xLjfgk1IhOAyimxo8kJLnIf
        eNIGI0/qu+U79zZxsjqNPpLBVH3oYuw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1650445936;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lY/g1frde4oX7eBXwM2/Tj1cBWBaluAIQ/i9m+pZh34=;
        b=wXJD6PTIhaCbjlZ3F8g+UVtB1S+XpSUrxx2yIdePp7ozF5nRfQbaAHE/29lzRBgrZUEq/n
        gQ7D8Is1aS3UJxCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AE6EE13AD5;
        Wed, 20 Apr 2022 09:12:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5sizKXDOX2KgCgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 20 Apr 2022 09:12:16 +0000
Message-ID: <c3195d8a-2931-0749-973a-1d04e4baec94@suse.cz>
Date:   Wed, 20 Apr 2022 11:12:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: + mm-swap-remember-pg_anon_exclusive-via-a-swp-pte-bit-fix.patch
 added to -mm tree
Content-Language: en-US
To:     linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org,
        david@redhat.com, akpm@linux-foundation.org
References: <20220413213339.1A60DC385A3@smtp.kernel.org>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220413213339.1A60DC385A3@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/13/22 23:33, Andrew Morton wrote:
> The patch titled
>      Subject: mm-swap-remember-pg_anon_exclusive-via-a-swp-pte-bit-fix
> has been added to the -mm tree.  Its filename is
>      mm-swap-remember-pg_anon_exclusive-via-a-swp-pte-bit-fix.patch
> 
> This patch should soon appear at
>     https://ozlabs.org/~akpm/mmots/broken-out/mm-swap-remember-pg_anon_exclusive-via-a-swp-pte-bit-fix.patch
> and later at
>     https://ozlabs.org/~akpm/mmotm/broken-out/mm-swap-remember-pg_anon_exclusive-via-a-swp-pte-bit-fix.patch

It seems to have disappeared? Also doesn't appear to be squashed in the
original patch?

> Before you just go and hit "reply", please:
>    a) Consider who else should be cc'ed
>    b) Prefer to cc a suitable mailing list as well
>    c) Ideally: find the original patch on the mailing list and do a
>       reply-to-all to that, adding suitable additional cc's
> 
> *** Remember to use Documentation/process/submit-checklist.rst when testing your code ***
> 
> The -mm tree is included into linux-next and is updated
> there every 3-4 working days
> 
> ------------------------------------------------------
> From: David Hildenbrand <david@redhat.com>
> Subject: mm-swap-remember-pg_anon_exclusive-via-a-swp-pte-bit-fix
> 
> Link: https://lkml.kernel.org/r/ac725bcb-313a-4fff-250a-68ba9a8f85fb@redhat.com
> 
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
> 
> --- a/mm/memory.c~mm-swap-remember-pg_anon_exclusive-via-a-swp-pte-bit-fix
> +++ a/mm/memory.c
> @@ -3747,7 +3747,7 @@ vm_fault_t do_swap_page(struct vm_fault
>  			 */
>  			exclusive = true;
>  		} else if (exclusive && PageWriteback(page) &&
> -			   !(swp_swap_info(entry)->flags & SWP_STABLE_WRITES)) {
> +			  (swp_swap_info(entry)->flags & SWP_STABLE_WRITES)) {
>  			/*
>  			 * This is tricky: not all swap backends support
>  			 * concurrent page modifications while under writeback.
> _
> 
> Patches currently in -mm which might be from david@redhat.com are
> 
> mm-rmap-fix-missing-swap_free-in-try_to_unmap-after-arch_unmap_one-failed.patch
> mm-hugetlb-take-src_mm-write_protect_seq-in-copy_hugetlb_page_range.patch
> mm-memory-slightly-simplify-copy_present_pte.patch
> mm-rmap-split-page_dup_rmap-into-page_dup_file_rmap-and-page_try_dup_anon_rmap.patch
> mm-rmap-convert-rmap-flags-to-a-proper-distinct-rmap_t-type.patch
> mm-rmap-remove-do_page_add_anon_rmap.patch
> mm-rmap-pass-rmap-flags-to-hugepage_add_anon_rmap.patch
> mm-rmap-drop-compound-parameter-from-page_add_new_anon_rmap.patch
> mm-rmap-use-page_move_anon_rmap-when-reusing-a-mapped-pageanon-page-exclusively.patch
> mm-huge_memory-remove-outdated-vm_warn_on_once_page-from-unmap_page.patch
> mm-page-flags-reuse-pg_mappedtodisk-as-pg_anon_exclusive-for-pageanon-pages.patch
> mm-remember-exclusively-mapped-anonymous-pages-with-pg_anon_exclusive.patch
> mm-gup-disallow-follow_pagefoll_pin.patch
> mm-support-gup-triggered-unsharing-of-anonymous-pages.patch
> mm-gup-trigger-fault_flag_unshare-when-r-o-pinning-a-possibly-shared-anonymous-page.patch
> mm-gup-sanity-check-with-config_debug_vm-that-anonymous-pages-are-exclusive-when-unpinning.patch
> mm-swap-remember-pg_anon_exclusive-via-a-swp-pte-bit.patch
> mm-swap-remember-pg_anon_exclusive-via-a-swp-pte-bit-fix.patch
> mm-debug_vm_pgtable-add-tests-for-__have_arch_pte_swp_exclusive.patch
> x86-pgtable-support-__have_arch_pte_swp_exclusive.patch
> arm64-pgtable-support-__have_arch_pte_swp_exclusive.patch
> s390-pgtable-cleanup-description-of-swp-pte-layout.patch
> s390-pgtable-support-__have_arch_pte_swp_exclusive.patch
> powerpc-pgtable-remove-_page_bit_swap_type-for-book3s.patch
> powerpc-pgtable-support-__have_arch_pte_swp_exclusive-for-book3s.patch
> 

