Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22B1B539AAF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 03:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348949AbiFABQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 21:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240650AbiFABQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 21:16:00 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8FF8CCEC
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 18:15:57 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id u140so742084oie.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 18:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9UJGq0A7q6FL04u0xtdwS4jKOl1pgj05l7WwmFLX2tk=;
        b=DBksz8GRfm6jzIINmjkD77LIIt7U5s4ZFbQ4TCPx8bjMcxRKfMSjrYSg1a8OhDSr/O
         0m5PSJX5OEBzesWtbO6mPXKzyN8uJ5SrN5klZboZJ6MX9R6u9bbsODyBInlh8vO3JTSK
         YD/nCWiwEKvV1whgFsodI+Rc7D9oIDnafKwceI5stYJjLGIG73XiteTKBsxjcc3RWe/J
         J2RBoZ2tPE0wnQnY389IPyfaJJM94axKwJqMEhMVRQ/y2HSD2SqQXchcxwXgurcr287A
         v83DTUbImL5l6UsYgV4YJBnL0ZFBp7k2Sf6rNSduT5s5D16lU+WgEUm1bM1GzU8foWPL
         5biA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9UJGq0A7q6FL04u0xtdwS4jKOl1pgj05l7WwmFLX2tk=;
        b=Bhjwzs5E1Cxb/uyQLy5CdpP0WCePq8f/4bCwK+RaOTY4EuQtWMqxlXoT2HuzyATWaK
         I/JHEYR4TbE26Mf1Op43G+Ks3OgCor3cRHkOyKM9eUSglyAZk2Hrgip7BgF3vfAn/v/L
         1BO8P20qavrMukdaaDKEL0vtdMPmRhSjS1b+yJybnR77RTZ/7l+googC1dfto0gUmYn1
         7BC5J7gBkRDEpF4E1c6/92NRswp167dLDrADosKYh+nNbt+TOBAj2pHQDpAO2AqMLHDK
         CQ7iv7t9pnsyu9Ni3bc/3FQwewI18PbUY6GkfyE15/L3AwulKRJ3Wu/KfKFbCk8RVx+B
         +vPw==
X-Gm-Message-State: AOAM531j02RxDOAROezhfyxRwYBYZcNhq8bPqesdHrmAiagsWFuKHgOy
        leKBGoDD/6LMQ2PR7wlaAnfsUV5/u7o=
X-Google-Smtp-Source: ABdhPJyrwQmNP54YFQ9HVHB5VZZZb0YdbrYdLXbQ7elgsq6mpmHeXynAB6UTwUaFRihEPPXIiT4YRw==
X-Received: by 2002:a05:6808:1828:b0:326:d7fc:bb56 with SMTP id bh40-20020a056808182800b00326d7fcbb56mr13063959oib.19.1654046157096;
        Tue, 31 May 2022 18:15:57 -0700 (PDT)
Received: from localhost ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id l14-20020a0568301d6e00b0060ae954bf27sm88071oti.62.2022.05.31.18.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 18:15:56 -0700 (PDT)
Date:   Tue, 31 May 2022 18:15:56 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [GIT PULL] Bitmap patches for v5.19-rc1
Message-ID: <Ypa9zOfLPbcfpOgb@yury-laptop>
References: <YpDxiBywRMcdZNUO@yury-laptop>
 <CAHk-=whTKRaz0j+cwkbLe6CEc1XWp45CLQESOqqGnRiaU1UsMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whTKRaz0j+cwkbLe6CEc1XWp45CLQESOqqGnRiaU1UsMQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2022 at 09:17:21PM -0700, Linus Torvalds wrote:
> On Fri, May 27, 2022 at 8:44 AM Yury Norov <yury.norov@gmail.com> wrote:
> >
> >       bitmap: add bitmap_weight_{cmp, eq, gt, ge, lt, le} functions
> 
> So honestly, I pulled this, looked at the code, and then unpulled it again.
> 
> This is not helping.
> 
> Making changes like this:
> 
> -       if (mm != current->active_mm || cpumask_weight(mm_cpumask(mm)) != 1) {
> +       if (mm != current->active_mm || !cpumask_weight_eq(mm_cpumask(mm), 1)) {
> 
> only makes the code harder to understand.
> 
> And it gets worse:
> 
> -               if (cpumask_weight(mask) > cpumask_weight(sibling_mask(cpu)))
> +               if (cpumask_weight_gt(mask, cpumask_weight(sibling_mask(cpu))))
> 
> is just disgusting. That original line is simple to read and makes
> sense. That new replacement really makes you do "Whaa?"
> 
> Now, I understand that these kinds of helper functions could make for
> slightly more efficient code in that you can break out of the bitmap
> scanning early when you have found enough bits set. I get it.
> 
> BUT.
> 
>  (a) code legibility is really really important
> 
>  (b) the places I found this weren't that performance-critical.
> 
>  (c) in most cases, the bitmaps in question are one single word
> 
> so I'm unpulling this again.
> 
> Now, some other parts of the pull were clear improvements. For
> example, the hyperv changes like this:
> 
> -               if (hc->var_cnt != bitmap_weight((unsigned long
> *)&valid_bank_mask, 64))
> +               if (hc->var_cnt != hweight64(valid_bank_mask))
> 
> were clear improvements where the old code was disgusting, and clearly
> improved by the change.
> 
> But the "bitmap_weight_cmp()" functions (and the cpumask_weight_cmp()
> ones) are just not a direction we want to go.
> 
> The special case of zero (ie "cpumask_weight() == 0" ->
> "bitmap_empty()") is one thing: making that kind of change tends to
> keep the code legible or even make it more understandable. So I didn't
> mind that. But I do mind the pointlessly complex new arbitrary weight
> comparisons, and the kind of mental cost they have.
> 
> There are people in the CS world that think "abstractions are always
> good". Those people are very very wrong.

Ok, I'll send a new pull with all but bitmap_weight_cmp() patches.
