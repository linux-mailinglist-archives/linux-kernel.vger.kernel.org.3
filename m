Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09FF2597E3B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 07:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243431AbiHRFub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 01:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243520AbiHRFu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 01:50:29 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161C474BBD
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 22:50:28 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id s11-20020a1cf20b000000b003a52a0945e8so376641wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 22:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=ISTBsODmMmJReeT53vlMzPfP03e4YyJB6CsgXy7s2fw=;
        b=Rwt0xGt4EiZ9fYmwiiJIcRk954lamBW36Q0C+7Y92tRcUbF1f/7tPz+qogCQglVUmq
         ne8+P6k5tzyujbMcwAWrR1ETMz2aZNQW+XCgZt0SJr0QO9Vm/WWoYjngRCTSzwlD23wm
         b04AwK1F4/jchQKpjKR6/ahLVDRu1o7AivATzEmfXU5/SZICpCbJmM6IK5NnZMWAgg4V
         FF4tey4hImAZ0V9oOlwL5k4i0X/N1/dk5TdqXfdV+nMIv1IKRbVsNTWGVf+wdqxczEVJ
         9Gj5MVzbfy3JOCJkHJP9U6FovoCXIMt+I5ep53/SNL3a8r+sub7FH8VOwG65qfROHXQJ
         0s9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=ISTBsODmMmJReeT53vlMzPfP03e4YyJB6CsgXy7s2fw=;
        b=29srPzd24+1HbMzVZopoZwsaByElhMJBXjnleuc9ViiHWMikk/7GYcf/3n2JEL+khX
         JXZBVzp2T1GrQvJUV1iQ2EA1/BadpMWwowKU+aF1TcCr8zCJ8870dRLpUAFOwZfpxih/
         hWZ0lfAtXolhrVUgnSfqc61R5N7TNN3hwOgAa3hV3CAFFogtydn1yPbt/3ZvvRDUG7tk
         mHg+6WevNk7nfHwbLrVJgwjd2KLm2u8x0lTCCHp9wKbERdwWnDrFQK0US/HTNMhpjSqE
         TDgUms+HvYO/koVKJugy9JYy6eZI+Br/esbhPAQ8/OeQKz4ayIdnjL4BPJkbmDmriqAd
         L5ig==
X-Gm-Message-State: ACgBeo0W8TEwpJRRk29xGiJx/lkni9x3jG1+IPJz0DBeSNfVwvH52lFa
        wN+YhCeKUWPVFeMjOoMOUw==
X-Google-Smtp-Source: AA6agR6vzN3FSmtK9zC+8z9ZxTDcLqE2M1QG1vGNrgEKNUASMnHGP8E4wQDKAqy3FkhVL1+mlL1lAQ==
X-Received: by 2002:a05:600c:2256:b0:3a5:c27d:bfb2 with SMTP id a22-20020a05600c225600b003a5c27dbfb2mr722654wmm.102.1660801826528;
        Wed, 17 Aug 2022 22:50:26 -0700 (PDT)
Received: from localhost.localdomain ([46.53.254.92])
        by smtp.gmail.com with ESMTPSA id r5-20020a05600c35c500b003a5b6086381sm4234132wmq.48.2022.08.17.22.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 22:50:25 -0700 (PDT)
Date:   Thu, 18 Aug 2022 08:50:24 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, josh@joshtriplett.org, deller@gmx.de
Subject: Re: +
 lib-dump_stack-add-dump_stack_print_cmdline-and-wire-up-in-dump_stack_print_info.patch
 added to mm-nonmm-unstable branch
Message-ID: <Yv3TILx7iB6wqKDD@localhost.localdomain>
References: <20220817195540.C2CE5C433C1@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220817195540.C2CE5C433C1@smtp.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 12:55:40PM -0700, Andrew Morton wrote:
> Add the function dump_stack_print_cmdline() which can be used by arch code
> to print the command line of the current processs.  This function is
> useful in arch code when dumping information for a faulting process.
> 
> Wire this function up in the dump_stack_print_info() function to include
> the dumping of the command line for architectures which use
> dump_stack_print_info().
> 
> As an example, with this patch a failing glibc testcase (which uses
> ld.so.1 as starting program) up to now reported just "ld.so.1" failing:
> 
>  do_page_fault() command='ld.so.1' type=15 address=0x565921d8 in libc.so[f7339000+1bb000]
>  trap #15: Data TLB miss fault, vm_start = 0x0001a000, vm_end = 0x0001b000
> 
> and now it reports in addition:
> 
>  ld.so.1[1151] cmdline: /home/gnu/glibc/objdir/elf/ld.so.1 --library-path =
> /home/gnu/glibc/objdir:/home/gnu/glibc/objdir/math:/home/gnu/
>     /home/gnu/glibc/objdir/malloc/tst-safe-linking-malloc-hugetlb1
> 
> Josh Triplett noted that dumping such command line parameters into syslog
> may theoretically lead to information disclosure.  That's why this patch
> checks the value of the kptr_restrict sysctl variable and will not print
> any information if kptr_restrict==2, and will not show the program
> parameters if kptr_restrict==1.

This whole feature needs its own sysctl. How is "kernel pointer restriction"
is related to "dump full command line to syslog at segfault"?

I've checked my non-customised Fedora system and kptr_restrict is 0.
It looks like Centos and Ubuntu ship with kptr_restrict=1.

There was a patch recently to hide specific command line options from
/proc/*/cmdline because some programs accept passwords from the command
line.
