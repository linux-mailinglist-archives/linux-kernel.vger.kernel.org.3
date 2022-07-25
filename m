Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D25F57FD9E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 12:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234379AbiGYKfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 06:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbiGYKfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 06:35:50 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3221055A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 03:35:48 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LrxJt751Fz4x1V;
        Mon, 25 Jul 2022 20:35:42 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1658745343;
        bh=0lCaavWzTEZHOsWuEv+IyLlCXiBw3fnmcQUsCDoTEz0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=hyKiJ+CvxWjTeFH0JhJenCdhUYGHkDfBTRDkIc1X4zHDAv1/FORSiBRgQZB8PGbR5
         Ldq6Btgt1i2zTlEr8ad8HFzqPXb/+gAdWOAweGIzyste/CmE/GPFpKKhVepo/o7PMo
         qcv/NfGcS3nH4QJxf0T2hElvPY+KR0jUTkUReVyEY4BQ0vhi0Y8WC5TNfwdlFCSiPB
         hkwx+cQ+V/GdxacJ/9pGduOp1MLDyWSTNZwtogKMwaoHm+NYNN7nwvNo+7f28rnRgG
         Pw+8J41ddH3Jw1FevbnYJkIOkTIuEhkjoH2TUnRbPWqJ59NslgXeD1L/xOyPUXtePH
         uk6gSM1mTppzA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     wangjianli <wangjianli@cdjrlc.com>, benh@kernel.crashing.org,
        paulus@samba.org, Julia.Lawall@inria.fr, liubo03@inspur.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/kvm: fix repeated words in comments Delete the
 redundant word 'that'.
In-Reply-To: <alpine.DEB.2.22.394.2207250913290.2424@hadrien>
References: <20220724062920.1551-1-wangjianli@cdjrlc.com>
 <87bktdd6s8.fsf@mpe.ellerman.id.au>
 <alpine.DEB.2.22.394.2207250913290.2424@hadrien>
Date:   Mon, 25 Jul 2022 20:35:40 +1000
Message-ID: <87zggxbhtv.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Julia Lawall <julia.lawall@inria.fr> writes:
> On Mon, 25 Jul 2022, Michael Ellerman wrote:
>> wangjianli <wangjianli@cdjrlc.com> writes:
>> > diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
>> > index 514fd45c1994..73c6db20cd8a 100644
>> > --- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
>> > +++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
>> > @@ -1601,7 +1601,7 @@ long kvm_vm_ioctl_resize_hpt_commit(struct kvm *kvm,
>> >   * is valid, it is written to the HPT as if an H_ENTER with the
>> >   * exact flag set was done.  When the invalid count is non-zero
>> >   * in the header written to the stream, the kernel will make
>> > - * sure that that many HPTEs are invalid, and invalidate them
>> > + * sure that many HPTEs are invalid, and invalidate them
>> >   * if not.
>>
>> The existing wording is correct:
>>
>>  "the kernel will make sure that ... that many HPTEs are invalid"
>
> Maybe it would be better as "that the number of invalid HPTEs is the same
> as the invalid count"?

That doesn't read quite right, I think because if the number of invalid
HPTEs doesn't match the invalid count, the code will invalidate HPTEs so
that the number matches.

So maybe:

  When the invalid count is non-zero in the header written to the stream,
  the kernel will make sure that number of HPTEs are invalid, or
  invalidate them if not.

cheers
