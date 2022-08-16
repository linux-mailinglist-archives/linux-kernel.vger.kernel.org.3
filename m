Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36E9F59658F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 00:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237729AbiHPWgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 18:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232911AbiHPWgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 18:36:44 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5964D8B9BF;
        Tue, 16 Aug 2022 15:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=kqzOfHqst6JeHRRhVNK+zvbxpqEo5N4H6rU+LSHNoSM=; b=AD92IfPLnvGpuBqNX4jiPX0LzA
        XY59emo27WMUvTMBUXmr7ofI8i09GiboQh9Iw2Av1G3paqDB6UGZxeVYJuTmKwpXgWqByx42ACBEH
        dg6PraG9coTDqj2lbltsYvodrqwbWKNwMJR/5NLW6gtI9AHtlL33mzER/Vzqw0H6Y5Xi+DZ2LSWFW
        Coh0TkHbXhM2PpLIBZ6EITsal1xmdpielIxfwHjfcuYII4g4S6JvwATg5DKDVhUdwoNy7FSF98/bl
        K3oF//GJGFzw3mb09Tk2zhFN6QV9Fi+Al2qO6QMWMhCQN8XBDIM/oqt09BHMHpvEt5O50WaSAbdP1
        fUnLiZTA==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oO5An-007Xxs-EZ; Tue, 16 Aug 2022 22:36:33 +0000
Message-ID: <299a0328-9d93-74ca-a2b2-114dfd896056@infradead.org>
Date:   Tue, 16 Aug 2022 15:36:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] docs: admin-guide/mm: Improve grammar on MM concepts
 documentation
Content-Language: en-US
To:     alexlzhu@fb.com, corbet@lwn.net, bobwxc@email.cn, rppt@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kernel-team@fb.com
References: <20220816022621.253778-1-alexlzhu@fb.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220816022621.253778-1-alexlzhu@fb.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 8/15/22 19:26, alexlzhu@fb.com wrote:
> From: Alexander Zhu <alexlzhu@fb.com>
> 
> Improve grammar on MM concepts documentation.
> 
> Signed-off-by: Alexander Zhu <alexlzhu@fb.com>
> ---
>  Documentation/admin-guide/mm/concepts.rst | 138 +++++++++++-----------
>  1 file changed, 68 insertions(+), 70 deletions(-)
> 
> diff --git a/Documentation/admin-guide/mm/concepts.rst b/Documentation/admin-guide/mm/concepts.rst
> index c79f1e336222..c471f80b7a38 100644
> --- a/Documentation/admin-guide/mm/concepts.rst
> +++ b/Documentation/admin-guide/mm/concepts.rst

[snip]

> -Depending on the page usage it is treated differently by the Linux
> -memory management. The pages that can be freed at any time, either
> -because they cache the data available elsewhere, for instance, on a
> -hard disk, or because they can be swapped out, again, to the hard
> +Depending on page usage it is treated differently by the Linux
> +memory management subsystem. Pages that can be freed at any time,
> +either because they cache the data available elsewhere
> +(ie on a hard disk) or because they can be swapped out to the hard

   (i.e., on a hard disk)

>  disk, are called `reclaimable`. The most notable categories of the
>  reclaimable pages are page cache and anonymous memory.
>  

[snip]

>  
>  Compaction
>  ==========
>  
> -As the system runs, tasks allocate and free the memory and it becomes
> +As the system runs, tasks will allocate and free memory. Memory thus becomes

Addition of "will" is not needed.

>  fragmented. Although with virtual memory it is possible to present
> -scattered physical pages as virtually contiguous range, sometimes it is
> +scattered physical pages as a virtually contiguous range, sometimes it is
>  necessary to allocate large physically contiguous memory areas. Such
>  need may arise, for instance, when a device driver requires a large
>  buffer for DMA, or when THP allocates a huge page. Memory `compaction`

Thanks.
-- 
~Randy
