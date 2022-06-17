Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCAEF54F91A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 16:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381939AbiFQOXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 10:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382716AbiFQOXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 10:23:35 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04EE04AE02
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 07:23:33 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id l4so4167730pgh.13
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 07:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s48+XZroV3EtTjiSKpn6ew2kCrik7JfCW2Vjzd0vaYU=;
        b=PDlfWJH2HoLU4NwlzMU+rq5k7uiuf05iH+c2Tb3fbzMPk47sse9YLNWJPcd4+ej2wS
         7DLtSvHG5HqW4/beX7rieAZtpFsvMPcBtsElEJ4FCX24Ih3gZeD2fZH1AsXvBfemscGQ
         HwXWdwUQnch/yx1uiHGGR+x+gitM73Vjgx8aEKearnR9mFMOhJ42rAE76fEsQ4XRURrU
         XNWCB+Q/WK++XC0AnbQe+WBVEV/ZnvCNECY1rGhenup0i9woxAtEcyxDkZglA8Cq9KzO
         ifNTNQNb/u+O5mu353zEflSTv3BZ32Bw2bwTqyi6N2SMb5qBk0WKdRTAP5mPUTYdbPM1
         54jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s48+XZroV3EtTjiSKpn6ew2kCrik7JfCW2Vjzd0vaYU=;
        b=qzZqEsc03XVVFuSf/Zq6lwQTIjZi/0o/MWkJj5Eh0UCtB2HQZoX99VGtp4GtOFcenJ
         za2g793L03gn3Y2dYU/tkO4ZTThAU+XNxm1VSXmESBJiiUO4xSTWElstVSmbp2QL3g90
         gWvi1re6gJncaU3hbItQfjCoiNfW7Byrg1HMjbeB3diRMSJReglubSTvWsiNo/6kPPJ3
         +DMhrMi8+XqQoaZaV8SOu70zsIyy5/jAtj07Qst8J4FJ8+ZOwWAkKtX/SRMlaVBNl0bw
         CRyisnsBr/5sE6zZ6ubr2wkgULzyPYzE5gH3xC+p2gwV0usBWwcIF3+TJ+mDWaM1E09O
         5xBw==
X-Gm-Message-State: AJIora92dlJaXwv2oijbzxTUh49anHRpm2yCAG49V3v/7ha9fcnrw48o
        Ql3wNDlBYZ085oE/HiaiRIl6hRdHTWoAeDv68Q8=
X-Google-Smtp-Source: AGRyM1ugYmqpUzTFbrQMpFzAvmG4jf2sABMC9YKb4GmNa0H0riR5gaWaeCsXeeUwFUevyvXjlZa10u/72X5mlz+kt/c=
X-Received: by 2002:a63:5522:0:b0:405:1ff7:33dd with SMTP id
 j34-20020a635522000000b004051ff733ddmr9429179pgb.86.1655475813003; Fri, 17
 Jun 2022 07:23:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220610143527.22974-1-kirill.shutemov@linux.intel.com>
 <20220610143527.22974-6-kirill.shutemov@linux.intel.com> <c7e2f8fb44da067e7565d091edeac300977b65ed.camel@intel.com>
 <Yqr4SVMyHRTkc+LN@hirez.programming.kicks-ass.net> <20220616164440.vw7sqnof6grrmnvl@black.fi.intel.com>
 <YqxnMbMhvWO9rEy4@worktop.programming.kicks-ass.net>
In-Reply-To: <YqxnMbMhvWO9rEy4@worktop.programming.kicks-ass.net>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Fri, 17 Jun 2022 07:22:57 -0700
Message-ID: <CAMe9rOq_WT-dxS3xthGtagn=aHruHyUJDR_=RDvMi9vX5PCmnA@mail.gmail.com>
Subject: Re: [PATCHv3 5/8] x86/uaccess: Provide untagged_addr() and remove
 tags before address check
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "kcc@google.com" <kcc@google.com>,
        "andreyknvl@gmail.com" <andreyknvl@gmail.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "ryabinin.a.a@gmail.com" <ryabinin.a.a@gmail.com>,
        "glider@google.com" <glider@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2022 at 4:36 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Jun 16, 2022 at 07:44:40PM +0300, Kirill A. Shutemov wrote:
> > Any objection against this variant (was posted in the thread):
> >
> >               #define untagged_addr(mm, addr) ({                                      \
> >                       u64 __addr = (__force u64)(addr);                               \
> >                       s64 sign = (s64)__addr >> 63;                                   \
> >                       __addr &= (mm)->context.untag_mask | sign;                      \
> >                       (__force __typeof__(addr))__addr;                               \
> >               })
> >
> > ?
>
> Yeah, I suppose that should work fine.

Won't the sign bit be put at the wrong place?

-- 
H.J.
