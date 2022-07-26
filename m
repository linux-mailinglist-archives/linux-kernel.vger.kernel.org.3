Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1952F5818B3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 19:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239598AbiGZRkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 13:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239508AbiGZRkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 13:40:20 -0400
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6382A5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 10:40:06 -0700 (PDT)
Received: by mail-pl1-f170.google.com with SMTP id c13so7266483pla.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 10:40:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4z3ntyExUg7FqjRZyJOCt/4sIEuonwhPPueXjKH5Olg=;
        b=Tl3OO80QO8U8hYUex34cIkz13m4XkHO5dZp37neT/dkp1e2ZnO3ILcYrHUnEzi7R1v
         lY0KNqg5MMo80N3cUMb3lZhjKXx2NNZsw7bUQwMgFo+YZmK3zbgKSgNljGZ7g4Sqjv7q
         bkH5qknGcpkneAW7pZal5bYK7A1pSlzpZY+imGN0+7Uxggofzkk1nnd/QhV3Co8hHanw
         l9k+AmSDlTtWfGuzO/8Ml+u+M9dfpD2rqhouphr6orQE07mKWhTIkGPVFRsp30tW9LeZ
         tc39FII81QpBGOt2O02OpJ6Io76DASBrHW7WKcinyBjKg+Czt44siX/wlcgxmyZQTnBh
         V3eg==
X-Gm-Message-State: AJIora9X2Bq13m92V5lVAPED5oMhqGDE4xUCPnIu223Yy4VEij6NL2Cv
        afG24io9/TIvbWsL3p5rdjOwctPAWNI=
X-Google-Smtp-Source: AGRyM1s7dfmvGBImEVfAgsX6VyOd6YD7yfdhAVr78N475olUJa3pRBkllDCLaks71DOTcWKdnhiElw==
X-Received: by 2002:a17:902:ba91:b0:16c:6b8e:cd06 with SMTP id k17-20020a170902ba9100b0016c6b8ecd06mr17476609pls.33.1658857193707;
        Tue, 26 Jul 2022 10:39:53 -0700 (PDT)
Received: from fedora (136-24-99-118.cab.webpass.net. [136.24.99.118])
        by smtp.gmail.com with ESMTPSA id a23-20020a63cd57000000b0041975999455sm10492644pgj.75.2022.07.26.10.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 10:39:53 -0700 (PDT)
Date:   Tue, 26 Jul 2022 10:39:50 -0700
From:   Dennis Zhou <dennis@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Yury Norov <yury.norov@gmail.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.19-rc8
Message-ID: <YuAm5h1B6bsrR/9q@fedora>
References: <CAHk-=wiWwDYxNhnStS0e+p-NTFAQSHvab=2-8LwxunCVuY5-2A@mail.gmail.com>
 <20220725161141.GA1306881@roeck-us.net>
 <CAHk-=whtGUwJwHUSNsXd4g7cok=n0Zwje7nACp8skh1fa2NtJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whtGUwJwHUSNsXd4g7cok=n0Zwje7nACp8skh1fa2NtJA@mail.gmail.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Jul 25, 2022 at 10:55:18AM -0700, Linus Torvalds wrote:
> On Mon, Jul 25, 2022 at 9:11 AM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > BUG: KFENCE: out-of-bounds read in _find_next_bit_le+0x10/0x48
> 
> Ok, I was hoping somebody more ARMy would look at this, particularly
> since there is no call trace beyond the actual fault.
> 
> So it shows that it happens in _find_next_bit_le(), but not who called it.
> 
> It does show "who allocated the page", and I can see the message that
> is printed afterwards, so it comes from that
> 
>    static void __init test_bitmap_printlist(void)
> 
> function, so I guess we know the call chain:
> 
>   test_bitmap_printlist ->
>     bitmap_print_to_pagebuf ->
>       scnprintf "%*pbl\n" ->
>         pointer ->
>           bitmap_list_string ->
>             for_each_set_bitrange
> 
> and I think I see what's wrong in there. That thing does
> 
>              (b) = find_next_bit((addr), (size), (e) + 1),      \
>              (e) = find_next_zero_bit((addr), (size), (b) + 1))
> 
> for the end of the range, and looking at the oops, the instruction
> that oopses is
> 
>          ldrb    r3, [r0, r2, lsr #3]
> 
> where 'r2' is the bit position, and 'r0' is the start of the bitmap.
> 
> And:
> 
> > r10: 00000000  r9 : 0000002d  r8 : ef59d000
> > r7 : c0e55514  r6 : c2215000  r5 : 00008000  r4 : 00008000
> > r3 : 845cac12  r2 : 00008001  r1 : 00008000  r0 : ef59d000
> 
> Lookie here: r1 contains the size, and r2 is past the end of the size.
> 
> So pick your poison: either the bug is in
> 
>  (a) the bitmap region iterators shouldn't even ask for past-the-end results
> 
>      I've added Dennis Zhou who did that first
> bitmap_for_each_set_region() in commit e837dfde15a4 ("bitmap:
> genericize percpu bitmap region iterators"), and Yuri Norov who
> renamed and moved it to for_each_set_bitrange() in commit ec288a2cf7ca
> ("bitmap: unify find_bit operations").
> 

It seems like this is mostly taken care of by migrating arm to use the
generic implementations, but I just want to cover our basis here.

Are we okay with adding the contract find_*_bit() operations must handle
asking for past size properly? FWIW, we'd have to modify most of the
iterators in find.h.

Thanks,
Dennis
