Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6136562891
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 03:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbiGABur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 21:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbiGABun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 21:50:43 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A074517065
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 18:50:42 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id w83so1734696oiw.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 18:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BPm5UBqQEkho6a63OI9gXhUvNp389zpCyk7F/wC2i0Y=;
        b=HOr2ycPAp0RwGOvIdF7yC/CI8FD6VYKm1P+G48K/m17MRB3JoqrQKy8kO1CFUH7ob3
         EKUn9waC3uxNm6BdnZesXlFFCOnaCTfsFi8QgoBx6xZV3KwgWzjo0CrmxSOXzXEiA81H
         6kUsA8NaALTh28FdZAyuMpvIjfXst1gMAVbgd/Ztv9yljo06T1w6hkp9xB5OvDxFUMjR
         R15fQl1ayAowPddTv1cntOwEtJq2r4H/G3vZjZ9qK7VC0lpyj9wEIR5O/kof4KpRBZ4c
         F68LTuwb9WoB/qqxwpqiVI/V8f9pv5g7+b2Fr+FWdrZSpzYpni/kwbyfCbxvnn9+0qGY
         bmUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BPm5UBqQEkho6a63OI9gXhUvNp389zpCyk7F/wC2i0Y=;
        b=SNwqEoDLKpb0qjmm8y/tjJaxkuqrfrEfkF46OVOv2sNfnRNx4jGtepllb85ugO0oD4
         vwChtDqVuWpFiRow87O6MGhYe0NbdxHrxaJy4SjspfZ7krCE+G/agsNKQy35DJTw9Iy2
         sGg08Poj6vBDqfVOuKRtm6TzMHibOa0oWwHaRDHPza6H1ZPDP/9j9oH3CsoMGcWrc98D
         Yj82/SwmfDOvuuMS48RDPDiOJbT+VuJei4Ckqyv+zf3tAhjERfKYfo2ex27KRBkLM+g3
         yh2h34miJVg7wPGgLw9j9Sv3Kvc5+AJyhuNjQPFzrO1qSLlHj8m4ExLYNJPQDYMcTmuv
         MGdg==
X-Gm-Message-State: AJIora9Lh27UVKOZpCLT2zv//ruMBXYrRgEmX/LSq2QbwFvbZsVY3PfM
        YUgCniWGF8MfnBPIq8Q0RW+P+LUL4Jw=
X-Google-Smtp-Source: AGRyM1vLVmWCgu4SwIBw+H0gwtB6cTs3qYQaHuCZSjNS0AKD8ZlG1JTgBOZSwIxcQC2PeLDT84KKgQ==
X-Received: by 2002:a05:6808:1794:b0:335:a89f:55b8 with SMTP id bg20-20020a056808179400b00335a89f55b8mr7300425oib.261.1656640241214;
        Thu, 30 Jun 2022 18:50:41 -0700 (PDT)
Received: from bertie (072-190-140-117.res.spectrum.com. [72.190.140.117])
        by smtp.gmail.com with ESMTPSA id a28-20020a0568301ddc00b00616b06d520dsm10709158otj.5.2022.06.30.18.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 18:50:40 -0700 (PDT)
Date:   Thu, 30 Jun 2022 20:50:37 -0500
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/4] memblock tests: add verbose output to memblock
 tests
Message-ID: <Yr5S7Rf63GXXLnjp@bertie>
References: <cover.1656368930.git.remckee0@gmail.com>
 <883c28e34527fd4cdc55df97c791ed8b2e79538d.1656368930.git.remckee0@gmail.com>
 <5db2944e-9d64-8faa-83d3-fd02fce583bd@redhat.com>
 <YryG1nuJ+nL9maeS@bertie>
 <ef1620a2-dbc6-911e-5cd0-e860ad7772e0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef1620a2-dbc6-911e-5cd0-e860ad7772e0@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 12:17:48PM +0200, David Hildenbrand wrote:
> On 29.06.22 19:07, Rebecca Mckeever wrote:
> > On Wed, Jun 29, 2022 at 01:34:54PM +0200, David Hildenbrand wrote:
> >> On 28.06.22 00:34, Rebecca Mckeever wrote:
> >>> Add and use functions and macros for printing verbose testing output.
> >>>
> >>> If the Memblock simulator was compiled with VERBOSE=1:
> >>> - prefix_push(): appends the given string to a prefix string that will be
> >>>   printed in test_fail() and test_pass*().
> >>>
> >>> - prefix_pop(): removes the last prefix from the prefix string.
> >>>
> >>> - prefix_reset(): clears the prefix string.
> >>>
> >>> - test_fail(): prints a message after a test fails containing the test
> >>>   number of the failing test and the prefix.
> >>>
> >>> - test_pass(): prints a message after a test passes containing its test
> >>>   number and the prefix.
> >>>
> >>> - test_print(): prints the given formatted output string.
> >>>
> >>> - test_pass_pop(): runs test_pass() followed by prefix_pop().
> >>>
> >>> - PREFIX_PUSH(): runs prefix_push(__func__).
> >>>
> >>> If the Memblock simulator was not compiled with VERBOSE=1, these
> >>> functions/macros do nothing.
> >>>
> >>> Add the assert wrapper macros ASSERT_EQ(), ASSERT_NE(), and ASSERT_LT().
> >>> If the assert condition fails, these macros call test_fail() before
> >>> executing assert().
> >>>
> >>> Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
> >>
> >>
> >> [...]
> >>
> >>>  
> >>> diff --git a/tools/testing/memblock/tests/common.c b/tools/testing/memblock/tests/common.c
> >>> index 62d3191f7c9a..e55b2a8bf0ff 100644
> >>> --- a/tools/testing/memblock/tests/common.c
> >>> +++ b/tools/testing/memblock/tests/common.c
> >>> @@ -4,8 +4,12 @@
> >>>  
> >>>  #define INIT_MEMBLOCK_REGIONS			128
> >>>  #define INIT_MEMBLOCK_RESERVED_REGIONS		INIT_MEMBLOCK_REGIONS
> >>> +#define PREFIXES_LEN_MAX			256
> >>> +#define DELIM					": "
> >>> +#define DELIM_LEN				strlen(DELIM)
> >>
> >> Why not simply
> >>
> >> #define PREFIXES_MAX	15
> >> static const char * __maybe_unused prefixes[PREFIXES_MAX];
> >> static int nr_prefixes;
> >>
> >> And then simply insert/clear the corresponding prefixes[] pointer and
> >> update nr_prefixes?
> >>
> >> When printing, you only have to walk prefixes from 0 ... nr_prefixes - 1
> >> and print the values.
> >>
> >> Avoids any string modifications.
> >>
> > What is nr_prefixes? Number of prefixes? Currently, the longest prefix is
> > 49 characters (alloc_try_nid_bottom_up_reserved_with_space_check), so I
> > think PREFIXES_MAX would need to be at least 52 (including the delimiter),
> > but let me know if I'm misunderstanding.
> 
> nr_prefixes would be the current number of prefixes (not the length).
> 
> You be storing pointers to strings in the constant pool, not copying the
> strings over.
> 
Okay, that makes sense. Good idea! I'll make this change.

> -- 
> Thanks,
> 
> David / dhildenb
> 
Thanks,
Rebecca
