Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D162481807
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 02:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233865AbhL3BSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 20:18:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233845AbhL3BSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 20:18:07 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E78DC061574
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 17:18:06 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id z3so17016070plg.8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 17:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Crvn2OOvogq+60DR9iu3ZJhiZKPUbfuYhtpKk4tVTgw=;
        b=q5Z+qtt4eYvy2SV7gn6V0+8W2B4cXgLuqvAs6m/WbZnSON/au9U8RB/cX5mYac2Xxl
         nyl/Ti8I0eaHAQ9BnJ4pOfKVOFc3fZnGyB0Xz8akvpppFJRF9cHXq9K5bZ+xGiFyy9eS
         kI7tDRO6MB28ouWamXmmM5B3jwSsq339cHrIxz1i+4lQwJuowSz3XWDbQK7ECmiwlmD/
         pGvXkncumYvfhMOU4E8pKvDTXPvpFq9yxaQEUBwLNPcBQpLoXZ4wou3NTSWilw3XXen6
         dIHLMu7WtJ8j68OFc9sa4A22LUicIUKEZP/hLBoY9thGXDEJ5Lwo+anpU9QqG5cOQW+x
         PcBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Crvn2OOvogq+60DR9iu3ZJhiZKPUbfuYhtpKk4tVTgw=;
        b=7jrO0eC4omhSFeFLIunTYPYIORCnOVyoLbTUK3H4Z+yBCe63ZtFlMfq3aDUGLrsEke
         S6SpYv6ni9XCVaIX46cB+ZzaWHNN7k5cBoZpzR07dIJuhWsHZdibYrfb5s5/W3usoN5b
         sPdz4mwAMrHFFtEY28KRnQiHUXzsOUj5EG9njyrwJFqsPax7+Jyq6JQMAFvkP8iFZFNu
         GEizju37lUAAtUTkGMHKITZB4ZRYhScvidMbczBBxkw/Hvw6mN5umxZJI35rm9+IbgUI
         SWdjUX68J8L1q9J7P1Z6cKuWtVwFExrFRjy1nP8p4D3t72jtDbArd5pD2Qm9Cv0FJR5t
         2CKg==
X-Gm-Message-State: AOAM5323CKwKU41jTDjs09cmt3mlqwC6L1XKJGHVLMgmf7euqcX9EHIO
        fo2wee1wAdd90/7gwL+1FicFrw==
X-Google-Smtp-Source: ABdhPJy0Ts1SMc4M89acfKJ62St6wcAMG4F+nLK5tIZALw3Qhwglbubi3+H0bw1RRYDw/5OOBB3AIg==
X-Received: by 2002:a17:90b:3850:: with SMTP id nl16mr35030348pjb.18.1640827086121;
        Wed, 29 Dec 2021 17:18:06 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id 27sm18661619pgx.81.2021.12.29.17.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 17:18:05 -0800 (PST)
Date:   Thu, 30 Dec 2021 01:18:02 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: vmlinux.o: warning: objtool: __svm_sev_es_vcpu_run()+0x54: BP
 used as a scratch register
Message-ID: <Yc0IyjWqEjqx56To@google.com>
References: <202111172015.2zvJUEBY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202111172015.2zvJUEBY-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2021, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   8ab774587903771821b59471cc723bba6d893942
> commit: 16809ecdc1e8ab7278f1d60021ac809edd17d060 KVM: SVM: Provide an updated VMRUN invocation for SEV-ES guests
> date:   11 months ago
> config: x86_64-buildonly-randconfig-r005-20211117 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> reproduce (this is a W=1 build):
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=16809ecdc1e8ab7278f1d60021ac809edd17d060
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 16809ecdc1e8ab7278f1d60021ac809edd17d060
>         # save the attached .config to linux build tree
>         mkdir build_dir
>         make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>    vmlinux.o: warning: objtool: __do_fast_syscall_32()+0x3d: call to syscall_enter_from_user_mode_work() leaves .noinstr.text section
>    vmlinux.o: warning: objtool: __svm_vcpu_run()+0x10e: BP used as a scratch register
> >> vmlinux.o: warning: objtool: __svm_sev_es_vcpu_run()+0x54: BP used as a scratch register

__svm_vcpu_run() and __svm_sev_es_vcpu_run() PUSH/POP RBP but don't create a stack
frame, which triggers the objtool warning because objtool things the code is using
BP as a scratch register (obviously).  This shows up when CONFIG_FRAME_POINTER=y
and KVM AMD is built into the kernel (apparently 'objtool check' isn't run on modules?).

The easy fix to is add "mov %rsp, %rbp" to create a stack frame.  Kinda pointless
since neither function makes true calls to other functions, but the extra MOV is
harmless and it'd be nice to get rid of the objtool warning.
