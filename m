Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFA43577529
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 11:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbiGQJNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 05:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiGQJNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 05:13:20 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A47214085;
        Sun, 17 Jul 2022 02:13:19 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id h62so15863752ybb.11;
        Sun, 17 Jul 2022 02:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uk9iE2xqsWDP3C6/qpL06kmkPCSpWSohZEixKNflFx4=;
        b=FhkQ0Svj/+tJNsDc6DNnIVS70lQM2tZNF65w+E2+XmCspafhyy1ZbmSSxFtKCs62Bw
         kR5R6AInk+RJVfOdkfa/kxDxYBuWaQa/Sc8Ytq+uOZB1j3NNM9QrG76BPsQa46KrmEaa
         omQgPKFQ02xqfcQMW2t4OjSVx56fbbMOKRVj1H6IBw4rS09VAU1+9+Z1jLWuYgIp6mlK
         F0ywUw3XJxW+T1E5aDt2V13U6Ec2zVnGbMRCMXQB0wiaU5RXgCEWnzloEi98Zi4Ox2nk
         LMv3sOPFciC/RvZtsLr9wC8Ne2u2jSiOA00h7rpHo/0iCk54CmMbCCHmftxi9Z09zdAQ
         009g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uk9iE2xqsWDP3C6/qpL06kmkPCSpWSohZEixKNflFx4=;
        b=N1t0Chn1ekDUC6HiZfn/dN6wSilM7TPLUoL1u1Ao3sImJ7a7e25zuURrnQ2Vlc2vH2
         1S7JpSzkcswHt/rQbo1kzh64Qt+89SOdYmr4qFTRsf0inLYAqhrlX/7jYzqqlV1g/uus
         Ean+8GmxB2mUAJpM82r2I0DEc54oLdqOpWdjMKsub4vXIiSEyd6Pmd4bIeYtzJYjG4Yv
         YsizaK+69vPAepM4zMChH9lT+7S9qC2pWsDbho4+edzxbq7qkNnYkh+kMn8ru+tAM2NM
         Xu/m4v2bk8YMreFuV7qpSDAkw56jqIUAAiBcSLSjkMBqSBJz0/lFSZ1bXK2n+XMMKk4j
         lurw==
X-Gm-Message-State: AJIora9kwfALMxItYI9SYnCr2CaLkFFF0fm+aZorcPUx7IMW+ogXpssZ
        CSpqfUYB/lEny6qFbksmSmdTsslOwKjUcPIH3ug=
X-Google-Smtp-Source: AGRyM1uPYmGAEYb9p0WCn6+51xo81lzv+WhiEGpAx5V4Q7xhNVkaND+PiOC3wHRn30UHjy08DJZdv0dkPzxmu6zNlW4=
X-Received: by 2002:a25:3c45:0:b0:664:cf75:c2d6 with SMTP id
 j66-20020a253c45000000b00664cf75c2d6mr21223452yba.446.1658049198400; Sun, 17
 Jul 2022 02:13:18 -0700 (PDT)
MIME-Version: 1.0
References: <Ys/aDKZNhhsENH9S@debian>
In-Reply-To: <Ys/aDKZNhhsENH9S@debian>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Sun, 17 Jul 2022 10:12:42 +0100
Message-ID: <CADVatmO9XzFnX+N0TuOtr0FYyxKr1oe5RAhCEJjmnvjteT5QNw@mail.gmail.com>
Subject: Re: mainline build failure of powerpc allmodconfig for prom_init_check
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Kees Cook <keescook@chromium.org>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 9:55 AM Sudip Mukherjee (Codethink)
<sudipm.mukherjee@gmail.com> wrote:
>
> Hi All,
>
> Not sure if it has been reported before but the latest mainline kernel
> branch fails to build for powerpc allmodconfig with gcc-12 and the error is:
>
> Error: External symbol 'memset' referenced from prom_init.c
> make[2]: *** [arch/powerpc/kernel/Makefile:204: arch/powerpc/kernel/prom_init_check] Error 1

I was trying to check it. With gcc-11 the assembly code generated is
not using memset, but using __memset.
But with gcc-12, I can see the assembly code is using memset. One
example from the assembly:

call_prom:
        .quad   .call_prom,.TOC.@tocbase,0
        .previous
        .size   call_prom,24
        .type   .call_prom,@function
.call_prom:
        mflr 0           #,
        std 29,-24(1)    #,
        std 30,-16(1)    #,
        std 31,-8(1)     #,
        mr 29,3          # tmp166, service
        mr 31,4          # nargs, tmp167
        mr 30,5          # tmp168, nret
 # arch/powerpc/kernel/prom_init.c:396:         struct prom_args args;
        li 4,254                 #,
        li 5,52          #,
 # arch/powerpc/kernel/prom_init.c:394: {
        std 0,16(1)      #,
        stdu 1,-208(1)   #,,
 # arch/powerpc/kernel/prom_init.c:396:         struct prom_args args;
        addi 3,1,112     # tmp174,,
 # arch/powerpc/kernel/prom_init.c:394: {
        std 9,304(1)     #,
        std 10,312(1)    #,
        std 6,280(1)     #,
        std 7,288(1)     #,
        std 8,296(1)     #,
 # arch/powerpc/kernel/prom_init.c:396:         struct prom_args args;
        bl .memset       #
        nop
        rldicl 9,31,0,32         # nargs, nargs
        addi 9,9,1       # tmp163, nargs,
        mtctr 9          # tmp163, tmp163



-- 
Regards
Sudip
