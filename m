Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41C9C480592
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 02:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234475AbhL1Btx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 20:49:53 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:40985 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230522AbhL1Btw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 20:49:52 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0V0.gs9J_1640656189;
Received: from 30.225.24.26(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0V0.gs9J_1640656189)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 28 Dec 2021 09:49:50 +0800
Message-ID: <f88a34a6-abe8-69e2-33e0-350a0a76eea7@linux.alibaba.com>
Date:   Tue, 28 Dec 2021 09:49:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH] ocfs2: remove redundant assignment to pointer root_bh
Content-Language: en-US
To:     Colin Ian King <colin.i.king@gmail.com>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>, ocfs2-devel@oss.oracle.com,
        akpm <akpm@linux-foundation.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211228013719.620923-1-colin.i.king@gmail.com>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <20211228013719.620923-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/28/21 9:37 AM, Colin Ian King wrote:
> Pointer root_bh is being initialized with a value that is not read,
> it is being re-assigned later on closer to its use. The early
> initialization is redundant and can be removed.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Acked-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> ---
>  fs/ocfs2/alloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ocfs2/alloc.c b/fs/ocfs2/alloc.c
> index bb247bc349e4..bf9357123bc5 100644
> --- a/fs/ocfs2/alloc.c
> +++ b/fs/ocfs2/alloc.c
> @@ -2040,7 +2040,7 @@ static void ocfs2_complete_edge_insert(handle_t *handle,
>  	int i, idx;
>  	struct ocfs2_extent_list *el, *left_el, *right_el;
>  	struct ocfs2_extent_rec *left_rec, *right_rec;
> -	struct buffer_head *root_bh = left_path->p_node[subtree_index].bh;
> +	struct buffer_head *root_bh;
>  
>  	/*
>  	 * Update the counts and position values within all the
