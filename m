Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2982A57F9FC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 09:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbiGYHOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 03:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiGYHOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 03:14:47 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236809FED
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 00:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=kG1YFRKxcbq+zSs5VKV9a0lQuS4b8911u6IYa7dyiHw=;
  b=aKKl4kYK8n9zjT/c1/cJvvic1NAhsKv0FOIN5j3RC+V/+fWiI7v/dPwZ
   Ca4UHnD0aHeNsfSoWctcyarLicKm2J2sr+8Ydk0IZwX2RJH8oJW/vjplE
   /7LoxvrdS+zYQktwNaL5TeV9WbvH+FONXwMFmMaJL2xu8JepDCbDBpbyo
   E=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.93,192,1654552800"; 
   d="scan'208";a="20053995"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2022 09:14:44 +0200
Date:   Mon, 25 Jul 2022 09:14:39 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: julia@hadrien
To:     Michael Ellerman <mpe@ellerman.id.au>
cc:     wangjianli <wangjianli@cdjrlc.com>, benh@kernel.crashing.org,
        paulus@samba.org, Julia.Lawall@inria.fr, liubo03@inspur.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/kvm: fix repeated words in comments Delete the
 redundant word 'that'.
In-Reply-To: <87bktdd6s8.fsf@mpe.ellerman.id.au>
Message-ID: <alpine.DEB.2.22.394.2207250913290.2424@hadrien>
References: <20220724062920.1551-1-wangjianli@cdjrlc.com> <87bktdd6s8.fsf@mpe.ellerman.id.au>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 25 Jul 2022, Michael Ellerman wrote:

> wangjianli <wangjianli@cdjrlc.com> writes:
> > Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
> > ---
> >  arch/powerpc/kvm/book3s_64_mmu_hv.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
> > index 514fd45c1994..73c6db20cd8a 100644
> > --- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
> > +++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
> > @@ -1601,7 +1601,7 @@ long kvm_vm_ioctl_resize_hpt_commit(struct kvm *kvm,
> >   * is valid, it is written to the HPT as if an H_ENTER with the
> >   * exact flag set was done.  When the invalid count is non-zero
> >   * in the header written to the stream, the kernel will make
> > - * sure that that many HPTEs are invalid, and invalidate them
> > + * sure that many HPTEs are invalid, and invalidate them
> >   * if not.
>
> The existing wording is correct:
>
>  "the kernel will make sure that ... that many HPTEs are invalid"

Maybe it would be better as "that the number of invalid HPTEs is the same
as the invalid count"?

julia
