Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFDC157F99F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 08:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbiGYGv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 02:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbiGYGv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 02:51:27 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B53EEE01
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 23:51:25 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LrrL206Bbz4xD0;
        Mon, 25 Jul 2022 16:51:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1658731884;
        bh=Cq8bprSGytnq2wIOB6aqNZj7GK3JK47zvUvRs+fgQm4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=SQ4dHzjSQVr6SQ8wG7VrnKMJ6yPNI7yp4dfApyCrgCSvRQ4dd2JzPWqGRBHv+SqYB
         pTr5y8lGQXXQPWdR1+3/oHhaAPDoybW29W3objiWdq7anBqYbTI05SsCmVgUCNGzjj
         I3tyc5sxmqGtpM5F+U/kim/dfMcE05BxOnj61gFuucMIeEKK/s0/YH/iAZzt3709Q2
         EdLvJCB8U53InTde6PO+wfQ3lwIdtji6Fddg0Woxz85+UH74bV5X1NdtzjNV5FcIy6
         yOk1JqM6NP6Ttlz//q96UKGru1D3mgAHupUSGc04EFIvk+QKnXKjLWFBnmzzayjkIN
         mWMMRZflV+h6A==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     wangjianli <wangjianli@cdjrlc.com>, benh@kernel.crashing.org,
        paulus@samba.org, Julia.Lawall@inria.fr, liubo03@inspur.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        wangjianli <wangjianli@cdjrlc.com>
Subject: Re: [PATCH] powerpc/kvm: fix repeated words in comments Delete the
 redundant word 'that'.
In-Reply-To: <20220724062920.1551-1-wangjianli@cdjrlc.com>
References: <20220724062920.1551-1-wangjianli@cdjrlc.com>
Date:   Mon, 25 Jul 2022 16:51:19 +1000
Message-ID: <87bktdd6s8.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wangjianli <wangjianli@cdjrlc.com> writes:
> Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
> ---
>  arch/powerpc/kvm/book3s_64_mmu_hv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
> index 514fd45c1994..73c6db20cd8a 100644
> --- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
> +++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
> @@ -1601,7 +1601,7 @@ long kvm_vm_ioctl_resize_hpt_commit(struct kvm *kvm,
>   * is valid, it is written to the HPT as if an H_ENTER with the
>   * exact flag set was done.  When the invalid count is non-zero
>   * in the header written to the stream, the kernel will make
> - * sure that that many HPTEs are invalid, and invalidate them
> + * sure that many HPTEs are invalid, and invalidate them
>   * if not.

The existing wording is correct:

 "the kernel will make sure that ... that many HPTEs are invalid"

cheers
