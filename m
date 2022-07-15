Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF0C575D42
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 10:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232261AbiGOISS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 04:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiGOISQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 04:18:16 -0400
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01BD7E83C
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 01:18:15 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R691e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VJOSTJF_1657873092;
Received: from 30.227.78.197(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0VJOSTJF_1657873092)
          by smtp.aliyun-inc.com;
          Fri, 15 Jul 2022 16:18:12 +0800
Message-ID: <793cab25-a591-b4f4-c4a6-bb80ac681a02@linux.alibaba.com>
Date:   Fri, 15 Jul 2022 16:18:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH] fs/ocfs2: Fix spelling typo in comment
Content-Language: en-US
To:     Jiangshan Yi <13667453960@163.com>, mark@fasheh.com,
        jlbec@evilplan.org, akpm@linux-foundation.org
Cc:     ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org,
        Jiangshan Yi <yijiangshan@kylinos.cn>,
        k2ci <kernel-bot@kylinos.cn>
References: <20220715060035.632903-1-13667453960@163.com>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <20220715060035.632903-1-13667453960@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/15/22 2:00 PM, Jiangshan Yi wrote:
> From: Jiangshan Yi <yijiangshan@kylinos.cn>
> 
> Fix spelling typo in comment.
> 
> Reported-by: k2ci <kernel-bot@kylinos.cn>
> Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>

Acked-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> ---
>  fs/ocfs2/quota_global.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ocfs2/quota_global.c b/fs/ocfs2/quota_global.c
> index 0b6f551a342a..dc9f76ab7e13 100644
> --- a/fs/ocfs2/quota_global.c
> +++ b/fs/ocfs2/quota_global.c
> @@ -412,7 +412,7 @@ int ocfs2_global_read_info(struct super_block *sb, int type)
>  	goto out_err;
>  }
>  
> -/* Write information to global quota file. Expects exlusive lock on quota
> +/* Write information to global quota file. Expects exclusive lock on quota
>   * file inode and quota info */
>  static int __ocfs2_global_write_info(struct super_block *sb, int type)
>  {
