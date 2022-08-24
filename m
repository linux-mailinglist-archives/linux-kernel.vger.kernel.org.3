Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 914865A026D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 22:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240082AbiHXUDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 16:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233529AbiHXUDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 16:03:48 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73FE7C1F9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 13:03:47 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id j17so13630235qtp.12
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 13:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=I/OhQ05sFa4+JbagejiMcd2839cYv/Wn8Ivi9z3/4j0=;
        b=F7kiYdCFyT/ZhldrVONseUJBHjLD7mzVSGdd5XX79poudK3LGXfpYWvrgCXmfoAyTr
         dwgT+0VvkgBM5iNF0eIP3BWPYNYtj32Je4xKe/Gh5QJWBWaPMQT/CxNDDN7kZMBWPCQ4
         DyuoG6hYvspPJ7TkBNHnO0QlbaMqtPjCEAEDB2FaAoHxwX+1y/dG+dRgzw1Y59p7bM9l
         scPThZAL9W10zGjFN6CbuJawuKQHsg2nT1oaQhzuKSfNYvwJJw2VL4mOtadHP1l92Y/F
         j7AD/a1NPTurHq+nXuLj/GiFRTC5EQb7rDZqJP+K0tcsISrL2uP4ssTGNx1OAJrNivNB
         4Qcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=I/OhQ05sFa4+JbagejiMcd2839cYv/Wn8Ivi9z3/4j0=;
        b=hBo8aKRMvLKNlwg0Oq7v6lFnclmtmLPapDcftVX7oa8T/onnmZjvs4kpDY84v6blUS
         yVKS7BMhQHZIFs7bSKTQTMb8qv4UwRPgdlaYfDtvk+W1mAtEUtm6xR8F0ZE2+OXa0RIu
         9CQnDipo4n9eP4Qoq/EkS++nOBWm61sNsyFN0dg+rko+CmsC/tZq9ndo/qYgwp/N7JgK
         1XLxwdBr70kCwSLhpwfWiQcWNtl3+I8vvXDXi5Yyt9ZkSNnTEX+7rjMUq5DffhpRNmu2
         oS05cV7yumwNgxlhwKAuJlMicT3Qop+NhPkFTVGF8/lDG0LpVGjj/hdE/ybzLtVdlgfg
         xyhg==
X-Gm-Message-State: ACgBeo3UvPOWvZXHl24D+Mw2pEPRLDxJvScf/mJ1/BieWPghWpfQHmRL
        /jVj8dUixY3DXsTBE2iH7D6Wo32xBcM=
X-Google-Smtp-Source: AA6agR7+K1kirULTq08b9kk3Whm9NekJugreqPrgDPv35N9AuMwUmw6mF/SiGQ1OqNVzv9HP1ar4RA==
X-Received: by 2002:ac8:5ad4:0:b0:344:5e40:7824 with SMTP id d20-20020ac85ad4000000b003445e407824mr877705qtd.482.1661371426996;
        Wed, 24 Aug 2022 13:03:46 -0700 (PDT)
Received: from localhost ([2601:4c1:c100:2270:5a54:d9d9:c2a4:527e])
        by smtp.gmail.com with ESMTPSA id d17-20020a05620a241100b006b46a78bc0fsm17001073qkn.118.2022.08.24.13.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 13:03:46 -0700 (PDT)
Date:   Wed, 24 Aug 2022 13:03:45 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Dennis Zhou <dennis@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alexey Klimov <aklimov@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Whitcroft <apw@canonical.com>
Subject: Re: [PATCH v2 2/3] lib/find_bit: create find_first_zero_bit_le()
Message-ID: <YwaEIRWYumY1i1Ne@yury-laptop>
References: <20220824012624.2826445-1-yury.norov@gmail.com>
 <20220824012624.2826445-3-yury.norov@gmail.com>
 <CAHp75VdgXBFH_vxUNYZLc2ahOrC8oBj0x=2GWXZr+CLGX1qyTg@mail.gmail.com>
 <YwYpqRZxCe9NLZyk@yury-laptop>
 <YwZmsvlFR0cOxvnD@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwZmsvlFR0cOxvnD@shell.armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 06:58:10PM +0100, Russell King (Oracle) wrote:
> On Wed, Aug 24, 2022 at 06:37:45AM -0700, Yury Norov wrote:
> > Because there is a codebase that relies on existing types, mostly in
> > filesystem code. And those fs fixes would require 5 or 6 patches.
> 
> Does that mean that are there filesystems that are passing pointers to
> the find_bit functions which are _not_ aligned to an "unsigned long" ?

Not necessarily. For example, I looked at ext2/4 code, and it looks like
they need void *bitmap, because they pass opaque pointer ->b_data from
struct buffer_head:

  struct buffer_head {
        ...
        char *b_data;                   /* pointer to data within the page */
        ...
  }

So, quite probably, the pointer is aligned when it points to a bitmap.
But I have nothing to prove it, except standard anthropic principle
"otherwise people would complain".

In LE case, the find_bit_le() functions are aliased to find_bit(),
which is aligned, and somehow it works.

> If there are, we should _not_ convert 32-bit ARM to use word loads or
> use the generic code; unaligned loads are expensive on older ARM CPUs,
> at least not the code for older ARM CPUs.

I wonder, if there's an arch that throws an exception in case of unaligned
access. IIRC, ARM can do that, but this option is disabled in kernel.
Right?

I have a series that adds a runtime parameters checker for bitmaps.
I'll add a test for alignment and see how it works (not very soon).

Thanks,
Yury
