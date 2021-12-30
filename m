Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E993F481931
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 05:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235532AbhL3EBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 23:01:46 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:34154 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235746AbhL3EBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 23:01:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C00E8B81A20
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 04:01:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F8C9C36AEB;
        Thu, 30 Dec 2021 04:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640836901;
        bh=FERXy+wCBsLySbQi2xNjJ07L5Ynq/sY5UAciAdWIWRA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=tBKOG+5ZCgE5hHDbMhCyYe+JgSMlEOSEjl3ActVRovdBTIttPiKrZHgvf+6xfHzBS
         l85Tl7i4kuzhhoHb7JKHWq87fZhim2gxaBtshYaMfRuxcytZ+HJpcQGYKmzUG4dr+s
         qQTXIsiwl852WEQS+XyHirQ+4mtko+RcnA2rdpo+ywMkGPLDTt6kexkuNRifLXguBV
         mPb0Rkhfr83mLms1UfpZX6Zv3o+BJ5OSMQ7RI1HxJyjLv9KzV/TQCiLpXFGc4Snmq4
         i+foA4JAv8+GddUZSQHZVbwqrZgOFbETdhySWyOylu7iLwM1VelzXKZ7BxniyGGNFo
         P2yWe1UWpADfQ==
Message-ID: <331dda35-b5cc-86c9-83ff-b30b383531b6@kernel.org>
Date:   Thu, 30 Dec 2021 12:01:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v4 5/5] erofs: add on-disk compressed tail-packing inline
 support
Content-Language: en-US
To:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org
Cc:     Yue Hu <huyue2@yulong.com>, LKML <linux-kernel@vger.kernel.org>
References: <20211228054604.114518-1-hsiangkao@linux.alibaba.com>
 <20211228054604.114518-6-hsiangkao@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20211228054604.114518-6-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/12/28 13:46, Gao Xiang wrote:
> From: Yue Hu <huyue2@yulong.com>
> 
> Introduces erofs compressed tail-packing inline support.
> 
> This approach adds a new field called `h_idata_size' in the
> per-file compression header to indicate the encoded size of
> each tail-packing pcluster.
> 
> At runtime, it will find the start logical offset of the tail
> pcluster when initializing per-inode zmap and record such
> extent (headlcn, idataoff) information to the in-memory inode.
> Therefore, follow-on requests can directly recognize if one
> pcluster is a tail-packing inline pcluster or not.
> 
> Signed-off-by: Yue Hu <huyue2@yulong.com>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
