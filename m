Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBA0957799F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 04:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbiGRCcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 22:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiGRCcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 22:32:23 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C410C11A16
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 19:32:22 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 89-20020a17090a09e200b001ef7638e536so16844322pjo.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 19:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oiXsE899ECsDO/JqAFKHt8xNeKUPeSho1Q6s/lHRKTM=;
        b=LvHZYMZU0maQBPP4n4e+69oL7V8QXoJ7ecc0LA/H6gVEJjfWbbG2TLqowgdpnx8sU2
         3KUZHojdJnYCrxOz4w7HFNTTGacr1XHalIa2gYS/1Dh/jKFdUWZv4suCqLNEAM/BQDeF
         1etmXojv+IYCuUqW3yvvJcxaWZDVbNBNVUZqlD8wKOSfXopbDdA+ELxke3HpVoCWFWao
         9qBGlMoeDZ6Bvw/wfs1sc6vQDhGEZuPVvRafhW1MvMqF7L4MjpGhXU1fCRU+e09/RWBb
         ssT+0GRM0unSNhg9v63cpiCJR6EImuWtdY0QIYecAl2sqG0R/jGyEc3YWAEkupArvMbW
         2wgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=oiXsE899ECsDO/JqAFKHt8xNeKUPeSho1Q6s/lHRKTM=;
        b=wllUoN1QeyjHIg7sEYF7KUTU/5DvT0b4KRlHOUmZdmu4PdcwcxyB1JHoEyXukAFWZa
         +QQVVGaPWNm7viKwH37b+vhF/LOnQxr1zM6XiV+r9rYGdmRB6OYkjrMwBumq0hIs2ukX
         1h3GfVsmxN/h4hPGtAr6U2z9Crv2SiG3Jhpt/5THmd60c1HK6nRjf2vqajD+antIImip
         qCT0RnI2oGRPVyetNOVYu5ZkXoOyOAhUTqMdA7MDPkOWJ3p/aaNRbkGfwr22ujst8czo
         9JCOGbSQHkMwY5mlj80kabQOsPRgNqkzvkE20VMhFC17+yqk98ixqr67gzvyQxs23dux
         0pIw==
X-Gm-Message-State: AJIora9ICix7VkuTg5qBvJT0WcB8J7zA7SexutJx0xSvIviKzooaFpYd
        dYLBxr2ejkAbdXCkCdPwr0D0YYQmMCMyzg==
X-Google-Smtp-Source: AGRyM1snxVFdcpDYuQnw3vEC7ZnT3d3A3vwmtxpaNphIDwZmrrV8qiE2QO+Hq118CKoH1zyu/GoV8g==
X-Received: by 2002:a17:902:e84e:b0:16b:f773:4692 with SMTP id t14-20020a170902e84e00b0016bf7734692mr25750738plg.19.1658111542242;
        Sun, 17 Jul 2022 19:32:22 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j7-20020a170903024700b0016c454598b5sm8032496plh.167.2022.07.17.19.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jul 2022 19:32:21 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 17 Jul 2022 19:32:20 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.19-rc7
