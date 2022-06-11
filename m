Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4294E547629
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 17:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238621AbiFKPh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 11:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbiFKPhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 11:37:54 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB6156C20
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 08:37:53 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-3137c877092so16025457b3.13
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 08:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wVBr+sp0YaWjcONzTg5TTCOzwq4j7xeRR6I1R3gyRS4=;
        b=WI6ijgREtxqhxJh6objs+KaDjHLMXR73FotHrvH52Bl3yZVd1jYGUTLqQKFXJgjOpN
         KMrLQm2l7mobkJ7tXFqUU634aGz7oQjRvyK8n3Dq36tS29gN6GrFFjM2eYOjemLpx6KK
         MXekEXOWpqte3OpklJCJZ7URAwegp4RJ4pXUq8PjmpIEYt/RP353lYC4DUXuzJnyy3Cy
         uQ3Xw3c8UsS+DYLnSBOTm9cNFgjk9FoCt/6BICsDHMGMPgC6TJJLt9qsFLv5MVCx0KJV
         v9feTp/gMVdAMr9KzPQU7pGwr32enF08pUYwZWOgnqwkeuWJLNVq1g3f88kJK2VCmdVI
         sjPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wVBr+sp0YaWjcONzTg5TTCOzwq4j7xeRR6I1R3gyRS4=;
        b=MEdxBVdvAW6biCYr1m8Lg0Bn4jyGbhOtQwCFvnmVJY3IBByG5iEhLb09t3pmc0jMKr
         zMuR0DsTqQ83IeXuf87LUwFhC8FotKQTH02w1zFyPF3Pwn05ZTeEf6HQBYzVbmLRZZzn
         KzJhqBJ9WTVVF8dWo2a42e8yHhTHLOMATiA7FTxkmj1xQs5j1YL2CF2F5WdYFzMhRGVH
         h+SCx1/FMurBAK6m2Ibr+94TbReeBcTLBLelUc1Q6WM3i15XM9X51O5UnrigvNvWaSBQ
         +l9RjyxllrzGxdwOz54caRYQ9LKXf/tXL6b0WL8qFGubo/cD2JIFWhhORNr0LJAUHd06
         61ug==
X-Gm-Message-State: AOAM53121opg6/P/IlZD5JgxJUHKBhaz6IrfzqmPPNEt9NvpzOgDfShU
        m2+Q/rK13KND8U+IUbELN3GPG5+UTfqtYcAmZfcPjQ==
X-Google-Smtp-Source: ABdhPJwYscYR7a8G5x9IA2z+7RgfsS1QYNZ3XzfkiSMwfEajlF8rLQULAnRq+TeuyyG3OlRTUG6+u3PtfUe7hOtnHdE=
X-Received: by 2002:a81:a1d3:0:b0:30f:c7f0:7b62 with SMTP id
 y202-20020a81a1d3000000b0030fc7f07b62mr53053752ywg.458.1654961872482; Sat, 11
 Jun 2022 08:37:52 -0700 (PDT)
MIME-Version: 1.0
References: <202206111120.hjvhr7ho-lkp@intel.com>
In-Reply-To: <202206111120.hjvhr7ho-lkp@intel.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Sat, 11 Jun 2022 23:37:16 +0800
Message-ID: <CAMZfGtXnb96ZSx8iTSfPbqqECGSy+PisRCX6PLRe0D6qXszCWw@mail.gmail.com>
Subject: Re: [ammarfaizi2-block:dhowells/linux-fs/netfs-linked-list 29/57]
 include/linux/page-flags.h:788:27: warning: passing argument 1 of 'dump_page'
 discards 'const' qualifier from pointer target type
To:     kernel test robot <lkp@intel.com>,
        David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org,
        "GNU/Weeb Mailing List" <gwml@vger.gnuweeb.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 11, 2022 at 11:19 AM kernel test robot <lkp@intel.com> wrote:
>
> tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/netfs-linked-list
> head:   c19d336b7f0c53bd31e73f6d7d6c1524f0df55b8
> commit: f951c9604853872cf088bb3dbf7d49e3f96b090d [29/57] mm: Make some folio function arguments const
> config: i386-randconfig-a001 (https://download.01.org/0day-ci/archive/20220611/202206111120.hjvhr7ho-lkp@intel.com/config)
> compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
> reproduce (this is a W=1 build):
>         # https://github.com/ammarfaizi2/linux-block/commit/f951c9604853872cf088bb3dbf7d49e3f96b090d
>         git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
>         git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/netfs-linked-list
>         git checkout f951c9604853872cf088bb3dbf7d49e3f96b090d
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         make W=1 O=build_dir ARCH=i386 prepare
>
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
>    In file included from include/linux/gfp.h:5,
>                     from include/linux/slab.h:15,
>                     from include/linux/crypto.h:20,
>                     from arch/x86/kernel/asm-offsets.c:9:
>    include/linux/page-flags.h: In function 'PageHead':
> >> include/linux/page-flags.h:788:27: warning: passing argument 1 of 'dump_page' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
>      788 |         PF_POISONED_CHECK(page);
>          |                           ^~~~
>    include/linux/mmdebug.h:21:35: note: in definition of macro 'VM_BUG_ON_PAGE'
>       21 |                         dump_page(page, "VM_BUG_ON_PAGE(" __stringify(cond)")");\

A lot of places which need to be fixed since dump_page() calls lots of helpers
which do not declare the "struct page *" as "const struct page *".
e.g. page_mapcount(),
PageKsm(), PageAnon(), page_to_pgoff(), PageCompound(), etc.

Thanks.
