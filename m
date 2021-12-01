Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 105A946541E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 18:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243107AbhLARjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 12:39:03 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:41312 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231944AbhLARi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 12:38:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E9B16CE1FD4
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 17:35:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56E30C53FCC;
        Wed,  1 Dec 2021 17:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638380132;
        bh=VmRo7SgVqKhhFI64rXsysCKZhUlG0qBigIxYURMdA6U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=gl117zOp6mJjUJ6ehjThBoPzG1VDcqmSwFr2eBAfNDTNosHkys9u9EJMb11b3APpN
         CKUavjTuyOuc13Ri0Ky9jg8UG7umzOzEiV95UcS/XXEopW9I1Xqepbo29QenOfD5gd
         u8s6HtQ6HVu9/Vd/3xvbMsvq4QUfOGoK7m5BX7xbrFswSO6BwQQ2ZURwJYooAixPAv
         I2LTB6U1H2/1enaJcRWLAKxJvX2s/AuIX/L8xXAvDesckte4Kxio2NhABt4fgcfGyM
         G8FvnaGy0QUaO+t04inbIx2k+eVnfYmriTsy3HYQ3Btbwvdu6ZHfXyClDv+357wAaW
         +iUnFNmLUzmaA==
From:   SeongJae Park <sj@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     SeongJae Park <sjpark@amazon.de>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: mm/damon/vaddr-test.h:309:1: warning: the frame size of 1064 bytes is larger than 1024 bytes
Date:   Wed,  1 Dec 2021 17:35:30 +0000
Message-Id: <20211201173530.2516-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <202111182146.OV3C4uGr-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Nov 2021 21:53:55 +0800 kernel test robot <lkp@intel.com> wrote:

> [-- Attachment #1: Type: text/plain, Size: 3453 bytes --]
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   42eb8fdac2fc5d62392dcfcf0253753e821a97b0
> commit: 17ccae8bb5c928946f6f3af14626ec458f74e6ad mm/damon: add kunit tests
> date:   2 months ago
> config: mips-randconfig-c004-20211118 (attached as .config)
> compiler: mipsel-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=17ccae8bb5c928946f6f3af14626ec458f74e6ad
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 17ccae8bb5c928946f6f3af14626ec458f74e6ad
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross ARCH=mips 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>

Thank you for the fix, and sorry for late reply.  A fix for this issue has
posted: https://lore.kernel.org/linux-mm/20211201150440.1088-6-sj@kernel.org/


Thanks,
SJ

> 
> All warnings (new ones prefixed by >>):
> 
>    In file included from mm/damon/vaddr.c:672:
>    mm/damon/vaddr-test.h: In function 'damon_test_split_evenly':
> >> mm/damon/vaddr-test.h:309:1: warning: the frame size of 1064 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>      309 | }
>          | ^
> 