Message-ID: <20220718023220.GA773385@roeck-us.net>
References: <CAHk-=wj63HHDU0MTRVKese5a4j82g3s3u4Ztno7=7Cj=cRRFFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj63HHDU0MTRVKese5a4j82g3s3u4Ztno7=7Cj=cRRFFQ@mail.gmail.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 17, 2022 at 02:02:37PM -0700, Linus Torvalds wrote:
> It's a Sunday afternoon, I wonder what that might mean..
> 
> Another week, another rc. We obviously had that whole "Retbleed"
> thing, and it does show up in both the diffstat and the shortlog, and
> rc7 is definitely bigger than usual.
> 
> And also as usual, when we've had one of those embargoed hw issues
> pending, the patches didn't get the open development, and then as a
> result missed all the usual sanity checking by all the automation
> build and test infrastructure we have. So no surprise - there's been
> various small fixup patches afterwards too for some corner cases.
> 
> That said, last week there were two other development trees that
> independently also asked for an extension, so 5.19 will be one of
> those releases that have an additional rc8 next weekend before the
> final release. We had some last-minute btrfs reverts, and there's also
> a pending issue with a intel GPU firmware.
> 
> When it rains it pours.
> 
> Not that things really look all that bad. I think we've got the
> retbleed fallout all handled (knock wood), and the btrfs reverts are
> in place. And the Intel GPU firmware issue seems to have a patch
> pending too (or we'll just revert). So it's not like we have any huge
> issues, but an extra week is most definitely called for.
> 

Build results look good.

Build results:
	total: 150 pass: 150 fail: 0
Qemu test results:
	total: 489 pass: 489 fail: 0

As for warnings, I see

[   19.798382] test_bitmap: parselist: 14: input is '0-2047:128/256' OK, Time: 12584
[   19.803177] ==================================================================
[   19.803628] BUG: KFENCE: out-of-bounds read in _find_next_bit_le+0x10/0x48
[   19.803628]
[   19.804846] Out-of-bounds read at 0xef5b2000 (4096B right of kfence-#103):
[   19.805333]  _find_next_bit_le+0x10/0x48
[   19.805561]
[   19.805782] kfence-#103: 0xef5b1000-0xef5b1fff, size=4096, cache=kmalloc-4k
[   19.805782]
[   19.806263] allocated by task 1 on cpu 1 at 19.800216s:
[   19.806797]  test_bitmap_printlist+0x2c/0x13c
[   19.807024]  test_bitmap_init+0x64/0x478
[   19.807197]  do_one_initcall+0x6c/0x3a4
[   19.807380]  kernel_init_freeable+0x1c4/0x230
[   19.807568]  kernel_init+0x18/0x130
[   19.807729]  ret_from_fork+0x14/0x2c
[   19.807885]  0x0
[   19.808520] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.19.0-rc7 #1
[   19.808924] Hardware name: Samsung Exynos (Flattened Device Tree)
[   19.809301] PC is at _find_next_bit_le+0x10/0x48
[   19.809516] LR is at bitmap_list_string.constprop.0+0xfc/0x144
[   19.809775] pc : [<c06ff0cc>]    lr : [<c0715870>]    psr: 20000113
[   19.810033] sp : f082dc70  ip : 00000001  fp : 00000001
[   19.810254] r10: 00000000  r9 : 0000002d  r8 : ef5b1000
[   19.810478] r7 : c0e55514  r6 : c2215000  r5 : 00008000  r4 : 00008000
[   19.810746] r3 : 3163db73  r2 : 00008001  r1 : 00008000  r0 : ef5b1000
[   19.811082] Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
[   19.811418] Control: 10c5387d  Table: 4000406a  DAC: 00000051
[   19.811791] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.19.0-rc7 #1
[   19.812049] Hardware name: Samsung Exynos (Flattened Device Tree)
[   19.812437]  unwind_backtrace from show_stack+0x10/0x14
[   19.812723]  show_stack from dump_stack_lvl+0x68/0x90
[   19.812953]  dump_stack_lvl from kfence_report_error+0x260/0x664
[   19.813231]  kfence_report_error from kfence_handle_page_fault+0x1ec/0x27c
[   19.813515]  kfence_handle_page_fault from __do_kernel_fault.part.0+0x3c/0x74
[   19.813799]  __do_kernel_fault.part.0 from do_page_fault+0x1d0/0x408
[   19.814070]  do_page_fault from do_DataAbort+0x3c/0xb4
[   19.814292]  do_DataAbort from __dabt_svc+0x50/0x80
[   19.814614] Exception stack(0xf082dc20 to 0xf082dc68)
[   19.815104] dc20: ef5b1000 00008000 00008001 3163db73 00008000 00008000 c2215000 c0e55514
[   19.815460] dc40: ef5b1000 0000002d 00000000 00000001 00000001 f082dc70 c0715870 c06ff0cc
[   19.815773] dc60: 20000113 ffffffff
[   19.815964]  __dabt_svc from _find_next_bit_le+0x10/0x48

which I don't recall seeing before. Digging into it, it may be spurious
(ie seen with various emulations and not with every boot), and it looks
like it is not not a new problem: I see the same or a similar report
in v5.18.y, but never in v5.15.y. I'll try to bisect.

Guenter
