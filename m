Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F45A485496
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 15:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240906AbiAEObm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 09:31:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240894AbiAEObc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 09:31:32 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F5E8C061792
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 06:31:32 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id m19so100997404ybf.9
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 06:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=i1Kmf+mXxxTK6snzYoyWCYOKV5LIiwkd3kVy/Y4pyHQ=;
        b=TkyQHv/nNalaVUulsra53ogj0b5rCHHppcPEeqpR4cJ7vEtmHXnV2I7czU+Qfd91vj
         Im6UEwGk0A+D07xhVJoWyVkuePZTqxDC8iqA/RbeCmL86ENQbsDnQNPwpdhUstiNymMQ
         9Wlx/Oqkhsq3UmM29NoweWwQ1y8y1bZSWW8EmiWjH4dsnGkDobgq54vIp/GOVkmrQ0BX
         Gmpdls+PYR0qUdEidM+U1/vlLSE+umg8uVmQtLC1NA1t/Ms5kLC9Kt+NIrJPCxELjSqW
         gJLMhUYx2filVidjEJrKbPa1QAWmYsz02kw5LF8UJKXA8dMFlVL1py8P90l2hp9mkUSQ
         LBdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=i1Kmf+mXxxTK6snzYoyWCYOKV5LIiwkd3kVy/Y4pyHQ=;
        b=xUvvhXU2dGRwN4W7pspa1jE6+IfhtNOQqFEEqxZVEjgt0ozVo8mBSRRTmsumLo6alQ
         6D17cNb3GDZjPAgqDhdQ78ii85d1an5+Jz2HMqkKkkgXep9HgENEU2wc8b3bmBKqJccD
         n69nqg05QZYmkWoliiIcXoBIAZJG5AkVEI8yGAnJRXB3XOyZHK+5+2v3dVdMwZesBGS1
         JPRbzW0qxgkJCbvfVcp5B3j13WqXX5EeNCXv24bzvpriK6wPTzOzKv/AFAOcZo+QnHZp
         doirXhhzPGynjHXejvywDs5UeUR4t59kYp/m/laBxobqZnHxJG1UhF2z/uxMTqdOIpiG
         x/cA==
X-Gm-Message-State: AOAM530hOFRu2e26ojT5zX7etcxZWQ6I3q7nGNh7p6xy+aTSyTeQJ8U4
        /CUsihlS5056n/9vIK59k/YBjfrhU/r9TWp3sW+QNA==
X-Google-Smtp-Source: ABdhPJx2y/wzL/OC+vP+3XmZtcVQhvBhCcFVUuoP+n9UVOq8afnPcz6TPe2geBvCjT0S0qFZyVO/sjIx1NMtwUQBZe4=
X-Received: by 2002:a25:ae85:: with SMTP id b5mr55614484ybj.200.1641393090685;
 Wed, 05 Jan 2022 06:31:30 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 5 Jan 2022 20:01:19 +0530
Message-ID: <CA+G9fYvXfD3wS8eJV6A6GygqhJb3AUF9OROQAkBRRTN+thVo-g@mail.gmail.com>
Subject: [next] mm/shmem.c:3993:5: error: conflicting types for 'shmem_unuse';
 have 'int(unsigned int, long unsigned int *)'
To:     linux-mm <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Christoph Hellwig <hch@lst.de>,
        Juergen Gross <jgross@suse.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Seth Jennings <sjenning@redhat.com>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        lkft-triage@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Please ignore this email if it already reported]
A large number of build failures noticed on Linux next for all arch's with
 - tinyconfig
 - allnoconfig

Build Error:
-------------
mm/shmem.c:3993:5: error: conflicting types for 'shmem_unuse'; have
'int(unsigned int,  long unsigned int *)'
 3993 | int shmem_unuse(unsigned int type, unsigned long *fs_pages_to_unuse)
      |     ^~~~~~~~~~~
In file included from include/linux/khugepaged.h:6,
                 from mm/shmem.c:37:
include/linux/shmem_fs.h:86:5: note: previous declaration of
'shmem_unuse' with type 'int(unsigned int)'
   86 | int shmem_unuse(unsigned int type);
      |     ^~~~~~~~~~~
make[2]: *** [scripts/Makefile.build:289: mm/shmem.o] Error 1

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build link: https://builds.tuxbuild.com/23GvPWRYOYokAPaEnhSYeOKuKCk/
Kconfig: https://builds.tuxbuild.com/23GvPWRYOYokAPaEnhSYeOKuKCk/config

Steps to reproduce:
# To install tuxmake on your system globally:
# sudo pip3 install -U tuxmake

tuxmake --runtime podman --target-arch x86_64 --toolchain gcc-11
--kconfig tinyconfig

--
Linaro LKFT
https://lkft.linaro.org
