Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE0E4A883D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 17:03:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352026AbiBCQDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 11:03:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbiBCQC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 11:02:57 -0500
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5588BC061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 08:02:56 -0800 (PST)
Received: by mail-ua1-x92b.google.com with SMTP id m90so6041506uam.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 08:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yQV3gPl1yDUBgxhny6R2vDhSuqKPXgGrUGZ3acHuiKk=;
        b=f/Gne2cEJE032CfqiT7wIXCMdEMeDWaNJaLR0uJbv/ll95V4w9Muj9+2Dt+ZFGTzIK
         ZT0l0HlLnM5cR4zkia5kROkDaIeFVJXpm5sjYGPQpxHGVfBJo4PQwkCFB+YE5/OqxFKR
         WbKW8TcLvT38g0muYFRVMgWjPY5EBGj2/a5/onaMv3+av491P+ABP/UovecDJkMIxIK6
         TVSo/g+g4mHE+K06lvS0qQobDByynd+Njzk9WMCQQ0WDF053NsNl67QNSqrDUIfunIaK
         4kZ3IHjk2ZCYsnFVjDyoaDKaWhI0/GeWokBMv3cSnVDCXpcu3F3RvxJSvR0JCLau8HtS
         dyqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yQV3gPl1yDUBgxhny6R2vDhSuqKPXgGrUGZ3acHuiKk=;
        b=f7HmBFQna+YIwz3Sz49qODuOZuJx2Qx2L7MXwV3PCtn3CsxXVP1YQi823eXvD/PqKT
         fphh3fgs8YClGBW8cIncoxGz1L32+aUDDUrMzgaebWIMIDLiTP9LQsqHTVIOBzyffueI
         wbIeYzsLYtYzV7dl4wwOS9D1EccNfSDtAw+dsfJJw13tAcYv5rVJ61o/cYtE3+/Y4wuI
         280g+06txF+HNGBvIvkZnG8dHx6d8KpkbXWnlqob6NCN5EP/+qFZ9PRIjiJ0R132OapW
         t6QVWgzzmY0puwjtpxdg5hQ3w49yh6Og84W4rVNmB0mnnX6bET/oq+aq0Uit82Bnf5bT
         rZyw==
X-Gm-Message-State: AOAM530ugnqzYkzfITiJmHuM3Jq6nqFcfEdM/jBd9Y6wnMoYTv2AKvP5
        dtgc4F+Aqn1izcRt2rv3Rdk/GjfLOrljSyRI1VfNChDYNHw=
X-Google-Smtp-Source: ABdhPJyhBbjRx1aCHhjU2k8YsIrOTaKsE/26P0h7qLgq7eQonjXjzD0pD9bIMm0zB/xqXcpOBnsVgM90Bnk9OZjiSv8=
X-Received: by 2002:ab0:6398:: with SMTP id y24mr8266775uao.92.1643904175454;
 Thu, 03 Feb 2022 08:02:55 -0800 (PST)
MIME-Version: 1.0
References: <20220202024137.2516438-1-Liam.Howlett@oracle.com> <20220202024137.2516438-8-Liam.Howlett@oracle.com>
In-Reply-To: <20220202024137.2516438-8-Liam.Howlett@oracle.com>
From:   Mark Hemment <markhemm@googlemail.com>
Date:   Thu, 3 Feb 2022 16:02:43 +0000
Message-ID: <CANe_+UhTyOr2SPc=SMhK=7t8Uw+HvehdTw1Ti1XGcLfJ_=BMjA@mail.gmail.com>
Subject: Re: [PATCH v5 07/70] Maple Tree: Add new data structure
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Feb 2022 at 02:42, Liam Howlett <liam.howlett@oracle.com> wrote:
>
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
>
> The maple tree is an RCU-safe range based B-tree designed to use modern
> processor cache efficiently.  There are a number of places in the kernel
> that a non-overlapping range-based tree would be beneficial, especially
> one with a simple interface.  The first user that is covered in this
> patch set is the vm_area_struct, where three data structures are
> replaced by the maple tree: the augmented rbtree, the vma cache, and the
> linked list of VMAs in the mm_struct.  The long term goal is to reduce
> or remove the mmap_sem contention.
>
> The tree has a branching factor of 10 for non-leaf nodes and 16 for leaf
> nodes.  With the increased branching factor, it is significantly shorter than
> the rbtree so it has fewer cache misses.  The removal of the linked list
> between subsequent entries also reduces the cache misses and the need to pull
> in the previous and next VMA during many tree alterations.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> ---
>  Documentation/core-api/index.rst              |    1 +
>  Documentation/core-api/maple_tree.rst         |  196 +
>  MAINTAINERS                                   |   12 +
>  include/linux/maple_tree.h                    |  673 ++
>  include/trace/events/maple_tree.h             |  123 +
>  lib/Kconfig.debug                             |    9 +
>  lib/Makefile                                  |    3 +-
>  lib/maple_tree.c                              | 6943 +++++++++++++++++
>  tools/testing/radix-tree/.gitignore           |    2 +
>  tools/testing/radix-tree/Makefile             |   13 +-
>  tools/testing/radix-tree/generated/autoconf.h |    1 +
>  tools/testing/radix-tree/linux/maple_tree.h   |    7 +
>  tools/testing/radix-tree/maple.c              |   59 +
>  .../radix-tree/trace/events/maple_tree.h      |    3 +
>  14 files changed, 8042 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/core-api/maple_tree.rst
>  create mode 100644 include/linux/maple_tree.h
>  create mode 100644 include/trace/events/maple_tree.h
>  create mode 100644 lib/maple_tree.c
>  create mode 100644 tools/testing/radix-tree/linux/maple_tree.h
>  create mode 100644 tools/testing/radix-tree/maple.c
>  create mode 100644 tools/testing/radix-tree/trace/events/maple_tree.h

...
> +Allocating Nodes
> +----------------
> +
> +Allocations are usually handled internally to the tree, however if allocations
> +need to occur before a write occurs then calling mas_entry_count() will
> +allocate the worst-case number of needed nodes to insert the provided number of
> +ranges.  This also causes the tree to enter mass insertion mode.  Once
> +insertions are complete calling mas_destroy() on the maple state will free the
> +unused allocations.

mas_entry_count() has been renamed to mas_expected_entries().
(Note: test code is still using mas_entry_count()).

Cheers,
Mark
