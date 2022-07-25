Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 968DC580496
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 21:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236184AbiGYTlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 15:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiGYTlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 15:41:05 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A19B122
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 12:41:04 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id e5so9053801qts.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 12:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=k8wlql15815HbzF6gaOVAzoTxjGvVTUEygoHa7TQmdk=;
        b=fjhnbxaB2brlSeZLc2kfY5jYQcx2XSsMXd3jYOygJqelb3xNv9y3KW+SzhPIV+qi/q
         n12piJQADGj1B6OWk+c14Dd8s91c1Phk2L258RELhe1eygmjHwBR6OZWi8ZnZTrCze+j
         hX15TTPVY65wfJ05KIpNP0syKFaxIXp2Zv8iVy5aajMi4CKzKxlcqE1FamMF6kEb5bIO
         10VASSLYYBfdBN6xBoSyMz4ZHYo/WQvpHsU4T1X1CW9gTloNlp8Ta9nmLpk0itVbdu8t
         UNLZyefV0vSfQxldeiCOFYrYD5vQLdRQ6HwGbx/j4B9CesBrKLhlKA3s5idIpzxjFWnh
         aFww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=k8wlql15815HbzF6gaOVAzoTxjGvVTUEygoHa7TQmdk=;
        b=pTHUVrL2sa4yT5M77lXPdWmp5ztpTd0JTR9X+Gl7qPR59wGZdI1oiE9orMoR16MpJ/
         oYYrvKuO5I68bgSn//IWfeKncU4oU5+w2+jTr/LcMZQTw2l9VFBYqsLkbqi1LfE1gkO1
         ogeDML1VSBeuKR8nfMZnkAknRz4bb+XoSlFXpwTmKqZmaCYJUJ69CAe51/o366RaBR8h
         voLaxynPbqtY0TM1ygdM7MjXNAg6l/NSc6jgt7nVx4xNEaQxGTVE+CRqduqd4eFrXhAj
         3uAL+LBshf0N/DrYxlz8ukmal32UQaMx/Xn/oyZn/q2AaE/ppMUVm/ikZwfAN6SXv6pi
         KCWw==
X-Gm-Message-State: AJIora/PuttcvgOljzDEUgnjtIFhdfCuDqCV3GJtf8NH6LT/+ncyZPRX
        XvOhW3dHeqT6wBU1ZU0igt0=
X-Google-Smtp-Source: AGRyM1tSGvvqUdE1DXEhK8T44dBn44QCj316XoHlwsvxEN8UwpqYu0OP5ozkBKImyCx0y5p99A5c7w==
X-Received: by 2002:ac8:5b56:0:b0:31e:fceb:8b77 with SMTP id n22-20020ac85b56000000b0031efceb8b77mr11576793qtw.378.1658778063102;
        Mon, 25 Jul 2022 12:41:03 -0700 (PDT)
Received: from localhost ([2601:4c1:c100:1230:3948:b82b:8f44:3d84])
        by smtp.gmail.com with ESMTPSA id o21-20020a05620a2a1500b006b249cc505fsm10244294qkp.82.2022.07.25.12.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 12:41:02 -0700 (PDT)
Date:   Mon, 25 Jul 2022 12:41:01 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Dennis Zhou <dennis@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.19-rc8
Message-ID: <Yt7xzVel3qlwO9Tf@yury-laptop>
References: <CAHk-=wiWwDYxNhnStS0e+p-NTFAQSHvab=2-8LwxunCVuY5-2A@mail.gmail.com>
 <20220725161141.GA1306881@roeck-us.net>
 <CAHk-=whtGUwJwHUSNsXd4g7cok=n0Zwje7nACp8skh1fa2NtJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whtGUwJwHUSNsXd4g7cok=n0Zwje7nACp8skh1fa2NtJA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
> or
> 
>  (b) the ARM find_next_bit() implementation, which doesn't check
> whether the position is past the end
> 
>      I've added Russell King (ARM stuff) and Catalin Marinas who
> touched that last many many years ago in 8b592783a2e8 ("Thumb-2:
> Implement the unified arch/arm/lib functions")
> 
> I think it's arguably a little bit of both, but mostly (b).
> 
> Note how the genetic find_next_bit() (and _find_next_bit()) does
> 
>         if (unlikely(start >= nbits))
>                 return nbits;
> 
> but the arm version of it does not.

If nbits == 0, a function of this sort shouldn't dereference memory at all.
Consider for example:
        void *memchr(const void *s, int c, size_t n)
        {
                const unsigned char *p = s;
                while (n-- != 0) {
                        if ((unsigned char)c == *p++) {
                                return (void *)(p - 1);
                        }
                }
                return NULL;
         }

In case of find_next_bit(), we shouldn't also dereference memory if
start is out of bonds. That's why there's start >= nbits check at the
very beginning. (We can't pack everything in a nice-looking loop, like
memchr does, because we need to mask 1st word at the beginning.)
 
> I think the fix might be something like this:
> 
>   diff --git a/arch/arm/lib/findbit.S b/arch/arm/lib/findbit.S
>   index b5e8b9ae4c7d..b36ca301892e 100644
>   --- a/arch/arm/lib/findbit.S
>   +++ b/arch/arm/lib/findbit.S
>   @@ -83,6 +83,8 @@ ENDPROC(_find_first_bit_le)
>    ENTRY(_find_next_bit_le)
>                 teq     r1, #0
>                 beq     3b
>   +             cmp     r2, r1
>   +             bhs     3b
>                 ands    ip, r2, #7
>                 beq     1b                      @ If new byte, goto old routine
>     ARM(                ldrb    r3, [r0, r2, lsr #3]    )

Looking at the ARM implementation... For sure, it's harder to maintain
because it's asm. It hasn't been revisited for long, and I'm not even
sure it's faster than generic code, because it reads memory per-byte
(ldrb), while bitmaps are optimized for per-word operations (ldr). 

It doesn't implement new functions from the API like find_next_and_bit(),
so ARM takes generic code for them, and nobody complains.

I'm looking at this code for quite a long. Now it starts causing troubles.
Maybe it's time to switch ARM to generic bitmap API entirely?

Thanks,
Yury

> but my ARM asm is so broken that the above is just really random noise
> that may or may not build - much less work.
> 
> I'll leave it to Russell &co to have a tested and working patch.
> 
> Hmm?
> 
>                     Linus
