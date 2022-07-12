Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6EE571505
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 10:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbiGLIrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 04:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232394AbiGLIrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 04:47:39 -0400
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F8EA6F20;
        Tue, 12 Jul 2022 01:47:38 -0700 (PDT)
Received: by mail-qt1-f169.google.com with SMTP id 23so8850452qtt.3;
        Tue, 12 Jul 2022 01:47:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FH/b2a6H8GyarbPO1fevZpm1/zS2ziSIONXtWtQHlSY=;
        b=y5kCTM6jjpaHfvKGk+TOgRcktTzQgBlaqMnm3UG9ZvkoxuZ3ffplJ6xcDZUkF5dQoB
         yCrL8U6woduRnKQ2Dbm9ds7o0xfWGGOcz17s4gqn1RhFB3RfMBWs0IFOxQXGiLxGTqyk
         T6fKg0juWJrGqaegFxbSW3B0Hau5Lw3octXMA9M56kb5vGj8o/cgtyFURT7ICiDx2bJo
         /+qK60or+5PN+euCJQYFdS9sB/81wj7snPnsjzBVc1g9jedI3/L2RzEZfzhcM1VsOW5k
         C1S15QrBgThAIUapgvRQqZhm0HepBucaI+MutODaPgcLKS/0xc0NAJ/2VO1g6zEIw3Ci
         w58Q==
X-Gm-Message-State: AJIora8RlgppUfrVV1zSdeecLvoZ4WJrIsmSwXUWXh0I3CbOqeFnUoiT
        qDfr7lUFBZhb7ECRVZPU+nCkoIffdQO51g==
X-Google-Smtp-Source: AGRyM1tjq6cRALvUhymGuGAJRQtDFVeRB++hdwTrfWhITkkimGRg5dOJOb/lCPOpBRAjYoy5oOyvnQ==
X-Received: by 2002:ac8:5a49:0:b0:31e:78fc:1f3 with SMTP id o9-20020ac85a49000000b0031e78fc01f3mr17465602qta.90.1657615657205;
        Tue, 12 Jul 2022 01:47:37 -0700 (PDT)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id f4-20020a05620a408400b006b5a63947e3sm699941qko.79.2022.07.12.01.47.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 01:47:36 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-31bf3656517so73624667b3.12;
        Tue, 12 Jul 2022 01:47:35 -0700 (PDT)
X-Received: by 2002:a0d:c787:0:b0:31b:a963:e1de with SMTP id
 j129-20020a0dc787000000b0031ba963e1demr23551067ywd.283.1657615655563; Tue, 12
 Jul 2022 01:47:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220712184238.3670f277@canb.auug.org.au>
In-Reply-To: <20220712184238.3670f277@canb.auug.org.au>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 12 Jul 2022 10:47:24 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUdFwoHqwtH-eL3dc3s612fV4v7gYteuCZxZnPpHOFh-Q@mail.gmail.com>
Message-ID: <CAMuHMdUdFwoHqwtH-eL3dc3s612fV4v7gYteuCZxZnPpHOFh-Q@mail.gmail.com>
Subject: Re: linux-next: manual merge of the mm tree with the m68k tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Zhang Jiaming <jiaming@nfschina.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Tue, Jul 12, 2022 at 10:42 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Today's linux-next merge of the mm tree got a conflict in:
>
>   arch/m68k/include/asm/sun3_pgtable.h
>
> between commit:
>
>   c2a6236024b7 ("m68k: sun3: Fix spelling mistake")
>
> from the m68k tree and commit:
>
>   e7911fea382d ("m68k/mm: enable ARCH_HAS_VM_GET_PAGE_PROT")
>
> from the mm tree.
>
> I fixed it up (the latter removed the comment that the former updated)
> and can carry the fix as necessary. This is now fixed as far as linux-next
> is concerned, but any non trivial conflicts should be mentioned to your
> upstream maintainer when your tree is submitted for merging.  You may
> also want to consider cooperating with the maintainer of the conflicting
> tree to minimise any particularly complex conflicts.

Ah, right. The previous version of the m68k/mm patch didn't remove
the comment, so I thought the spelling fix was safe to apply.

I'll drop the spelling fix from the m68k for-v5.20 branch.

Thanks for reporting!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
