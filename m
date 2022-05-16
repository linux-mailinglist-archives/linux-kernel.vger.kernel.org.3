Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 574F3528C87
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 20:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239177AbiEPSGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 14:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344620AbiEPSGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 14:06:09 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E0FC01
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 11:06:05 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id i17so15167595pla.10
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 11:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lgfZv34I/u7STMeii3JXQ6Fvbr/cHGXJxMl0hsDFMRU=;
        b=mk/wPcdEs/mIfRRBNAyF+w/QHeAbaz3JkOQmagto8O7G5LlbRzlnSSYUbbUfvLUo4t
         6X8FtWPHrvuY3v9xoIweEd6/Uo3WG7HQIY4qIobRQGiTPSQlxLjq2+lVXNS5pOCFi4Ag
         VnWBdJKYOGzTtP8n8I0p6LhDiP3+/Zm5ckaUek+JDEGuO7xkV2RqW0glMOo6ey3+okke
         YViopZ9e2dZBhliGIufP0UrL+S/TxgntN16KkK+6ERXMY337fuCln2AUnzya/Q02u/wM
         rXq5wABKbbsdRsLHd+W3LsGBPVvUtmvY5tPkOk9OSpKw/xgUV33gT8SIXm9gdoxZHLlv
         uJEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lgfZv34I/u7STMeii3JXQ6Fvbr/cHGXJxMl0hsDFMRU=;
        b=SRr6WJzWUlforTPKWNwcYhGh7WkpllAcBiBHGHDbCL6HkDvQzsMkKFdb8K/SrNec1h
         z3akrd8kCVltTjJWcWrJnfnZNK79PQJvWFVVR1i1FJ3y/UWbXXd2JQUIQFUKZcBIyOW9
         qiW09mMz5i+HYxa8cIrVBLhF9iqMorhWPslrRWY//v+c5qszbokeCpWbdrre0u/Qisl0
         JEO4URYErDZKq85mXgPNks9Amm0ucNo6akwN8atVqD6q1KXgqzokBDKMQlsT5jOQv5XS
         ZkjaDH1Zm/nX9CS7CsNZKMpxJ4gn1pSk/4VccAXPn/HYeOx2D4OSqdrxd7HeDeyWrniA
         G2Kg==
X-Gm-Message-State: AOAM532mKZ+wOl2qqk9xjxnN+drJ7Q/SOTqEvUKAg5On42I9lP5hVGi/
        BWDX2N84fe+2fdRGZ1v+D1oIVOH5FY+3L9X+0CaZSg==
X-Google-Smtp-Source: ABdhPJxQd5wyabmd//Ptl5WUVDabc29Ub06YSsGfG1behYpfB9BrPeLeLUj+aBXa741Qf6Pyo1s2T49DrGlFS3YzY+w=
X-Received: by 2002:a17:902:da8b:b0:15e:c0e8:d846 with SMTP id
 j11-20020a170902da8b00b0015ec0e8d846mr18769359plx.34.1652724364595; Mon, 16
 May 2022 11:06:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220516191005.27cee43c@canb.auug.org.au>
In-Reply-To: <20220516191005.27cee43c@canb.auug.org.au>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 16 May 2022 11:05:55 -0700
Message-ID: <CAPcyv4jaMVC0n8yEpH9LDi6HAf0eR82BfA7qs=2BsuZ0uLTahQ@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the nvdimm tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Jane Chu <jane.chu@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 2:11 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> After merging the nvdimm tree, today's linux-next build (i386 defconfig)
> failed like this:
>
> In file included from include/linux/bits.h:6,
>                  from include/linux/bitops.h:6,
>                  from include/linux/kernel.h:22,
>                  from arch/x86/include/asm/percpu.h:27,
>                  from arch/x86/include/asm/preempt.h:6,
>                  from include/linux/preempt.h:78,
>                  from include/linux/spinlock.h:55,
>                  from include/linux/wait.h:9,
>                  from include/linux/wait_bit.h:8,
>                  from include/linux/fs.h:6,
>                  from include/linux/highmem.h:5,
>                  from arch/x86/mm/pat/set_memory.c:6:
> arch/x86/mm/pat/set_memory.c: In function 'set_mce_nospec':
> include/vdso/bits.h:7:40: error: left shift count >= width of type [-Werror=shift-count-overflow]
>     7 | #define BIT(nr)                 (UL(1) << (nr))
>       |                                        ^~
> arch/x86/mm/pat/set_memory.c:1941:59: note: in expansion of macro 'BIT'
>  1941 |         decoy_addr = (pfn << PAGE_SHIFT) + (PAGE_OFFSET ^ BIT(63));
>       |                                                           ^~~
>
> Caused by commit
>
>   39702cf7885c ("x86/mce: relocate set{clear}_mce_nospec() functions")
>
> I applied the following patch for today.

Sorry I missed this. I looked for a way to avoid adding ifdefs in the
C file, but it seems that game is already lost in this file, so I'll
fold this change into the resend.

Thanks!
