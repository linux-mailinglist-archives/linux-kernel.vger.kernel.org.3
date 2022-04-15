Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 332C550283A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 12:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345541AbiDOKZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 06:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343614AbiDOKZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 06:25:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B283BBE04
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 03:22:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D4B44B82DD8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 10:22:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75248C385A6
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 10:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650018160;
        bh=SG53jx5hbACDasyAwOVcOuCZSp72pRLMI6HQk8fNWEs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dcw52qmWSkF0C9prN3DgM/DAnY31QNvXcaAJuTozCYDGH7UhMNRKVSfiFAfO2Pr8T
         8aFOi99RO5C92uA7ePh4Z+TzNs1nzwOmEBSgG1MhiCcJhrp3+FySk256HAZWgMXkLW
         VUsRymlGVg4MwQTK3BMjlNgPZkT9aLq3G14tfOUCmJCTsWtxmRVgnBdtJTy7sxJRrE
         XWJHNxeFwhN20uORbqeEnDe4/qH081DJM3jA+g6cqWpEFeAX2izl3LN8M3amVZtoYd
         n2KfZjKTaUAA9GWOb1T5gY1YgF2UlnKyUsCFZbNKstXEJMCv1SUfDjYDLmHxvWabJX
         34CCovi16nqxA==
Received: by mail-oi1-f178.google.com with SMTP id t15so371182oie.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 03:22:40 -0700 (PDT)
X-Gm-Message-State: AOAM531myr0MpaV0hSOch6Zg+Tc8/qWKJKmoJzHDO2CL+rzTUHzulnXJ
        6hnm2f8TulZhneNsZWecNYli2w5xy4s+7JvDO6U=
X-Google-Smtp-Source: ABdhPJxd8R1jAfVjK9PZ0AEFBBqMoMB4bfX+Af0crm7iEuzlvmLYcmE08UUdz+HQf/1i+sTh/ULArtM0VA74n8EsNWA=
X-Received: by 2002:a05:6808:1596:b0:2f7:5d89:eec7 with SMTP id
 t22-20020a056808159600b002f75d89eec7mr1320830oiw.228.1650018159669; Fri, 15
 Apr 2022 03:22:39 -0700 (PDT)
MIME-Version: 1.0
References: <YlVSBuEqMt2S1Gi6@gondor.apana.org.au> <YlVxGAHHD/j6lW3c@arm.com>
 <CAMj1kXGCR833rqKOetj8ykQ8XtDCWbszJYVtVKvLpDLWnM=B5w@mail.gmail.com>
 <YlaOIbSA7B/G9222@arm.com> <YlkV7NtatO7KFusX@gondor.apana.org.au>
 <CAMj1kXFW_zC-U5Ox9_=4gKCwWOmkR7wPNb6UQhiz8viNWTRU-w@mail.gmail.com>
 <YlkkGpVx8rhcsBot@gondor.apana.org.au> <CAMj1kXH0x5Va7Wgs+mU1ONDwwsazOBuN4z4ihVzO2uG-n41Kbg@mail.gmail.com>
 <Ylko07++4naWJ5LE@gondor.apana.org.au> <CAMj1kXH=ybJWBzmMqkrkvyF8nM3UpTchUOq+oweW=BqW2TOyRw@mail.gmail.com>
 <YllE+wWqP6F+1nwa@gondor.apana.org.au>
In-Reply-To: <YllE+wWqP6F+1nwa@gondor.apana.org.au>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 15 Apr 2022 12:22:27 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFjLbtpJLFh-C_k3Ydcg4M7NqrCfOXnBY2iSxusWtBLbA@mail.gmail.com>
Message-ID: <CAMj1kXFjLbtpJLFh-C_k3Ydcg4M7NqrCfOXnBY2iSxusWtBLbA@mail.gmail.com>
Subject: Re: [PATCH 07/10] crypto: Use ARCH_DMA_MINALIGN instead of ARCH_KMALLOC_MINALIGN
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Apr 2022 at 12:12, Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> On Fri, Apr 15, 2022 at 11:51:49AM +0200, Ard Biesheuvel wrote:
> >
> > That is the whole point, really: ARCH_DMA_MINALIGN==128 does not mean
> > __ctx needs to be aligned to 128 bytes, it only means that it should
> > not share a 128 byte cacheline with the preceding fields. So if
> > kmalloc() returns buffers that are aligned to whatever alignment the
> > platform requires (which will be 64 in most cases), the above
> > arrangement ensures that, without requiring that CRYPTO_MINALIGN ==
> > ARCH_DMA_MINALIGN.
>
> What if they started sharing a cacheline with the subsequent object?
> I guess you could add some more padding at the end though.
>

Subsequent objects are owned by the driver, and it is the
responsibility of the driver not to modify the fields while it is also
mapped for DMA (and we have had issues in the past where drivers
violated this rule). So as long as ARCH_KMALLOC_ALIGN guarantees
actual DMA minimum alignment for both the start and the end, we
shouldn't need any explicit padding at the end.

> I could accept this as a temporary solution, if you volunteer to
> modify all the affected drivers so we can get rid of this bandaid.
>

I'l do a scan of drivers/crypto to figure out how much we are relying
on this to begin with.
