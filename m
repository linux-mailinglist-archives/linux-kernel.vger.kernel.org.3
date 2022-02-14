Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7811B4B3E85
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 01:07:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238823AbiBNAFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 19:05:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbiBNAFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 19:05:10 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3638C51E5D
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 16:05:03 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id d10so34045399eje.10
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 16:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Q506mjUFQLa0QCAR/FySqXIPlqEu0ztpqvJS5nI+hGk=;
        b=X7P19J5HBFK2SmheyA6Q1sZm+NEp0a9SLQi9jLpvdD3XpmR8S+ap9oRFwqaqvIMmzK
         vRlzLqoKLLimR2mVVs3l1KJbQ+TYsZ+3Ivi5GIj54sm4U8RIGEkI12srqJfWCKkPCXPP
         vCcyqEPcU2oSU/8vIEfqWs4CL82KfWVxkzOOqfwcg3WDgND32zntNkDEJvqT8CBICkVY
         ImR92SsK7vL73mAZtkeOcMtlAHcVWMjZPQMqIjBygcfxtM9ebUnaswgGKbDrcVRGgIAG
         pTqSuAqc4+IxiGN5yCLzLoVfDKWJmsutpbSff31EUN/A8oTCL2yoElZuX8+oL6vdoq4j
         y4oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q506mjUFQLa0QCAR/FySqXIPlqEu0ztpqvJS5nI+hGk=;
        b=WbD4XabCdDN0hcwNEtg1Koh2xGQZq9IARvMh6VsYjX9IXjsWso6CyjI7+l9EJqqjBJ
         Ifo2BkbutQTcFcpkhNkss1aDVi1LiUgZIagIv9Q0fgKPLSW+08JdKq578pMKru7npc+b
         gPh1lqLv0DUl3pCte/BCmGDet9tM2DkL5NDMy7T+TjH1XEMcfpyFE7ELEvhV/kmuT3GV
         nPgy0HWPXbHroRP0Dj86WpaSVP+Jgj3/1neUYpuLGWvIHWCIQcdDNf7KmeH9d9JEpYAU
         PEW6dllDgz+GaCnIvzJ+5P7uAsAdyRTY85OLu2uRol/zPO9U0ZuNDP1hmxbi5PKdvEul
         6Xww==
X-Gm-Message-State: AOAM530wx5vsHrTobbn/xy07+Ah6C5Q7238+cV1FX3cAUzlxJpvAtLn3
        GCyDsMq7ynga3h7ORi2MzJk=
X-Google-Smtp-Source: ABdhPJxV1GWN5wCzBdVXLOEp5MDCv+JSAT7A6ufaM7t2X91/YLsbHO0PY7RHIEqm8c7xtH7T+5m7TA==
X-Received: by 2002:a17:907:a409:: with SMTP id sg9mr9162530ejc.219.1644797101621;
        Sun, 13 Feb 2022 16:05:01 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 5sm1372646ejr.144.2022.02.13.16.05.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 13 Feb 2022 16:05:01 -0800 (PST)
Date:   Mon, 14 Feb 2022 00:05:00 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Wei Yang <richard.weiyang@gmail.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: include/linux/build_bug.h:78:41: error: static assertion failed:
 "offsetof(struct page, mapping) == offsetof(struct folio, mapping)"
