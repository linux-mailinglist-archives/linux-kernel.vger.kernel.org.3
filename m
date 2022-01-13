Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6D9B48D065
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 03:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbiAMCSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 21:18:23 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:60148 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231591AbiAMCSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 21:18:15 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R481e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0V1hSvEW_1642040292;
Received: from 30.225.24.43(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0V1hSvEW_1642040292)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 13 Jan 2022 10:18:13 +0800
Message-ID: <dc5c3f04-b13f-6c32-9836-8d9f9783b81f@linux.alibaba.com>
Date:   Thu, 13 Jan 2022 10:18:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH] ocfs2: remove redundant assignment to variable free_space
Content-Language: en-US
To:     Colin Ian King <colin.i.king@gmail.com>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>, ocfs2-devel@oss.oracle.com,
        akpm <akpm@linux-foundation.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220112230411.1090761-1-colin.i.king@gmail.com>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <20220112230411.1090761-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/13/22 7:04 AM, Colin Ian King wrote:
> Variable free_space is being initialized with a value that is not read,
> it is being re-assigned later in the two paths of an if statement. The
> early initialization is redundant and can be removed.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Acked-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> ---
>  fs/ocfs2/dir.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ocfs2/dir.c b/fs/ocfs2/dir.c
> index bd8d534f11cb..f2cc1ff29e6d 100644
> --- a/fs/ocfs2/dir.c
> +++ b/fs/ocfs2/dir.c
> @@ -3343,7 +3343,7 @@ static int ocfs2_find_dir_space_id(struct inode *dir, struct buffer_head *di_bh,
>  	struct ocfs2_dir_entry *de, *last_de = NULL;
>  	char *de_buf, *limit;
>  	unsigned long offset = 0;
> -	unsigned int rec_len, new_rec_len, free_space = dir->i_sb->s_blocksize;
> +	unsigned int rec_len, new_rec_len, free_space;
>  
>  	/*
>  	 * This calculates how many free bytes we'd have in block zero, should
