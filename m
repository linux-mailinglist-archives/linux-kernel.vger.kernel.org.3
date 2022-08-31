Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECC865A7483
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 05:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbiHaDfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 23:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiHaDfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 23:35:00 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2F4AE4D
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 20:34:54 -0700 (PDT)
Received: by gandalf.ozlabs.org (Postfix, from userid 1003)
        id 4MHVDF0DYLz4xGC; Wed, 31 Aug 2022 13:34:53 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
        s=201707; t=1661916893;
        bh=HCg6+BvaYmSmlRjB/itmRf5kMZ9vl1V8waSjYVg7RZs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NQBMw4uCQpWTwSQQEZ7Iqitx69FGv8Tv1E6TRiyXhKHc0+STFMwyqrYsZR7iYbDyO
         z5R3ptFKmQpbwoWjqmeUg1Qo6Pk8xegVomYW5WLq3phLNuQyfXzZooC7GrM0H7dZ3v
         jtqcyuvEwq8jRRP7k7N9htFZXioN3Pj5eDc7ppxs4dpVcSo6XDZD5qtbkeH5aHCS8E
         iCKbilz1JqXPaTUVcWAdTI/awb4FdKPEPQy67qp+C1IJcvVzpyP37ntYr0crzBDhFN
         DQDQxZuJIArJhir+2XTsizWlKJ3vv6DdGXuYMmPJiiGEYqCiTYvbzEtLT75RY0+CWp
         5tiPDTb6qZmnA==
Date:   Wed, 31 Aug 2022 13:34:48 +1000
From:   Paul Mackerras <paulus@ozlabs.org>
To:     Jilin Yuan <yuanjilin@cdjrlc.com>
Cc:     mpe@ellerman.id.au, npiggin@gmail.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: fix repeated words in comments
Message-ID: <Yw7W2DfOvqqm7IvM@cleo>
References: <20220831004454.33921-1-yuanjilin@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220831004454.33921-1-yuanjilin@cdjrlc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 08:44:54AM +0800, Jilin Yuan wrote:
> Delete the redundant word 'that'.

Nack, having two "that"s in a row is intentional.  It's "make sure
that" (i.e. bring about the situation described in what follows)
"that many HPTEs" (i.e. the number of HPTEs referenced previously)
"are invalid".

> Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
> ---
>  arch/powerpc/kvm/book3s_64_mmu_hv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
> index e9744b41a226..8e4b42b5f37f 100644
> --- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
> +++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
> @@ -1601,7 +1601,7 @@ long kvm_vm_ioctl_resize_hpt_commit(struct kvm *kvm,
>   * is valid, it is written to the HPT as if an H_ENTER with the
>   * exact flag set was done.  When the invalid count is non-zero
>   * in the header written to the stream, the kernel will make
> - * sure that that many HPTEs are invalid, and invalidate them
> + * sure that many HPTEs are invalid, and invalidate them
>   * if not.
>   */

Paul.