Message-ID: <20220214000500.4ao6vrh4l33donqz@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <202202131932.diaqTbxo-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202202131932.diaqTbxo-lkp@intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 13, 2022 at 07:51:34PM +0800, kernel test robot wrote:
>tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>head:   b81b1829e7e39f6cebdf6e4d5484eacbceda8554
>commit: 536f4217ced62b671bd759f6b549621a5654a70f mm: page->mapping folio->mapping should have the same offset
>date:   2 weeks ago
>config: parisc-randconfig-r004-20220213 (https://download.01.org/0day-ci/archive/20220213/202202131932.diaqTbxo-lkp@intel.com/config)
>compiler: hppa64-linux-gcc (GCC) 11.2.0
>reproduce (this is a W=1 build):
>        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>        chmod +x ~/bin/make.cross
>        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=536f4217ced62b671bd759f6b549621a5654a70f
>        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>        git fetch --no-tags linus master
>        git checkout 536f4217ced62b671bd759f6b549621a5654a70f
>        # save the config file to linux build tree
>        mkdir build_dir
>        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=parisc prepare
>
>If you fix the issue, kindly add following tag as appropriate
>Reported-by: kernel test robot <lkp@intel.com>
>
>All errors (new ones prefixed by >>):
>
>      18 |         if (!(word & (~0ul << 32))) {
>         |                            ^~
>   include/asm-generic/bitops/__fls.h:20:22: warning: left shift count >= width of type [-Wshift-count-overflow]
>      20 |                 word <<= 32;
>         |                      ^~~
>   include/asm-generic/bitops/__fls.h:23:28: warning: left shift count >= width of type [-Wshift-count-overflow]
>      23 |         if (!(word & (~0ul << (BITS_PER_LONG-16)))) {
>         |                            ^~
>   include/asm-generic/bitops/__fls.h:27:28: warning: left shift count >= width of type [-Wshift-count-overflow]
>      27 |         if (!(word & (~0ul << (BITS_PER_LONG-8)))) {
>         |                            ^~
>   include/asm-generic/bitops/__fls.h:31:28: warning: left shift count >= width of type [-Wshift-count-overflow]
>      31 |         if (!(word & (~0ul << (BITS_PER_LONG-4)))) {
>         |                            ^~
>   include/asm-generic/bitops/__fls.h:35:28: warning: left shift count >= width of type [-Wshift-count-overflow]
>      35 |         if (!(word & (~0ul << (BITS_PER_LONG-2)))) {
>         |                            ^~
>   include/asm-generic/bitops/__fls.h:39:28: warning: left shift count >= width of type [-Wshift-count-overflow]
>      39 |         if (!(word & (~0ul << (BITS_PER_LONG-1))))
>         |                            ^~
>   In file included from arch/parisc/include/asm/bitops.h:201,
>                    from include/linux/bitops.h:33,
>                    from include/linux/kernel.h:22,
>                    from arch/parisc/include/asm/bug.h:5,
>                    from include/linux/bug.h:5,
>                    from include/linux/thread_info.h:13,
>                    from include/asm-generic/preempt.h:5,
>                    from ./arch/parisc/include/generated/asm/preempt.h:1,
>                    from include/linux/preempt.h:78,
>                    from include/linux/rcupdate.h:27,
>                    from include/linux/rculist.h:11,
>                    from include/linux/pid.h:5,
>                    from include/linux/sched.h:14,
>                    from arch/parisc/kernel/asm-offsets.c:18:
>   include/asm-generic/bitops/__fls.h: In function '__fls':
>   include/asm-generic/bitops/__fls.h:18:28: warning: left shift count >= width of type [-Wshift-count-overflow]
>      18 |         if (!(word & (~0ul << 32))) {
>         |                            ^~
>   include/asm-generic/bitops/__fls.h:20:22: warning: left shift count >= width of type [-Wshift-count-overflow]
>      20 |                 word <<= 32;
>         |                      ^~~
>   include/asm-generic/bitops/__fls.h:23:28: warning: left shift count >= width of type [-Wshift-count-overflow]
>      23 |         if (!(word & (~0ul << (BITS_PER_LONG-16)))) {
>         |                            ^~
>   include/asm-generic/bitops/__fls.h:27:28: warning: left shift count >= width of type [-Wshift-count-overflow]
>      27 |         if (!(word & (~0ul << (BITS_PER_LONG-8)))) {
>         |                            ^~
>   include/asm-generic/bitops/__fls.h:31:28: warning: left shift count >= width of type [-Wshift-count-overflow]
>      31 |         if (!(word & (~0ul << (BITS_PER_LONG-4)))) {
>         |                            ^~
>   include/asm-generic/bitops/__fls.h:35:28: warning: left shift count >= width of type [-Wshift-count-overflow]
>      35 |         if (!(word & (~0ul << (BITS_PER_LONG-2)))) {
>         |                            ^~
>   include/asm-generic/bitops/__fls.h:39:28: warning: left shift count >= width of type [-Wshift-count-overflow]
>      39 |         if (!(word & (~0ul << (BITS_PER_LONG-1))))
>         |                            ^~
>   In file included from arch/parisc/include/asm/processor.h:18,
>                    from arch/parisc/include/asm/thread_info.h:6,
>                    from include/linux/thread_info.h:60,
>                    from include/asm-generic/preempt.h:5,
>                    from ./arch/parisc/include/generated/asm/preempt.h:1,
>                    from include/linux/preempt.h:78,
>                    from include/linux/rcupdate.h:27,
>                    from include/linux/rculist.h:11,
>                    from include/linux/pid.h:5,
>                    from include/linux/sched.h:14,
>                    from arch/parisc/kernel/asm-offsets.c:18:
>   arch/parisc/include/asm/pdc.h: At top level:
>   arch/parisc/include/asm/pdc.h:77:24: warning: 'struct pdc_memory_table' declared inside parameter list will not be visible outside of this definition or declaration
>      77 |                 struct pdc_memory_table *tbl, unsigned long entries);
>         |                        ^~~~~~~~~~~~~~~~
>   arch/parisc/include/asm/pdc.h:76:30: warning: 'struct pdc_memory_table_raddr' declared inside parameter list will not be visible outside of this definition or declaration
>      76 | int pdc_mem_mem_table(struct pdc_memory_table_raddr *r_addr,
>         |                              ^~~~~~~~~~~~~~~~~~~~~~
>   In file included from include/linux/compiler_types.h:65,
>                    from <command-line>:
>   include/linux/smp.h:34:33: error: requested alignment '20' is not a positive power of 2
>      34 |         __aligned(sizeof(struct __call_single_data));
>         |                                 ^~~~~~~~~~~~~~~~~~
>   include/linux/compiler_attributes.h:33:68: note: in definition of macro '__aligned'
>      33 | #define __aligned(x)                    __attribute__((__aligned__(x)))
>         |                                                                    ^
>   In file included from include/linux/container_of.h:5,
>                    from include/linux/list.h:5,
>                    from include/linux/rculist.h:10,
>                    from include/linux/pid.h:5,
>                    from include/linux/sched.h:14,
>                    from arch/parisc/kernel/asm-offsets.c:18:
>   include/linux/build_bug.h:78:41: error: static assertion failed: "offsetof(struct page, lru) == offsetof(struct folio, lru)"
>      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
>         |                                         ^~~~~~~~~~~~~~
>   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
>      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
>         |                                  ^~~~~~~~~~~~~~~
>   include/linux/mm_types.h:261:9: note: in expansion of macro 'static_assert'
>     261 |         static_assert(offsetof(struct page, pg) == offsetof(struct folio, fl))
>         |         ^~~~~~~~~~~~~
>   include/linux/mm_types.h:263:1: note: in expansion of macro 'FOLIO_MATCH'
>     263 | FOLIO_MATCH(lru, lru);

Sounds each FOLIO_MATCH() gets an compile error?

Compile on my machine looks good to me. How this happens?

>         | ^~~~~~~~~~~
>>> include/linux/build_bug.h:78:41: error: static assertion failed: "offsetof(struct page, mapping) == offsetof(struct folio, mapping)"
>      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
>         |                                         ^~~~~~~~~~~~~~
>   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
>      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
>         |                                  ^~~~~~~~~~~~~~~
>   include/linux/mm_types.h:261:9: note: in expansion of macro 'static_assert'
>     261 |         static_assert(offsetof(struct page, pg) == offsetof(struct folio, fl))
>         |         ^~~~~~~~~~~~~
>   include/linux/mm_types.h:264:1: note: in expansion of macro 'FOLIO_MATCH'
>     264 | FOLIO_MATCH(mapping, mapping);
>         | ^~~~~~~~~~~
>   include/linux/build_bug.h:78:41: error: static assertion failed: "offsetof(struct page, compound_head) == offsetof(struct folio, lru)"
>      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
>         |                                         ^~~~~~~~~~~~~~
>   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
>      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
>         |                                  ^~~~~~~~~~~~~~~
>   include/linux/mm_types.h:261:9: note: in expansion of macro 'static_assert'
>     261 |         static_assert(offsetof(struct page, pg) == offsetof(struct folio, fl))
>         |         ^~~~~~~~~~~~~
>   include/linux/mm_types.h:265:1: note: in expansion of macro 'FOLIO_MATCH'
>     265 | FOLIO_MATCH(compound_head, lru);
>         | ^~~~~~~~~~~
>   include/linux/build_bug.h:78:41: error: static assertion failed: "offsetof(struct page, index) == offsetof(struct folio, index)"
>      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
>         |                                         ^~~~~~~~~~~~~~
>   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
>      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
>         |                                  ^~~~~~~~~~~~~~~
>   include/linux/mm_types.h:261:9: note: in expansion of macro 'static_assert'
>     261 |         static_assert(offsetof(struct page, pg) == offsetof(struct folio, fl))
>         |         ^~~~~~~~~~~~~
>   include/linux/mm_types.h:266:1: note: in expansion of macro 'FOLIO_MATCH'
>     266 | FOLIO_MATCH(index, index);
>         | ^~~~~~~~~~~
>   include/linux/build_bug.h:78:41: error: static assertion failed: "offsetof(struct page, private) == offsetof(struct folio, private)"
>      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
>         |                                         ^~~~~~~~~~~~~~
>   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
>      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
>         |                                  ^~~~~~~~~~~~~~~
>   include/linux/mm_types.h:261:9: note: in expansion of macro 'static_assert'
>     261 |         static_assert(offsetof(struct page, pg) == offsetof(struct folio, fl))
>         |         ^~~~~~~~~~~~~
>   include/linux/mm_types.h:267:1: note: in expansion of macro 'FOLIO_MATCH'
>     267 | FOLIO_MATCH(private, private);
>         | ^~~~~~~~~~~
>   include/linux/build_bug.h:78:41: error: static assertion failed: "offsetof(struct page, _mapcount) == offsetof(struct folio, _mapcount)"
>      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
>         |                                         ^~~~~~~~~~~~~~
>   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
>      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
>         |                                  ^~~~~~~~~~~~~~~
>   include/linux/mm_types.h:261:9: note: in expansion of macro 'static_assert'
>     261 |         static_assert(offsetof(struct page, pg) == offsetof(struct folio, fl))
>         |         ^~~~~~~~~~~~~
>   include/linux/mm_types.h:268:1: note: in expansion of macro 'FOLIO_MATCH'
>     268 | FOLIO_MATCH(_mapcount, _mapcount);
>         | ^~~~~~~~~~~
>   include/linux/build_bug.h:78:41: error: static assertion failed: "offsetof(struct page, _refcount) == offsetof(struct folio, _refcount)"
>      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
>         |                                         ^~~~~~~~~~~~~~
>   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
>      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
>         |                                  ^~~~~~~~~~~~~~~
>   include/linux/mm_types.h:261:9: note: in expansion of macro 'static_assert'
>     261 |         static_assert(offsetof(struct page, pg) == offsetof(struct folio, fl))
>         |         ^~~~~~~~~~~~~
>   include/linux/mm_types.h:269:1: note: in expansion of macro 'FOLIO_MATCH'
>     269 | FOLIO_MATCH(_refcount, _refcount);
>         | ^~~~~~~~~~~
>   include/linux/build_bug.h:78:41: error: static assertion failed: "offsetof(struct page, memcg_data) == offsetof(struct folio, memcg_data)"
>      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
>         |                                         ^~~~~~~~~~~~~~
>   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
>      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
>         |                                  ^~~~~~~~~~~~~~~
>   include/linux/mm_types.h:261:9: note: in expansion of macro 'static_assert'
>     261 |         static_assert(offsetof(struct page, pg) == offsetof(struct folio, fl))
>         |         ^~~~~~~~~~~~~
>   include/linux/mm_types.h:271:1: note: in expansion of macro 'FOLIO_MATCH'
>     271 | FOLIO_MATCH(memcg_data, memcg_data);
>         | ^~~~~~~~~~~
>   In file included from include/linux/mm.h:33,
>                    from include/linux/pid_namespace.h:7,
>                    from include/linux/ptrace.h:10,
>                    from arch/parisc/kernel/asm-offsets.c:20:
>   include/linux/pgtable.h: In function 'pud_index':
>   include/linux/pgtable.h:77:25: warning: right shift count >= width of type [-Wshift-count-overflow]
>      77 |         return (address >> PUD_SHIFT) & (PTRS_PER_PUD - 1);
>         |                         ^~
>   include/linux/pgtable.h: In function 'pgd_offset_pgd':
>   include/linux/pgtable.h:84:29: warning: right shift count >= width of type [-Wshift-count-overflow]
>      84 | #define pgd_index(a)  (((a) >> PGDIR_SHIFT) & (PTRS_PER_PGD - 1))
>         |                             ^~
>   include/linux/pgtable.h:124:23: note: in expansion of macro 'pgd_index'
>     124 |         return (pgd + pgd_index(address));
>         |                       ^~~~~~~~~
>   In file included from include/linux/stringhash.h:7,
>                    from include/linux/dcache.h:15,
>
>
>vim +78 include/linux/build_bug.h
>
>bc6245e5efd70c Ian Abbott       2017-07-10  60  
>6bab69c65013be Rasmus Villemoes 2019-03-07  61  /**
>6bab69c65013be Rasmus Villemoes 2019-03-07  62   * static_assert - check integer constant expression at build time
>6bab69c65013be Rasmus Villemoes 2019-03-07  63   *
>6bab69c65013be Rasmus Villemoes 2019-03-07  64   * static_assert() is a wrapper for the C11 _Static_assert, with a
>6bab69c65013be Rasmus Villemoes 2019-03-07  65   * little macro magic to make the message optional (defaulting to the
>6bab69c65013be Rasmus Villemoes 2019-03-07  66   * stringification of the tested expression).
>6bab69c65013be Rasmus Villemoes 2019-03-07  67   *
>6bab69c65013be Rasmus Villemoes 2019-03-07  68   * Contrary to BUILD_BUG_ON(), static_assert() can be used at global
>6bab69c65013be Rasmus Villemoes 2019-03-07  69   * scope, but requires the expression to be an integer constant
>6bab69c65013be Rasmus Villemoes 2019-03-07  70   * expression (i.e., it is not enough that __builtin_constant_p() is
>6bab69c65013be Rasmus Villemoes 2019-03-07  71   * true for expr).
>6bab69c65013be Rasmus Villemoes 2019-03-07  72   *
>6bab69c65013be Rasmus Villemoes 2019-03-07  73   * Also note that BUILD_BUG_ON() fails the build if the condition is
>6bab69c65013be Rasmus Villemoes 2019-03-07  74   * true, while static_assert() fails the build if the expression is
>6bab69c65013be Rasmus Villemoes 2019-03-07  75   * false.
>6bab69c65013be Rasmus Villemoes 2019-03-07  76   */
>6bab69c65013be Rasmus Villemoes 2019-03-07  77  #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
>6bab69c65013be Rasmus Villemoes 2019-03-07 @78  #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
>6bab69c65013be Rasmus Villemoes 2019-03-07  79  
>
>:::::: The code at line 78 was first introduced by commit
>:::::: 6bab69c65013bed5fce9f101a64a84d0385b3946 build_bug.h: add wrapper for _Static_assert
>
>:::::: TO: Rasmus Villemoes <linux@rasmusvillemoes.dk>
>:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>
>
>---
>0-DAY CI Kernel Test Service, Intel Corporation
>https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

-- 
Wei Yang
Help you, Help me
