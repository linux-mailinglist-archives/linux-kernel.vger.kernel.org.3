Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCD1485E66
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 03:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344578AbiAFCCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 21:02:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344518AbiAFCCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 21:02:05 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 460F9C061245
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 18:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=FVF/TCzPTrNkd86Ozi+iwBwca5oDi+G1GC25DxmABZY=; b=a7/jkvgm4YHilMWQxkrNHCVI0N
        ywHbH/vRS7VKfJTKdUCurv6JI3vFLuw6ZhxNUr7aLvMw2GsX1IW7sg/AeKX80W/MWvbFU6O/myttr
        eszlSUXcKQwY+mVEvICIju+jrgKSD/hknMM/WpEm/3wPtRqmUHmTO5jVlwZpEegGn9pSP6r5q7r8X
        5/kCjnRRX5VfpEDaovpSlDRIQzyAH3GfTUFpgEbjWVwwZjafk5DKfvLsUfKDh0mCGRbuNNyN6TFax
        WQ2RX4jMs42xgm5soN/2Nc8ZJNFHOGlQ9ga4aoEqZ6iTDpJAamoB6Axr0uNKleKNCWYzyVLvzBCDf
        Eii8MCOg==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n5I6D-00F4gI-MX; Thu, 06 Jan 2022 02:01:53 +0000
Message-ID: <64e8bd65-4801-4e09-3c35-03e3ff73c094@infradead.org>
Date:   Wed, 5 Jan 2022 18:01:49 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH -next] NTFS: Fix one kernel-doc comment
Content-Language: en-US
To:     Yang Li <yang.lee@linux.alibaba.com>, anton@tuxera.com
Cc:     linux-ntfs-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>,
        akpm@linux-foundation.org
References: <20220106015145.67067-1-yang.lee@linux.alibaba.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220106015145.67067-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/5/22 17:51, Yang Li wrote:
> /**
>  * attrib.c - NTFS attribute operations.  Part of the Linux-NTFS
> 
> The comments for the file should not be in kernel-doc format, which causes
> it to be incorrectly identified for function ntfs_map_runlist_nolock(),
> causing some warnings found by running scripts/kernel-doc.
> 
> fs/ntfs/attrib.c:25: warning: Incorrect use of kernel-doc format:  *
> ntfs_map_runlist_nolock - map (a part of) a runlist of an ntfs inode
> fs/ntfs/attrib.c:71: warning: Function parameter or member 'ni' not
> described in 'ntfs_map_runlist_nolock'
> fs/ntfs/attrib.c:71: warning: Function parameter or member 'vcn' not
> described in 'ntfs_map_runlist_nolock'
> fs/ntfs/attrib.c:71: warning: Function parameter or member 'ctx' not
> described in 'ntfs_map_runlist_nolock'
> fs/ntfs/attrib.c:71: warning: expecting prototype for attrib.c - NTFS
> attribute operations.  Part of the Linux(). Prototype was for
> ntfs_map_runlist_nolock() instead
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

[adding akpm]

> ---
>  fs/ntfs/attrib.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
> index d563abc3e136..2911c04a33e0 100644
> --- a/fs/ntfs/attrib.c
> +++ b/fs/ntfs/attrib.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
> -/**
> +/*
>   * attrib.c - NTFS attribute operations.  Part of the Linux-NTFS project.
>   *
>   * Copyright (c) 2001-2012 Anton Altaparmakov and Tuxera Inc.

-- 
~Randy
